Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262642AbTCYNmB>; Tue, 25 Mar 2003 08:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262643AbTCYNmB>; Tue, 25 Mar 2003 08:42:01 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:48060 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S262642AbTCYNl1>; Tue, 25 Mar 2003 08:41:27 -0500
Message-ID: <3E805F0C.90804@quark.didntduck.org>
Date: Tue, 25 Mar 2003 08:52:12 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] convert code to use list_move()
Content-Type: multipart/mixed;
 boundary="------------030007010704070207000909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030007010704070207000909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch converts a bunch of list_del(x); list_add(x,y) to list_move(x,y).

--
				Brian Gerst

--------------030007010704070207000909
Content-Type: text/plain;
 name="list_move-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="list_move-1"

diff -ur linux-2.5.66/arch/i386/pci/pcbios.c linux/arch/i386/pci/pcbios.c
--- linux-2.5.66/arch/i386/pci/pcbios.c	2003-03-24 19:29:39.000000000 -0500
+++ linux/arch/i386/pci/pcbios.c	2003-03-25 07:59:10.000000000 -0500
@@ -380,8 +380,7 @@
 			for (ln=pci_devices.next; ln != &pci_devices; ln=ln->next) {
 				d = pci_dev_g(ln);
 				if (d->bus->number == bus && d->devfn == devfn) {
-					list_del(&d->global_list);
-					list_add_tail(&d->global_list, &sorted_devices);
+					list_move_tail(&d->global_list, &sorted_devices);
 					if (d == dev)
 						found = 1;
 					break;
@@ -399,8 +398,7 @@
 		if (!found) {
 			printk(KERN_WARNING "PCI: Device %02x:%02x not found by BIOS\n",
 				dev->bus->number, dev->devfn);
-			list_del(&dev->global_list);
-			list_add_tail(&dev->global_list, &sorted_devices);
+			list_move_tail(&dev->global_list, &sorted_devices);
 		}
 	}
 	list_splice(&sorted_devices, &pci_devices);
diff -ur linux-2.5.66/arch/m68k/mm/memory.c linux/arch/m68k/mm/memory.c
--- linux-2.5.66/arch/m68k/mm/memory.c	2003-03-24 19:29:40.000000000 -0500
+++ linux/arch/m68k/mm/memory.c	2003-03-25 07:59:10.000000000 -0500
@@ -98,8 +98,7 @@
 	PD_MARKBITS(dp) = mask & ~tmp;
 	if (!PD_MARKBITS(dp)) {
 		/* move to end of list */
-		list_del(dp);
-		list_add_tail(dp, &ptable_list);
+		list_move_tail(dp, &ptable_list);
 	}
 	return (pmd_t *) (page_address(PD_PAGE(dp)) + off);
 }
@@ -127,8 +126,7 @@
 		 * move this descriptor to the front of the list, since
 		 * it has one or more free tables.
 		 */
-		list_del(dp);
-		list_add(dp, &ptable_list);
+		list_move(dp, &ptable_list);
 	}
 	return 0;
 }
diff -ur linux-2.5.66/arch/m68k/sun3/sun3dvma.c linux/arch/m68k/sun3/sun3dvma.c
--- linux-2.5.66/arch/m68k/sun3/sun3dvma.c	2003-03-24 19:29:41.000000000 -0500
+++ linux/arch/m68k/sun3/sun3dvma.c	2003-03-25 07:59:10.000000000 -0500
@@ -118,8 +118,7 @@
 		if(hole->end == prev->start) {
 			hole->size += prev->size;
 			hole->end = prev->end;
-			list_del(&(prev->list));
-			list_add(&(prev->list), &hole_cache);
+			list_move(&(prev->list), &hole_cache);
 			ret++;
 		}
 		
@@ -181,8 +180,7 @@
 #endif
 			return hole->end;
 		} else if(hole->size == newlen) {
-			list_del(&(hole->list));
-			list_add(&(hole->list), &hole_cache);
+			list_move(&(hole->list), &hole_cache);
 			dvma_entry_use(hole->start) = newlen;
 #ifdef DVMA_DEBUG
 			dvma_allocs++;
diff -ur linux-2.5.66/arch/sparc64/kernel/pci.c linux/arch/sparc64/kernel/pci.c
--- linux-2.5.66/arch/sparc64/kernel/pci.c	2003-03-17 18:04:46.000000000 -0500
+++ linux/arch/sparc64/kernel/pci.c	2003-03-25 07:59:10.000000000 -0500
@@ -339,10 +339,8 @@
 		struct pci_dev *pdev = pci_dev_g(walk);
 		struct list_head *walk_next = walk->next;
 
-		if (pdev->irq && (__irq_ino(pdev->irq) & 0x20)) {
-			list_del(walk);
-			list_add(walk, pci_onboard);
-		}
+		if (pdev->irq && (__irq_ino(pdev->irq) & 0x20))
+			list_move(walk, pci_onboard);
 
 		walk = walk_next;
 	}
diff -ur linux-2.5.66/drivers/char/h8.c linux/drivers/char/h8.c
--- linux-2.5.66/drivers/char/h8.c	2002-12-24 00:19:57.000000000 -0500
+++ linux/drivers/char/h8.c	2003-03-25 07:59:10.000000000 -0500
@@ -505,9 +505,8 @@
          * it on the active queue.
          */
         qp = list_entry(h8_cmdq.next, h8_cmd_q_t, link);
-        list_del(&qp->link);
         /* XXX should this go to the end of the active queue? */
-        list_add(&qp->link, &h8_actq);
+        list_move(&qp->link, &h8_actq);
         h8_state = H8_XMIT;
         if (h8_debug & 0x1)
                 Dprintk("h8_start_new_cmd: Starting a command\n");
