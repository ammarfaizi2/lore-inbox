Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbTGQTBz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbTGQTBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:01:55 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:59019 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268702AbTGQTBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:01:24 -0400
Message-ID: <3F16F54C.949A9299@us.ibm.com>
Date: Thu, 17 Jul 2003 12:13:16 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jmorris@intercode.com.au, davem@redhat.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk,
       rddunlap@osdl.org, kuznet@ms2.inr.ac.ru, jkenisto@us.ibm.com
Subject: Re: [PATCH] [1/2] kernel error reporting (revised)
References: <Mutt.LNX.4.44.0307131052420.2146-100000@excalibur.intercode.com.au>
		<3F143D0A.A052F0B6@us.ibm.com> <20030715125121.315920a2.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------1C2AB73BB6D657AFF025223B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1C2AB73BB6D657AFF025223B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> 
> Jim Keniston <jkenisto@us.ibm.com> wrote:
> >
> > +int kernel_error_event_iov(const struct iovec *iov, unsigned int nseg,
> > +     u32 groups)
> > +{
> > ...
> > +
> > +     return netlink_broadcast(kerror_nl, skb, 0, ~0, GFP_ATOMIC);
> 
> This appears to be deadlocky when called from interrupt handlers.
> 
> netlink_broadcast() does read_lock(&nl_table_lock).  But nl_table_lock is
> not an irq-safe lock.
> 
> Possibly netlink_broadcast() can be made callable from hardirq context, but
> it looks to be non trivial.  The various error and delivery handlers need
> to be reviewed,

Yes indeed.  I believe this issue is resolved by detecting that we're in an
interrupt handler and delaying the call to netlink_broadcast() via a tasklet.
See the enclosed patch to the previously posted rev.  I'll update the full patch at
http://prdownloads.sourceforge.net/evlog/kerror-2.5.75.patch?download

An issue remains: what, if anything, to tell the caller if the delayed
netlink_broadcast() fails.  See below for further thoughts.

> the kfree_skb() calls should be thought about, etc.

I've thought about them. :-)  Given the aforementioned solution, I don't think
kfree_skb() is an issue, because it's called as needed by netlink_broadcast().
If I'm missing something here, feel free to clarify.

Thanks.
Jim

WHAT IF THE DELAYED netlink_broadcast() CALL FAILS?
1. Can we detect from IRQ context that nobody is listening, and thereby
return -ESRCH to the caller?  No, to do that would require perusing the
nl_table[NETLINK_KERROR] list.  We can't do that for the same reason we
can't call netlink_broadcast().  So kernel_error_event_iov() now returns
-EINPROGRESS if it had to delay the netlink_broadcast() call.

2. Could the tasklet report netlink_broadcast() failures back to the
higher-level code?  Yes, we could implement a per-group callback to handle
that.  Current thinking is that it's overkill.  But it would resolve
the next issue...

3. Given the above, what should the evlog.c caller do when
kernel_error_event_iov() returns -EINPROGRESS?
a. Nothing.  Figure the packet will probably get logged.
b. Just to be safe, report it via printk, the same way we report dropped
packets.
We currently do (a).  (b) would mean that every event logged from IRQ
context would be cc-ed to printk.
-----
--------------1C2AB73BB6D657AFF025223B
Content-Type: text/plain; charset=us-ascii;
 name="kerror.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kerror.patch.txt"

--- kerror.c.old	Thu Jul 17 10:53:19 2003
+++ kerror.c	Thu Jul 17 10:54:55 2003
@@ -3,10 +3,12 @@
  * Copyright (C) 2003 David S. Miller (davem@redhat.com)
  * June 2003 - Jim Keniston and Dan Stekloff (kenistoj and dsteklof@us.ibm.com)
  *	Fixed a couple of bugs and added iovec interface.
+ * July 2003 - Jim Keniston - Added handling of packets logged from IRQ context.
  */
 
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/interrupt.h>
 #include <linux/skbuff.h>
 #include <linux/socket.h>
 #include <linux/netlink.h>
@@ -17,6 +19,33 @@
 
 static struct sock *kerror_nl;
 
+/* Packets logged from IRQ context are queued for broadcast by a tasklet. */
+static struct sk_buff_head delayed_pkts;
+static void broadcast_delayed_pkts(unsigned long);
+static DECLARE_TASKLET(delayed_pkts_tasklet, broadcast_delayed_pkts, 0);
+
+/**
+ * delayed_broadcast() - Schedule a tasklet to broadcast a packet.
+ * We want to broadcast the indicated packet, but can't because we're
+ * in a hardware interrupt and so can't call netlink_broadcast().
+ * Schedule a tasklet to do the job.
+ *
+ * @skb: the socket buffer to broadcast
+ */
+static void delayed_broadcast(struct sk_buff *skb)
+{
+	skb_queue_tail(&delayed_pkts, skb);
+	tasklet_schedule(&delayed_pkts_tasklet);
+}
+
+static void broadcast_delayed_pkts(unsigned long ignored)
+{
+	struct sk_buff *skb;
+	while ((skb = skb_dequeue(&delayed_pkts)) != NULL) {
+		(void) netlink_broadcast(kerror_nl, skb, 0, ~0, GFP_ATOMIC);
+	}
+}
+
 /**
  * kernel_error_event_iov() - Broadcast packet to NETLINK_KERROR sockets.
  * @iov: the packet's data
@@ -54,6 +83,11 @@
 
 	NETLINK_CB(skb).dst_groups = groups;
 
+	if (in_irq()) {
+		delayed_broadcast(skb);
+		return -EINPROGRESS;
+	}
+
 	return netlink_broadcast(kerror_nl, skb, 0, ~0, GFP_ATOMIC);
 
 nlmsg_failure:
@@ -85,6 +119,7 @@
 	if (kerror_nl == NULL)
 		panic("kerror_init: cannot initialize kerror_nl\n");
 
+	skb_queue_head_init(&delayed_pkts);
 	return 0;
 }
 

--------------1C2AB73BB6D657AFF025223B--

