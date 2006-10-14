Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422690AbWJNPsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422690AbWJNPsk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 11:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWJNPsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 11:48:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37768 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422692AbWJNPsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 11:48:39 -0400
Date: Sat, 14 Oct 2006 16:48:26 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: sfrench@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] new cifs endianness bugs
Message-ID: <20061014154826.GK29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* missing cpu_to_le64() for ChangeTime (introduced by
    [CIFS] Legacy time handling for Win9x and OS/2 part 1)
* missing le16_to_cpu() for DialectIndex (introduced by
    [CIFS] Do not send newer QFSInfo to legacy servers which can not support it)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/cifs/cifssmb.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 5dc5a96..098790e 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -399,6 +399,7 @@ CIFSSMBNegotiate(unsigned int xid, struc
 	struct TCP_Server_Info * server;
 	u16 count;
 	unsigned int secFlags;
+	u16 dialect;
 
 	if(ses->server)
 		server = ses->server;
@@ -438,9 +439,10 @@ CIFSSMBNegotiate(unsigned int xid, struc
 	if (rc != 0) 
 		goto neg_err_exit;
 
-	cFYI(1,("Dialect: %d", pSMBr->DialectIndex));
+	dialect = le16_to_cpu(pSMBr->DialectIndex);
+	cFYI(1,("Dialect: %d", dialect));
 	/* Check wct = 1 error case */
-	if((pSMBr->hdr.WordCount < 13) || (pSMBr->DialectIndex == BAD_PROT)) {
+	if((pSMBr->hdr.WordCount < 13) || (dialect == BAD_PROT)) {
 		/* core returns wct = 1, but we do not ask for core - otherwise
 		small wct just comes when dialect index is -1 indicating we 
 		could not negotiate a common dialect */
@@ -448,8 +450,8 @@ CIFSSMBNegotiate(unsigned int xid, struc
 		goto neg_err_exit;
 #ifdef CONFIG_CIFS_WEAK_PW_HASH 
 	} else if((pSMBr->hdr.WordCount == 13)
-			&& ((pSMBr->DialectIndex == LANMAN_PROT)
-				|| (pSMBr->DialectIndex == LANMAN2_PROT))) {
+			&& ((dialect == LANMAN_PROT)
+				|| (dialect == LANMAN2_PROT))) {
 		__s16 tmp;
 		struct lanman_neg_rsp * rsp = (struct lanman_neg_rsp *)pSMBr;
 
@@ -2943,7 +2945,7 @@ QInfRetry:
 		ts.tv_nsec = 0;
 		ts.tv_sec = time;
 		/* decode time fields */
-		pFinfo->ChangeTime = cifs_UnixTimeToNT(ts);
+		pFinfo->ChangeTime = cpu_to_le64(cifs_UnixTimeToNT(ts));
 		pFinfo->LastWriteTime = pFinfo->ChangeTime;
 		pFinfo->LastAccessTime = 0;
 		pFinfo->AllocationSize =
-- 
1.4.2.GIT
