Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVBMUX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVBMUX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 15:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVBMUX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 15:23:27 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:43688 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261303AbVBMUXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 15:23:09 -0500
Date: Sun, 13 Feb 2005 21:22:30 +0100
From: Luca <kronos@kronoz.cjb.net>
To: Marcel Sebek <sebek64@post.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Frenchs <french@samba.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6] Check return value of copy_to_user in fs/cifs/file.c [Re: Linux 2.6.11-rc4]
Message-ID: <20050213202230.GA10402@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <Pine.LNX.4.58.0502121928590.19649@ppc970.osdl.org> <20050213154416.GA26396@dreamland.darkstar.lan> <20050213172838.GA7829@penguin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050213172838.GA7829@penguin.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sun, Feb 13, 2005 at 06:28:38PM +0100, Marcel Sebek ha scritto: 
> > @@ -1164,13 +1164,22 @@
> >  				 current_read_size, *poffset,
> >  				 &bytes_read, &smb_read_data);
> >  
> > +			if (rc == -EAGAIN)
> > +				continue;
> > +			else
> > +				break;
> > +
> >  			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Perhaps this line and the following lines are never executed with your
> patch, am I right?

Yes, you are. Let's try again:

The following patch against 2.6.11-rc4 fixes this compile time
warning:

 CC [M]  fs/cifs/file.o
fs/cifs/file.c: In function `cifs_user_read':
fs/cifs/file.c:1168: warning: ignoring return value of
`copy_to_user', declared with attribute warn_unused_result

I also added an explicit check for errors other than -EAGAIN, since
CIFSSMBRead may return -ENOMEM if it's unable to allocate
smb_com_read_rsp; in that case we don't want to call copy_to_user with a
NULL pointer.

Signed-off-by: Luca Tettamanti <kronoz@kronoz.cjb.net>

--- a/fs/cifs/file.c	2005-02-03 17:58:07.000000000 +0100
+++ b/fs/cifs/file.c	2005-02-13 21:18:01.000000000 +0100
@@ -1151,7 +1151,7 @@
 		current_read_size = min_t(const int,read_size - total_read,cifs_sb->rsize);
 		rc = -EAGAIN;
 		smb_read_data = NULL;
-		while(rc == -EAGAIN) {
+		while(1) {
 			if ((open_file->invalidHandle) && (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
 					file,TRUE);
@@ -1164,13 +1164,22 @@
 				 current_read_size, *poffset,
 				 &bytes_read, &smb_read_data);
 
+			if (rc == -EAGAIN)
+				continue;
+			if (rc)
+				break;
+
 			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
-			copy_to_user(current_offset,smb_read_data + 4/* RFC1001 hdr*/
+			rc = copy_to_user(current_offset,smb_read_data + 4/* RFC1001 hdr*/
 				+ le16_to_cpu(pSMBr->DataOffset), bytes_read);
 			if(smb_read_data) {
 				cifs_buf_release(smb_read_data);
 				smb_read_data = NULL;
 			}
+			if (rc) {
+				FreeXid(xid);
+				return -EFAULT;
+			}
 		}
 		if (rc || (bytes_read == 0)) {
 			if (total_read) {


Luca
-- 
Home: http://kronoz.cjb.net
"La teoria e` quando sappiamo come funzionano le cose ma non funzionano.
 La pratica e` quando le cose funzionano ma non sappiamo perche`.
 Abbiamo unito la teoria e la pratica: le cose non funzionano piu` e non
 sappiamo il perche`." -- A. Einstein
