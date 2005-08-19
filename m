Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbVHSVWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbVHSVWl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVHSVWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:22:41 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:33999 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965166AbVHSVWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:22:40 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: netdev@oss.sgi.com, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050817162324.GA24495@elte.hu>
References: <20050816170805.GA12959@elte.hu>
	 <1124214647.5764.40.camel@localhost.localdomain>
	 <1124215631.5764.43.camel@localhost.localdomain>
	 <1124218245.5764.52.camel@localhost.localdomain>
	 <1124252419.5764.83.camel@localhost.localdomain>
	 <1124257580.5764.105.camel@localhost.localdomain>
	 <20050817064750.GA8395@elte.hu>
	 <1124287505.5764.141.camel@localhost.localdomain>
	 <1124288677.5764.154.camel@localhost.localdomain>
	 <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 19 Aug 2005 17:22:28 -0400
Message-Id: <1124486548.18408.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 18:23 +0200, Ingo Molnar wrote:

> 
> > And it goes on and on. This happens everytime. Without netconsole, I
> > only get the nonzero lock count error. Also, one of my lockups on SMP
> > had to do with the kernel_thread_helper:
> > 
> > Using IPI Shortcut mode
> > khelper/794[CPU#0]: BUG in set_new_owner at kernel/rt.c:916

This was with netconsole and showed up after a bunch of other bugs. So
this is a side effect of what happened earlier.
> 
> this is a 'must not happen'. Somehow lock->held list got non-empty.  
> Maybe some use-after-free thing? Havent seen it myself.
> 

I started debugging netconsole with the RT patch and found this
happening.  After seeing what's wrong, I looked at the latest git
branch, and it seems to already have a similar solution that I was going
to make. Here's a description of what's wrong.

In net/core/dev.c the following code is in net_rx_action:

		netpoll_poll_lock(dev);

		if (dev->quota <= 0 || dev->poll(dev, &budget)) {
			netpoll_poll_unlock(dev);
			raw_local_irq_disable();
			list_del(&dev->poll_list);
			list_add_tail(&dev->poll_list, &queue->poll_list);
			if (dev->quota < 0)
				dev->quota += dev->weight;
			else
				dev->quota = dev->weight;
		} else {
			netpoll_poll_unlock(dev);

The netpoll_poll_lock and netpoll_poll_unlock look like this (in current RT):

static inline netpoll_poll_lock(struct net_device *dev)
{
	if (dev->npinfo) {
		spin_lock(&dev->npinfo->poll_lock);
		dev->npinfo->poll_owner = smp_processor_id();
	}
}

static inline void netpoll_poll_unlock(struct net_device *dev)
{
	if (dev->npinfo) {
		dev->npinfo->poll_owner = -1;
		spin_unlock(&dev->npinfo->poll_lock);
	}
}


The problem here is that between netpoll_poll_lock and
netpoll_poll_unlock the dev->npinfo gets assigned. So we unlock the
dev->npinfo->poll_lock without ever locking it.

Here's the port from the latest git to solve this. I've CCed the netdev,
since I'm not sure I got all the places for rcu_lock for the netpoll. At
least to solve this problem.  I did boot up the kernel and this patch
did fix my bugs that I was getting using netconsole. (I have one more
patch to send to fix the illegal API messages).

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_ernie/include/linux/netpoll.h
===================================================================
--- linux_realtime_ernie/include/linux/netpoll.h	(revision 296)
+++ linux_realtime_ernie/include/linux/netpoll.h	(working copy)
@@ -60,25 +60,31 @@
 	return ret;
 }
 
-static inline void netpoll_poll_lock(struct net_device *dev)
+static inline void *netpoll_poll_lock(struct net_device *dev)
 {
+	rcu_read_lock();
 	if (dev->npinfo) {
 		spin_lock(&dev->npinfo->poll_lock);
 		dev->npinfo->poll_owner = smp_processor_id();
+		return dev->npinfo;
 	}
+	return NULL;
 }
 
-static inline void netpoll_poll_unlock(struct net_device *dev)
+static inline void netpoll_poll_unlock(void *have)
 {
-	if (dev->npinfo) {
-		dev->npinfo->poll_owner = -1;
-		spin_unlock(&dev->npinfo->poll_lock);
+	struct netpoll_info *npi = have;
+
+	if (npi) {
+		npi->poll_owner = -1;
+		spin_unlock(&npi->poll_lock);
 	}
+	rcu_read_unlock();
 }
 
 #else
 #define netpoll_rx(a) 0
-#define netpoll_poll_lock(a)
+#define netpoll_poll_lock(a) 0
 #define netpoll_poll_unlock(a)
 #endif
 
Index: linux_realtime_ernie/net/core/netpoll.c
===================================================================
--- linux_realtime_ernie/net/core/netpoll.c	(revision 296)
+++ linux_realtime_ernie/net/core/netpoll.c	(working copy)
@@ -726,6 +726,9 @@
 	/* last thing to do is link it to the net device structure */
 	ndev->npinfo = npinfo;
 
+	/* avoid racing with NAPI reading npinfo */
+	synchronize_rcu();
+
 	return 0;
 
  release:
Index: linux_realtime_ernie/net/core/dev.c
===================================================================
--- linux_realtime_ernie/net/core/dev.c	(revision 296)
+++ linux_realtime_ernie/net/core/dev.c	(working copy)
@@ -1723,6 +1723,7 @@
 
 	while (!list_empty(&queue->poll_list)) {
 		struct net_device *dev;
+		void *have;
 
 		if (budget <= 0 || jiffies - start_time > 1)
 			goto softnet_break;
@@ -1735,10 +1736,10 @@
 
 		dev = list_entry(queue->poll_list.next,
 				 struct net_device, poll_list);
-		netpoll_poll_lock(dev);
+		have = netpoll_poll_lock(dev);
 
 		if (dev->quota <= 0 || dev->poll(dev, &budget)) {
-			netpoll_poll_unlock(dev);
+			netpoll_poll_unlock(have);
 			raw_local_irq_disable();
 			list_del(&dev->poll_list);
 			list_add_tail(&dev->poll_list, &queue->poll_list);
@@ -1747,7 +1748,7 @@
 			else
 				dev->quota = dev->weight;
 		} else {
-			netpoll_poll_unlock(dev);
+			netpoll_poll_unlock(have);
 			dev_put(dev);
 			raw_local_irq_disable();
 		}


