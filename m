Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277267AbRJQWRt>; Wed, 17 Oct 2001 18:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277265AbRJQWRa>; Wed, 17 Oct 2001 18:17:30 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:23762 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S277264AbRJQWRS>; Wed, 17 Oct 2001 18:17:18 -0400
Date: Wed, 17 Oct 2001 18:17:54 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Patch to make free_kiobuf prettier in -ac
Message-ID: <20011017181754.A6918@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fellow hackers:

YMMV, but free_kiobuf_sz injures my sense of beauty
in C programming. Anyone cares enough to comment?

Greerings,
-- Pete

diff -urN -X dontdiff linux-2.4.10-ac10/drivers/char/raw.c linux-2.4.10-ac10-e/drivers/char/raw.c
--- linux-2.4.10-ac10/drivers/char/raw.c	Wed Oct 10 21:51:41 2001
+++ linux-2.4.10-ac10-e/drivers/char/raw.c	Wed Oct 17 14:49:53 2001
@@ -157,13 +157,12 @@
 {
 	int minor;
 	struct block_device *bdev;
-	int	nbhs = KIO_MAX_SECTORS;
-	
+
 	minor = MINOR(inode->i_rdev);
 	down(&raw_devices[minor].mutex);
 	bdev = raw_devices[minor].binding;
 	if (!--raw_devices[minor].inuse)
-		free_kiovec_sz(1, &raw_devices[minor].iobuf, &nbhs);
+		free_kiovec(1, &raw_devices[minor].iobuf);
 	up(&raw_devices[minor].mutex);
 	blkdev_put(bdev, BDEV_RAW);
 	return 0;
@@ -390,7 +389,7 @@
 	if (!new_iobuf)
 		clear_bit(0, &raw_devices[minor].iobuf_lock);
 	else
-		free_kiovec_sz(1, &iobuf, &nbhs);
+		free_kiovec(1, &iobuf);
  out:	
 	return err;
 }
diff -urN -X dontdiff linux-2.4.10-ac10/drivers/md/lvm-snap.c linux-2.4.10-ac10-e/drivers/md/lvm-snap.c
--- linux-2.4.10-ac10/drivers/md/lvm-snap.c	Wed Oct 10 21:51:44 2001
+++ linux-2.4.10-ac10-e/drivers/md/lvm-snap.c	Wed Oct 17 14:51:42 2001
@@ -528,12 +528,12 @@
 
 out_free_both_kiovecs:
 	unmap_kiobuf(lv_snap->lv_COW_table_iobuf);
-	free_kiovec_sz(1, &lv_snap->lv_COW_table_iobuf, &nbhs);
+	free_kiovec(1, &lv_snap->lv_COW_table_iobuf);
 	lv_snap->lv_COW_table_iobuf = NULL;
 
 out_free_kiovec:
 	unmap_kiobuf(lv_snap->lv_iobuf);
-	free_kiovec_sz(1, &lv_snap->lv_iobuf, &nbhs);
+	free_kiovec(1, &lv_snap->lv_iobuf);
 	lv_snap->lv_iobuf = NULL;
 	if (lv_snap->lv_snapshot_hash_table != NULL)
 		vfree(lv_snap->lv_snapshot_hash_table);
@@ -543,7 +543,6 @@
 
 void lvm_snapshot_release(lv_t * lv)
 {
-	int 	nbhs = KIO_MAX_SECTORS;
 
 	if (lv->lv_block_exception)
 	{
@@ -560,14 +559,14 @@
 	{
 	        kiobuf_wait_for_io(lv->lv_iobuf);
 		unmap_kiobuf(lv->lv_iobuf);
-		free_kiovec_sz(1, &lv->lv_iobuf, &nbhs);
+		free_kiovec(1, &lv->lv_iobuf);
 		lv->lv_iobuf = NULL;
 	}
 	if (lv->lv_COW_table_iobuf)
 	{
                kiobuf_wait_for_io(lv->lv_COW_table_iobuf);
                unmap_kiobuf(lv->lv_COW_table_iobuf);
-               free_kiovec_sz(1, &lv->lv_COW_table_iobuf, &nbhs);
+               free_kiovec(1, &lv->lv_COW_table_iobuf);
                lv->lv_COW_table_iobuf = NULL;
 	}
 }
diff -urN -X dontdiff linux-2.4.10-ac10/drivers/mtd/devices/blkmtd.c linux-2.4.10-ac10-e/drivers/mtd/devices/blkmtd.c
--- linux-2.4.10-ac10/drivers/mtd/devices/blkmtd.c	Wed Oct 10 21:51:44 2001
+++ linux-2.4.10-ac10-e/drivers/mtd/devices/blkmtd.c	Wed Oct 17 14:50:24 2001
@@ -229,7 +229,7 @@
   err = brw_kiovec(READ, 1, &iobuf, dev, iobuf->blocks, rawdevice->sector_size);
   DEBUG(3, "blkmtd: readpage: finished, err = %d\n", err);
   iobuf->locked = 0;
-  free_kiovec_sz(1, &iobuf, &nbhs);
+  free_kiovec(1, &iobuf);
   if(err != PAGE_SIZE) {
     printk("blkmtd: readpage: error reading page %ld\n", page->index);
     memset(page_address(page), 0, PAGE_SIZE);
@@ -364,7 +364,7 @@
   }
   remove_wait_queue(&thr_wq, &wait);
   DEBUG(1, "blkmtd: writetask: exiting\n");
-  free_kiovec_sz(1, &iobuf, &nbhs);
+  free_kiovec(1, &iobuf);
   /* Tell people we have exitd */
   up(&thread_sem);
   return 0;
diff -urN -X dontdiff linux-2.4.10-ac10/drivers/scsi/sg.c linux-2.4.10-ac10-e/drivers/scsi/sg.c
--- linux-2.4.10-ac10/drivers/scsi/sg.c	Wed Oct 10 21:52:00 2001
+++ linux-2.4.10-ac10-e/drivers/scsi/sg.c	Wed Oct 17 14:45:24 2001
@@ -1472,7 +1472,6 @@
 
 static void sg_unmap_and(Sg_scatter_hold * schp, int free_also)
 {
-	int	nbhs = KIO_MAX_SECTORS;
 
 #ifdef SG_ALLOW_DIO_CODE
     if (schp && schp->kiobp) {
@@ -1481,7 +1480,7 @@
 	    schp->mapped = 0;
 	}
 	if (free_also) {
-	    free_kiovec_sz(1, &schp->kiobp, &nbhs);
+	    free_kiovec(1, &schp->kiobp);
 	    schp->kiobp = NULL;
 	}
     }
diff -urN -X dontdiff linux-2.4.10-ac10/fs/iobuf.c linux-2.4.10-ac10-e/fs/iobuf.c
--- linux-2.4.10-ac10/fs/iobuf.c	Wed Oct 10 21:52:08 2001
+++ linux-2.4.10-ac10-e/fs/iobuf.c	Wed Oct 17 14:57:48 2001
@@ -45,6 +45,7 @@
 	iobuf->array_len = KIO_STATIC_PAGES;
 	iobuf->maplist   = iobuf->map_array;
 	iobuf->nr_pages = 0;
+	iobuf->buffers = 0;
 	iobuf->locked = 0;
 	iobuf->io_count.counter = 0;
 	iobuf->end_io = NULL;
@@ -62,6 +63,7 @@
 			}
 			return -ENOMEM;
 		}
