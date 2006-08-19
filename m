Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422661AbWHSA4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWHSA4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 20:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWHSA4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 20:56:47 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:5078 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751626AbWHSA4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 20:56:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] HOWTO use NAPI to reduce TX interrupts
Date: Sat, 19 Aug 2006 02:56:25 +0200
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       David Miller <davem@davemloft.net>
References: <20060818220700.GG26889@austin.ibm.com> <20060818222657.GL26889@austin.ibm.com> <200608190103.05649.arnd@arndb.de>
In-Reply-To: <200608190103.05649.arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608190256.26373.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 August 2006 01:03, Arnd Bergmann wrote:
> Someone should probably document that in 
> Documentation/networking/NAPI_HOWTO.txt, I might end up doing that
> once we get it right for spidernet.

Oh well, what else is there to do on a Friday night ;-)

This is a first draft, I expect to have gotten some aspects wrong,
so please review well.

For those that did not follow the spidernet discussion, it turns out
that all good ethernet drivers call their TX descriptor reclaim function
from their poll() method, but there is no documentation explaining
why this is a good idea . I talked to a number of people that have
written network drivers before and most of them have not understood
this well enough. I'm sure spidernet is not the only driver that
implemented this wrong.

Thanks to benh and davem for being really patient about explaining this
to me!

	Arnd <><

diff --git a/Documentation/networking/NAPI_HOWTO.txt b/Documentation/networking/NAPI_HOWTO.txt
index 54376e8..4d333a4 100644
--- a/Documentation/networking/NAPI_HOWTO.txt
+++ b/Documentation/networking/NAPI_HOWTO.txt
@@ -738,6 +738,60 @@ USER       PID %CPU %MEM  SIZE   RSS TTY
 root         3  0.2  0.0     0     0  ?  RWN Aug 15 602:00 (ksoftirqd_CPU0)
 root       232  0.0  7.9 41400 40884  ?  S   Aug 15  74:12 gated 
 
+
+APPENDIX 4: Using NAPI for TX skb cleanup
+=========================================
+
+While most of the discussion is focused on optimising the receive path,
+in most drivers it is also beneficial to free TX buffers from the
+dev->poll() function. Many devices trigger an interrupt for each
+frame that has been sent out to notify the driver that it can free
+the skb. This results in a large amount of interrupt processing that
+we want to avoid.
+
+The simplistic approach of setting a long kernel timer to clean up
+descriptors results in poor throughput because a user process that
+tries to send out a lot of data then blocks on its socket send buffer,
+while the driver never frees up the skbs in that buffer until the
+timeout.
+
+In order to get optimal throughput on transmit, the sent skbs need to
+be cleaned up before the chip runs out of data to transmit, so
+relying on an end of queue interrupt means that in the window between
+the interrupt and the time that new user packets have arrived in the
+adapter, there is no outgoing data on the wire, even if user data is
+available.
+It may also be bad to defer freeing skbs too long because they may consume
+a significan amount of memory.
+
+Experience shows that combination of events that trigger skb reclaim
+works best. These events include:
+- new packets coming in through hard_start_xmit()
+- packets coming in from the network through dev->poll()
+- time has passed since the first frame was send over the wire
+  but has not been reclaimed (tx_coalesce_usecs)
+- a number of packets have been sent (tx_max_coalesced_frames)
+
+We can avoid expensive locking between these by using the poll()
+function as the only place to call skb reclaim. This also means
+that in the interrupt handler, we always call netif_rx_schedule()
+for any interrupt, regardless of whether it is an rx or tx
+event. Don't get confused by the fact that we're scheduling
+the rx softirq to do tx work.
+
+Depending on the actual hardware, slightly different methods
+for coalesced tx interrupts may be used:
+- a timer that starts with the successful transmission of a packet
+  may need to be replaced with a timer that is started at when a
+  packet is submitted to the adapter.
+- instead of an interrupt that is triggered after a fixed number
+  of transmitted packets, it may be possible to mark a specific
+  packet so it generates an interrupt after processing.
+- If the adapter knows about the number of packets that have been
+  queued, a low-watermark interrupt may be used that fires
+  when the number drops below a user-defined value.
+
+
 --------------------------------------------------------------------
 
 relevant sites:
