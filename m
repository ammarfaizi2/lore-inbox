Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWG0Uw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWG0Uw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWG0Uw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:52:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39127 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750800AbWG0Uw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:52:57 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 04/30] NFS: Fix NFS4 callback up/down prototypes [try #11]
Date: Thu, 27 Jul 2006 21:52:34 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205234.8443.96362.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the nfs_callback_up()/down() prototypes just do nothing if NFS4 is not
enabled.  Also make the down function void type since we can't really do
anything if it fails.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/callback.c |    5 +----
 fs/nfs/callback.h |    7 ++++++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index d6c4bae..b1f7dc4 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -149,10 +149,8 @@ out_err:
 /*
  * Kill the server process if it is not already up.
  */
-int nfs_callback_down(void)
+void nfs_callback_down(void)
 {
-	int ret = 0;
-
 	lock_kernel();
 	mutex_lock(&nfs_callback_mutex);
 	nfs_callback_info.users--;
@@ -164,7 +162,6 @@ int nfs_callback_down(void)
 	} while (wait_for_completion_timeout(&nfs_callback_info.stopped, 5*HZ) == 0);
 	mutex_unlock(&nfs_callback_mutex);
 	unlock_kernel();
-	return ret;
 }
 
 static int nfs_callback_authenticate(struct svc_rqst *rqstp)
diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index b252e7f..5676163 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -62,8 +62,13 @@ struct cb_recallargs {
 extern unsigned nfs4_callback_getattr(struct cb_getattrargs *args, struct cb_getattrres *res);
 extern unsigned nfs4_callback_recall(struct cb_recallargs *args, void *dummy);
 
+#ifdef CONFIG_NFS_V4
 extern int nfs_callback_up(void);
-extern int nfs_callback_down(void);
+extern void nfs_callback_down(void);
+#else
+#define nfs_callback_up()	(0)
+#define nfs_callback_down()	do {} while(0)
+#endif
 
 extern unsigned int nfs_callback_set_tcpport;
 extern unsigned short nfs_callback_tcpport;
