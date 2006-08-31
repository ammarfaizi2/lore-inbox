Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWHaXqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWHaXqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWHaXqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:46:50 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:64977 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932488AbWHaXqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:46:49 -0400
Message-ID: <44F7764A.9050909@student.ltu.se>
Date: Fri, 01 Sep 2006 01:52:42 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, sfrench@samba.org
CC: linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc4-mm3 1/2] fs/cifs: Correcting error-prone boolean-statement
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Converting error-prone statement:
"if (var == FALSE)" into "if (!var)"
"if (var == TRUE)"  into "if (var)"
 
Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

Compile-tested
Please Cc: since I'm not on linux-cifs-client@lists.samba.org


 cifssmb.c |   10 +++++-----
 connect.c |    4 ++--
 dir.c     |    4 ++--
 file.c    |    6 +++---
 readdir.c |    2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)


diff -Narup a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
--- a/fs/cifs/cifssmb.c	2006-08-31 22:04:44.000000000 +0200
+++ b/fs/cifs/cifssmb.c	2006-09-01 00:22:10.000000000 +0200
@@ -135,7 +135,7 @@ small_smb_init(int smb_command, int wct,
 					(tcon->ses->server->tcpStatus == CifsGood), 10 * HZ);
 				if(tcon->ses->server->tcpStatus == CifsNeedReconnect) {
 					/* on "soft" mounts we wait once */
-					if((tcon->retry == FALSE) || 
+					if(!(tcon->retry) || 
 					   (tcon->ses->status == CifsExiting)) {
 						cFYI(1,("gave up waiting on reconnect in smb_init"));
 						return -EHOSTDOWN;
@@ -272,7 +272,7 @@ smb_init(int smb_command, int wct, struc
 				if(tcon->ses->server->tcpStatus == 
 						CifsNeedReconnect) {
 					/* on "soft" mounts we wait once */
-					if((tcon->retry == FALSE) || 
+					if(!(tcon->retry) || 
 					   (tcon->ses->status == CifsExiting)) {
 						cFYI(1,("gave up waiting on reconnect in smb_init"));
 						return -EHOSTDOWN;
@@ -582,7 +582,7 @@ CIFSSMBNegotiate(unsigned int xid, struc
 #ifdef CONFIG_CIFS_WEAK_PW_HASH
 signing_check:
 #endif
-	if(sign_CIFS_PDUs == FALSE) {        
+	if(!sign_CIFS_PDUs) {        
 		if(server->secMode & SECMODE_SIGN_REQUIRED)
 			cERROR(1,("Server requires "
 				 "/proc/fs/cifs/PacketSigningEnabled to be on"));
@@ -1432,7 +1432,7 @@ CIFSSMBLock(const int xid, struct cifsTc
 	if(lockType == LOCKING_ANDX_OPLOCK_RELEASE) {
 		timeout = -1; /* no response expected */
 		pSMB->Timeout = 0;
-	} else if (waitFlag == TRUE) {
+	} else if (waitFlag) {
 		timeout = 3;  /* blocking operation, no timeout */
 		pSMB->Timeout = cpu_to_le32(-1);/* blocking - do not time out */
 	} else {
@@ -3310,7 +3310,7 @@ int CIFSFindNext(const int xid, struct c
 
 	cFYI(1, ("In FindNext"));
 
-	if(psrch_inf->endOfSearch == TRUE)
+	if(psrch_inf->endOfSearch)
 		return -ENOENT;
 
 	rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
diff -Narup a/fs/cifs/connect.c b/fs/cifs/connect.c
--- a/fs/cifs/connect.c	2006-08-31 22:04:44.000000000 +0200
+++ b/fs/cifs/connect.c	2006-09-01 00:19:25.000000000 +0200
@@ -631,8 +631,8 @@ multi_t2_fnd:
 					smallbuf = NULL;
 			}
 			wake_up_process(task_to_wake);
-		} else if ((is_valid_oplock_break(smb_buffer, server) == FALSE)
-		    && (isMultiRsp == FALSE)) {                          
+		} else if (!is_valid_oplock_break(smb_buffer, server)
+		    && !isMultiRsp) {                          
 			cERROR(1, ("No task to wake, unknown frame rcvd! NumMids %d", midCount.counter));
 			cifs_dump_mem("Received Data is: ",(char *)smb_buffer,
 				      sizeof(struct smb_hdr));
diff -Narup a/fs/cifs/dir.c b/fs/cifs/dir.c
--- a/fs/cifs/dir.c	2006-08-31 22:04:44.000000000 +0200
+++ b/fs/cifs/dir.c	2006-09-01 00:22:15.000000000 +0200
@@ -252,7 +252,7 @@ cifs_create(struct inode *inode, struct 
 				direntry->d_op = &cifs_dentry_ops;
 			d_instantiate(direntry, newinode);
 		}
-		if((nd->flags & LOOKUP_OPEN) == FALSE) {
+		if(!(nd->flags & LOOKUP_OPEN)) {
 			/* mknod case - do not leave file open */
 			CIFSSMBClose(xid, pTcon, fileHandle);
 		} else if(newinode) {
@@ -278,7 +278,7 @@ cifs_create(struct inode *inode, struct 
 			pCifsInode = CIFS_I(newinode);
 			if(pCifsInode) {
 				/* if readable file instance put first in list*/
-				if (write_only == TRUE) {
+				if (write_only) {
                                        	list_add_tail(&pCifsFile->flist,
 						&pCifsInode->openFileList);
 				} else {
diff -Narup a/fs/cifs/file.c b/fs/cifs/file.c
--- a/fs/cifs/file.c	2006-08-31 22:04:44.000000000 +0200
+++ b/fs/cifs/file.c	2006-09-01 00:21:24.000000000 +0200
@@ -361,7 +361,7 @@ static int cifs_reopen_file(struct inode
 
 	xid = GetXid();
 	down(&pCifsFile->fh_sem);
-	if (pCifsFile->invalidHandle == FALSE) {
+	if (!(pCifsFile->invalidHandle)) {
 		up(&pCifsFile->fh_sem);
 		FreeXid(xid);
 		return 0;
@@ -553,8 +553,8 @@ int cifs_closedir(struct inode *inode, s
 		pTcon = cifs_sb->tcon;
 
 		cFYI(1, ("Freeing private data in close dir"));
-		if ((pCFileStruct->srch_inf.endOfSearch == FALSE) &&
-		   (pCFileStruct->invalidHandle == FALSE)) {
+		if (!(pCFileStruct->srch_inf.endOfSearch) &&
+		    !(pCFileStruct->invalidHandle)) {
 			pCFileStruct->invalidHandle = TRUE;
 			rc = CIFSFindClose(xid, pTcon, pCFileStruct->netfid);
 			cFYI(1, ("Closing uncompleted readdir with rc %d",
diff -Narup a/fs/cifs/readdir.c b/fs/cifs/readdir.c
--- a/fs/cifs/readdir.c	2006-08-31 22:04:44.000000000 +0200
+++ b/fs/cifs/readdir.c	2006-09-01 00:17:31.000000000 +0200
@@ -671,7 +671,7 @@ static int find_cifs_entry(const int xid
 	}
 
 	while((index_to_find >= cifsFile->srch_inf.index_of_last_entry) && 
-	      (rc == 0) && (cifsFile->srch_inf.endOfSearch == FALSE)){
+	      (rc == 0) && !(cifsFile->srch_inf.endOfSearch)){
 	 	cFYI(1,("calling findnext2"));
 		rc = CIFSFindNext(xid,pTcon,cifsFile->netfid, 
 				  &cifsFile->srch_inf);


