Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSKZVQ2>; Tue, 26 Nov 2002 16:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSKZVQ2>; Tue, 26 Nov 2002 16:16:28 -0500
Received: from hera.cwi.nl ([192.16.191.8]:9694 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261295AbSKZVQU>;
	Tue, 26 Nov 2002 16:16:20 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 26 Nov 2002 22:23:33 +0100 (MET)
Message-Id: <UTC200211262123.gAQLNXV15145.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] Silence debugging message
Cc: eric@ma-northadams1b-112.nad.adelphia.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Buddington writes:

> ...  I tried getting rid of the advanced partition types options,
> which eliminated the MS-DOS partition table message, but did not
> otherwise change things.

> hda: host protected area => 1
> hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=4982/255/63
> /dev/ide/host0/bus0/target0/lun0:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
> p1 p4

Yes, that annoying ldm message is just debugging output
somebody forgot to remove.

Andries

--- /linux/2.5/linux-2.5.49/linux/fs/partitions/ldm.c	Fri Nov 22 22:40:30 2002
+++ ./ldm.c	Tue Nov 26 22:22:28 2002
@@ -560,10 +560,8 @@
 		return FALSE;
 	}
 
-	if (*(u16*) (data + 0x01FE) != cpu_to_le16 (MSDOS_LABEL_MAGIC)) {
-		ldm_debug ("No MS-DOS partition table found.");
+	if (*(u16*) (data + 0x01FE) != cpu_to_le16 (MSDOS_LABEL_MAGIC))
 		goto out;
-	}
 
 	p = (struct partition*)(data + 0x01BE);
 	for (i = 0; i < 4; i++, p++)
@@ -573,9 +571,8 @@
 		}
 
 	if (result)
-		ldm_debug ("Parsed partition table successfully.");
-	else
-		ldm_debug ("Found an MS-DOS partition table, not a dynamic disk.");
+		ldm_debug ("Found W2K dynamic disk partition type.");
+
 out:
 	put_dev_sector (sect);
 	return result;
@@ -585,9 +582,10 @@
  * ldm_get_disk_objid - Search a linked list of vblk's for a given Disk Id
  * @ldb:  Cache of the database structures
  *
- * The LDM Database contains a list of all partitions on all dynamic disks.  The
- * primary PRIVHEAD, at the beginning of the physical disk, tells us the GUID of
- * this disk.  This function searches for the GUID in a linked list of vblk's.
+ * The LDM Database contains a list of all partitions on all dynamic disks.
+ * The primary PRIVHEAD, at the beginning of the physical disk, tells us
+ * the GUID of this disk.  This function searches for the GUID in a linked
+ * list of vblk's.
  *
  * Return:  Pointer, A matching vblk was found
  *          NULL,    No match, or an error
