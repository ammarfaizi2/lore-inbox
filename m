Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbUKIWBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbUKIWBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbUKIWBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:01:35 -0500
Received: from lists.us.dell.com ([143.166.224.162]:59458 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261717AbUKIV7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:59:53 -0500
Date: Tue, 9 Nov 2004 15:59:36 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org
Cc: davej@redhat.com, "Luck, Tony" <tony.luck@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [PATCH 2.6] EFI GPT: reduce alternate header probing
Message-ID: <20041109215936.GB617@lists.us.dell.com>
References: <Pine.LNX.4.58.0411070959560.2223@ppc970.osdl.org> <Pine.LNX.4.58.0411071128240.24286@ppc970.osdl.org> <20041107200351.GA3169@lists.us.dell.com> <Pine.LNX.4.58.0411071306000.24286@ppc970.osdl.org> <20041109214935.GA617@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109214935.GA617@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EFI partitioning scheme was reading the last reported sector of the
block device to look for the alternate GPT header, before it had
confirmed that it should.  This causes problems for devices with the
following problems:  a) those who misreport their size (typically
off-by-one), and b) those who fail when asked to read a block
outside their range.

This patch moves the test for the Protective Master Boot Record (PMBR)
ahead of the tests for the Primary and Alternate GPT headers.  If the
PMBR is not valid, the disk is assumed to not be a GPT disk.  This can
be overridden with the 'gpt' kernel command line option.  If the
Primary GPT header is not valid, the Alternate GPT header is not
probed automatically unless the 'gpt' kernel command line option is
passed.  If the both the PMBR and Primary GPT header are valid, then
the Alternate GPT header at the end of the disk is probed.

Also re-enables CONFIG_EFI_PARTITION for all architectures.


Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== fs/partitions/efi.c 1.8 vs edited =====
--- 1.8/fs/partitions/efi.c	2004-02-22 23:24:15 -06:00
+++ edited/fs/partitions/efi.c	2004-11-09 14:43:34 -06:00
@@ -3,7 +3,7 @@
  * Per Intel EFI Specification v1.02
  * http://developer.intel.com/technology/efi/efi.htm
  * efi.[ch] by Matt Domsch <Matt_Domsch@dell.com>
- *   Copyright 2000,2001,2002 Dell Inc.
+ *   Copyright 2000,2001,2002,2004 Dell Inc.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -23,6 +23,11 @@
  * TODO:
  *
  * Changelog:
+ * Mon Nov 09 2004 Matt Domsch <Matt_Domsch@dell.com>
+ * - test for valid PMBR and valid PGPT before ever reading
+ *   AGPT, allow override with 'gpt' kernel command line option.
+ * - check for first/last_usable_lba outside of size of disk
+ *
  * Tue  Mar 26 2002 Matt Domsch <Matt_Domsch@dell.com>
  * - Ported to 2.5.7-pre1 and 2.5.7-dj2
  * - Applied patch to avoid fault in alternate header handling