diff -ur linux-2.5.66/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.66/drivers/ide/ide.c	2003-03-24 19:29:52.000000000 -0500
+++ linux/drivers/ide/ide.c	2003-03-25 08:47:12.000000000 -0500
@@ -2374,8 +2374,7 @@
 	setup_driver_defaults(drive);
 	spin_unlock_irqrestore(&ide_lock, flags);
 	spin_lock(&drives_lock);
-	list_del_init(&drive->list);
-	list_add(&drive->list, &drive->driver->drives);
+	list_move(&drive->list, &drive->driver->drives);
 	spin_unlock(&drives_lock);
 	return 0;
 }
diff -ur linux-2.5.66/drivers/ieee1394/amdtp.c linux/drivers/ieee1394/amdtp.c
--- linux-2.5.66/drivers/ieee1394/amdtp.c	2003-03-07 19:00:47.000000000 -0500
+++ linux/drivers/ieee1394/amdtp.c	2003-03-25 07:59:10.000000000 -0500
@@ -449,8 +449,7 @@
 	 * back to the free list, and notify any waiters.
 	 */
 	spin_lock(&s->packet_list_lock);
-	list_del(&pl->link);
-	list_add_tail(&pl->link, &s->free_packet_lists);
+	list_move_tail(&pl->link, &s->free_packet_lists);
 	spin_unlock(&s->packet_list_lock);
 
 	wake_up_interruptible(&s->packet_list_wait);
diff -ur linux-2.5.66/drivers/ieee1394/ieee1394_core.c linux/drivers/ieee1394/ieee1394_core.c
--- linux-2.5.66/drivers/ieee1394/ieee1394_core.c	2003-03-24 19:29:52.000000000 -0500
+++ linux/drivers/ieee1394/ieee1394_core.c	2003-03-25 07:59:10.000000000 -0500
@@ -948,10 +948,8 @@
 	for (lh = host->pending_packets.next; lh != &host->pending_packets; lh = next) {
                 packet = list_entry(lh, struct hpsb_packet, list);
 		next = lh->next;
-                if (time_before(packet->sendtime + expire, jiffies)) {
-                        list_del(&packet->list);
-                        list_add(&packet->list, &expiredlist);
-                }
+                if (time_before(packet->sendtime + expire, jiffies))
+                        list_move(&packet->list, &expiredlist);
         }
 
         if (!list_empty(&host->pending_packets))
diff -ur linux-2.5.66/drivers/ieee1394/nodemgr.c linux/drivers/ieee1394/nodemgr.c
--- linux-2.5.66/drivers/ieee1394/nodemgr.c	2003-03-07 19:00:48.000000000 -0500
+++ linux/drivers/ieee1394/nodemgr.c	2003-03-25 07:59:10.000000000 -0500
@@ -810,15 +810,13 @@
 					 struct hpsb_protocol_driver *driver)
 {
 	ud->driver = driver;
-	list_del(&ud->driver_list);
-	list_add_tail(&ud->driver_list, &driver->unit_directories);
+	list_move_tail(&ud->driver_list, &driver->unit_directories);
 }
 
 static void nodemgr_release_unit_directory(struct unit_directory *ud)
 {
 	ud->driver = NULL;
-	list_del(&ud->driver_list);
-	list_add_tail(&ud->driver_list, &unit_directory_list);
+	list_move_tail(&ud->driver_list, &unit_directory_list);
 }
 
 void hpsb_release_unit_directory(struct unit_directory *ud)
diff -ur linux-2.5.66/drivers/ieee1394/pcilynx.c linux/drivers/ieee1394/pcilynx.c
--- linux-2.5.66/drivers/ieee1394/pcilynx.c	2003-02-24 14:59:20.000000000 -0500
+++ linux/drivers/ieee1394/pcilynx.c	2003-03-25 07:59:10.000000000 -0500
@@ -480,8 +480,7 @@
         }
 
         packet = driver_packet(d->queue.next);
-        list_del(&packet->driver_list);
-        list_add_tail(&packet->driver_list, &d->pcl_queue);
+        list_move_tail(&packet->driver_list, &d->pcl_queue);
 
         d->header_dma = pci_map_single(lynx->dev, packet->header,
                                        packet->header_size, PCI_DMA_TODEVICE);
diff -ur linux-2.5.66/drivers/ieee1394/raw1394.c linux/drivers/ieee1394/raw1394.c
--- linux-2.5.66/drivers/ieee1394/raw1394.c	2003-03-07 19:00:48.000000000 -0500
+++ linux/drivers/ieee1394/raw1394.c	2003-03-25 07:59:10.000000000 -0500
@@ -137,8 +137,7 @@
 static void __queue_complete_req(struct pending_request *req)
 {
 	struct file_info *fi = req->file_info;
-	list_del(&req->list);
-        list_add_tail(&req->list, &fi->req_complete);
+	list_move_tail(&req->list, &fi->req_complete);
 
 	up(&fi->complete_sem);
         wake_up_interruptible(&fi->poll_wait_complete);
diff -ur linux-2.5.66/drivers/isdn/i4l/isdn_net_lib.c linux/drivers/isdn/i4l/isdn_net_lib.c
--- linux-2.5.66/drivers/isdn/i4l/isdn_net_lib.c	2003-03-17 18:04:49.000000000 -0500
+++ linux/drivers/isdn/i4l/isdn_net_lib.c	2003-03-25 07:59:10.000000000 -0500
@@ -2023,8 +2023,7 @@
 	list_for_each_entry(idev, &mlp->online, online) {
 		if (!isdn_net_dev_busy(idev)) {
 			/* point the head to next online channel */
-			list_del(&mlp->online);
-			list_add(&mlp->online, &idev->online);
+			list_move(&mlp->online, &idev->online);
 			return idev;
 		}
 	}
@@ -2229,8 +2228,7 @@
 			idev->sqfull = 0;
 		}
 		/* this is a hack to allow auto-hangup for slaves on moderate loads */