+	kiobuf->buffers = sz;
 	return 0;
 }
 
@@ -79,28 +81,27 @@
 {
 	int i;
 	struct kiobuf *iobuf;
-	int	*tszp = szp;
-	
+
 	for (i = 0; i < nr; i++) {
 		iobuf = kmem_cache_alloc(kiobuf_cachep, SLAB_KERNEL);
 		if (!iobuf) {
-			free_kiovec_sz(i, bufp, szp);
+			free_kiovec(i, bufp);
 			return -ENOMEM;
 		}
 		kiobuf_init(iobuf);
- 		if (alloc_kiobuf_bhs_sz(iobuf,*tszp)) {
+ 		if (alloc_kiobuf_bhs_sz(iobuf, *szp)) {
 			kmem_cache_free(kiobuf_cachep, iobuf);
- 			free_kiovec_sz(i, bufp, szp);
+ 			free_kiovec(i, bufp);
  			return -ENOMEM;
  		}
-		tszp++;
+		szp++;
 		bufp[i] = iobuf;
 	}
 	
 	return 0;
 }
 
-void free_kiovec_sz(int nr, struct kiobuf **bufp, int *szp) 
+void free_kiovec(int nr, struct kiobuf **bufp) 
 {
 	int i;
 	struct kiobuf *iobuf;
@@ -111,9 +112,8 @@
 			unlock_kiovec(1, &iobuf);
 		if (iobuf->array_len > KIO_STATIC_PAGES)
 			kfree (iobuf->maplist);
-		free_kiobuf_bhs_sz(iobuf,*szp);
+		free_kiobuf_bhs_sz(iobuf, iobuf->buffers);
 		kmem_cache_free(kiobuf_cachep, bufp[i]);
-		szp++;
 	}
 }
 
diff -urN -X dontdiff linux-2.4.10-ac10/include/linux/iobuf.h linux-2.4.10-ac10-e/include/linux/iobuf.h
--- linux-2.4.10-ac10/include/linux/iobuf.h	Wed Oct 10 21:52:15 2001
+++ linux-2.4.10-ac10-e/include/linux/iobuf.h	Wed Oct 17 14:48:14 2001
@@ -36,6 +36,7 @@
 	int		array_len;	/* Space in the allocated lists */
 	int		offset;		/* Offset to start of valid data */
 	int		length;		/* Number of valid bytes of data */
+	int		buffers;	/* So many used in bh[] */
 
 	/* Keep separate track of the physical addresses and page
 	 * structs involved.  If we do IO to a memory-mapped device
@@ -72,7 +73,7 @@
 void	end_kio_request(struct kiobuf *, int);
 void	simple_wakeup_kiobuf(struct kiobuf *);
 int	alloc_kiovec_sz(int nr, struct kiobuf **, int *);
-void	free_kiovec_sz(int nr, struct kiobuf **, int *);
+void	free_kiovec(int nr, struct kiobuf **);
 int	expand_kiobuf(struct kiobuf *, int);
 void	kiobuf_wait_for_io(struct kiobuf *);
 extern int alloc_kiobuf_bhs(struct kiobuf *);
diff -urN -X dontdiff linux-2.4.10-ac10/kernel/ksyms.c linux-2.4.10-ac10-e/kernel/ksyms.c
--- linux-2.4.10-ac10/kernel/ksyms.c	Wed Oct 10 21:52:16 2001
+++ linux-2.4.10-ac10-e/kernel/ksyms.c	Wed Oct 17 14:47:51 2001
@@ -395,7 +395,7 @@
 
 /* Kiobufs */
 EXPORT_SYMBOL(alloc_kiovec_sz);
-EXPORT_SYMBOL(free_kiovec_sz);
+EXPORT_SYMBOL(free_kiovec);
 EXPORT_SYMBOL(expand_kiobuf);
 
 EXPORT_SYMBOL(map_user_kiobuf);
