Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbULVARQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbULVARQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbULVARQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:17:16 -0500
Received: from mail.dif.dk ([193.138.115.101]:13545 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261916AbULVARK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:17:10 -0500
Date: Wed, 22 Dec 2004 01:27:53 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Domen Puncer <domen@coderock.org>
Cc: Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>,
       samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: Re: in cifssmb.c add copy_from_user return value check and do minor
 formatting/whitespace cleanups.
In-Reply-To: <20041221235424.GA19274@nd47.coderock.org>
Message-ID: <Pine.LNX.4.61.0412220107230.3518@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412220021580.3518@dragon.hygekrogen.localhost>
 <20041221235424.GA19274@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2004, Domen Puncer wrote:

> On 22/12/04 00:33 +0100, Jesper Juhl wrote:
> > 
[...]
> > +	if (buf) {
> > +		memcpy(pSMB->Data,buf,bytes_sent);
> > +	} else if (ubuf) {
> > +		if (copy_from_user(pSMB->Data,ubuf,bytes_sent)) {
> > +			if (pSMB)
> 
> How can this be NULL, and code not Oopsing?
> 
Right, it would have Oopsed in tons of places above if pSMB was NULL, so 
there's no point in checking it at this stage. And if I'm reading 
smb_init() correctly, then it will return an error if it can't give pSMB a 
sane value, so we already bail out at the smb_init() call in that case.

How about this patch instead? (same as the previous one except it also 
removes those aparently pointless checks of pSMB and changes a single 
instance of a pointer being compared to 0 to instead compare against NULL 
so sparse won't complain about that) :


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc3-bk13-orig/fs/cifs/cifssmb.c linux-2.6.10-rc3-bk13/fs/cifs/cifssmb.c
--- linux-2.6.10-rc3-bk13-orig/fs/cifs/cifssmb.c	2004-12-20 22:19:42.000000000 +0100
+++ linux-2.6.10-rc3-bk13/fs/cifs/cifssmb.c	2004-12-22 01:20:21.000000000 +0100
@@ -246,7 +246,7 @@ smb_init(int smb_command, int wct, struc
 		return rc;
 
 	*request_buf = cifs_buf_get();
-	if (*request_buf == 0) {
+	if (*request_buf == NULL) {
 		/* BB should we add a retry in here if not a writepage? */
 		return -ENOMEM;
 	}
@@ -895,15 +895,18 @@ CIFSSMBWrite(const int xid, struct cifsT
 		bytes_sent = count;
 	pSMB->DataLengthHigh = 0;
 	pSMB->DataOffset =
-	    cpu_to_le16(offsetof(struct smb_com_write_req,Data) - 4);
-    if(buf)
-	    memcpy(pSMB->Data,buf,bytes_sent);
-	else if(ubuf)
-		copy_from_user(pSMB->Data,ubuf,bytes_sent);
-    else {
-		/* No buffer */
-		if(pSMB)
+		cpu_to_le16(offsetof(struct smb_com_write_req,Data) - 4);
+
+	if (buf) {
+		memcpy(pSMB->Data,buf,bytes_sent);
+	} else if (ubuf) {
+		if (copy_from_user(pSMB->Data,ubuf,bytes_sent)) {
 			cifs_buf_release(pSMB);
+			return -EFAULT;
+		}
+	} else {
+		/* No buffer */
+		cifs_buf_release(pSMB);
 		return -EINVAL;
 	}
 
@@ -921,8 +924,7 @@ CIFSSMBWrite(const int xid, struct cifsT
 	} else
 		*nbytes = le16_to_cpu(pSMBr->Count);
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls 
 		since file handle passed in no longer valid */