-		list_del(&mlp->online);
-		list_add_tail(&mlp->online, &idev->online);
+		list_move_tail(&mlp->online, &idev->online);
 	}
 
 	retval = 0;
diff -ur linux-2.5.66/drivers/net/ppp_generic.c linux/drivers/net/ppp_generic.c
--- linux-2.5.66/drivers/net/ppp_generic.c	2003-03-24 19:29:52.000000000 -0500
+++ linux/drivers/net/ppp_generic.c	2003-03-25 07:59:10.000000000 -0500
@@ -2403,8 +2403,7 @@
 	while ((list = list->next) != &new_channels) {
 		pch = list_entry(list, struct channel, list);
 		if (pch->file.index == unit) {
-			list_del(&pch->list);
-			list_add(&pch->list, &all_channels);
+			list_move(&pch->list, &all_channels);
 			return pch;
 		}
 	}
diff -ur linux-2.5.66/drivers/usb/serial/whiteheat.c linux/drivers/usb/serial/whiteheat.c
--- linux-2.5.66/drivers/usb/serial/whiteheat.c	2003-03-24 19:29:53.000000000 -0500
+++ linux/drivers/usb/serial/whiteheat.c	2003-03-25 07:59:10.000000000 -0500
@@ -661,19 +661,16 @@
 		wrap = list_entry(tmp, struct whiteheat_urb_wrap, list);
 		urb = wrap->urb;
 		usb_unlink_urb(urb);
-		list_del(tmp);
-		list_add(tmp, &info->rx_urbs_free);
+		list_move(tmp, &info->rx_urbs_free);
 	}
 	list_for_each_safe(tmp, tmp2, &info->rx_urb_q) {
-		list_del(tmp);
-		list_add(tmp, &info->rx_urbs_free);
+		list_move(tmp, &info->rx_urbs_free);
 	}
 	list_for_each_safe(tmp, tmp2, &info->tx_urbs_submitted) {
 		wrap = list_entry(tmp, struct whiteheat_urb_wrap, list);
 		urb = wrap->urb;
 		usb_unlink_urb(urb);
-		list_del(tmp);
-		list_add(tmp, &info->tx_urbs_free);
+		list_move(tmp, &info->tx_urbs_free);
 	}
 	spin_unlock_irqrestore(&info->lock, flags);
 
@@ -1099,8 +1096,7 @@
 		err("%s - Not my urb!", __FUNCTION__);
 		return;
 	}
-	list_del(&wrap->list);
-	list_add(&wrap->list, &info->tx_urbs_free);
+	list_move(&wrap->list, &info->tx_urbs_free);
 	spin_unlock(&info->lock);
 
 	if (!serial) {
@@ -1400,8 +1396,7 @@
 				wrap = list_entry(tmp, struct whiteheat_urb_wrap, list);
 				urb = wrap->urb;
 				usb_unlink_urb(urb);
-				list_del(tmp);
-				list_add(tmp, &info->rx_urbs_free);
+				list_move(tmp, &info->rx_urbs_free);
 			}
 			break;
 		}
diff -ur linux-2.5.66/fs/afs/cell.c linux/fs/afs/cell.c
--- linux-2.5.66/fs/afs/cell.c	2002-12-24 00:19:26.000000000 -0500
+++ linux/fs/afs/cell.c	2003-03-25 07:59:10.000000000 -0500
@@ -344,8 +344,7 @@
 
 	/* we found it in the graveyard - resurrect it */
  found_dead_server:
-	list_del(&server->link);
-	list_add_tail(&server->link,&cell->sv_list);
+	list_move_tail(&server->link,&cell->sv_list);
 	afs_get_server(server);
 	afs_kafstimod_del_timer(&server->timeout);
 	spin_unlock(&cell->sv_gylock);
diff -ur linux-2.5.66/fs/afs/kafsasyncd.c linux/fs/afs/kafsasyncd.c
--- linux-2.5.66/fs/afs/kafsasyncd.c	2003-02-24 14:59:15.000000000 -0500
+++ linux/fs/afs/kafsasyncd.c	2003-03-25 07:59:10.000000000 -0500
@@ -133,8 +133,7 @@
 
 			if (!list_empty(&kafsasyncd_async_attnq)) {
 				op = list_entry(kafsasyncd_async_attnq.next,afs_async_op_t,link);
-				list_del(&op->link);
-				list_add_tail(&op->link,&kafsasyncd_async_busyq);
+				list_move_tail(&op->link,&kafsasyncd_async_busyq);
 			}
 
 			spin_unlock(&kafsasyncd_async_lock);
@@ -199,8 +198,7 @@
 
 	init_waitqueue_entry(&op->waiter,kafsasyncd_task);
 
-	list_del(&op->link);
-	list_add_tail(&op->link,&kafsasyncd_async_busyq);
+	list_move_tail(&op->link,&kafsasyncd_async_busyq);
 
 	spin_unlock(&kafsasyncd_async_lock);
 
@@ -218,8 +216,7 @@
 
 	spin_lock(&kafsasyncd_async_lock);
 
-	list_del(&op->link);
-	list_add_tail(&op->link,&kafsasyncd_async_attnq);
+	list_move_tail(&op->link,&kafsasyncd_async_attnq);
 
 	spin_unlock(&kafsasyncd_async_lock);
 
diff -ur linux-2.5.66/fs/afs/server.c linux/fs/afs/server.c
--- linux-2.5.66/fs/afs/server.c	2002-12-24 00:19:28.000000000 -0500
+++ linux/fs/afs/server.c	2003-03-25 07:59:10.000000000 -0500
@@ -124,8 +124,7 @@
  resurrect_server:
 	_debug("resurrecting server");
 
