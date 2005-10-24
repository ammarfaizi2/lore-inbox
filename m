Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbVJXF3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVJXF3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 01:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbVJXF3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 01:29:49 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:40059 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750991AbVJXF3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 01:29:48 -0400
Message-ID: <435C7149.3010004@gmail.com>
Date: Mon, 24 Oct 2005 00:29:45 -0500
From: Hareesh Nagarajan <hnagar2@gmail.com>
Reply-To: hnagar2@gmail.com
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mpm@selenic.com, ak@suse.de
Subject: [TRIVIAL] Error checks omitted in init_tmpfs() in mm/tiny-shmem.c
Content-Type: multipart/mixed;
 boundary="------------020605000001040507090707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020605000001040507090707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The existing code in init_tmpfs() in mm/tiny-shmem.c does not handle the 
cases when the calls to register_filesystem() and kern_mount() fail. 
This patch adds those checks.

Signed-off-by: Hareesh Nagarajan <hnagar2@gmail.com>


--------------020605000001040507090707
Content-Type: text/x-patch;
 name="tiny-shmmem-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tiny-shmmem-fix.patch"

--- linux-2.6.13.4/mm/tiny-shmem.c	2005-10-10 13:54:29.000000000 -0500
+++ linux-2.6.13.4-edit/mm/tiny-shmem.c	2005-10-24 00:13:10.532652000 -0500
@@ -31,12 +31,27 @@
 
 static int __init init_tmpfs(void)
 {
-	register_filesystem(&tmpfs_fs_type);
+	int error;
+
+	error = register_filesystem(&tmpfs_fs_type);
+	if (error) {
+		goto out2;
+	}
+
 #ifdef CONFIG_TMPFS
 	devfs_mk_dir("shm");
 #endif
 	shm_mnt = kern_mount(&tmpfs_fs_type);
+	if (IS_ERR(shm_mnt)) {
+		error = PTR_ERR(shm_mnt);
+		goto out1;
+	}
+
 	return 0;
+out1:
+	unregister_filesystem(&tmpfs_fs_type);
+out2:
+	return error;
 }
 module_init(init_tmpfs)
 

--------------020605000001040507090707--
