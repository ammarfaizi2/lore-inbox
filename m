Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316773AbSFFEFV>; Thu, 6 Jun 2002 00:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSFFEFU>; Thu, 6 Jun 2002 00:05:20 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:44228 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S316773AbSFFEFR>; Thu, 6 Jun 2002 00:05:17 -0400
Message-ID: <3CFEDE73.80202@didntduck.org>
Date: Thu, 06 Jun 2002 00:00:51 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] More list_del_init cleanups
Content-Type: multipart/mixed;
 boundary="------------090804090008090505010500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090804090008090505010500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Clean up some other instances of list_del + INIT_LIST_HEAD.

--
				Brian Gerst

--------------090804090008090505010500
Content-Type: text/plain;
 name="list_del_init-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="list_del_init-1"

diff -urN linux-bk/drivers/md/md.c linux/drivers/md/md.c
--- linux-bk/drivers/md/md.c	Wed May 29 15:06:00 2002
+++ linux/drivers/md/md.c	Wed Jun  5 09:53:51 2002
@@ -626,8 +626,7 @@
 		MD_BUG();
 		return;
 	}
-	list_del(&rdev->same_set);
-	INIT_LIST_HEAD(&rdev->same_set);
+	list_del_init(&rdev->same_set);
 	rdev->mddev->nb_dev--;
 	printk(KERN_INFO "md: unbind<%s,%d>\n", partition_name(rdev->dev),
 						 rdev->mddev->nb_dev);
@@ -680,13 +679,11 @@
 		MD_BUG();
 	unlock_rdev(rdev);
 	free_disk_sb(rdev);
-	list_del(&rdev->all);
-	INIT_LIST_HEAD(&rdev->all);
+	list_del_init(&rdev->all);
 	if (rdev->pending.next != &rdev->pending) {
 		printk(KERN_INFO "md: (%s was pending)\n",
 			partition_name(rdev->dev));
-		list_del(&rdev->pending);
-		INIT_LIST_HEAD(&rdev->pending);
+		list_del_init(&rdev->pending);
 	}
 #ifndef MODULE
 	md_autodetect_dev(rdev->dev);
@@ -745,8 +742,7 @@
 		schedule();
 
 	del_mddev_mapping(mddev, mk_kdev(MD_MAJOR, mdidx(mddev)));
-	list_del(&mddev->all_mddevs);
-	INIT_LIST_HEAD(&mddev->all_mddevs);
+	list_del_init(&mddev->all_mddevs);
 	kfree(mddev);
 	MOD_DEC_USE_COUNT;
 }
@@ -1963,8 +1959,7 @@
 		printk(KERN_INFO "md: created md%d\n", mdidx(mddev));
 		ITERATE_RDEV_GENERIC(candidates,pending,rdev,tmp) {
 			bind_rdev_to_array(rdev, mddev);
-			list_del(&rdev->pending);
-			INIT_LIST_HEAD(&rdev->pending);
+			list_del_init(&rdev->pending);
 		}
 		autorun_array(mddev);
 	}
diff -urN linux-bk/drivers/usb/class/audio.c linux/drivers/usb/class/audio.c
--- linux-bk/drivers/usb/class/audio.c	Sat May 25 01:54:28 2002
+++ linux/drivers/usb/class/audio.c	Wed Jun  5 09:50:44 2002
@@ -3832,8 +3832,7 @@
 		return;
 	}
 	down(&open_sem);
-	list_del(&s->audiodev);
-	INIT_LIST_HEAD(&s->audiodev);
+	list_del_init(&s->audiodev);
 	s->usbdev = NULL;
 	/* deregister all audio and mixer devices, so no new processes can open this device */
 	for(list = s->audiolist.next; list != &s->audiolist; list = list->next) {
diff -urN linux-bk/drivers/usb/core/devio.c linux/drivers/usb/core/devio.c
--- linux-bk/drivers/usb/core/devio.c	Sat May 25 01:54:28 2002
+++ linux/drivers/usb/core/devio.c	Wed Jun  5 09:51:45 2002
@@ -215,8 +215,7 @@
         unsigned long flags;
         
         spin_lock_irqsave(&ps->lock, flags);
-        list_del(&as->asynclist);
-        INIT_LIST_HEAD(&as->asynclist);
+        list_del_init(&as->asynclist);
         spin_unlock_irqrestore(&ps->lock, flags);
 }
 
@@ -228,8 +227,7 @@
         spin_lock_irqsave(&ps->lock, flags);
         if (!list_empty(&ps->async_completed)) {
                 as = list_entry(ps->async_completed.next, struct async, asynclist);
-                list_del(&as->asynclist);
-                INIT_LIST_HEAD(&as->asynclist);
+                list_del_init(&as->asynclist);
         }
         spin_unlock_irqrestore(&ps->lock, flags);
         return as;
