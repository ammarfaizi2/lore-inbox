Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbUL1XpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbUL1XpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUL1XpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:45:00 -0500
Received: from mail.dif.dk ([193.138.115.101]:37819 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261164AbUL1Xou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:44:50 -0500
Date: Wed, 29 Dec 2004 00:55:51 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Steve French <sfrench@samba.org>,
       Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] get rid of two unnessesary assignments in fs/cifs/file.c
In-Reply-To: <1104104286.16545.7.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0412290052530.3528@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost>
 <1104104286.16545.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in two places in fs/cifs/file.c we assign -EIO to a variable (rc) then 
do something unrelated to rc, then return rc. The assignment of -EIO to rc 
is unnessesary, we may as well just return -EIO directly and avoid the 
extra assignment (yeah, the compiler will probably optimize it, but 
still...).


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10/fs/cifs/file.c~ linux-2.6.10/fs/cifs/file.c
--- linux-2.6.10/fs/cifs/file.c~	2004-12-29 00:41:00.000000000 +0100
+++ linux-2.6.10/fs/cifs/file.c	2004-12-29 00:40:51.000000000 +0100
@@ -1947,17 +1947,15 @@ cifs_readdir(struct file *file, void *di
 	xid = GetXid();
 
 	if (file->f_dentry == NULL) {
-		rc = -EIO;
 		FreeXid(xid);
-		return rc;
+		return -EIO;
 	}
 	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
 	pTcon = cifs_sb->tcon;
 	bufsize = pTcon->ses->server->maxBuf - MAX_CIFS_HDR_SIZE;
 	if (bufsize > CIFSMaxBufSize) {
-		rc = -EIO;
 		FreeXid(xid);
-		return rc;
+		return -EIO;
 	}
 	data = kmalloc(bufsize, GFP_KERNEL);
 	pfindData = (FILE_DIRECTORY_INFO *)data;