-	list_del(&zombie->link);
-	list_add_tail(&zombie->link,&cell->sv_list);
+	list_move_tail(&zombie->link,&cell->sv_list);
 	afs_get_server(zombie);
 	afs_kafstimod_del_timer(&zombie->timeout);
 	spin_unlock(&cell->sv_gylock);
@@ -166,8 +165,7 @@
 	}
 
 	spin_lock(&cell->sv_gylock);
-	list_del(&server->link);
-	list_add_tail(&server->link,&cell->sv_graveyard);
+	list_move_tail(&server->link,&cell->sv_graveyard);
 
 	/* time out in 10 secs */
 	afs_kafstimod_add_timer(&server->timeout,10*HZ);
diff -ur linux-2.5.66/fs/afs/vlocation.c linux/fs/afs/vlocation.c
--- linux-2.5.66/fs/afs/vlocation.c	2002-12-24 00:19:59.000000000 -0500
+++ linux/fs/afs/vlocation.c	2003-03-25 07:59:10.000000000 -0500
@@ -293,8 +293,7 @@
 	/* found in the graveyard - resurrect */
 	_debug("found in graveyard");
 	atomic_inc(&vlocation->usage);
-	list_del(&vlocation->link);
-	list_add_tail(&vlocation->link,&cell->vl_list);
+	list_move_tail(&vlocation->link,&cell->vl_list);
 	spin_unlock(&cell->vl_gylock);
 
 	afs_kafstimod_del_timer(&vlocation->timeout);
@@ -432,8 +431,7 @@
 	}
 
 	/* move to graveyard queue */
-	list_del(&vlocation->link);
-	list_add_tail(&vlocation->link,&cell->vl_graveyard);
+	list_move_tail(&vlocation->link,&cell->vl_graveyard);
 
 	/* remove from pending timeout queue (refcounted if actually being updated) */
 	list_del_init(&vlocation->upd_op.link);
diff -ur linux-2.5.66/fs/afs/vnode.c linux/fs/afs/vnode.c
--- linux-2.5.66/fs/afs/vnode.c	2003-03-07 19:00:57.000000000 -0500
+++ linux/fs/afs/vnode.c	2003-03-25 07:59:10.000000000 -0500
@@ -88,8 +88,7 @@
 		afs_kafstimod_add_timer(&vnode->cb_timeout,vnode->cb_expiry*HZ);
 
 		spin_lock(&afs_cb_hash_lock);
-		list_del(&vnode->cb_hash_link);
-		list_add_tail(&vnode->cb_hash_link,&afs_cb_hash(server,&vnode->fid));
+		list_move_tail(&vnode->cb_hash_link,&afs_cb_hash(server,&vnode->fid));
 		spin_unlock(&afs_cb_hash_lock);
 
 		/* swap ref to old callback server with that for new callback server */
diff -ur linux-2.5.66/fs/autofs4/expire.c linux/fs/autofs4/expire.c
--- linux-2.5.66/fs/autofs4/expire.c	2002-12-24 00:20:50.000000000 -0500
+++ linux/fs/autofs4/expire.c	2003-03-25 07:59:10.000000000 -0500
@@ -201,8 +201,7 @@
 			DPRINTK(("autofs_expire: returning %p %.*s\n",
 				 dentry, (int)dentry->d_name.len, dentry->d_name.name));
 			/* Start from here next time */
-			list_del(&root->d_subdirs);
-			list_add(&root->d_subdirs, &dentry->d_child);
+			list_move(&root->d_subdirs, &dentry->d_child);
 			dget(dentry);
 			spin_unlock(&dcache_lock);
 
diff -ur linux-2.5.66/fs/dcache.c linux/fs/dcache.c
--- linux-2.5.66/fs/dcache.c	2003-03-24 19:29:56.000000000 -0500
+++ linux/fs/dcache.c	2003-03-25 07:59:10.000000000 -0500
@@ -436,8 +436,7 @@
 		dentry = list_entry(tmp, struct dentry, d_lru);
 		if (dentry->d_sb != sb)
 			continue;
-		list_del(tmp);
-		list_add(tmp, &dentry_unused);
+		list_move(tmp, &dentry_unused);
 	}
 
 	/*
diff -ur linux-2.5.66/fs/exec.c linux/fs/exec.c
--- linux-2.5.66/fs/exec.c	2003-03-24 19:29:56.000000000 -0500
+++ linux/fs/exec.c	2003-03-25 07:59:10.000000000 -0500
@@ -696,8 +696,7 @@
 			__ptrace_link(current, parent);
 		}
 
-		list_del(&current->tasks);
-		list_add_tail(&current->tasks, &init_task.tasks);
+		list_move_tail(&current->tasks, &init_task.tasks);
 		current->exit_signal = SIGCHLD;
 		state = leader->state;
 
diff -ur linux-2.5.66/fs/hfs/catalog.c linux/fs/hfs/catalog.c
--- linux-2.5.66/fs/hfs/catalog.c	2002-12-24 00:21:01.000000000 -0500
+++ linux/fs/hfs/catalog.c	2003-03-25 07:59:10.000000000 -0500
@@ -209,10 +209,8 @@
 	        entry->state |= HFS_DIRTY;
 
 		/* Only add valid (ie hashed) entries to the dirty list. */
-		if (!list_empty(&entry->hash)) {
-		        list_del(&entry->list);
-			list_add(&entry->list, &mdb->entry_dirty);
-		}
+		if (!list_empty(&entry->hash))
+			list_move(&entry->list, &mdb->entry_dirty);
 	}
 	spin_unlock(&entry_lock);
 }
@@ -835,8 +833,7 @@
 
 		if (!entry->count) {
 		        list_del_init(&entry->hash);
-			list_del(&entry->list);
-			list_add(&entry->list, dispose);
+			list_move(&entry->list, dispose);
 			continue;
 		}
 		
