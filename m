Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWHTRse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWHTRse (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWHTRsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:48:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:2762 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751066AbWHTRsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:48:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: [RFC v2] HOWTO use NAPI to reduce TX interrupts
Date: Sun, 20 Aug 2006 19:48:19 +0200
User-Agent: KMail/1.9.1
Cc: linuxppc-dev@ozlabs.org, akpm@osdl.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       David Miller <davem@davemloft.net>,
       Linas Vepstas <linas@austin.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com> <44E7BB7F.7030204@osdl.org> <200608191325.19557.arnd@arndb.de>
In-Reply-To: <200608191325.19557.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608201948.20596.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A recent discussion about the spidernet driver resulted in the dicovery
that network drivers are supposed to use NAPI for both their receive and
transmit paths, but this is documented nowhere.

In order to help the next person writing a NAPI based driver, I wrote
down what I found missing about this.

Please tell me if anything in here is still wrong or could use better
wording.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
This is the second version of my mini howto, after a few comments
I got from Stephen Hemminger and  Avuton Olrich.

Index: linux-cg/Documentation/networking/NAPI_HOWTO.txt
===================================================================
--- linux-cg.orig/Documentation/networking/NAPI_HOWTO.txt	2006-08-20 16:51:12.000000000 +0200
+++ linux-cg/Documentation/networking/NAPI_HOWTO.txt	2006-08-20 19:42:20.000000000 +0200
@@ -1,11 +1,6 @@
-HISTORY:
-February 16/2002 -- revision 0.2.1:
-COR typo corrected
-February 10/2002 -- revision 0.2:
-some spell checking ;->
-January 12/2002 -- revision 0.1
-This is still work in progress so may change.
-To keep up to date please watch this space.
+Note: this document could use a serious cleanup by a good writer.
+It would be nice to split out the reference parts into a kerneldoc
+document and turn the rest into a tutorial.
 
 Introduction to NAPI
 ====================
@@ -738,6 +733,64 @@
 root         3  0.2  0.0     0     0  ?  RWN Aug 15 602:00 (ksoftirqd_CPU0)
 root       232  0.0  7.9 41400 40884  ?  S   Aug 15  74:12 gated 
 
+
+APPENDIX 4: Using NAPI for TX skb cleanup
+=========================================
+
+While most of the discussion is focused on optimizing the receive path, in
+most drivers it is also beneficial to free TX buffers from the dev->poll()
+function. Many devices trigger an interrupt for each packet that has been
+sent out to notify the driver that it can free the skb. This results in
+a large amount of interrupt processing that we want to avoid. It is also
+suboptimal to free skbs in a hardirq context, because dev_kfree_skb_irq()
+needs to schedule a softirq to do the actual work. Calling dev_kfree_skb()
+from dev->poll() directly avoids these extra softirq schedules.
+
+The simplistic approach of setting a long kernel timer to clean up
+descriptors results in poor throughput because a user process that tries
+to send out a lot of data then blocks on its socket send buffer, while
+the driver never frees up the skbs in that buffer until the timeout.
+
+Trying the cleanup every time that hard_start_xmit() is entered provides
+relatively good throughput, but typically causes extra processing overhead
+because of mmio accesses and/or spinlocks, so you normally want to batch
+skb reclaim.
+
+In order to get optimal throughput on transmit, the sent skbs need to be
+cleaned up before the chip runs out of data to transmit, so relying on
+an end of queue interrupt means that in the window between the interrupt
+and the time that new user packets have arrived in the adapter, there is
+no outgoing data on the wire, even if user data is available.  It may
+also be bad to defer freeing skbs too long because they may consume a
+significant amount of memory.
+
+Experience shows that combination of events that trigger skb reclaim
+works best. These events include:
+- new packets coming in through hard_start_xmit()
+- packets coming in from the network through dev->poll()
+- time has passed since the first packet was send over the wire
+  but has not been reclaimed (tx_coalesce_usecs)
+- a number of packets have been sent (tx_max_coalesced_frames)
+
+We can avoid expensive locking between these by using the poll() function
+as the only place to call skb reclaim. This also means that in the
+interrupt handler, we always call netif_rx_schedule() for any interrupt,
+including those for tx or e.g. PHY handling.  This is particularly
+helpful if reading the IRQ status does an auto mask operation.
+
+Depending on the actual hardware, slightly different methods for coalesced
+tx interrupts may be used:
+- a timer that starts with the successful transmission of a packet
+  may need to be replaced with a timer that is started at when a packet
+  is submitted to the adapter.
+- instead of an interrupt that is triggered after a fixed number
+  of transmitted packets, it may be possible to mark a specific packet
+  so it generates an interrupt after processing.
+- If the adapter knows about the number of packets that have been
+  queued, a low-watermark interrupt may be used that fires when the
+  number drops below a user-defined value.
+
+
 --------------------------------------------------------------------
 
 relevant sites:
@@ -764,3 +817,4 @@
 Manfred Spraul <manfred@colorfullife.com>
 Donald Becker <becker@scyld.com>
 Jeff Garzik <jgarzik@pobox.com>
+Arnd Bergmann <arnd@arndb.de>
