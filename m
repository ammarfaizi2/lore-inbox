Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVHWUqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVHWUqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVHWUqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:46:15 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:8969 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932392AbVHWUqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:46:14 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, smfrench@austin.rr.com
In-reply-to: <E1E7fcN-0006IR-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 23 Aug 2005 22:43:35 +0200)
Subject: [PATCH 7/8] cifs_create() fix
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu> <E1E7fMD-0006En-00@dorka.pomaz.szeredi.hu> <E1E7fPj-0006Fq-00@dorka.pomaz.szeredi.hu> <E1E7fSd-0006Gr-00@dorka.pomaz.szeredi.hu> <E1E7fVJ-0006HK-00@dorka.pomaz.szeredi.hu> <E1E7fcN-0006IR-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1E7feg-0006JB-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Aug 2005 22:45:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cifs_create() did totally the wrong thing with nd->intent.open.flags:
it interpreted nd->intent.open.flags as the original open flags, not
the one transformed for open_namei().  Also it used the intent data
even if it was not filled in (if called from sys_mknod()).

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/cifs/dir.c
===================================================================
--- linux.orig/fs/cifs/dir.c	2005-08-23 11:01:58.000000000 +0200
+++ linux/fs/cifs/dir.c	2005-08-23 11:09:03.000000000 +0200
@@ -145,24 +145,23 @@ cifs_create(struct inode *inode, struct 
 		return -ENOMEM;
 	}
 
-	if(nd) {
-		if ((nd->intent.open.flags & O_ACCMODE) == O_RDONLY)
-			desiredAccess = GENERIC_READ;
-		else if ((nd->intent.open.flags & O_ACCMODE) == O_WRONLY) {
-			desiredAccess = GENERIC_WRITE;
-			write_only = TRUE;
-		} else if ((nd->intent.open.flags & O_ACCMODE) == O_RDWR) {
-			/* GENERIC_ALL is too much permission to request */
-			/* can cause unnecessary access denied on create */
-			/* desiredAccess = GENERIC_ALL; */
-			desiredAccess = GENERIC_READ | GENERIC_WRITE;
+	if(nd && (nd->flags & LOOKUP_OPEN)) {
+		int oflags = nd->intent.open.flags;
+
+		desiredAccess = 0;		
+		if (oflags & FMODE_READ)
+			desiredAccess |= GENERIC_READ;
+		if (oflags & FMODE_WRITE) {
+			desiredAccess |= GENERIC_WRITE;
+			if (!(oflags & FMODE_READ))
+				write_only = TRUE;
 		}
 
-		if((nd->intent.open.flags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
+		if((oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
 			disposition = FILE_CREATE;
-		else if((nd->intent.open.flags & (O_CREAT | O_TRUNC)) == (O_CREAT | O_TRUNC))
+		else if((oflags & (O_CREAT | O_TRUNC)) == (O_CREAT | O_TRUNC))
 			disposition = FILE_OVERWRITE_IF;
-		else if((nd->intent.open.flags & O_CREAT) == O_CREAT)
+		else if((oflags & O_CREAT) == O_CREAT)
 			disposition = FILE_OPEN_IF;
 		else {
 			cFYI(1,("Create flag not set in create function"));