@@ -131,32 +136,6 @@
 }
 
 /**
- * is_pmbr_valid(): test Protective MBR for validity
- * @mbr: pointer to a legacy mbr structure
- *
- * Description: Returns 1 if PMBR is valid, 0 otherwise.
- * Validity depends on two things:
- *  1) MSDOS signature is in the last two bytes of the MBR
- *  2) One partition of type 0xEE is found
- */
-static int
-is_pmbr_valid(legacy_mbr *mbr)
-{
-	int i, found = 0, signature = 0;
-	if (!mbr)
-		return 0;
-	signature = (le16_to_cpu(mbr->signature) == MSDOS_MBR_SIGNATURE);
-	for (i = 0; signature && i < 4; i++) {
-		if (mbr->partition_record[i].sys_ind ==
-                    EFI_PMBR_OSTYPE_EFI_GPT) {
-			found = 1;
-			break;
-		}
-	}
-	return (signature && found);
-}
-
-/**
  * last_lba(): return number of last logical block of device
  * @bdev: block device
  * 
@@ -168,7 +147,40 @@
 static u64
 last_lba(struct block_device *bdev)
 {
-	return (bdev->bd_inode->i_size >> 9) - 1;
+	if (!bdev || !bdev->bd_inode)
+		return 0;
+	return (bdev->bd_inode->i_size >> 9) - 1ULL;
+}
+
+static inline int
+pmbr_part_valid(struct partition *part, u64 lastlba)
+{
+        if (part->sys_ind == EFI_PMBR_OSTYPE_EFI_GPT &&
+            le32_to_cpu(part->start_sect) == 1UL)
+                return 1;
+        return 0;
+}
+
+/**
+ * is_pmbr_valid(): test Protective MBR for validity
+ * @mbr: pointer to a legacy mbr structure
+ * @lastlba: last_lba for the whole device
+ *
+ * Description: Returns 1 if PMBR is valid, 0 otherwise.
+ * Validity depends on two things:
+ *  1) MSDOS signature is in the last two bytes of the MBR
+ *  2) One partition of type 0xEE is found
+ */
+static int
+is_pmbr_valid(legacy_mbr *mbr, u64 lastlba)
+{
+	int i;
+	if (!mbr || le16_to_cpu(mbr->signature) != MSDOS_MBR_SIGNATURE)
+                return 0;
+	for (i = 0; i < 4; i++)
+		if (pmbr_part_valid(&mbr->partition_record[i], lastlba))
+                        return 1;
+	return 0;
 }
 
 /**
@@ -186,8 +198,8 @@
 {
 	size_t totalreadcount = 0;
 
-	if (!bdev || !buffer)
-		return 0;
+	if (!bdev || !buffer || lba > last_lba(bdev))
+                return 0;
 
 	while (count) {
 		int copied = 512;
@@ -206,7 +218,6 @@
 	return totalreadcount;
 }
 
-
 /**
  * alloc_read_gpt_entries(): reads partition entries from disk
  * @bdev
@@ -289,6 +300,7 @@
 	     gpt_header **gpt, gpt_entry **ptes)
 {
 	u32 crc, origcrc;
+	u64 lastlba;
 
 	if (!bdev || !gpt || !ptes)
 		return 0;
@@ -301,9 +313,7 @@
 			"%lld != %lld\n",
 			(unsigned long long)le64_to_cpu((*gpt)->signature),
 			(unsigned long long)GPT_HEADER_SIGNATURE);
-		kfree(*gpt);
-		*gpt = NULL;
-		return 0;
+		goto fail;
 	}
 
 	/* Check the GUID Partition Table CRC */
@@ -315,9 +325,7 @@
 		Dprintk
 		    ("GUID Partition Table Header CRC is wrong: %x != %x\n",
 		     crc, origcrc);
-		kfree(*gpt);
-		*gpt = NULL;
-		return 0;
+		goto fail;
 	}
 	(*gpt)->header_crc32 = cpu_to_le32(origcrc);
 
@@ -327,16 +335,28 @@
 		Dprintk("GPT my_lba incorrect: %lld != %lld\n",
 			(unsigned long long)le64_to_cpu((*gpt)->my_lba),
 			(unsigned long long)lba);
-		kfree(*gpt);
-		*gpt = NULL;
-		return 0;
+		goto fail;
 	}
 
