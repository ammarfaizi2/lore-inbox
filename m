Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVH0D47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVH0D47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 23:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbVH0D47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 23:56:59 -0400
Received: from mail25.sea5.speakeasy.net ([69.17.117.27]:923 "EHLO
	mail25.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030296AbVH0D47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 23:56:59 -0400
Date: Fri, 26 Aug 2005 23:56:56 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de
Subject: [PATCH ISDN] Fix capifs bug in initialization error path.
Message-ID: <Pine.LNX.4.63.0508262339210.21123@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug in the capifs initialization code, where the 
filesystem is not unregistered if kern_mount() fails.

Please apply.

Signed-off-by: James Morris <jmorris@namei.org>

---

 capifs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -purN -X dontdiff linux-2.6.13-mm2.o/drivers/isdn/capi/capifs.c linux-2.6.13-mm2.x/drivers/isdn/capi/capifs.c
--- linux-2.6.13-mm2.o/drivers/isdn/capi/capifs.c	2005-03-02 02:37:50.000000000 -0500
+++ linux-2.6.13-mm2.x/drivers/isdn/capi/capifs.c	2005-08-26 23:35:50.000000000 -0400
@@ -191,8 +191,10 @@ static int __init capifs_init(void)
 	err = register_filesystem(&capifs_fs_type);
 	if (!err) {
 		capifs_mnt = kern_mount(&capifs_fs_type);
-		if (IS_ERR(capifs_mnt))
+		if (IS_ERR(capifs_mnt)) {
 			err = PTR_ERR(capifs_mnt);
+			unregister_filesystem(&capifs_fs_type);
+		}
 	}
 	if (!err)
 		printk(KERN_NOTICE "capifs: Rev %s\n", rev);
