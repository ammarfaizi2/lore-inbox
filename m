Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWDXUZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWDXUZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWDXUZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:25:38 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:48391 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751238AbWDXUZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:25:37 -0400
Date: Mon, 24 Apr 2006 22:25:39 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Steve French <sfrench@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix cifs breakage when CONFIG_CIFS_EXPERIMENTAL=n
Message-Id: <20060424222539.1d3c96fd.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Cifs is currently broken when CONFIG_CIFS_EXPERIMENTAL=n:

fs/cifs/connect.c: In function `cifs_setup_session':
fs/cifs/connect.c:3451: warning: implicit declaration of function `CIFS_SessSetup'
(...)
WARNING: "CIFS_SessSetup" [fs/cifs/cifs.ko] undefined!

The following patch attempts to fix that. Untested beyond compilation.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 fs/cifs/cifsproto.h |    2 --
 fs/cifs/cifssmb.c   |    2 --
 fs/cifs/ntlmssp.c   |    2 --
 3 files changed, 6 deletions(-)

--- linux-2.6.17-rc2.orig/fs/cifs/cifsproto.h	2006-04-24 21:56:45.000000000 +0200
+++ linux-2.6.17-rc2/fs/cifs/cifsproto.h	2006-04-24 22:05:43.000000000 +0200
@@ -64,14 +64,12 @@
 extern void header_assemble(struct smb_hdr *, char /* command */ ,
 			    const struct cifsTconInfo *, int /* length of
 			    fixed section (word count) in two byte units */);
-#ifdef CONFIG_CIFS_EXPERIMENTAL
 extern int small_smb_init_no_tc(const int smb_cmd, const int wct,
 				struct cifsSesInfo *ses,
 				void ** request_buf);
 extern int CIFS_SessSetup(unsigned int xid, struct cifsSesInfo *ses,
 			     const int stage, int * pNTLMv2_flg,
 			     const struct nls_table *nls_cp);
-#endif
 extern __u16 GetNextMid(struct TCP_Server_Info *server);
 extern struct oplock_q_entry * AllocOplockQEntry(struct inode *, u16, 
 						 struct cifsTconInfo *);
--- linux-2.6.17-rc2.orig/fs/cifs/ntlmssp.c	2006-04-24 21:56:45.000000000 +0200
+++ linux-2.6.17-rc2/fs/cifs/ntlmssp.c	2006-04-24 22:09:34.000000000 +0200
@@ -27,7 +27,6 @@
 #include "ntlmssp.h"
 #include "nterr.h"
 
-#ifdef CONFIG_CIFS_EXPERIMENTAL
 static __u32 cifs_ssetup_hdr(struct cifsSesInfo *ses, SESSION_SETUP_ANDX *pSMB)
 {
 	__u32 capabilities = 0;
@@ -140,4 +139,3 @@
 
 	return rc;
 }
-#endif /* CONFIG_CIFS_EXPERIMENTAL */
--- linux-2.6.17-rc2.orig/fs/cifs/cifssmb.c	2006-04-24 10:47:55.000000000 +0200
+++ linux-2.6.17-rc2/fs/cifs/cifssmb.c	2006-04-24 22:08:19.000000000 +0200
@@ -188,7 +188,6 @@
 	return rc;
 }
 
-#ifdef CONFIG_CIFS_EXPERIMENTAL  
 int
 small_smb_init_no_tc(const int smb_command, const int wct, 
 		     struct cifsSesInfo *ses, void **request_buf)
@@ -214,7 +213,6 @@
 
 	return rc;
 }
-#endif  /* CONFIG_CIFS_EXPERIMENTAL */
 
 /* If the return code is zero, this function must fill in request_buf pointer */
 static int



-- 
Jean Delvare
