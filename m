Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWDMXKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWDMXKy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWDMXKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:10:53 -0400
Received: from ns2.suse.de ([195.135.220.15]:22735 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965025AbWDMXKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:10:48 -0400
Date: Thu, 13 Apr 2006 16:09:46 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       chas@cmf.nrl.navy.mil, netdev@vger.kernel.org,
       Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 22/22] atm: clip causes unregister hang
Message-ID: <20060413230946.GW5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="atm-clip-causes-unregister-hang.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

If Classical IP over ATM module is loaded, its neighbor table gets
populated when permanent neighbor entries are created; but these entries
are not flushed when the device is removed. Since the entry never gets
flushed the unregister of the network device never completes.

This version of the patch also adds locking around the reference to
the atm arp daemon to avoid races with events and daemon state changes.
(Note: barrier() was never really safe)

Bug-reference: http://bugzilla.kernel.org/show_bug.cgi?id=6295

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/atm/clip.c |   42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

--- linux-2.6.16.5.orig/net/atm/clip.c
+++ linux-2.6.16.5/net/atm/clip.c
@@ -613,12 +613,19 @@ static int clip_create(int number)
 
 
 static int clip_device_event(struct notifier_block *this,unsigned long event,
-    void *dev)
+			     void *arg)
 {
+	struct net_device *dev = arg;
+
+	if (event == NETDEV_UNREGISTER) {
+		neigh_ifdown(&clip_tbl, dev);
+		return NOTIFY_DONE;
+	}
+
 	/* ignore non-CLIP devices */
-	if (((struct net_device *) dev)->type != ARPHRD_ATM ||
-	    ((struct net_device *) dev)->hard_start_xmit != clip_start_xmit)
+	if (dev->type != ARPHRD_ATM || dev->hard_start_xmit != clip_start_xmit)
 		return NOTIFY_DONE;
+
 	switch (event) {
 		case NETDEV_UP:
 			DPRINTK("clip_device_event NETDEV_UP\n");
@@ -686,14 +693,12 @@ static struct notifier_block clip_inet_n
 static void atmarpd_close(struct atm_vcc *vcc)
 {
 	DPRINTK("atmarpd_close\n");
-	atmarpd = NULL; /* assumed to be atomic */
-	barrier();
-	unregister_inetaddr_notifier(&clip_inet_notifier);
-	unregister_netdevice_notifier(&clip_dev_notifier);
-	if (skb_peek(&sk_atm(vcc)->sk_receive_queue))
-		printk(KERN_ERR "atmarpd_close: closing with requests "
-		    "pending\n");
+
+	rtnl_lock();
+	atmarpd = NULL;
 	skb_queue_purge(&sk_atm(vcc)->sk_receive_queue);
+	rtnl_unlock();
+
 	DPRINTK("(done)\n");
 	module_put(THIS_MODULE);
 }
@@ -714,7 +719,12 @@ static struct atm_dev atmarpd_dev = {
 
 static int atm_init_atmarp(struct atm_vcc *vcc)
 {
-	if (atmarpd) return -EADDRINUSE;
+	rtnl_lock();
+	if (atmarpd) {
+		rtnl_unlock();
+		return -EADDRINUSE;
+	}
+
 	if (start_timer) {
 		start_timer = 0;
 		init_timer(&idle_timer);
@@ -731,10 +741,7 @@ static int atm_init_atmarp(struct atm_vc
 	vcc->push = NULL;
 	vcc->pop = NULL; /* crash */
 	vcc->push_oam = NULL; /* crash */
-	if (register_netdevice_notifier(&clip_dev_notifier))
-		printk(KERN_ERR "register_netdevice_notifier failed\n");
-	if (register_inetaddr_notifier(&clip_inet_notifier))
-		printk(KERN_ERR "register_inetaddr_notifier failed\n");
+	rtnl_unlock();
 	return 0;
 }
 
@@ -992,6 +999,8 @@ static int __init atm_clip_init(void)
 
 	clip_tbl_hook = &clip_tbl;
 	register_atm_ioctl(&clip_ioctl_ops);
+	register_netdevice_notifier(&clip_dev_notifier);
+	register_inetaddr_notifier(&clip_inet_notifier);
 
 #ifdef CONFIG_PROC_FS
 {
@@ -1012,6 +1021,9 @@ static void __exit atm_clip_exit(void)
 
 	remove_proc_entry("arp", atm_proc_root);
 
+	unregister_inetaddr_notifier(&clip_inet_notifier);
+	unregister_netdevice_notifier(&clip_dev_notifier);
+
 	deregister_atm_ioctl(&clip_ioctl_ops);
 
 	/* First, stop the idle timer, so it stops banging

--