@@ -912,8 +909,7 @@
 			        insert = entry_in_use.prev;
 
 		       /* add to in_use list */
-		       list_del(&entry->list);
-		       list_add(&entry->list, insert);
+		       list_move(&entry->list, insert);
 
 		       /* reset DIRTY, set LOCK */
 		       entry->state ^= HFS_DIRTY | HFS_LOCK;
diff -ur linux-2.5.66/fs/hugetlbfs/inode.c linux/fs/hugetlbfs/inode.c
--- linux-2.5.66/fs/hugetlbfs/inode.c	2003-03-07 19:00:58.000000000 -0500
+++ linux/fs/hugetlbfs/inode.c	2003-03-25 07:59:10.000000000 -0500
@@ -211,10 +211,9 @@
 	if (hlist_unhashed(&inode->i_hash))
 		goto out_truncate;
 
-	if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
-		list_del(&inode->i_list);
-		list_add(&inode->i_list, &inode_unused);
-	}
+	if (!(inode->i_state & (I_DIRTY|I_LOCK)))
+		list_move(&inode->i_list, &inode_unused);
+
 	inodes_stat.nr_unused++;
 	if (!super_block || (super_block->s_flags & MS_ACTIVE)) {
 		spin_unlock(&inode_lock);
diff -ur linux-2.5.66/fs/inode.c linux/fs/inode.c
--- linux-2.5.66/fs/inode.c	2003-03-24 19:29:56.000000000 -0500
+++ linux/fs/inode.c	2003-03-25 08:01:04.000000000 -0500
@@ -209,10 +209,8 @@
 		return;
 	}
 	atomic_inc(&inode->i_count);
-	if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
-		list_del(&inode->i_list);
-		list_add(&inode->i_list, &inode_in_use);
-	}
+	if (!(inode->i_state & (I_DIRTY|I_LOCK)))
+		list_move(&inode->i_list, &inode_in_use);
 	inodes_stat.nr_unused--;
 }
 
