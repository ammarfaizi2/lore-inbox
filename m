Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290173AbSAKXwI>; Fri, 11 Jan 2002 18:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290174AbSAKXvv>; Fri, 11 Jan 2002 18:51:51 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:55026 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290173AbSAKXvf>; Fri, 11 Jan 2002 18:51:35 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201112351.g0BNp8912572@eng2.beaverton.ibm.com>
Subject: [PATCH] Mostly PAGE_SIZE IO for RAW (NEW VERSION)
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, bcrl@redhat.com,
        axboe@suse.de, andrea@suse.de, alan@lxorguk.ukuu.org.uk
Date: Fri, 11 Jan 2002 15:51:08 -0800 (PST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the new version of the patch for doing mostly PAGE_SIZE IO
for RAW (2.4.17). Here are the things that changed.

1) Inorder to address Jens Axboe and Ben LaHaise concerns, I followed
   Andrea's suggestion and modified the patch to do variable size IO 
   only for the tested drivers/adaptors.

   The patch will work only on the drivers which set "can_do_varyio" 
   bit in their SCSI Host template. Currently, I tested this on 
   QLOGIC, AIC adaptors. The hardware which has extra aligment 
   restrictions & drivers which can not handle variable buffer sizes 
   in a single IO can be safely excluded.

2) Limited the scope to only SCSI. 

   
Thanks to Andrea, Jens, Ben & Alan for their valuable input.

Thanks,
Badari

diff -Nur -X dontdiff linux/drivers/block/ll_rw_blk.c linux-2417newvary/drivers/block/ll_rw_blk.c
--- linux/drivers/block/ll_rw_blk.c	Mon Oct 29 12:11:17 2001
+++ linux-2417newvary/drivers/block/ll_rw_blk.c	Fri Jan 11 16:58:37 2002
@@ -118,6 +118,13 @@
 int * max_sectors[MAX_BLKDEV];
 
 /*
+ * blkdev_varyio indicates if variable size IO can be done on a device.
+ *
+ * Currently used for doing variable size IO on RAW devices.
+ */
+char * blkdev_varyio[MAX_BLKDEV];
+
+/*
  * How many reqeusts do we allocate per queue,
  * and how many do we "batch" on freeing them?
  */
@@ -874,20 +881,7 @@
 }
 
 
-/**
- * submit_bh: submit a buffer_head to the block device later for I/O
- * @rw: whether to %READ or %WRITE, or maybe to %READA (read ahead)
- * @bh: The &struct buffer_head which describes the I/O
- *
- * submit_bh() is very similar in purpose to generic_make_request(), and
- * uses that function to do most of the work.
- *
- * The extra functionality provided by submit_bh is to determine
- * b_rsector from b_blocknr and b_size, and to set b_rdev from b_dev.
- * This is is appropriate for IO requests that come from the buffer
- * cache and page cache which (currently) always use aligned blocks.
- */
-void submit_bh(int rw, struct buffer_head * bh)
+static inline void submit_bh_rsector(int rw, struct buffer_head * bh, int rsect)
 {
 	int count = bh->b_size >> 9;
 
@@ -901,7 +895,7 @@
 	 * further remap this.
 	 */
 	bh->b_rdev = bh->b_dev;
-	bh->b_rsector = bh->b_blocknr * count;
+	bh->b_rsector = rsect;
 
 	generic_make_request(rw, bh);
 
@@ -913,6 +907,33 @@
 			kstat.pgpgin += count;
 			break;
 	}
