Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbTDUUJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTDUUJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:09:21 -0400
Received: from sj-core-1.cisco.com ([171.71.177.237]:46302 "EHLO
	sj-core-1.cisco.com") by vger.kernel.org with ESMTP id S261978AbTDUUJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:09:17 -0400
Subject: [Fwd: IDE DMA compact flash patch linux 2.4.20]
From: Stephen Baker <sbaker@stonecold.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-JUy9XWk//VfxGrUIpVJe"
Message-Id: <1050956401.10629.0.camel@stbaker-lnx4.cisco.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Apr 2003 15:20:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JUy9XWk//VfxGrUIpVJe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-JUy9XWk//VfxGrUIpVJe
Content-Disposition: inline
Content-Description: Forwarded message - IDE DMA compact flash patch linux
	2.4.20
Content-Type: message/rfc822

Subject: IDE DMA compact flash patch linux 2.4.20
From: Stephen Baker <sbaker@stonecold.net>
To: andre@linux-ide.org
Content-Type: multipart/mixed; boundary="=-iFy1tlax5FjEs7bkDAGW"
Organization: 
Message-Id: <1050336008.1506.27.camel@stbaker-lnx4.cisco.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 Apr 2003 11:05:54 -0500


--=-iFy1tlax5FjEs7bkDAGW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

All,

I have been testing several vendors Compact Flash Cards with Linux
2.4.20.  I have noticed many DMA problems when the Compact Flash is used
with a hard drive (salve or master) on the same control ide0.  The
second problem was the detection of the hard drive.

I read most of the posting and most people doing this kind of
configuration work was seeing some kind of DMA error with this
configuration but know one had any fixes.

The first change I made was to modify my grub to use "hda=flash".  I did
this because I would have to add each vendors ID string to the list of
compact flash device in the kernel which would mean frequent patches.

Now with the flash flag set correctly; I change the ide-dma.c to black
list Compact Flash cards.  This keeps us from having to list all compact
flash cards in the black list as well.  Now I'm able to use the Compact
Flash with out random DMA errors.

To fix the hard drive detection in this case I just commented out the
code that disables the other device if one of the devices is Compact
Flash in ide-probe.c.  I researched this change and it was put in to fix
having two compact flash and if one was missing so the boot would not
hang for a long time.  This breaks any configuration that uses a Compact
Flash with a hard drive.  I had seen some posts that had this same
change but I guess they never submitted as a patch.  I think the correct
solution for the original two Compact Flash cards would be using the
"noprobe" option in the grub.conf not as a kernel mod.

Thanks,
SB



--=-iFy1tlax5FjEs7bkDAGW
Content-Disposition: attachment; filename=idedma.patch
Content-Type: text/plain; name=idedma.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- ref/linux-2.4.20/drivers/ide/ide-probe.c	2002-11-28 17:53:13.000000000 -0600
+++ linux-2.4.20/drivers/ide/ide-probe.c	2003-03-30 00:22:43.000000000 -0600
@@ -166,6 +166,7 @@
 	 * Prevent long system lockup probing later for non-existant
 	 * slave drive if the hwif is actually a flash memory card of some variety:
 	 */
+#if 0
 	if (drive_is_flashcard(drive)) {
 		ide_drive_t *mate = &HWIF(drive)->drives[1^drive->select.b.unit];
 		if (!mate->ata_flash) {
@@ -173,6 +174,7 @@
 			mate->noprobe = 1;
 		}
 	}
+#endif
 	drive->media = ide_disk;
 	printk("ATA DISK drive\n");
 	QUIRK_LIST(HWIF(drive),drive);
--- ref/linux-2.4.20/drivers/ide/ide-dma.c	2002-11-28 17:53:13.000000000 -0600
+++ linux-2.4.20/drivers/ide/ide-dma.c	2003-03-30 00:20:19.000000000 -0600
@@ -439,6 +439,8 @@
  *  For both Blacklisted and Whitelisted drives.
  *  This is setup to be called as an extern for future support
  *  to other special driver code.
+ *
+ *  All flash cards in ATA mode should also be black listed
  */
 int check_drive_lists (ide_drive_t *drive, int good_bad)
 {
@@ -448,7 +450,7 @@
 	if (good_bad) {
 		return in_drive_list(id, drive_whitelist);
 	} else {
-		int blacklist = in_drive_list(id, drive_blacklist);
+		int blacklist = drive_is_flashcard(drive) || in_drive_list(id, drive_blacklist);
 		if (blacklist)
 			printk("%s: Disabling (U)DMA for %s\n", drive->name, id->model);
 		return(blacklist);
@@ -465,6 +467,12 @@
 		}
 	} else {
 		/* Consult the list of known "bad" drives */
+           if( drive_is_flashcard(drive) ) {
+              printk("%s: Disabling (U)DMA for Flash %s\n",
+	      drive->name, id->model);           
+              return 1;
+           }
+
 		list = bad_dma_drives;
 		while (*list) {
 			if (!strcmp(*list++,id->model)) {

--=-iFy1tlax5FjEs7bkDAGW--


--=-JUy9XWk//VfxGrUIpVJe--

