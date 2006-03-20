Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWCTTxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWCTTxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWCTTxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:53:34 -0500
Received: from assei2bl6.telenet-ops.be ([195.130.133.69]:52694 "EHLO
	assei2bl6.telenet-ops.be") by vger.kernel.org with ESMTP
	id S964951AbWCTTxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:53:33 -0500
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mtd/redboot: Handle holes in fis table
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 20 Mar 2006 20:53:38 +0100
Message-ID: <87hd5slwot.fsf@48ers.dk>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Redboot simply sets the first character of a fis entry to 0xff on
"fis delete". The kernel redboot parser stops parsing on such an
entry, and without this patch any entries after a deleted image would
not be detected.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
--

 drivers/mtd/redboot.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: linux/drivers/mtd/redboot.c
===================================================================
--- linux.orig/drivers/mtd/redboot.c	2006-03-20 15:54:37.000000000 +0100
+++ linux/drivers/mtd/redboot.c	2006-03-20 16:00:06.000000000 +0100
@@ -85,10 +85,6 @@
 
 	numslots = (master->erasesize / sizeof(struct fis_image_desc));
 	for (i = 0; i < numslots; i++) {
-		if (buf[i].name[0] == 0xff) {
-			i = numslots;
-			break;
-		}
 		if (!memcmp(buf[i].name, "FIS directory", 14)) {
 			/* This is apparently the FIS directory entry for the
 			 * FIS directory itself.  The FIS directory size is
@@ -128,7 +124,7 @@
 		struct fis_list *new_fl, **prev;
 
 		if (buf[i].name[0] == 0xff)
-			break;
+			continue;
 		if (!redboot_checksum(&buf[i]))
 			break;
 
-- 
Bye, Peter Korsgaard