+}
+
+/**
+ * submit_bh: submit a buffer_head to the block device later for I/O
+ * @rw: whether to %READ or %WRITE, or maybe to %READA (read ahead)
+ * @bh: The &struct buffer_head which describes the I/O
+ *
+ * submit_bh() is very similar in purpose to generic_make_request(), and
+ * uses that function to do most of the work.
+ *
+ * The extra functionality provided by submit_bh is to determine
+ * b_rsector from b_blocknr and b_size, and to set b_rdev from b_dev.
+ * This is is appropriate for IO requests that come from the buffer
+ * cache and page cache which (currently) always use aligned blocks.
+ */
+void submit_bh(int rw, struct buffer_head * bh)
+{
+	submit_bh_rsector(rw, bh, bh->b_blocknr * (bh->b_size >> 9));
+}
+
+/*
+ * submit_bh_blknr() - same as submit_bh() except that b_rsector is
+ * set to b_blocknr. Used for RAW VARY.
+ */
+void submit_bh_blknr(int rw, struct buffer_head * bh)
+{
+	submit_bh_rsector(rw, bh, bh->b_blocknr);
 }
 
 /**
diff -Nur -X dontdiff linux/drivers/char/raw.c linux-2417newvary/drivers/char/raw.c
--- linux/drivers/char/raw.c	Sat Sep 22 20:35:43 2001
+++ linux-2417newvary/drivers/char/raw.c	Fri Jan 11 21:37:16 2002
@@ -23,6 +23,7 @@
 	struct block_device *binding;
 	int inuse, sector_size, sector_bits;
 	struct semaphore mutex;
+	int can_do_vary;
 } raw_device_data_t;
 
 static raw_device_data_t raw_devices[256];
@@ -225,6 +226,8 @@
 				bdput(raw_devices[minor].binding);
 			raw_devices[minor].binding = 
 				bdget(kdev_t_to_nr(MKDEV(rq.block_major, rq.block_minor)));
+			raw_devices[minor].can_do_vary = 
+				get_blkdev_varyio(rq.block_major, rq.block_minor);
 			up(&raw_devices[minor].mutex);
 		} else {
 			struct block_device *bdev;
@@ -283,6 +286,7 @@
 
 	int		sector_size, sector_bits, sector_mask;
 	int		max_sectors;
+	int		can_do_varyio;
 	
 	/*
 	 * First, a few checks on device size limits 
@@ -308,6 +312,7 @@
 	sector_bits = raw_devices[minor].sector_bits;
 	sector_mask = sector_size- 1;
 	max_sectors = KIO_MAX_SECTORS >> (sector_bits - 9);
+	can_do_varyio = raw_devices[minor].can_do_vary;
 	
 	if (blk_size[MAJOR(dev)])
 		limit = (((loff_t) blk_size[MAJOR(dev)][MINOR(dev)]) << BLOCK_SIZE_BITS) >> sector_bits;
@@ -350,8 +355,12 @@
 
 		for (i=0; i < blocks; i++) 
 			iobuf->blocks[i] = blocknr++;
+
+		iobuf->dovary = can_do_varyio;
 		
 		err = brw_kiovec(rw, 1, &iobuf, dev, iobuf->blocks, sector_size);
+
+		iobuf->dovary = 0;
 
 		if (rw == READ && err > 0)
 			mark_dirty_kiobuf(iobuf, err);
diff -Nur -X dontdiff linux/drivers/scsi/aic7xxx/aic7xxx_linux_host.h linux-2417newvary/drivers/scsi/aic7xxx/aic7xxx_linux_host.h
--- linux/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Thu Oct 25 13:53:49 2001
+++ linux-2417newvary/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Fri Jan 11 21:39:18 2002
@@ -89,7 +89,8 @@
 	present: 0,		/* number of 7xxx's present   */\
 	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
 	use_clustering: ENABLE_CLUSTERING,			\
-	use_new_eh_code: 1					\
+	use_new_eh_code: 1,					\
+	can_do_varyio: 1					\
 }
 
 #endif /* _AIC7XXX_LINUX_HOST_H_ */
diff -Nur -X dontdiff linux/drivers/scsi/hosts.h linux-2417newvary/drivers/scsi/hosts.h
--- linux/drivers/scsi/hosts.h	Thu Nov 22 11:49:15 2001
+++ linux-2417newvary/drivers/scsi/hosts.h	Fri Jan 11 18:19:39 2002
@@ -292,6 +292,11 @@
     unsigned emulated:1;
 
     /*
+     * True for drivers which can handle variable length IO
+     */
+    unsigned can_do_varyio:1;
+
+    /*
      * Name of proc directory
      */
     char *proc_name;
diff -Nur -X dontdiff linux/drivers/scsi/qlogicisp.h linux-2417newvary/drivers/scsi/qlogicisp.h
--- linux/drivers/scsi/qlogicisp.h	Fri Nov 12 04:40:46 1999
+++ linux-2417newvary/drivers/scsi/qlogicisp.h	Thu Jan 10 22:51:55 2002
@@ -84,7 +84,8 @@
 	cmd_per_lun:		1,					   \
 	present:		0,					   \
 	unchecked_isa_dma:	0,					   \
-	use_clustering:		DISABLE_CLUSTERING			   \
+	use_clustering:		DISABLE_CLUSTERING,			   \
+	can_do_varyio:		1					   \
 }
 
 #endif /* _QLOGICISP_H */
diff -Nur -X dontdiff linux/drivers/scsi/sd.c linux-2417newvary/drivers/scsi/sd.c
--- linux/drivers/scsi/sd.c	Fri Nov  9 14:05:06 2001
+++ linux-2417newvary/drivers/scsi/sd.c	Fri Jan 11 21:34:19 2002
@@ -1241,6 +1241,8 @@
 	return 1;
 }
 
