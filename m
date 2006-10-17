Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWJQUxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWJQUxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWJQUxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:53:35 -0400
Received: from cap31-3-82-227-199-249.fbx.proxad.net ([82.227.199.249]:43181
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750728AbWJQUxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:53:34 -0400
From: Cedric Le Goater <clg@fr.ibm.com>
Message-Id: <20061017205314.623412000@localhost.localdomain>
References: <20061017203004.555659000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 17 Oct 2006 22:30:07 +0200
To: linux-kernel@vger.kernel.org
Cc: Kirill Korotaev <dev@openvz.org>, Cedric Le Goater <clg@fr.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sukadev Bhattiprolu <sukadev@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch -mm 3/7] add an identifier to nsproxy
Content-Disposition: inline; filename=nsproxy-add-id.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an identifier to nsproxy. The default init_ns_proxy
has identifier 0 and allocated nsproxies are given -1.

This identifier will be used by a new syscall sys_bind_ns.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
---
 include/linux/init_task.h |    1 +
 include/linux/nsproxy.h   |    1 +
 kernel/nsproxy.c          |    1 +
 3 files changed, 3 insertions(+)

Index: 2.6.19-rc2-mm1/include/linux/init_task.h
===================================================================
--- 2.6.19-rc2-mm1.orig/include/linux/init_task.h
+++ 2.6.19-rc2-mm1/include/linux/init_task.h
@@ -72,6 +72,7 @@ extern struct nsproxy init_nsproxy;
 #define INIT_NSPROXY(nsproxy) {						\
 	.count		= ATOMIC_INIT(1),				\
 	.nslock		= SPIN_LOCK_UNLOCKED,				\
+	.id		= 0,						\
 	.uts_ns		= &init_uts_ns,					\
 	.mnt_ns		= NULL,						\
 	INIT_IPC_NS(ipc_ns)						\
Index: 2.6.19-rc2-mm1/include/linux/nsproxy.h
===================================================================
--- 2.6.19-rc2-mm1.orig/include/linux/nsproxy.h
+++ 2.6.19-rc2-mm1/include/linux/nsproxy.h
@@ -23,6 +23,7 @@ struct ipc_namespace;
 struct nsproxy {
 	atomic_t count;
 	spinlock_t nslock;
+	unsigned long id;
 	struct uts_namespace *uts_ns;
 	struct ipc_namespace *ipc_ns;
 	struct mnt_namespace *mnt_ns;
Index: 2.6.19-rc2-mm1/kernel/nsproxy.c
===================================================================
--- 2.6.19-rc2-mm1.orig/kernel/nsproxy.c
+++ 2.6.19-rc2-mm1/kernel/nsproxy.c
@@ -48,6 +48,7 @@ static inline struct nsproxy *clone_name
 	if (ns) {
 		memcpy(ns, orig, sizeof(struct nsproxy));
 		atomic_set(&ns->count, 1);
+		ns->id = -1;
 	}
 	return ns;
 }

--
