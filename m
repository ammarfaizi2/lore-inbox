Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268581AbUIQJMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268581AbUIQJMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 05:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268594AbUIQJMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 05:12:15 -0400
Received: from fmr12.intel.com ([134.134.136.15]:2259 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S268581AbUIQJLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 05:11:55 -0400
Subject: Re: hotplug e1000 failed after 32 times
From: Li Shaohua <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20040916221406.1f3764e0.akpm@osdl.org>
References: <1095396793.10407.9.camel@sli10-desk.sh.intel.com>
	 <20040916221406.1f3764e0.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-XuxFUbK9CKS+hSzDa/M4"
Message-Id: <1095411933.10407.29.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Sep 2004 17:05:34 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XuxFUbK9CKS+hSzDa/M4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-09-17 at 13:14, Andrew Morton wrote:
> Li Shaohua <shaohua.li@intel.com> wrote:
> >
> > I'm testing a hotplug driver. In my test, I will hot add/remove an e1000
> >  NIC frequently. The result is my hot add failed after 32 times hotadd.
> >  After looking at the code of e1000 driver, I found
> >  e1000_adapter->bd_number has maxium limitation of 32, and it increased
> >  one every hot add. Looks like the remove driver routine didn't free the
> >  'bd_number', so hot add failed after 32 times. Below patch fixes this
> >  issue.
> 
> Yeah.  I think you'll find that damn near every net driver in the kernel
> has this problem.  I think it would be better to create a little suite of
> library functions in net/core/dev.c to handle this situation.
<snip>
Here is the patch adding the API as you suggested.

Thanks,
Shaohua


Signed-off-by: Li Shaohua <shaohua.li@intel.com>
===== lib/idr.c 1.10 vs edited =====
--- 1.10/lib/idr.c	2004-08-23 16:14:51 +08:00
+++ edited/lib/idr.c	2004-09-17 15:53:47 +08:00
@@ -39,8 +39,10 @@ static struct idr_layer *alloc_layer(str
 	struct idr_layer *p;
 
 	spin_lock(&idp->lock);
-	if (!(p = idp->id_free))
+	if (!(p = idp->id_free)) {
+		spin_unlock(&idp->lock);
 		return NULL;
+	}
 	idp->id_free = p->ary[0];
 	idp->id_free_cnt--;
 	p->ary[0] = NULL;
===== include/linux/netdevice.h 1.89 vs edited =====
--- 1.89/include/linux/netdevice.h	2004-09-13 07:52:49 +08:00
+++ edited/include/linux/netdevice.h	2004-09-17 15:54:41 +08:00
@@ -154,6 +154,7 @@ enum {
 
 #include <linux/cache.h>
 #include <linux/skbuff.h>
+#include <linux/idr.h>
 
 struct neighbour;
 struct neigh_parms;
@@ -503,6 +504,16 @@ static inline void *netdev_priv(struct n
  * if set prior to registration will cause a symlink during
initialization.
  */
 #define SET_NETDEV_DEV(net, pdev)	((net)->class_dev.dev = (pdev))
+
+struct net_boards {
+	struct idr idr;
+	int max_boards;
+	spinlock_t lock;
+};
+
+void net_boards_init(struct net_boards *board, int max_boards);
+int net_boards_alloc(struct net_boards *board);
+int net_boards_free(struct net_boards *board, int board_no);
 
 struct packet_type {
 	unsigned short		type;	/* This is really htons(ether_type).	*/
===== net/core/dev.c 1.165 vs edited =====
--- 1.165/net/core/dev.c	2004-09-13 07:23:46 +08:00
+++ edited/net/core/dev.c	2004-09-17 15:52:43 +08:00
@@ -3220,6 +3220,53 @@ static int dev_cpu_callback(struct notif
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+void net_boards_init(struct net_boards *board, int max_boards)
+{
+	if (!board || (max_boards < 0))
+		return;
+	idr_init(&board->idr);
+	board->max_boards = max_boards;
+	spin_lock_init(&board->lock);
+}
+
+/*
+ * return -1 on error, >= 0 on success
+ */
+int net_boards_alloc(struct net_boards *board)
+{
+	int ret, error;
+
+	if (!board)
+		return -1;
+retry:
+	if (idr_pre_get(&board->idr, GFP_KERNEL) == 0)
+		return -1;
+
+	spin_lock(&board->lock);
+	error = idr_get_new(&board->idr, NULL, &ret);
+	spin_unlock(&board->lock);
+	if (error == -EAGAIN)
+		goto retry;
+	else if (error)
+		return -1;
+	if (ret > board->max_boards) {
+		spin_lock(&board->lock);
+		idr_remove(&board->idr, ret);
+		spin_unlock(&board->lock);
+		return -1;
+	}
+	return ret;
+}
+
+int net_boards_free(struct net_boards *board, int board_no)
+{
+	if ((board_no < 0) || (board_no > board->max_boards))
+		return -1;
+	spin_lock(&board->lock);
+	idr_remove(&board->idr, board_no);
+	spin_unlock(&board->lock);
+	return 0;
+}
 
 /*
  *	Initialize the DEV module. At boot time this walks the device list
and
@@ -3296,6 +3343,9 @@ out:
 
 subsys_initcall(net_dev_init);
 
+EXPORT_SYMBOL(net_boards_init);
+EXPORT_SYMBOL(net_boards_alloc);
+EXPORT_SYMBOL(net_boards_free);
 EXPORT_SYMBOL(__dev_get);
 EXPORT_SYMBOL(__dev_get_by_flags);
 EXPORT_SYMBOL(__dev_get_by_index);



--=-XuxFUbK9CKS+hSzDa/M4
Content-Disposition: attachment; filename=nic.patch
Content-Type: text/x-patch; name=nic.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== lib/idr.c 1.10 vs edited =====
--- 1.10/lib/idr.c	2004-08-23 16:14:51 +08:00
+++ edited/lib/idr.c	2004-09-17 15:53:47 +08:00
@@ -39,8 +39,10 @@ static struct idr_layer *alloc_layer(str
 	struct idr_layer *p;
 
 	spin_lock(&idp->lock);
-	if (!(p = idp->id_free))
+	if (!(p = idp->id_free)) {
+		spin_unlock(&idp->lock);
 		return NULL;
+	}
 	idp->id_free = p->ary[0];
 	idp->id_free_cnt--;
 	p->ary[0] = NULL;
===== include/linux/netdevice.h 1.89 vs edited =====
--- 1.89/include/linux/netdevice.h	2004-09-13 07:52:49 +08:00
+++ edited/include/linux/netdevice.h	2004-09-17 15:54:41 +08:00
@@ -154,6 +154,7 @@ enum {
 
 #include <linux/cache.h>
 #include <linux/skbuff.h>
+#include <linux/idr.h>
 
 struct neighbour;
 struct neigh_parms;
@@ -503,6 +504,16 @@ static inline void *netdev_priv(struct n
  * if set prior to registration will cause a symlink during initialization.
  */
 #define SET_NETDEV_DEV(net, pdev)	((net)->class_dev.dev = (pdev))
+
+struct net_boards {
+	struct idr idr;
+	int max_boards;
+	spinlock_t lock;
+};
+
+void net_boards_init(struct net_boards *board, int max_boards);
+int net_boards_alloc(struct net_boards *board);
+int net_boards_free(struct net_boards *board, int board_no);
 
 struct packet_type {
 	unsigned short		type;	/* This is really htons(ether_type).	*/
===== net/core/dev.c 1.165 vs edited =====
--- 1.165/net/core/dev.c	2004-09-13 07:23:46 +08:00
+++ edited/net/core/dev.c	2004-09-17 15:52:43 +08:00
@@ -3220,6 +3220,53 @@ static int dev_cpu_callback(struct notif
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+void net_boards_init(struct net_boards *board, int max_boards)
+{
+	if (!board || (max_boards < 0))
+		return;
+	idr_init(&board->idr);
+	board->max_boards = max_boards;
+	spin_lock_init(&board->lock);
+}
+
+/*
+ * return -1 on error, >= 0 on success
+ */
+int net_boards_alloc(struct net_boards *board)
+{
+	int ret, error;
+
+	if (!board)
+		return -1;
+retry:
+	if (idr_pre_get(&board->idr, GFP_KERNEL) == 0)
+		return -1;
+
+	spin_lock(&board->lock);
+	error = idr_get_new(&board->idr, NULL, &ret);
+	spin_unlock(&board->lock);
+	if (error == -EAGAIN)
+		goto retry;
+	else if (error)
+		return -1;
+	if (ret > board->max_boards) {
+		spin_lock(&board->lock);
+		idr_remove(&board->idr, ret);
+		spin_unlock(&board->lock);
+		return -1;
+	}
+	return ret;
+}
+
+int net_boards_free(struct net_boards *board, int board_no)
+{
+	if ((board_no < 0) || (board_no > board->max_boards))
+		return -1;
+	spin_lock(&board->lock);
+	idr_remove(&board->idr, board_no);
+	spin_unlock(&board->lock);
+	return 0;
+}
 
 /*
  *	Initialize the DEV module. At boot time this walks the device list and
@@ -3296,6 +3343,9 @@ out:
 
 subsys_initcall(net_dev_init);
 
+EXPORT_SYMBOL(net_boards_init);
+EXPORT_SYMBOL(net_boards_alloc);
+EXPORT_SYMBOL(net_boards_free);
 EXPORT_SYMBOL(__dev_get);
 EXPORT_SYMBOL(__dev_get_by_flags);
 EXPORT_SYMBOL(__dev_get_by_index);

--=-XuxFUbK9CKS+hSzDa/M4--

