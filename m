Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263963AbRFWOmq>; Sat, 23 Jun 2001 10:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263964AbRFWOmg>; Sat, 23 Jun 2001 10:42:36 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:8767
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S263963AbRFWOm2>; Sat, 23 Jun 2001 10:42:28 -0400
Date: Sat, 23 Jun 2001 16:42:18 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: jffs-dev@axis.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add kmalloc checking to fs/jffs/intrep.c (245-ac16)
Message-ID: <20010623164218.D840@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch adds some checks for kmalloc returning NULL
to fs/jffs/intrep.c along with some way of getting that propagated
back. Applies against 245ac16 and 246p5. These dereferences were
reported by the Stanford team a way back.


--- linux-245-ac16-clean/fs/jffs/intrep.c	Thu Jun 21 21:26:24 2001
+++ linux-245-ac16/fs/jffs/intrep.c	Sat Jun 23 16:25:33 2001
@@ -320,8 +320,8 @@
 }
 
 
-__u32
-jffs_checksum_flash(struct mtd_info *mtd, loff_t start, int size)
+int
+jffs_checksum_flash(struct mtd_info *mtd, loff_t start, int size, __u32* checksum)
 {
 	__u32 sum = 0;
 	loff_t ptr = start;
@@ -330,6 +330,10 @@
 
 	/* Allocate read buffer */
 	read_buf = (__u8 *) kmalloc (sizeof(__u8) * 4096, GFP_KERNEL);
+	if (!read_buf) {
+		printk(KERN_ERR "(jffs:) Out of memory allocating buffer. Aborting.");
+		return -1;
+	}
 
 	/* Loop until checksum done */
 	while (size) {
@@ -357,7 +361,8 @@
 
 	/* Return result */
 	D3(printk("checksum result: 0x%08x\n", sum));
-	return sum;
+	*checksum = sum;
+	return 0;
 }
 static __inline__ void jffs_fm_write_lock(struct jffs_fmcontrol *fmc)
 {
@@ -605,6 +610,8 @@
 
 	/* Allocate read buffer */
 	read_buf = (__u8 *) kmalloc (sizeof(__u8) * 4096, GFP_KERNEL);
+	if (!read_buf) 
+		return -ENOMEM;
 
 	/* Start the scan.  */
 	while (pos < end) {
@@ -859,7 +866,10 @@
 			if (raw_inode.rename) {
 				deleted_file = flash_read_u32(fmc->mtd, pos);
 			}
-			checksum = jffs_checksum_flash(fmc->mtd, pos, raw_inode.dsize);
+			if (jffs_checksum_flash(fmc->mtd, pos, 
+						raw_inode.dsize, &checksum))
+				return -ENOMEM;
+
 			pos += raw_inode.dsize
 			       + JFFS_GET_PAD_BYTES(raw_inode.dsize);
 

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Television is called a medium because it is neither rare nor well-done. 
  -- Anonymous
