Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUFXGIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUFXGIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 02:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUFXGIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 02:08:19 -0400
Received: from outmx017.isp.belgacom.be ([195.238.2.116]:32934 "EHLO
	outmx017.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S263851AbUFXGIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 02:08:07 -0400
Subject: Re: [PATCH 2.6.7-mm1] MBR centralization
From: FabF <fabian.frederick@skynet.be>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040623213629.GC3072@pclin040.win.tue.nl>
References: <1088025348.2213.32.camel@localhost.localdomain>
	 <20040623213629.GC3072@pclin040.win.tue.nl>
Content-Type: multipart/mixed; boundary="=-GCf5R6WLXxJeYHGelWsY"
Message-Id: <1088057276.1901.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 24 Jun 2004 08:07:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GCf5R6WLXxJeYHGelWsY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-06-23 at 23:36, Andries Brouwer wrote:
> On Wed, Jun 23, 2004 at 11:15:49PM +0200, FabF wrote:
> > 
> > 	-DOS_EXTENDED_PARTITION washing#2
> > 		(we don't want magic numbers, do we ?)
> > 		-Remove use of <= 4 to < DOS_EXTENDED_PARTITION where needed
> 
> > -       for (slot = 1; slot <= 4; slot++, p++) {
> > +       for (slot = 1; slot < DOS_EXTENDED_PARTITION; slot++, p++) {
> 
> Maybe you do not know, but the 5 of DOS_EXTENDED_PARTITION is the
> value written in the sys_ind field of a partition.
> 
> It is totally unrelated to the 4 that is the upper bound of the
> loop over the four primary partitions in a DOS-type partition table.
> 

Here's a new version:
	-macro simplification (We're calling from struct & buffer so static fx
conversion seems troublesome)
	-(p)
	-MBR patch only

Someone could check EFI ?

Regards,
FabF

--=-GCf5R6WLXxJeYHGelWsY
Content-Disposition: attachment; filename=partitions4.diff
Content-Type: text/x-patch; name=partitions4.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/partitions/efi.c edited/fs/partitions/efi.c
--- orig/fs/partitions/efi.c	2004-06-16 07:19:23.000000000 +0200
+++ edited/fs/partitions/efi.c	2004-06-24 01:43:45.000000000 +0200
@@ -145,7 +145,7 @@
 	int i, found = 0, signature = 0;
 	if (!mbr)
 		return 0;
-	signature = (le16_to_cpu(mbr->signature) == MSDOS_MBR_SIGNATURE);
+	signature = MSDOS_MBR(&mbr->signature);
 	for (i = 0; signature && i < 4; i++) {
 		if (mbr->partition_record[i].sys_ind ==
                     EFI_PMBR_OSTYPE_EFI_GPT) {
diff -Naur orig/fs/partitions/efi.h edited/fs/partitions/efi.h
--- orig/fs/partitions/efi.h	2004-06-16 07:19:43.000000000 +0200
+++ edited/fs/partitions/efi.h	2004-06-24 01:20:46.000000000 +0200
@@ -34,7 +34,6 @@
 #include <linux/string.h>
 #include <linux/efi.h>
 
-#define MSDOS_MBR_SIGNATURE 0xaa55
 #define EFI_PMBR_OSTYPE_EFI 0xEF
 #define EFI_PMBR_OSTYPE_EFI_GPT 0xEE
 
diff -Naur orig/fs/partitions/msdos.c edited/fs/partitions/msdos.c
--- orig/fs/partitions/msdos.c	2004-06-16 07:19:37.000000000 +0200
+++ edited/fs/partitions/msdos.c	2004-06-24 08:00:05.000000000 +0200
@@ -50,15 +50,6 @@
 		SYS_IND(p) == LINUX_EXTENDED_PARTITION);
 }
 
-#define MSDOS_LABEL_MAGIC1	0x55
-#define MSDOS_LABEL_MAGIC2	0xAA
-
-static inline int
-msdos_magic_present(unsigned char *p)
-{
-	return (p[0] == MSDOS_LABEL_MAGIC1 && p[1] == MSDOS_LABEL_MAGIC2);
-}
-
 /*
  * Create devices for each logical partition in an extended partition.
  * The logical partitions form a linked list, with each entry being
@@ -87,6 +78,7 @@
 	this_size = first_size;
 
 	while (1) {
+		/*FIXME : Some definition for 100*/
 		if (++loopct > 100)
 			return;
 		if (state->next == state->limit)
@@ -95,7 +87,7 @@
 		if (!data)
 			return;
 
-		if (!msdos_magic_present(data + 510))
+		if (!MSDOS_MBR (data+510))
 			goto done; 
 
 		p = (struct partition *) (data + 0x1be);
@@ -112,7 +104,7 @@
 		/* 
 		 * First process the data partition(s)
 		 */
-		for (i=0; i<4; i++, p++) {
+		for (i = 0; i < 4; i++, p++) {
 			u32 offs, size, next;
 			if (!NR_SECTS(p) || is_extended_partition(p))
 				continue;
@@ -146,7 +138,7 @@
 		 * It should be a link to the next logical partition.
 		 */
 		p -= 4;
-		for (i=0; i<4; i++, p++)
+		for (i = 0; i < 4; i++, p++)
 			if (NR_SECTS(p) && is_extended_partition(p))
 				break;
 		if (i == 4)
@@ -342,7 +334,7 @@
 	/* The first sector of a Minix partition can have either
 	 * a secondary MBR describing its subpartitions, or
 	 * the normal boot sector. */
-	if (msdos_magic_present (data + 510) &&
+	if (MSDOS_MBR(data + 510) &&
 	    SYS_IND(p) == MINIX_PARTITION) { /* subpartition table present */
 
 		printk(" %s%d: <minix:", state->name, origin);
@@ -385,7 +377,7 @@
 	data = read_dev_sector(bdev, 0, &sect);
 	if (!data)
 		return -1;
-	if (!msdos_magic_present(data + 510)) {
+	if (!MSDOS_MBR(data + 510)) {
 		put_dev_sector(sect);
 		return 0;
 	}
@@ -403,7 +395,7 @@
 			return 0;
 		}
 	}
-
+	/*EFI : Extensible Firmware Initiative partitions ?*/
 #ifdef CONFIG_EFI_PARTITION
 	p = (struct partition *) (data + 0x1be);
 	for (slot = 1 ; slot <= 4 ; slot++, p++) {
@@ -433,6 +425,7 @@
 			   extended partition, but leave room for LILO */
 			put_partition(state, slot, start, size == 1 ? 1 : 2);
 			printk(" <");
+			/*parsing extended for logical partitions*/
 			parse_extended(state, bdev, start, size);
 			printk(" >");
 			continue;
diff -Naur orig/include/linux/genhd.h edited/include/linux/genhd.h
--- orig/include/linux/genhd.h	2004-06-16 07:18:59.000000000 +0200
+++ edited/include/linux/genhd.h	2004-06-24 08:02:45.151489490 +0200
@@ -17,6 +17,9 @@
 #include <linux/string.h>
 #include <linux/fs.h>
 
+/*Master boot record magic numbers*/
+#define MSDOS_MBR(p) le16_to_cpu((u16)*(p)) == 0xaa55
+
 enum {
 /* These three have identical behaviour; use the second one if DOS FDISK gets
    confused about extended/logical partitions starting past cylinder 1023. */

--=-GCf5R6WLXxJeYHGelWsY--

