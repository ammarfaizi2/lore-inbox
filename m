Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUFWUv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUFWUv0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 16:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266664AbUFWUv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 16:51:26 -0400
Received: from outmx019.isp.belgacom.be ([195.238.2.200]:2208 "EHLO
	outmx019.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261654AbUFWUvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 16:51:19 -0400
Subject: [PATCH 2.6.7-mm1] MBR centralization
From: FabF <fabian.frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Rz4VkMBTDLB3ERYBhnCm"
Message-Id: <1088025348.2213.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 23 Jun 2004 23:15:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Rz4VkMBTDLB3ERYBhnCm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	Here's a patch for partition management:

	-Centralize msdos mbr detection.(magic detection was made twice : in
efi and msdos)

		-mbr definition moved from efi to genhd
		-msdos partition code mbr magics removed to use the one above
		-adding genhd explicit macro used by both

	-DOS_EXTENDED_PARTITION washing#2
		(we don't want magic numbers, do we ?)
		-Remove use of <= 4 to < DOS_EXTENDED_PARTITION where needed
	-Trivial doc (so trivial indeed).
	-Some code washing

PS: It runs under !EFI (for the least)

Regards,
FabF

--=-Rz4VkMBTDLB3ERYBhnCm
Content-Disposition: attachment; filename=partitions2.diff
Content-Type: text/x-patch; name=partitions2.diff; charset=UTF-8
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
+++ edited/fs/partitions/msdos.c	2004-06-23 22:36:46.496786675 +0200
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
+		if (!MSDOS_MBR (data + 510))
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
@@ -397,16 +389,16 @@
 	 * is not 0 or 0x80.
 	 */
 	p = (struct partition *) (data + 0x1be);
-	for (slot = 1; slot <= 4; slot++, p++) {
+	for (slot = 1; slot < DOS_EXTENDED_PARTITION; slot++, p++) {
 		if (p->boot_ind != 0 && p->boot_ind != 0x80) {
 			put_dev_sector(sect);
 			return 0;
 		}
 	}
-
+	/*EFI : Extensible Firmware Initiative partitions ?*/
 #ifdef CONFIG_EFI_PARTITION
 	p = (struct partition *) (data + 0x1be);
-	for (slot = 1 ; slot <= 4 ; slot++, p++) {
+	for (slot = 1 ; slot < DOS_EXTENDED_PARTITION; slot++, p++) {
 		/* If this is an EFI GPT disk, msdos should ignore it. */
 		if (SYS_IND(p) == EFI_PMBR_OSTYPE_EFI_GPT) {
 			put_dev_sector(sect);
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
+++ edited/include/linux/genhd.h	2004-06-24 02:00:09.000000000 +0200
@@ -17,6 +17,10 @@
 #include <linux/string.h>
 #include <linux/fs.h>
 
+/*Master boot record magic numbers*/
+#define MSDOS_MBR_SIGNATURE 0xaa55
+#define MSDOS_MBR(p) le16_to_cpu((u16)*p) == MSDOS_MBR_SIGNATURE
+
 enum {
 /* These three have identical behaviour; use the second one if DOS FDISK gets
    confused about extended/logical partitions starting past cylinder 1023. */

--=-Rz4VkMBTDLB3ERYBhnCm--

