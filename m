Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbUL1XhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUL1XhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbUL1XhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:37:15 -0500
Received: from mail.dif.dk ([193.138.115.101]:62906 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261170AbUL1XhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:37:01 -0500
Date: Wed, 29 Dec 2004 00:48:01 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Steve French <sfrench@samba.org>,
       Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/3] copy_to_user check in fs/cifs/file.c
In-Reply-To: <1104104286.16545.7.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0412290042480.3528@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost>
 <1104104286.16545.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Dec 2004, Alan Cox wrote:

> On Sul, 2004-12-26 at 23:24, Jesper Juhl wrote:
> > Hi,
> > 
> > Patch below adds a check for the copy_to_user return value and makes a few 
> > whitespace cleanups in  fs/cifs/file.c::cifs_user_read()
> > I hope bundling two different things together in one patch is OK when the 
> > change is as small as this, but if you want it spplit in two patches, then 
> > just say so.
> 
> Corrupts the stats
> Fails to free smb_read_data where in some cases it was freed before
> 
> I'm not sure the stats matter but I think you need something more like
> 
Like this patch perhaps? :

It implements what you sugested except it breaks the loop when there's 
some residue from the copy_to_user call, since the logic after the while 
loop handles the   return total_read ? total_read : -EFAULT;  case if we 
set rc and break (I've cut the diff with a few lines of extra context to 
make this easy to verify).

Comments welcome as always.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff --unified=8 -p linux-2.6.10-orig/fs/cifs/file.c linux-2.6.10/fs/cifs/file.c
--- linux-2.6.10-orig/fs/cifs/file.c	2004-12-24 22:33:48.000000000 +0100
+++ linux-2.6.10/fs/cifs/file.c	2004-12-28 23:27:17.000000000 +0100
@@ -1142,16 +1142,17 @@ cifs_user_read(struct file * file, char 
 	open_file = (struct cifsFileInfo *)file->private_data;
 
 	if((file->f_flags & O_ACCMODE) == O_WRONLY) {
 		cFYI(1,("attempting read on write only file instance"));
 	}
 
 	for (total_read = 0,current_offset=read_data; read_size > total_read;
 				total_read += bytes_read,current_offset+=bytes_read) {
+		unsigned residue;
 		current_read_size = min_t(const int,read_size - total_read,cifs_sb->rsize);
 		rc = -EAGAIN;
 		smb_read_data = NULL;
 		while(rc == -EAGAIN) {
 			if ((open_file->invalidHandle) && (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
 					file,TRUE);
 				if(rc != 0)
@@ -1159,22 +1160,27 @@ cifs_user_read(struct file * file, char 
 			}
 
 			rc = CIFSSMBRead(xid, pTcon,
 				 open_file->netfid,
 				 current_read_size, *poffset,
 				 &bytes_read, &smb_read_data);
 
 			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
-			copy_to_user(current_offset,smb_read_data + 4/* RFC1001 hdr*/
+			residue = copy_to_user(current_offset, smb_read_data + 4 /* RFC1001 hdr */
 				+ le16_to_cpu(pSMBr->DataOffset), bytes_read);
 			if(smb_read_data) {
 				cifs_buf_release(smb_read_data);
 				smb_read_data = NULL;
 			}
+			if (residue) {
+				total_read += bytes_read - residue;
+				rc = -EFAULT;
+				break;
+			}
 		}
 		if (rc || (bytes_read == 0)) {
 			if (total_read) {
 				break;
 			} else {
 				FreeXid(xid);
 				return rc;
 			}



