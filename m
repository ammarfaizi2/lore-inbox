Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUHDMgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUHDMgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 08:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUHDMgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 08:36:47 -0400
Received: from avalon.servus.at ([193.170.194.18]:55172 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261451AbUHDMg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 08:36:29 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Message-Id: <200408041233.i74CX93f009939@wildsau.enemy.org>
Subject: PATCH: cdrecord: avoiding scsi device numbering for ide devices
To: linux-kernel@vger.kernel.org
Date: Wed, 4 Aug 2004 14:33:09 +0200 (MET DST)
CC: schilling@fokus.fraunhofer.de
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

I've written a patch for cdrecord/cdrtools. I've sent it to Joerg Schilling
already, but got no answer so far. Probably he's on vaccation.

I'm sending this to LKML too, because I've read about some ... nebulosity
with respect to scsi device numbering as used by cdrtools.

To cut a long story short: the patch avoids cdrecord having to use the
"virtual" scsi device numbering in the form of "ATAPI:x.y.z" and allows
you to use the name of the device, e.g. /dev/hdc instead.

By removing the IDE to virtual scsi bus/host/lun mapping, a lot of confusion
can be avoided especially if you have a lot devices of this kind in one
system.

with kind regards,
Herbert "herp" Rosmanith

Version: cdrtools-2.01a34

Solution: when the device specified in dev= starts with "/dev/hd" and
          this device can be found in /proc/ide, then cdrecord (and all
          it's components, such as e.g. cdrdao) is forced to use the
          ATAPI driver.

The patch is really very short and works at least on our system.

with kind regards,
Herbert Rosmanith

--- snip ---
diff -ru cdrtools-2.01.orig/libscg/scsi-linux-ata.c cdrtools-2.01/libscg/scsi-linux-ata.c
--- cdrtools-2.01.orig/libscg/scsi-linux-ata.c	Sat Jun 12 12:48:12 2004
+++ cdrtools-2.01/libscg/scsi-linux-ata.c	Wed Aug  4 14:19:31 2004
@@ -42,6 +42,11 @@
  * You should have received a copy of the GNU General Public License along with
  * this program; see the file COPYING.  If not, write to the Free Software
  * Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Sat Jun 12 12:48:12 CEST 2004 herp - Herbert Rosmanith
+ *     Force ATAPI driver if dev= starts with /dev/hd and device
+ *     is present in /proc/ide/hdX
+ *
  */
 
 #ifdef	USE_ATA
@@ -60,7 +65,7 @@
 LOCAL	int	scgo_areset	__PR((SCSI *scgp, int what));
 LOCAL	int	scgo_asend	__PR((SCSI *scgp));
 
-LOCAL scg_ops_t ata_ops = {
+EXPORT scg_ops_t scg_ata_ops = {
 	scgo_asend,
 	scgo_aversion,
 	scgo_ahelp,
diff -ru cdrtools-2.01.orig/libscg/scsi-linux-sg.c cdrtools-2.01/libscg/scsi-linux-sg.c
--- cdrtools-2.01.orig/libscg/scsi-linux-sg.c	Thu May 20 15:42:12 2004
+++ cdrtools-2.01/libscg/scsi-linux-sg.c	Wed Aug  4 14:20:56 2004
@@ -40,6 +40,11 @@
  *	string is related to a modified source.
  *
  *	Copyright (c) 1997 J. Schilling
+ *
+ * Sat Jun 12 12:48:12 CEST 2004 herp - Herbert Rosmanith
+ *     Force ATAPI driver if dev= starts with /dev/hd and device
+ *     is present in /proc/ide/hdX
+ *
  */
 /*
  * This program is free software; you can redistribute it and/or modify
@@ -315,7 +320,7 @@
 	if (device != NULL && *device != '\0') {
 #ifdef	USE_ATA
 		if (strncmp(device, "ATAPI", 5) == 0) {
-			scgp->ops = &ata_ops;
+			scgp->ops = &scg_ata_ops;
 			return (SCGO_OPEN(scgp, device));
 		}
 #endif
diff -ru cdrtools-2.01.orig/libscg/scsitransp.c cdrtools-2.01/libscg/scsitransp.c
--- cdrtools-2.01.orig/libscg/scsitransp.c	Thu Jun 17 22:20:27 2004
+++ cdrtools-2.01/libscg/scsitransp.c	Wed Aug  4 14:26:07 2004
@@ -13,6 +13,11 @@
  *	string is related to a modified source.
  *
  *	Copyright (c) 1988,1995,2000-2004 J. Schilling
+ *
+ * Sat Jun 12 12:48:12 CEST 2004 herp - Herbert Rosmanith
+ *     Force ATAPI driver if dev= starts with /dev/hd and device
+ *     is present in /proc/ide/hdX
+ *
  */
 /*
  * This program is free software; you can redistribute it and/or modify
@@ -34,6 +39,7 @@
 #include <stdio.h>
 #include <standard.h>
 #include <stdxlib.h>
+#include <sys/stat.h>
 #include <unixstd.h>
 #include <errno.h>
 #include <timedefs.h>
@@ -157,7 +163,7 @@
 {
 	int	ret;
 	scg_ops_t *ops;
-extern	scg_ops_t scg_std_ops;
+extern	scg_ops_t scg_std_ops,scg_ata_ops;
 
 	/*
 	 * Begin restricted code for quality assurance.
@@ -185,6 +191,16 @@
 			scgp->ops = ops;
 	}
 
+	// XXX herp - check if atapi driver neccessary
+	//            and load if ide device found
+
+	if (device && strncmp(device,"/dev/hd",7)==0) {
+	char pdev[]="/proc/ide/XXXX";
+	struct stat st;
+		strncpy(pdev+10,device+5,4);    /* hdXY should be enough, eh? */
+		if (stat(pdev,&st)==0)
+			scgp->ops=&scg_ata_ops;
+	}
 	ret = SCGO_OPEN(scgp, device);
 	if (ret < 0)
 		return (ret);
--- snip ---

