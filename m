Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVAGRMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVAGRMh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVAGRMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:12:36 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:59292 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261351AbVAGRMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:12:17 -0500
Subject: Re: do_IRQ: stack overflow: 872..
From: David Woodhouse <dwmw2@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Crazy AMD K7 <snort2004@mail.ru>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Stephen Hemminger <shemminger@osdl.org>
In-Reply-To: <p73zn0ccaee.fsf@verdi.suse.de>
References: <1131604877.20041218092730@mail.ru.suse.lists.linux.kernel>
	 <p73zn0ccaee.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 17:05:59 +0000
Message-Id: <1105117559.11753.34.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-18 at 08:50 +0100, Andi Kleen wrote:
> It's not really an oops, just a warning that stack space got quiet
> tight.
> 
> The problem seems to be that the br netfilter code is nesting far too
> deeply and recursing several times. Looks like a design bug to me,
> it shouldn't do that.

I don't think it's recursing -- I think the stack trace is just a bit
noisy. The problem is that the bridge code, especially with br_netfilter
in the equation, is implicated in code paths which are just _too_ deep.
This happens when you're bridging packets received in an interrupt while
you were deep in journalling code, and it's also been seen with a call
trace something like nfs->sunrpc->ip->bridge->br_netfilter.

One option might be to make br_dev_xmit() just queue the packet rather
than trying to deliver it to all the slave devices immediately. Then the
actual retransmission can be handled from a context where we're _not_
short of stack; perhaps from a dedicated kernel thread. 

Unfortunately that approach would introduce a lot of latency on all
packets we pass. Another option would be to have all architectures
provide a stack_available() function and for br_dev_xmit() to queue the
packet only if we're short of stack, while still sending most packets
immediately. 

Proof of concept below; obviously the stack_available() is an evil hack
and would need to be done more sanely. Comments?

===== net/bridge/br_device.c 1.17 vs edited =====
--- 1.17/net/bridge/br_device.c	2004-07-29 22:40:51 +01:00
+++ edited/net/bridge/br_device.c	2005-01-07 16:54:26 +00:00
@@ -19,6 +19,13 @@
 #include <asm/uaccess.h>
 #include "br_private.h"
 
+static inline unsigned long stack_available(void)
+{
+	unsigned long esp;
+	asm volatile("movl %%esp,%0" : "=r"(esp));
+	return esp - (unsigned long)current - sizeof(struct thread_info);
+}
+
 static struct net_device_stats *br_dev_get_stats(struct net_device *dev)
 {
 	struct net_bridge *br;
@@ -34,6 +41,14 @@
 	const unsigned char *dest = skb->data;
 	struct net_bridge_fdb_entry *dst;
 
+	if (stack_available() < THREAD_SIZE/2) {
+		if (net_ratelimit()) {
+			printk(KERN_DEBUG "Bridge device %s queues packet due to stack shortage\n",
+			       dev->name);
+		}
+		return NETDEV_TX_BUSY;
+	}
+
 	br->statistics.tx_packets++;
 	br->statistics.tx_bytes += skb->len;
 
@@ -104,7 +119,7 @@
 	SET_MODULE_OWNER(dev);
 	dev->stop = br_dev_stop;
 	dev->accept_fastpath = br_dev_accept_fastpath;
-	dev->tx_queue_len = 0;
+	dev->tx_queue_len = 5;
 	dev->set_mac_address = NULL;
 	dev->priv_flags = IFF_EBRIDGE;
 }




-- 
dwmw2