@@ -247,8 +245,7 @@
                 p = p->next;
                 if (as->userurb != userurb)
                         continue;
-                list_del(&as->asynclist);
-                INIT_LIST_HEAD(&as->asynclist);
+                list_del_init(&as->asynclist);
                 spin_unlock_irqrestore(&ps->lock, flags);
                 return as;
         }
@@ -284,8 +281,7 @@
         spin_lock_irqsave(&ps->lock, flags);
         while (!list_empty(&ps->async_pending)) {
                 as = list_entry(ps->async_pending.next, struct async, asynclist);
-                list_del(&as->asynclist);
-                INIT_LIST_HEAD(&as->asynclist);
+                list_del_init(&as->asynclist);
                 spin_unlock_irqrestore(&ps->lock, flags);
                 /* usb_unlink_urb calls the completion handler with status == -ENOENT */
                 usb_unlink_urb(as->urb);
@@ -528,8 +524,7 @@
 	unsigned int i;
 
 	lock_kernel();
-	list_del(&ps->list);
-	INIT_LIST_HEAD(&ps->list);
+	list_del_init(&ps->list);
 	if (ps->dev) {
 		for (i = 0; ps->ifclaimed && i < 8*sizeof(ps->ifclaimed); i++)
 			if (test_bit(i, &ps->ifclaimed))
diff -urN linux-bk/drivers/usb/core/hub.c linux/drivers/usb/core/hub.c
--- linux-bk/drivers/usb/core/hub.c	Wed May 29 15:06:00 2002
+++ linux/drivers/usb/core/hub.c	Wed Jun  5 09:52:49 2002
@@ -499,10 +499,8 @@
 	spin_lock_irqsave(&hub_event_lock, flags);
 
 	/* Delete it and then reset it */
-	list_del(&hub->event_list);
-	INIT_LIST_HEAD(&hub->event_list);
-	list_del(&hub->hub_list);
-	INIT_LIST_HEAD(&hub->hub_list);
+	list_del_init(&hub->event_list);
+	list_del_init(&hub->hub_list);
 
 	spin_unlock_irqrestore(&hub_event_lock, flags);
 
@@ -519,10 +517,8 @@
 	spin_lock_irqsave(&hub_event_lock, flags);
 
 	/* Delete it and then reset it */
-	list_del(&hub->event_list);
-	INIT_LIST_HEAD(&hub->event_list);
-	list_del(&hub->hub_list);
-	INIT_LIST_HEAD(&hub->hub_list);
+	list_del_init(&hub->event_list);
+	list_del_init(&hub->hub_list);
 
 	spin_unlock_irqrestore(&hub_event_lock, flags);
 
@@ -946,8 +942,7 @@
 		hub = list_entry(tmp, struct usb_hub, event_list);
 		dev = hub->dev;
 
-		list_del(tmp);
-		INIT_LIST_HEAD(tmp);
+		list_del_init(tmp);
 
 		down(&hub->khubd_sem); /* never blocks, we were on list */
 		spin_unlock_irqrestore(&hub_event_lock, flags);
diff -urN linux-bk/drivers/usb/core/inode.c linux/drivers/usb/core/inode.c
--- linux-bk/drivers/usb/core/inode.c	Tue Jun  4 23:54:33 2002
+++ linux/drivers/usb/core/inode.c	Wed Jun  5 09:53:00 2002
@@ -672,8 +672,7 @@
 	}
 	while (!list_empty(&dev->filelist)) {
 		ds = list_entry(dev->filelist.next, struct dev_state, list);
-		list_del(&ds->list);
-		INIT_LIST_HEAD(&ds->list);
+		list_del_init(&ds->list);
 		down_write(&ds->devsem);
 		ds->dev = NULL;
 		up_write(&ds->devsem);
diff -urN linux-bk/drivers/usb/host/hc_simple.c linux/drivers/usb/host/hc_simple.c
--- linux-bk/drivers/usb/host/hc_simple.c	Wed May 29 15:06:00 2002
+++ linux/drivers/usb/host/hc_simple.c	Wed Jun  5 09:49:59 2002
@@ -560,8 +560,7 @@
 	epd_t *ed = &hci_dev->ed[qu_pipeindex (urb->pipe)];
 
 	DBGFUNC ("enter qu_next_urb\n");
-	list_del (&urb->urb_list);
-	INIT_LIST_HEAD (&urb->urb_list);
+	list_del_init (&urb->urb_list);
 	if (ed->pipe_head == urb) {
 
 #ifdef HC_URB_TIMEOUT
@@ -574,8 +573,7 @@
 
 		if (!list_empty (&ed->urb_queue)) {
 			urb = list_entry (ed->urb_queue.next, struct urb, urb_list);
-			list_del (&urb->urb_list);
-			INIT_LIST_HEAD (&urb->urb_list);
+			list_del_init (&urb->urb_list);
 			ed->pipe_head = urb;
 			qu_queue_active_urb (hci, urb, ed);
 		} else {
diff -urN linux-bk/drivers/usb/host/hc_sl811.c linux/drivers/usb/host/hc_sl811.c
--- linux-bk/drivers/usb/host/hc_sl811.c	Wed May 29 15:06:00 2002
+++ linux/drivers/usb/host/hc_sl811.c	Wed Jun  5 09:50:25 2002
@@ -1206,8 +1206,7 @@
 	usb_deregister_bus (hci->bus);
 	usb_free_bus (hci->bus);
 
-	list_del (&hci->hci_hcd_list);
-	INIT_LIST_HEAD (&hci->hci_hcd_list);
+	list_del_init (&hci->hci_hcd_list);
 
 	kfree (hci);
 }
diff -urN linux-bk/drivers/usb/host/usb-ohci.c linux/drivers/usb/host/usb-ohci.c
--- linux-bk/drivers/usb/host/usb-ohci.c	Sun Jun  2 21:55:29 2002
+++ linux/drivers/usb/host/usb-ohci.c	Wed Jun  5 09:49:29 2002
@@ -2425,8 +2425,7 @@
 		usb_free_bus (ohci->bus);
 	}
 
-	list_del (&ohci->ohci_hcd_list);
-	INIT_LIST_HEAD (&ohci->ohci_hcd_list);
+	list_del_init (&ohci->ohci_hcd_list);
 
 	ohci_mem_cleanup (ohci);
     
diff -urN linux-bk/fs/dquot.c linux/fs/dquot.c
--- linux-bk/fs/dquot.c	Wed May 29 15:06:00 2002
+++ linux/fs/dquot.c	Wed Jun  5 09:56:16 2002
@@ -190,8 +190,7 @@
 
 static inline void remove_dquot_hash(struct dquot *dquot)
 {
-	list_del(&dquot->dq_hash);
-	INIT_LIST_HEAD(&dquot->dq_hash);
+	list_del_init(&dquot->dq_hash);
 }
 
 static inline struct dquot *find_dquot(unsigned int hashent, struct super_block *sb, unsigned int id, int type)
@@ -232,8 +231,7 @@
 {
 	if (list_empty(&dquot->dq_free))
 		return;
-	list_del(&dquot->dq_free);
-	INIT_LIST_HEAD(&dquot->dq_free);
+	list_del_init(&dquot->dq_free);
 	dqstats.free_dquots--;
 }
 
@@ -738,8 +736,7 @@
 	while (act_head != tofree_head) {
 		dquot = list_entry(act_head, struct dquot, dq_free);
 		act_head = act_head->next;
-		list_del(&dquot->dq_free);	/* Remove dquot from the list so we won't have problems... */
-		INIT_LIST_HEAD(&dquot->dq_free);
+		list_del_init(&dquot->dq_free);	/* Remove dquot from the list so we won't have problems... */
 		dqput(dquot);
 	}
 	unlock_kernel();
diff -urN linux-bk/fs/hfs/catalog.c linux/fs/hfs/catalog.c
--- linux-bk/fs/hfs/catalog.c	Thu Mar  7 21:18:16 2002
+++ linux/fs/hfs/catalog.c	Wed Jun  5 09:54:53 2002
@@ -158,8 +158,7 @@
 
 static inline void remove_hash(struct hfs_cat_entry *entry)
 {
-	list_del(&entry->hash);
-	INIT_LIST_HEAD(&entry->hash);
+	list_del_init(&entry->hash);
 }
 
 /*
@@ -223,8 +222,7 @@
 {
         if (!(entry->state & HFS_DELETED)) {
 	        entry->state |= HFS_DELETED;
-		list_del(&entry->hash);
-		INIT_LIST_HEAD(&entry->hash);
+		list_del_init(&entry->hash);
 
 	        if (entry->type == HFS_CDR_FIL) {
 		  /* free all extents */
@@ -882,8 +880,7 @@
 		}
 
 		if (!entry->count) {
-		        list_del(&entry->hash);
-			INIT_LIST_HEAD(&entry->hash);
+		        list_del_init(&entry->hash);
 			list_del(&entry->list);
 			list_add(&entry->list, dispose);
 			continue;
diff -urN linux-bk/fs/inode.c linux/fs/inode.c
--- linux-bk/fs/inode.c	Tue Jun  4 23:54:33 2002
+++ linux/fs/inode.c	Wed Jun  5 09:57:47 2002
@@ -390,8 +390,7 @@
 		if (atomic_read(&inode->i_count))
 			continue;
 		list_del(tmp);
-		list_del(&inode->i_hash);
-		INIT_LIST_HEAD(&inode->i_hash);
+		list_del_init(&inode->i_hash);
 		list_add(tmp, freeable);
 		inode->i_state |= I_FREEING;
 		count++;
@@ -777,8 +776,7 @@
 void remove_inode_hash(struct inode *inode)
 {
 	spin_lock(&inode_lock);
-	list_del(&inode->i_hash);
-	INIT_LIST_HEAD(&inode->i_hash);
+	list_del_init(&inode->i_hash);
 	spin_unlock(&inode_lock);
 }
 
@@ -786,10 +784,8 @@
 {
 	struct super_operations *op = inode->i_sb->s_op;
 
-	list_del(&inode->i_hash);
-	INIT_LIST_HEAD(&inode->i_hash);
-	list_del(&inode->i_list);
-	INIT_LIST_HEAD(&inode->i_list);
+	list_del_init(&inode->i_hash);
+	list_del_init(&inode->i_list);
 	inode->i_state|=I_FREEING;
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
diff -urN linux-bk/fs/intermezzo/psdev.c linux/fs/intermezzo/psdev.c
--- linux-bk/fs/intermezzo/psdev.c	Tue May 21 01:54:12 2002
+++ linux/fs/intermezzo/psdev.c	Wed Jun  5 09:55:33 2002
@@ -162,8 +162,7 @@
                 if (tmp->rq_unique == hdr.unique) {
                         req = tmp;
                       /* unlink here: keeps search length minimal */
-                        list_del(&req->rq_chain);
-                      INIT_LIST_HEAD(&req->rq_chain);
+                        list_del_init(&req->rq_chain);
                         CDEBUG(D_PSDEV,"Eureka opc %d uniq %d!\n",
                                hdr.opcode, hdr.unique);
                         break;
@@ -1442,8 +1441,7 @@
                 schedule();
 
         }
-      list_del(&req->rq_chain); 
-      INIT_LIST_HEAD(&req->rq_chain); 
+	list_del_init(&req->rq_chain); 
         remove_wait_queue(&req->rq_sleep, &wait);
         current->state = TASK_RUNNING;
 
diff -urN linux-bk/fs/locks.c linux/fs/locks.c
--- linux-bk/fs/locks.c	Tue Jun  4 23:54:33 2002
+++ linux/fs/locks.c	Wed Jun  5 09:56:58 2002
@@ -397,10 +397,8 @@
  */
 static void locks_delete_block(struct file_lock *waiter)
 {
-	list_del(&waiter->fl_block);
-	INIT_LIST_HEAD(&waiter->fl_block);
-	list_del(&waiter->fl_link);
-	INIT_LIST_HEAD(&waiter->fl_link);
+	list_del_init(&waiter->fl_block);
+	list_del_init(&waiter->fl_link);
 	waiter->fl_next = NULL;
 }
 
diff -urN linux-bk/fs/nfs/write.c linux/fs/nfs/write.c
--- linux-bk/fs/nfs/write.c	Wed May 29 15:06:00 2002
+++ linux/fs/nfs/write.c	Wed Jun  5 09:54:11 2002
@@ -338,8 +338,7 @@
 	if (!NFS_WBACK_BUSY(req))
 		printk(KERN_ERR "NFS: unlocked request attempted unhashed!\n");
 	inode = req->wb_inode;
-	list_del(&req->wb_hash);
-	INIT_LIST_HEAD(&req->wb_hash);
+	list_del_init(&req->wb_hash);
 	nfsi = NFS_I(inode);
 	nfsi->npages--;
 	if ((nfsi->npages == 0) != list_empty(&nfsi->writeback))
diff -urN linux-bk/include/linux/dcache.h linux/include/linux/dcache.h
--- linux-bk/include/linux/dcache.h	Wed Jun  5 00:03:11 2002
+++ linux/include/linux/dcache.h	Wed Jun  5 09:58:00 2002
@@ -156,8 +156,7 @@
 static __inline__ void d_drop(struct dentry * dentry)
 {
 	spin_lock(&dcache_lock);
-	list_del(&dentry->d_hash);
-	INIT_LIST_HEAD(&dentry->d_hash);
+	list_del_init(&dentry->d_hash);
 	spin_unlock(&dcache_lock);
 }
 

--------------090804090008090505010500--

