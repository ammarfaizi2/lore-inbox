Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965324AbWHOJQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965324AbWHOJQs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965326AbWHOJQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:16:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48514 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965324AbWHOJQr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:16:47 -0400
Date: Tue, 15 Aug 2006 10:16:46 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] endianness bitrot in cifs
Message-ID: <20060815091646.GX29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	le16 compared to host-endian constant
	u8 fed to le32_to_cpu()
	le16 compared to host-endian constant

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 19678c5..6a76ae5 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -477,7 +477,7 @@ #ifdef CONFIG_CIFS_WEAK_PW_HASH 
 		/* BB get server time for time conversions and add
 		code to use it and timezone since this is not UTC */	
 
-		if (rsp->EncryptionKeyLength == CIFS_CRYPTO_KEY_SIZE) {
+		if (rsp->EncryptionKeyLength == cpu_to_le16(CIFS_CRYPTO_KEY_SIZE)) {
 			memcpy(server->cryptKey, rsp->EncryptionKey,
 				CIFS_CRYPTO_KEY_SIZE);
 		} else if (server->secMode & SECMODE_PW_ENCRYPT) {
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 03bbcb3..105761e 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -556,7 +556,7 @@ static int cifs_entry_is_dot(char *curre
 		FIND_FILE_STANDARD_INFO * pFindData =
 			(FIND_FILE_STANDARD_INFO *)current_entry;
 		filename = &pFindData->FileName[0];
-		len = le32_to_cpu(pFindData->FileNameLength);
+		len = pFindData->FileNameLength;
 	} else {
 		cFYI(1,("Unknown findfirst level %d",cfile->srch_inf.info_level));
 	}
diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index 7202d53..d1705ab 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -372,7 +372,7 @@ #ifdef CONFIG_CIFS_WEAK_PW_HASH
 
 		/* no capabilities flags in old lanman negotiation */
 
-		pSMB->old_req.PasswordLength = CIFS_SESS_KEY_SIZE; 
+		pSMB->old_req.PasswordLength = cpu_to_le16(CIFS_SESS_KEY_SIZE); 
 		/* BB calculate hash with password */
 		/* and copy into bcc */
 