@@ -291,8 +289,7 @@
 		invalidate_inode_buffers(inode);
 		if (!atomic_read(&inode->i_count)) {
 			hlist_del_init(&inode->i_hash);
-			list_del(&inode->i_list);
-			list_add(&inode->i_list, dispose);
+			list_move(&inode->i_list, dispose);
 			inode->i_state |= I_FREEING;
 			count++;
 			continue;
@@ -972,10 +969,8 @@
 	struct super_block *sb = inode->i_sb;
 
 	if (!hlist_unhashed(&inode->i_hash)) {
-		if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
-			list_del(&inode->i_list);
-			list_add(&inode->i_list, &inode_unused);
-		}
+		if (!(inode->i_state & (I_DIRTY|I_LOCK)))
+			list_move(&inode->i_list, &inode_unused);
 		inodes_stat.nr_unused++;
 		spin_unlock(&inode_lock);
 		if (!sb || (sb->s_flags & MS_ACTIVE))
diff -ur linux-2.5.66/fs/jffs2/erase.c linux/fs/jffs2/erase.c
--- linux-2.5.66/fs/jffs2/erase.c	2002-12-24 00:19:34.000000000 -0500
+++ linux/fs/jffs2/erase.c	2003-03-25 07:59:10.000000000 -0500
@@ -38,8 +38,7 @@
 	if (!instr) {
 		printk(KERN_WARNING "kmalloc for struct erase_info in jffs2_erase_block failed. Refiling block for later\n");
 		spin_lock_bh(&c->erase_completion_lock);
-		list_del(&jeb->list);
-		list_add(&jeb->list, &c->erase_pending_list);
+		list_move(&jeb->list, &c->erase_pending_list);
 		c->erasing_size -= c->sector_size;
 		spin_unlock_bh(&c->erase_completion_lock);
 		return;
@@ -70,8 +69,7 @@
 		/* Erase failed immediately. Refile it on the list */
 		D1(printk(KERN_DEBUG "Erase at 0x%08x failed: %d. Refiling on erase_pending_list\n", jeb->offset, ret));
 		spin_lock_bh(&c->erase_completion_lock);
-		list_del(&jeb->list);
-		list_add(&jeb->list, &c->erase_pending_list);
+		list_move(&jeb->list, &c->erase_pending_list);
 		c->erasing_size -= c->sector_size;
 		spin_unlock_bh(&c->erase_completion_lock);
 		return;
@@ -91,8 +89,7 @@
 	spin_lock_bh(&c->erase_completion_lock);
 	c->erasing_size -= c->sector_size;
 	c->bad_size += c->sector_size;
-	list_del(&jeb->list);
-	list_add(&jeb->list, &c->bad_list);
+	list_move(&jeb->list, &c->bad_list);
 	c->nr_erasing_blocks--;
 	spin_unlock_bh(&c->erase_completion_lock);
 	wake_up(&c->erase_wait);
@@ -149,8 +146,7 @@
 {
 	D1(printk(KERN_DEBUG "Erase completed successfully at 0x%08x\n", jeb->offset));
 	spin_lock(&c->erase_completion_lock);
-	list_del(&jeb->list);
-	list_add_tail(&jeb->list, &c->erase_complete_list);
+	list_move_tail(&jeb->list, &c->erase_complete_list);
 	spin_unlock(&c->erase_completion_lock);
 	/* Ensure that kupdated calls us again to mark them clean */
 	jffs2_erase_pending_trigger(c);
@@ -162,8 +158,7 @@
 	 spin_lock(&c->erase_completion_lock);
 	 c->erasing_size -= c->sector_size;
 	 c->bad_size += c->sector_size;
-	 list_del(&jeb->list);
-	 list_add(&jeb->list, &c->bad_list);
+	 list_move(&jeb->list, &c->bad_list);
 	 c->nr_erasing_blocks--;
 	 spin_unlock(&c->erase_completion_lock);
 	 wake_up(&c->erase_wait);
diff -ur linux-2.5.66/fs/jffs2/nodemgmt.c linux/fs/jffs2/nodemgmt.c
--- linux-2.5.66/fs/jffs2/nodemgmt.c	2002-12-24 00:19:46.000000000 -0500
+++ linux/fs/jffs2/nodemgmt.c	2003-03-25 07:59:10.000000000 -0500
@@ -174,8 +174,7 @@
 				struct jffs2_eraseblock *ejeb;
 
 				ejeb = list_entry(c->erasable_list.next, struct jffs2_eraseblock, list);
-				list_del(&ejeb->list);
-				list_add_tail(&ejeb->list, &c->erase_pending_list);
+				list_move_tail(&ejeb->list, &c->erase_pending_list);
 				c->nr_erasing_blocks++;
 				jffs2_erase_pending_trigger(c);
 				D1(printk(KERN_DEBUG "jffs2_do_reserve_space: Triggering erase of erasable block at 0x%08x\n",
@@ -456,15 +455,13 @@
 		D2(printk(KERN_DEBUG "Not moving gcblock 0x%08x to dirty_list\n", jeb->offset));
 	} else if (ISDIRTY(jeb->dirty_size) && !ISDIRTY(jeb->dirty_size - ref->totlen)) {
 		D1(printk(KERN_DEBUG "Eraseblock at 0x%08x is freshly dirtied. Removing from clean list...\n", jeb->offset));
-		list_del(&jeb->list);
 		D1(printk(KERN_DEBUG "...and adding to dirty_list\n"));
-		list_add_tail(&jeb->list, &c->dirty_list);
+		list_move_tail(&jeb->list, &c->dirty_list);
 	} else if (VERYDIRTY(c, jeb->dirty_size) &&
 		   !VERYDIRTY(c, jeb->dirty_size - ref->totlen)) {
 		D1(printk(KERN_DEBUG "Eraseblock at 0x%08x is now very dirty. Removing from dirty list...\n", jeb->offset));
-		list_del(&jeb->list);
 		D1(printk(KERN_DEBUG "...and adding to very_dirty_list\n"));
-		list_add_tail(&jeb->list, &c->very_dirty_list);
+		list_move_tail(&jeb->list, &c->very_dirty_list);
 	} else {
 		D1(printk(KERN_DEBUG "Eraseblock at 0x%08x not moved anywhere. (free 0x%08x, dirty 0x%08x, used 0x%08x)\n",
 			  jeb->offset, jeb->free_size, jeb->dirty_size, jeb->used_size)); 
diff -ur linux-2.5.66/fs/libfs.c linux/fs/libfs.c
--- linux-2.5.66/fs/libfs.c	2003-02-24 14:59:02.000000000 -0500
+++ linux/fs/libfs.c	2003-03-25 07:59:10.000000000 -0500
@@ -83,8 +83,7 @@
 					n--;
 				p = p->next;
 			}
-			list_del(&cursor->d_child);
-			list_add_tail(&cursor->d_child, p);
+			list_move_tail(&cursor->d_child, p);
 			spin_unlock(&dcache_lock);
 		}
 	}
@@ -129,10 +128,8 @@
 			/* fallthrough */
 		default:
 			spin_lock(&dcache_lock);
-			if (filp->f_pos == 2) {
-				list_del(q);
-				list_add(q, &dentry->d_subdirs);
-			}
+			if (filp->f_pos == 2)
+				list_move(q, &dentry->d_subdirs);
 			for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
 				struct dentry *next;
 				next = list_entry(p, struct dentry, d_child);
@@ -144,8 +141,7 @@
 					return 0;
 				spin_lock(&dcache_lock);
 				/* next is still alive */
-				list_del(q);
-				list_add(q, p);
+				list_move(q, p);
 				p = q;
 				filp->f_pos++;
 			}
diff -ur linux-2.5.66/fs/namespace.c linux/fs/namespace.c
--- linux-2.5.66/fs/namespace.c	2003-03-07 19:00:58.000000000 -0500
+++ linux/fs/namespace.c	2003-03-25 07:59:10.000000000 -0500
@@ -264,10 +264,8 @@
 	struct vfsmount *p;
 	LIST_HEAD(kill);
 
-	for (p = mnt; p; p = next_mnt(p, mnt)) {
-		list_del(&p->mnt_list);
-		list_add(&p->mnt_list, &kill);
-	}
+	for (p = mnt; p; p = next_mnt(p, mnt))
+		list_move(&p->mnt_list, &kill);
 
 	while (!list_empty(&kill)) {
 		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
diff -ur linux-2.5.66/fs/smbfs/request.c linux/fs/smbfs/request.c
--- linux-2.5.66/fs/smbfs/request.c	2002-12-24 00:21:35.000000000 -0500
+++ linux/fs/smbfs/request.c	2003-03-25 07:59:10.000000000 -0500
@@ -392,8 +392,7 @@
 	if (!(req->rq_flags & SMB_REQ_TRANSMITTED))
 		goto out;
 
-	list_del_init(&req->rq_queue);
-	list_add_tail(&req->rq_queue, &server->recvq);
+	list_move_tail(&req->rq_queue, &server->recvq);
 	result = 1;
 out:
 	return result;
@@ -427,8 +426,7 @@
 	result = smb_request_send_req(req);
 	if (result < 0) {
 		server->conn_error = result;
-		list_del_init(&req->rq_queue);
-		list_add(&req->rq_queue, &server->xmitq);
+		list_move(&req->rq_queue, &server->xmitq);
 		result = -EIO;
 		goto out;
 	}
diff -ur linux-2.5.66/fs/smbfs/smbiod.c linux/fs/smbfs/smbiod.c
--- linux-2.5.66/fs/smbfs/smbiod.c	2003-02-24 14:59:15.000000000 -0500
+++ linux/fs/smbfs/smbiod.c	2003-03-25 07:59:10.000000000 -0500
@@ -175,8 +175,7 @@
 		if (req->rq_flags & SMB_REQ_RETRY) {
 			/* must move the request to the xmitq */
 			VERBOSE("retrying request %p on recvq\n", req);
-			list_del(&req->rq_queue);
-			list_add(&req->rq_queue, &server->xmitq);
+			list_move(&req->rq_queue, &server->xmitq);
 			continue;
 		}
 #endif
diff -ur linux-2.5.66/fs/xfs/pagebuf/page_buf.c linux/fs/xfs/pagebuf/page_buf.c
--- linux-2.5.66/fs/xfs/pagebuf/page_buf.c	2003-03-24 19:29:56.000000000 -0500
+++ linux/fs/xfs/pagebuf/page_buf.c	2003-03-25 07:59:10.000000000 -0500
@@ -630,8 +630,7 @@
 			/* If we look at something bring it to the
 			 * front of the list for next time
 			 */
-			list_del(&pb->pb_hash_list);
-			list_add(&pb->pb_hash_list, &h->pb_hash);
+			list_move(&pb->pb_hash_list, &h->pb_hash);
 			goto found;
 		}
 	}
