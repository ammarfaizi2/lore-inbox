Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281225AbRKEQeJ>; Mon, 5 Nov 2001 11:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281222AbRKEQdv>; Mon, 5 Nov 2001 11:33:51 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:54262 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281217AbRKEQdl>;
	Mon, 5 Nov 2001 11:33:41 -0500
Date: Sat, 3 Nov 2001 16:29:15 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, acme@conectiva.com.br
Subject: [PATCH] net/core/dev.c jiffies cleanup
Message-ID: <20011103162914.A12523@lynx.no>
Mail-Followup-To: torvalds@transmeta.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	acme@conectiva.com.br
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Alan,
here is the first of the jiffies cleanups, this one of the files that
Tim Schmielau flagged as "suspicious" users of jiffies.  Yes, I'm
selfish, I'll only be sending patches for now for drivers/subsystems
that I actually use.  The jiffies audit should probably become an
item on the kernel janitor list of things to do (Arnaldo CC'd).

Some places in the network code are hairy users of jiffies values,
and it is not always clear that they are being used safely, but I
can only do my best.

Where possible, I've also moved end-time calculations outside the
loop and removed some confusing uses of "now".

Cheers, Andreas
=========================================================================
--- linux/net/core/dev.c.orig	Thu Oct 25 02:55:57 2001
+++ linux/net/core/dev.c	Fri Nov  2 22:47:49 2001
@@ -1407,7 +1407,7 @@
 {
 	int this_cpu = smp_processor_id();
 	struct softnet_data *queue = &softnet_data[this_cpu];
-	unsigned long start_time = jiffies;
+	unsigned long end_time = jiffies + 1;
 	int bugdet = netdev_max_backlog;
 
 	br_read_lock(BR_NETPROTO_LOCK);
@@ -1504,7 +1504,7 @@
 
 		dev_put(rx_dev);
 
-		if (bugdet-- < 0 || jiffies - start_time > 1)
+		if (bugdet-- < 0 || time_after(jiffies, end_time))
 			goto softnet_break;
 
 #ifdef CONFIG_NET_HW_FLOWCONTROL
@@ -2585,7 +2585,7 @@
 
 int unregister_netdevice(struct net_device *dev)
 {
-	unsigned long now, warning_time;
+	unsigned long notify_time, warning_time;
 	struct net_device *d, **dp;
 
 	/* If device is running, close it first. */
@@ -2686,20 +2686,21 @@
 
 	 */
 
-	now = warning_time = jiffies;
+	notify_time = jiffies + 1*HZ;
+	warning_time = jiffies + 10*HZ;
 	while (atomic_read(&dev->refcnt) != 1) {
-		if ((jiffies - now) > 1*HZ) {
+		if (time_after(jiffies, notify_time)) {
 			/* Rebroadcast unregister notification */
 			notifier_call_chain(&netdev_chain, NETDEV_UNREGISTER, dev);
 		}
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(HZ/4);
 		current->state = TASK_RUNNING;
-		if ((jiffies - warning_time) > 10*HZ) {
-			printk(KERN_EMERG "unregister_netdevice: waiting for %s to "
-					"become free. Usage count = %d\n",
+		if (time_after(jiffies, warning_time)) {
+			printk(KERN_EMERG "unregister_netdevice: waiting for %s"
+					" to become free. Usage count = %d\n",
 					dev->name, atomic_read(&dev->refcnt));
-			warning_time = jiffies;
+			warning_time = jiffies + 10*HZ;
 		}
 	}
 	dev_put(dev);
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

