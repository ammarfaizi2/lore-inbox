Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVAONmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVAONmD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 08:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVAONgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 08:36:21 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:21928 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262280AbVAONaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 08:30:19 -0500
Subject: [PATCH 5/6] cifs: reduce deep nesting
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: sfrench@samba.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1105795751.9555.7.camel@localhost>
References: <1105795546.9555.2.camel@localhost>
	 <1105795614.9555.3.camel@localhost>  <1105795682.9555.5.camel@localhost>
	 <1105795751.9555.7.camel@localhost>
Date: Sat, 15 Jan 2005 15:30:18 +0200
Message-Id: <1105795818.9555.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts deep if statement nesting to use gotos in few places.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 cifsfs.c  |   51 +++++++++++++++++++++++++++++++--------------------
 connect.c |   44 ++++++++++++++++++++------------------------
 2 files changed, 51 insertions(+), 44 deletions(-)

Index: linux/fs/cifs/cifsfs.c
===================================================================
--- linux.orig/fs/cifs/cifsfs.c	2005-01-11 08:04:55.007622032 +0200
+++ linux/fs/cifs/cifsfs.c	2005-01-11 08:04:57.454250088 +0200
@@ -839,26 +839,37 @@
 	}
 
 	rc = cifs_init_inodecache();
-	if (!rc) {
-		rc = cifs_init_mids();
-		if (!rc) {
-			rc = cifs_init_request_bufs();
-			if (!rc) {
-				rc = register_filesystem(&cifs_fs_type);
-				if (!rc) {                
-					rc = (int)kernel_thread(cifs_oplock_thread, NULL, 
-						CLONE_FS | CLONE_FILES | CLONE_VM);
-					if(rc > 0)
-						return 0;
-					else 
-						cERROR(1,("error %d create oplock thread",rc));
-				}
-				cifs_destroy_request_bufs();
-			}
-			cifs_destroy_mids();
-		}
-		cifs_destroy_inodecache();
-	}
+	if (rc)
+		goto failed_init_inodecache;
+
+	rc = cifs_init_mids();
+	if (rc)
+		goto failed_init_mids;
+
+	rc = cifs_init_request_bufs();
+	if (rc)
+		goto failed_init_request_bufs;
+
+	rc = register_filesystem(&cifs_fs_type);
+	if (rc)
+		goto failed_register_filesystem;
+
+	rc = kernel_thread(cifs_oplock_thread, NULL,
+			   CLONE_FS | CLONE_FILES | CLONE_VM);
+	if (rc <= 0)
+		goto failed_kernel_thread;
+
+	return 0;
+
+ failed_kernel_thread:
+	cERROR(1,("error %d create oplock thread",rc));
+ failed_register_filesystem:
+	cifs_destroy_request_bufs();
+ failed_init_request_bufs:
+	cifs_destroy_mids();
+ failed_init_mids:
+	cifs_destroy_inodecache();
+ failed_init_inodecache:
 #ifdef CONFIG_PROC_FS
 	cifs_proc_clean();
 #endif
Index: linux/fs/cifs/connect.c
===================================================================
--- linux.orig/fs/cifs/connect.c	2005-01-11 08:04:50.326333696 +0200
+++ linux/fs/cifs/connect.c	2005-01-11 08:04:57.457249632 +0200
@@ -122,11 +122,9 @@
 	read_lock(&GlobalSMBSeslock);
 	list_for_each(tmp, &GlobalSMBSessionList) {
 		ses = list_entry(tmp, struct cifsSesInfo, cifsSessionList);
-		if (ses->server) {
-			if (ses->server == server) {
-				ses->status = CifsNeedReconnect;
-				ses->ipc_tid = 0;
-			}
+		if (ses->server && ses->server == server) {
+			ses->status = CifsNeedReconnect;
+			ses->ipc_tid = 0;
 		}
 		/* else tcp and smb sessions need reconnection */
 	}
@@ -857,33 +855,31 @@
 		 char *userName, struct TCP_Server_Info **psrvTcp)
 {
 	struct list_head *tmp;
-	struct cifsSesInfo *ses;
+	struct cifsSesInfo *ret = NULL;
 	*psrvTcp = NULL;
 	read_lock(&GlobalSMBSeslock);
 
 	list_for_each(tmp, &GlobalSMBSessionList) {
-		ses = list_entry(tmp, struct cifsSesInfo, cifsSessionList);
-		if (ses->server) {
-			if((target_ip_addr && 
-				(ses->server->addr.sockAddr.sin_addr.s_addr
-				  == target_ip_addr->s_addr)) || (target_ip6_addr
-				&& memcmp(&ses->server->addr.sockAddr6.sin6_addr,
-					target_ip6_addr,sizeof(*target_ip6_addr)))){
-				/* BB lock server and tcp session and increment use count here?? */
-				*psrvTcp = ses->server;	/* found a match on the TCP session */
-				/* BB check if reconnection needed */
-				if (strncmp
-				    (ses->userName, userName,
-				     MAX_USERNAME_SIZE) == 0){
-					read_unlock(&GlobalSMBSeslock);
-					return ses;	/* found exact match on both tcp and SMB sessions */
-				}
+		struct cifsSesInfo * ses = list_entry(tmp, struct cifsSesInfo, cifsSessionList);
+		if (!ses->server)
+			continue;
+		if((target_ip_addr && 
+			(ses->server->addr.sockAddr.sin_addr.s_addr
+			  == target_ip_addr->s_addr)) || (target_ip6_addr
+			&& memcmp(&ses->server->addr.sockAddr6.sin6_addr,
+				target_ip6_addr,sizeof(*target_ip6_addr)))){
+			/* BB lock server and tcp session and increment use count here?? */
+			*psrvTcp = ses->server;	/* found a match on the TCP session */
+			/* BB check if reconnection needed */
+			if (strncmp(ses->userName, userName, MAX_USERNAME_SIZE) == 0) {
+				ret = ses;
+				goto out;
 			}
 		}
-		/* else tcp and smb sessions need reconnection */
 	}
+ out:
 	read_unlock(&GlobalSMBSeslock);
-	return NULL;
+	return ret;
 }
 
 static struct cifsTconInfo *