@@ -1641,8 +1640,7 @@
 					break;
 				}
 
-				list_del(&pb->pb_list);
-				list_add(&pb->pb_list, &tmp);
+				list_move(&pb->pb_list, &tmp);
 
 				count++;
 			}
diff -ur linux-2.5.66/kernel/futex.c linux/kernel/futex.c
--- linux-2.5.66/kernel/futex.c	2003-03-07 19:01:05.000000000 -0500
+++ linux/kernel/futex.c	2003-03-25 07:59:10.000000000 -0500
@@ -209,8 +209,7 @@
 
 	if (!list_empty(&q->list)) {
 		q->page = new_page;
-		list_del(&q->list);
-		list_add_tail(&q->list, head);
+		list_move_tail(&q->list, head);
 	}
 
 	spin_unlock(&futex_lock);
diff -ur linux-2.5.66/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.66/kernel/sched.c	2003-03-24 19:29:57.000000000 -0500
+++ linux/kernel/sched.c	2003-03-25 07:59:10.000000000 -0500
@@ -2008,8 +2008,7 @@
 		dequeue_task(current, array);
 		enqueue_task(current, rq->expired);
 	} else {
-		list_del(&current->run_list);
-		list_add_tail(&current->run_list, array->queue + current->prio);
+		list_move_tail(&current->run_list, array->queue + current->prio);
 	}
 	/*
 	 * Since we are going to call schedule() anyway, there's
diff -ur linux-2.5.66/mm/page-writeback.c linux/mm/page-writeback.c
--- linux-2.5.66/mm/page-writeback.c	2003-03-24 19:29:57.000000000 -0500
+++ linux/mm/page-writeback.c	2003-03-25 07:59:10.000000000 -0500
@@ -517,8 +517,7 @@
 		if (page->mapping) {	/* Race with truncate? */
 			if (!mapping->backing_dev_info->memory_backed)
 				inc_page_state(nr_dirty);
-			list_del(&page->list);
-			list_add(&page->list, &mapping->dirty_pages);
+			list_move(&page->list, &mapping->dirty_pages);
 		}
 		write_unlock(&mapping->page_lock);
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
@@ -555,8 +554,7 @@
 				BUG_ON(page->mapping != mapping);
 				if (!mapping->backing_dev_info->memory_backed)
 					inc_page_state(nr_dirty);
-				list_del(&page->list);
-				list_add(&page->list, &mapping->dirty_pages);
+				list_move(&page->list, &mapping->dirty_pages);
 			}
 			write_unlock(&mapping->page_lock);
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
diff -ur linux-2.5.66/mm/swap.c linux/mm/swap.c
--- linux-2.5.66/mm/swap.c	2003-03-24 19:29:57.000000000 -0500
+++ linux/mm/swap.c	2003-03-25 07:59:10.000000000 -0500
@@ -59,8 +59,7 @@
 	zone = page_zone(page);
 	spin_lock_irqsave(&zone->lru_lock, flags);
 	if (PageLRU(page) && !PageActive(page)) {
-		list_del(&page->lru);
-		list_add_tail(&page->lru, &zone->inactive_list);
+		list_move_tail(&page->lru, &zone->inactive_list);
 		inc_page_state(pgrotated);
 	}
 	if (!TestClearPageWriteback(page))
diff -ur linux-2.5.66/net/core/dev.c linux/net/core/dev.c
--- linux-2.5.66/net/core/dev.c	2003-03-24 19:29:57.000000000 -0500
+++ linux/net/core/dev.c	2003-03-25 07:59:10.000000000 -0500
@@ -1640,8 +1640,7 @@
 
 		if (dev->quota <= 0 || dev->poll(dev, &budget)) {
 			local_irq_disable();
-			list_del(&dev->poll_list);
-			list_add_tail(&dev->poll_list, &queue->poll_list);
+			list_move_tail(&dev->poll_list, &queue->poll_list);
 			if (dev->quota < 0)
 				dev->quota += dev->weight;
 			else
diff -ur linux-2.5.66/net/rxrpc/call.c linux/net/rxrpc/call.c
--- linux-2.5.66/net/rxrpc/call.c	2003-02-24 14:59:02.000000000 -0500
+++ linux/net/rxrpc/call.c	2003-03-25 07:59:10.000000000 -0500
@@ -1048,8 +1048,7 @@
 
 		call->app_ready_seq = pmsg->seq;
 		call->app_ready_qty += pmsg->dsize;
-		list_del_init(&pmsg->link);
-		list_add_tail(&pmsg->link,&call->app_readyq);
+		list_move_tail(&pmsg->link,&call->app_readyq);
 	}
 
 	/* see if we've got the last packet yet */
