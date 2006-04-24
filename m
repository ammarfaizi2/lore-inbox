Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWDXUhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWDXUhJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDXUhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:37:09 -0400
Received: from mail.suse.de ([195.135.220.2]:39124 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751254AbWDXUhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:37:07 -0400
Date: Mon, 24 Apr 2006 13:35:23 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.16.11
Message-ID: <20060424203523.GB17597@kroah.com>
References: <20060424203358.GA17597@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424203358.GA17597@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 9ebe182..e86b4ba 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .10
+EXTRAVERSION = .11
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index fed55e3..5e562bc 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -441,6 +441,20 @@ cifs_lookup(struct inode *parent_dir_ino
 	cifs_sb = CIFS_SB(parent_dir_inode->i_sb);
 	pTcon = cifs_sb->tcon;
 
+	/*
+	 * Don't allow the separator character in a path component.
+	 * The VFS will not allow "/", but "\" is allowed by posix.
+	 */
+	if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS)) {
+		int i;
+		for (i = 0; i < direntry->d_name.len; i++)
+			if (direntry->d_name.name[i] == '\\') {
+				cFYI(1, ("Invalid file name"));
+				FreeXid(xid);
+				return ERR_PTR(-EINVAL);
+			}
+	}
+
 	/* can not grab the rename sem here since it would
 	deadlock in the cases (beginning of sys_rename itself)
 	in which we already have the sb rename sem */