+#define SD_DISK_MAJOR(i)	SD_MAJOR((i) >> 4)
+
 static int sd_attach(Scsi_Device * SDp)
 {
         unsigned int devnum;
@@ -1274,6 +1276,22 @@
 	printk("Attached scsi %sdisk %s at scsi%d, channel %d, id %d, lun %d\n",
 	       SDp->removable ? "removable " : "",
 	       nbuff, SDp->host->host_no, SDp->channel, SDp->id, SDp->lun);
+
+	if (SDp->host->hostt->can_do_varyio) {
+		char *varyio;
+
+		varyio = blkdev_varyio[SD_DISK_MAJOR(i)];
+		if (varyio == NULL) {
+			varyio =  kmalloc((sd_template.dev_max << 4), GFP_ATOMIC);
+			if (varyio == NULL) {
+				printk("Unable allocate for VARYIO\n");
+				return 0;
+			}
+			blkdev_varyio[SD_DISK_MAJOR(i)] = varyio;
+		}
+
+		memset(varyio + (devnum << 4), 1, 16);
+	}
 	return 0;
 }
 
diff -Nur -X dontdiff linux/fs/buffer.c linux-2417newvary/fs/buffer.c
--- linux/fs/buffer.c	Fri Jan 11 18:11:37 2002
+++ linux-2417newvary/fs/buffer.c	Fri Jan 11 18:16:29 2002
@@ -2071,11 +2071,11 @@
 	err = 0;
 
 	for (i = nr; --i >= 0; ) {
-		iosize += size;
 		tmp = bh[i];
 		if (buffer_locked(tmp)) {
 			wait_on_buffer(tmp);
 		}
+		iosize += tmp->b_size;
 		
 		if (!buffer_uptodate(tmp)) {
 			/* We are traversing bh'es in reverse order so
@@ -2118,6 +2118,7 @@
 	struct kiobuf *	iobuf = NULL;
 	struct page *	map;
 	struct buffer_head *tmp, **bhs = NULL;
+	int		iosize = size;
 
 	if (!nr)
 		return 0;
@@ -2154,7 +2155,7 @@
 			}
 			
 			while (length > 0) {
-				blocknr = b[bufind++];
+				blocknr = b[bufind];
 				if (blocknr == -1UL) {
 					if (rw == READ) {
 						/* there was an hole in the filesystem */
@@ -2167,9 +2168,15 @@
 					} else
 						BUG();
 				}
+				if (iobuf->dovary) {
+					iosize = PAGE_SIZE - offset;
+					if (iosize > length)
+						iosize = length;
+				}
+				bufind += (iosize/size);
 				tmp = bhs[bhind++];
 
-				tmp->b_size = size;
+				tmp->b_size = iosize;
 				set_bh_page(tmp, map, offset);
 				tmp->b_this_page = tmp;
 
@@ -2185,7 +2192,10 @@
 					set_bit(BH_Uptodate, &tmp->b_state);
 
 				atomic_inc(&iobuf->io_count);
-				submit_bh(rw, tmp);
+				if (iobuf->dovary) 
+					submit_bh_blknr(rw, tmp);
+				else 
+					submit_bh(rw, tmp);
 				/* 
 				 * Wait for IO if we have got too much 
 				 */
@@ -2200,8 +2210,8 @@
 				}
 
 			skip_block:
-				length -= size;
-				offset += size;
+				length -= iosize;
+				offset += iosize;
 
 				if (offset >= PAGE_SIZE) {
 					offset = 0;
diff -Nur -X dontdiff linux/include/linux/blkdev.h linux-2417newvary/include/linux/blkdev.h
--- linux/include/linux/blkdev.h	Mon Nov 26 05:29:17 2001
+++ linux-2417newvary/include/linux/blkdev.h	Fri Jan 11 16:58:52 2002
@@ -175,6 +175,8 @@
 
 extern int * max_segments[MAX_BLKDEV];
 
+extern char * blkdev_varyio[MAX_BLKDEV];
+
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS 255
 
@@ -228,4 +230,12 @@
 	return retval;
 }
 
+static inline int get_blkdev_varyio(int major, int minor)
+{
+	int retval = 0;
+	if (blkdev_varyio[major]) {
+		retval = blkdev_varyio[major][minor];	
+	}
+	return retval;
+}
 #endif
diff -Nur -X dontdiff linux/include/linux/iobuf.h linux-2417newvary/include/linux/iobuf.h
--- linux/include/linux/iobuf.h	Thu Nov 22 11:46:26 2001
+++ linux-2417newvary/include/linux/iobuf.h	Wed Jan  9 22:17:39 2002
@@ -44,7 +44,8 @@
 
 	struct page **	maplist;
 
-	unsigned int	locked : 1;	/* If set, pages has been locked */
+	unsigned int	locked : 1,	/* If set, pages has been locked */
+			dovary : 1;	/* If set, do variable size IO */
 	
 	/* Always embed enough struct pages for atomic IO */
 	struct page *	map_array[KIO_STATIC_PAGES];