diff -ur linux-2.5.66/net/rxrpc/connection.c linux/net/rxrpc/connection.c
--- linux-2.5.66/net/rxrpc/connection.c	2002-12-24 00:20:35.000000000 -0500
+++ linux/net/rxrpc/connection.c	2003-03-25 07:59:10.000000000 -0500
@@ -314,8 +314,7 @@
 	}
 
 	/* move to graveyard queue */
-	list_del(&conn->link);
-	list_add_tail(&conn->link,&peer->conn_graveyard);
+	list_move_tail(&conn->link,&peer->conn_graveyard);
 
 	/* discard in 100 secs */
 	rxrpc_krxtimod_add_timer(&conn->timeout,20*HZ);
diff -ur linux-2.5.66/net/rxrpc/krxsecd.c linux/net/rxrpc/krxsecd.c
--- linux-2.5.66/net/rxrpc/krxsecd.c	2003-02-24 14:59:15.000000000 -0500
+++ linux/net/rxrpc/krxsecd.c	2003-03-25 07:59:10.000000000 -0500
@@ -158,8 +158,7 @@
 	list_for_each_safe(_p,_n,&rxrpc_krxsecd_initmsgq) {
 		msg = list_entry(_p,struct rxrpc_message,link);
 		if (msg->trans==trans) {
-			list_del(&msg->link);
-			list_add_tail(&msg->link,&tmp);
+			list_move_tail(&msg->link,&tmp);
 			atomic_dec(&rxrpc_krxsecd_qcount);
 		}
 	}
diff -ur linux-2.5.66/net/sunrpc/auth.c linux/net/sunrpc/auth.c
--- linux-2.5.66/net/sunrpc/auth.c	2003-02-24 14:59:24.000000000 -0500
+++ linux/net/sunrpc/auth.c	2003-03-25 07:59:10.000000000 -0500
@@ -158,8 +158,7 @@
 	if (time_before(jiffies, cred->cr_expire))
 		return 0;
 	cred->cr_auth = NULL;
-	list_del(&cred->cr_hash);
-	list_add(&cred->cr_hash, free);
+	list_move(&cred->cr_hash, free);
 	return 1;
 }
 
diff -ur linux-2.5.66/sound/core/timer.c linux/sound/core/timer.c
--- linux-2.5.66/sound/core/timer.c	2003-03-24 19:29:58.000000000 -0500
+++ linux/sound/core/timer.c	2003-03-25 08:02:35.000000000 -0500
@@ -189,8 +189,7 @@
 			master = (snd_timer_instance_t *)list_entry(q, snd_timer_instance_t, open_list);
 			if (slave->slave_class == master->slave_class &&
 			    slave->slave_id == master->slave_id) {
-				list_del(&slave->open_list);
-				list_add_tail(&slave->open_list, &master->slave_list_head);
+				list_move_tail(&slave->open_list, &master->slave_list_head);
 				spin_lock_irq(&slave_active_lock);
 				slave->master = master;
 				slave->timer = master->timer;
@@ -217,8 +216,7 @@
 		slave = (snd_timer_instance_t *)list_entry(p, snd_timer_instance_t, open_list);
 		if (slave->slave_class == master->slave_class &&
 		    slave->slave_id == master->slave_id) {
-			list_del(p);
-			list_add_tail(p, &master->slave_list_head);
+			list_move_tail(p, &master->slave_list_head);
 			spin_lock_irq(&slave_active_lock);
 			slave->master = master;
 			slave->timer = master->timer;
@@ -326,8 +324,7 @@
 			slave = (snd_timer_instance_t *)list_entry(p, snd_timer_instance_t, open_list);
 			spin_lock_irq(&slave_active_lock);
 			_snd_timer_stop(slave, 1, SNDRV_TIMER_EVENT_RESOLUTION);
-			list_del(p);
-			list_add_tail(p, &snd_timer_slave_list);
+			list_move_tail(p, &snd_timer_slave_list);
 			slave->master = NULL;
 			slave->timer = NULL;
 			spin_unlock_irq(&slave_active_lock);
@@ -391,8 +388,7 @@
 
 static int snd_timer_start1(snd_timer_t *timer, snd_timer_instance_t *timeri, unsigned long sticks)
 {
-	list_del(&timeri->active_list);
-	list_add_tail(&timeri->active_list, &timer->active_list_head);
+	list_move_tail(&timeri->active_list, &timer->active_list_head);
 	if (timer->running) {
 		timer->flags |= SNDRV_TIMER_FLG_RESCHED;
 		timeri->flags |= SNDRV_TIMER_IFLG_START;
diff -ur linux-2.5.66/sound/pci/emu10k1/memory.c linux/sound/pci/emu10k1/memory.c
--- linux-2.5.66/sound/pci/emu10k1/memory.c	2003-03-24 19:29:58.000000000 -0500
+++ linux/sound/pci/emu10k1/memory.c	2003-03-25 07:59:10.000000000 -0500
@@ -258,8 +258,7 @@
 	spin_lock_irqsave(&emu->memblk_lock, flags);
 	if (blk->mapped_page >= 0) {
 		/* update order link */
-		list_del(&blk->mapped_order_link);
-		list_add_tail(&blk->mapped_order_link, &emu->mapped_order_link_head);
+		list_move_tail(&blk->mapped_order_link, &emu->mapped_order_link_head);
 		spin_unlock_irqrestore(&emu->memblk_lock, flags);
 		return 0;
 	}

--------------030007010704070207000909--

