Return-Path: <linux-kernel-owner+w=401wt.eu-S933052AbWLSW75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933052AbWLSW75 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933054AbWLSW74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:59:56 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:54148 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933052AbWLSW7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:59:52 -0500
Date: Tue, 19 Dec 2006 16:59:49 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, containers@lists.osdl.org
Subject: [PATCH 1/8] nsproxy: externalizes exit_task_namespaces
Message-ID: <20061219225949.GB25904@sergelap.austin.ibm.com>
References: <20061219225902.GA25904@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219225902.GA25904@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cedric Le Goater <clg@fr.ibm.com>
Subject: [PATCH 1/8] nsproxy: externalizes exit_task_namespaces

this is required to remove a header dependency in sched.h which breaks
next patches.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 include/linux/nsproxy.h |   15 ++++-----------
 kernel/nsproxy.c        |   11 +++++++++++
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 0b9f0dc..602f3d2 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -2,7 +2,8 @@ #ifndef _LINUX_NSPROXY_H
 #define _LINUX_NSPROXY_H
 
 #include <linux/spinlock.h>
-#include <linux/sched.h>
+
+struct task_struct;
 
 struct mnt_namespace;
 struct uts_namespace;
@@ -43,14 +44,6 @@ static inline void put_nsproxy(struct ns
 	}
 }
 
-static inline void exit_task_namespaces(struct task_struct *p)
-{
-	struct nsproxy *ns = p->nsproxy;
-	if (ns) {
-		task_lock(p);
-		p->nsproxy = NULL;
-		task_unlock(p);
-		put_nsproxy(ns);
-	}
-}
+extern void exit_task_namespaces(struct task_struct *p);
+
 #endif
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index f5b9ee6..f11bbbf 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -36,6 +36,17 @@ void get_task_namespaces(struct task_str
 	}
 }
 
+void exit_task_namespaces(struct task_struct *p)
+{
+	struct nsproxy *ns = p->nsproxy;
+	if (ns) {
+		task_lock(p);
+		p->nsproxy = NULL;
+		task_unlock(p);
+		put_nsproxy(ns);
+	}
+}
+
 /*
  * creates a copy of "orig" with refcount 1.
  * This does not grab references to the contained namespaces,
-- 
1.4.1

