Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVELIeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVELIeo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVELIel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:34:41 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:56861
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261338AbVELIcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:32:23 -0400
Message-Id: <s28322a5.093@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 12 May 2005 10:32:34 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] ide-floppy adjustments
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part0F2CC3B2.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part0F2CC3B2.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Fix a build problem when IDEFLOPPY_DEBUG_BUGS is turned off, and eliminate
an access to memory that is no longer allocated (causing systems to fail
booting when CONFIG_DEBUG_PAGEALLOC is turned on).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/drivers/ide/ide-floppy.c linux-2.6.12-rc4/=
drivers/ide/ide-floppy.c
--- linux-2.6.12-rc4.base/drivers/ide/ide-floppy.c	2005-05-11 =
17:27:57.385469928 +0200
+++ linux-2.6.12-rc4/drivers/ide/ide-floppy.c	2005-05-11 17:50:36.2678884=
00 +0200
@@ -661,10 +661,12 @@ static void idefloppy_output_buffers (id
=20
 	idefloppy_do_end_request(drive, 1, done >> 9);
=20
+#if IDEFLOPPY_DEBUG_BUGS
 	if (bcount) {
 		printk(KERN_ERR "%s: leftover data in idefloppy_output_buff=
ers, bcount =3D=3D %d\n", drive->name, bcount);
 		idefloppy_write_zeros(drive, bcount);
 	}
+#endif
 }
=20
 static void idefloppy_update_buffers (ide_drive_t *drive, idefloppy_pc_t =
*pc)
@@ -1048,6 +1050,9 @@ static ide_startstop_t idefloppy_issue_p
 	atapi_bcount_t bcount;
 	ide_handler_t *pkt_xfer_routine;
=20
+#if 0 /* Accessing floppy->pc is not valid here, the previous pc may be =
gone
+         and have lived on another thread's stack; that stack may have =
become
+         unmapped meanwhile (CONFIG_DEBUG_PAGEALLOC). */
 #if IDEFLOPPY_DEBUG_BUGS
 	if (floppy->pc->c[0] =3D=3D IDEFLOPPY_REQUEST_SENSE_CMD &&
 	    pc->c[0] =3D=3D IDEFLOPPY_REQUEST_SENSE_CMD) {
@@ -1055,6 +1060,7 @@ static ide_startstop_t idefloppy_issue_p
 			"Two request sense in serial were issued\n");
 	}
 #endif /* IDEFLOPPY_DEBUG_BUGS */
+#endif
=20
 	if (floppy->failed_pc =3D=3D NULL &&
 	    pc->c[0] !=3D IDEFLOPPY_REQUEST_SENSE_CMD)



--=__Part0F2CC3B2.0__=
Content-Type: text/plain; name="linux-2.6.12-rc4-idefloppy.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.12-rc4-idefloppy.patch"

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Fix a build problem when IDEFLOPPY_DEBUG_BUGS is turned off, and eliminate
an access to memory that is no longer allocated (causing systems to fail
booting when CONFIG_DEBUG_PAGEALLOC is turned on).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc4.base/drivers/ide/ide-floppy.c linux-2.6.12-rc4/drivers/ide/ide-floppy.c
--- linux-2.6.12-rc4.base/drivers/ide/ide-floppy.c	2005-05-11 17:27:57.385469928 +0200
+++ linux-2.6.12-rc4/drivers/ide/ide-floppy.c	2005-05-11 17:50:36.267888400 +0200
@@ -661,10 +661,12 @@ static void idefloppy_output_buffers (id
 
 	idefloppy_do_end_request(drive, 1, done >> 9);
 
+#if IDEFLOPPY_DEBUG_BUGS
 	if (bcount) {
 		printk(KERN_ERR "%s: leftover data in idefloppy_output_buffers, bcount == %d\n", drive->name, bcount);
 		idefloppy_write_zeros(drive, bcount);
 	}
+#endif
 }
 
 static void idefloppy_update_buffers (ide_drive_t *drive, idefloppy_pc_t *pc)
@@ -1048,6 +1050,9 @@ static ide_startstop_t idefloppy_issue_p
 	atapi_bcount_t bcount;
 	ide_handler_t *pkt_xfer_routine;
 
+#if 0 /* Accessing floppy->pc is not valid here, the previous pc may be gone
+         and have lived on another thread's stack; that stack may have become
+         unmapped meanwhile (CONFIG_DEBUG_PAGEALLOC). */
 #if IDEFLOPPY_DEBUG_BUGS
 	if (floppy->pc->c[0] == IDEFLOPPY_REQUEST_SENSE_CMD &&
 	    pc->c[0] == IDEFLOPPY_REQUEST_SENSE_CMD) {
@@ -1055,6 +1060,7 @@ static ide_startstop_t idefloppy_issue_p
 			"Two request sense in serial were issued\n");
 	}
 #endif /* IDEFLOPPY_DEBUG_BUGS */
+#endif
 
 	if (floppy->failed_pc == NULL &&
 	    pc->c[0] != IDEFLOPPY_REQUEST_SENSE_CMD)

--=__Part0F2CC3B2.0__=--