-	if (!(*ptes = alloc_read_gpt_entries(bdev, *gpt))) {
-		kfree(*gpt);
-		*gpt = NULL;
-		return 0;
+	/* Check the first_usable_lba and last_usable_lba are
+	 * within the disk.
+	 */
+	lastlba = last_lba(bdev);
+	if (le64_to_cpu((*gpt)->first_usable_lba) > lastlba) {
+		Dprintk("GPT: first_usable_lba incorrect: %lld > %lld\n",
+			(unsigned long long)le64_to_cpu((*gpt)->first_usable_lba),
+			(unsigned long long)lastlba);
+		goto fail;
 	}
+	if (le64_to_cpu((*gpt)->last_usable_lba) > lastlba) {
+		Dprintk("GPT: last_usable_lba incorrect: %lld > %lld\n",
+			(unsigned long long)le64_to_cpu((*gpt)->last_usable_lba),
+			(unsigned long long)lastlba);
+		goto fail;
+	}
+
+	if (!(*ptes = alloc_read_gpt_entries(bdev, *gpt)))
+		goto fail;
 
 	/* Check the GUID Partition Entry Array CRC */
 	crc = efi_crc32((const unsigned char *) (*ptes),
@@ -345,15 +365,36 @@
 
 	if (crc != le32_to_cpu((*gpt)->partition_entry_array_crc32)) {
 		Dprintk("GUID Partitition Entry Array CRC check failed.\n");
-		kfree(*gpt);
-		*gpt = NULL;
-		kfree(*ptes);
-		*ptes = NULL;
-		return 0;
+		goto fail_ptes;
 	}
 
 	/* We're done, all's well */
 	return 1;
+
+ fail_ptes:
+	kfree(*ptes);
+	*ptes = NULL;
+ fail:
+	kfree(*gpt);
+	*gpt = NULL;
+	return 0;
+}
+
+/**
+ * is_pte_valid() - tests one PTE for validity
+ * @pte is the pte to check
+ * @lastlba is last lba of the disk
+ *
+ * Description: returns 1 if valid,  0 on error.
+ */
+static inline int
+is_pte_valid(const gpt_entry *pte, const u64 lastlba)
+{
+	if ((!efi_guidcmp(pte->partition_type_guid, NULL_GUID)) ||
+	    le64_to_cpu(pte->starting_lba) > lastlba         ||
+	    le64_to_cpu(pte->ending_lba)   > lastlba)
+		return 0;
+	return 1;
 }
 
 /**
@@ -464,8 +505,13 @@
  * @ptes is a PTEs ptr, filled on return.
  * Description: Returns 1 if valid, 0 on error.
  * If valid, returns pointers to newly allocated GPT header and PTEs.
- * Validity depends on finding either the Primary GPT header and PTEs valid,
- * or the Alternate GPT header and PTEs valid, and the PMBR valid.
+ * Validity depends on PMBR being valid (or being overridden by the
+ * 'gpt' kernel command line option) and finding either the Primary
+ * GPT header and PTEs valid, or the Alternate GPT header and PTEs
+ * valid.  If the Primary GPT header is not valid, the Alternate GPT header
+ * is not checked unless the 'gpt' kernel command line option is passed.
+ * This protects against devices which misreport their size, and forces
+ * the user to decide to use the Alternate GPT.
  */
 static int
 find_valid_gpt(struct block_device *bdev, gpt_header **gpt, gpt_entry **ptes)
@@ -479,70 +525,43 @@
 		return 0;
 
 	lastlba = last_lba(bdev);
+        if (!force_gpt) {
+                /* This will be added to the EFI Spec. per Intel after v1.02. */
+                legacymbr = kmalloc(sizeof (*legacymbr), GFP_KERNEL);
+                if (legacymbr) {
+                        memset(legacymbr, 0, sizeof (*legacymbr));
+                        read_lba(bdev, 0, (u8 *) legacymbr,
+                                 sizeof (*legacymbr));
+                        good_pmbr = is_pmbr_valid(legacymbr, lastlba);
+                        kfree(legacymbr);
+                        legacymbr=NULL;
+                }
+                if (!good_pmbr)
+                        goto fail;
+        }
+
 	good_pgpt = is_gpt_valid(bdev, GPT_PRIMARY_PARTITION_TABLE_LBA,
 				 &pgpt, &pptes);
-        if (good_pgpt) {
+        if (good_pgpt)
 		good_agpt = is_gpt_valid(bdev,
-                                         le64_to_cpu(pgpt->alternate_lba),
+					 le64_to_cpu(pgpt->alternate_lba),
 					 &agpt, &aptes);
-                if (!good_agpt) {
-                        good_agpt = is_gpt_valid(bdev, lastlba,
-                                                 &agpt, &aptes);
-                }
-        }
-        else {
+        if (!good_agpt && force_gpt)
                 good_agpt = is_gpt_valid(bdev, lastlba,
                                          &agpt, &aptes);
-        }
 
         /* The obviously unsuccessful case */
-        if (!good_pgpt && !good_agpt) {
-                goto fail;
-        }
-
-	/* This will be added to the EFI Spec. per Intel after v1.02. */
-        legacymbr = kmalloc(sizeof (*legacymbr), GFP_KERNEL);
-        if (legacymbr) {
-                memset(legacymbr, 0, sizeof (*legacymbr));
-                read_lba(bdev, 0, (u8 *) legacymbr,
-                         sizeof (*legacymbr));
-                good_pmbr = is_pmbr_valid(legacymbr);
-                kfree(legacymbr);
-                legacymbr=NULL;
-        }
-
-        /* Failure due to bad PMBR */
-        if ((good_pgpt || good_agpt) && !good_pmbr && !force_gpt) {
-                printk(KERN_WARNING 
-                       "  Warning: Disk has a valid GPT signature "
-                       "but invalid PMBR.\n");
-                printk(KERN_WARNING
-                       "  Assuming this disk is *not* a GPT disk anymore.\n");
-                printk(KERN_WARNING
-                       "  Use gpt kernel option to override.  "
-                       "Use GNU Parted to correct disk.\n");
+        if (!good_pgpt && !good_agpt)
                 goto fail;
-        }
-
-        /* Would fail due to bad PMBR, but force GPT anyhow */
-        if ((good_pgpt || good_agpt) && !good_pmbr && force_gpt) {
-                printk(KERN_WARNING
-                       "  Warning: Disk has a valid GPT signature but "
-                       "invalid PMBR.\n");
-                printk(KERN_WARNING
-                       "  Use GNU Parted to correct disk.\n");
-                printk(KERN_WARNING
-                       "  gpt option taken, disk treated as GPT.\n");
-        }
 
         compare_gpts(pgpt, agpt, lastlba);
 
         /* The good cases */
-        if (good_pgpt && (good_pmbr || force_gpt)) {
+        if (good_pgpt) {
                 *gpt  = pgpt;
                 *ptes = pptes;
-                if (agpt)  { kfree(agpt);   agpt = NULL; }
-                if (aptes) { kfree(aptes); aptes = NULL; }
+                kfree(agpt);
+                kfree(aptes);
                 if (!good_agpt) {
                         printk(KERN_WARNING 
 			       "Alternate GPT is invalid, "
@@ -550,21 +569,21 @@
                 }
                 return 1;
         }
-        else if (good_agpt && (good_pmbr || force_gpt)) {
+        else if (good_agpt) {
                 *gpt  = agpt;
                 *ptes = aptes;
-                if (pgpt)  { kfree(pgpt);   pgpt = NULL; }
-                if (pptes) { kfree(pptes); pptes = NULL; }
+                kfree(pgpt);
+                kfree(pptes);
                 printk(KERN_WARNING 
                        "Primary GPT is invalid, using alternate GPT.\n");
                 return 1;
         }
 
  fail:
-        if (pgpt)  { kfree(pgpt);   pgpt=NULL; }
-        if (agpt)  { kfree(agpt);   agpt=NULL; }
-        if (pptes) { kfree(pptes); pptes=NULL; }
-        if (aptes) { kfree(aptes); aptes=NULL; }
+        kfree(pgpt);
+        kfree(agpt);
+        kfree(pptes);
+        kfree(aptes);
         *gpt = NULL;
         *ptes = NULL;
         return 0;
@@ -606,15 +625,15 @@
 	Dprintk("GUID Partition Table is valid!  Yea!\n");
 
 	for (i = 0; i < le32_to_cpu(gpt->num_partition_entries) && i < state->limit-1; i++) {
-		if (!efi_guidcmp(ptes[i].partition_type_guid, NULL_GUID))
+		if (!is_pte_valid(&ptes[i], last_lba(bdev)))
 			continue;
 
 		put_partition(state, i+1, le64_to_cpu(ptes[i].starting_lba),
 				 (le64_to_cpu(ptes[i].ending_lba) -
                                   le64_to_cpu(ptes[i].starting_lba) +
-				  1));
+				  1ULL));
 
-		/* If there's this is a RAID volume, tell md */
+		/* If this is a RAID volume, tell md */
 		if (!efi_guidcmp(ptes[i].partition_type_guid,
 				 PARTITION_LINUX_RAID_GUID))
 			state->parts[i+1].flags = 1;
@@ -624,22 +643,3 @@
 	printk("\n");
 	return 1;
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: nil
- * tab-width: 8
- * End:
- */
===== fs/partitions/Kconfig 1.6 vs edited =====
--- 1.6/fs/partitions/Kconfig	2004-11-07 12:15:48 -06:00
+++ edited/fs/partitions/Kconfig	2004-11-08 09:52:30 -06:00
@@ -219,7 +219,7 @@
 
 config EFI_PARTITION
 	bool "EFI GUID Partition support"
-	depends on PARTITION_ADVANCED && IA64
+	depends on PARTITION_ADVANCED
 	select CRC32
 	help
 	  Say Y here if you would like to use hard disks under Linux which
