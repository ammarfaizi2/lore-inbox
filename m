Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933420AbWKWJYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933420AbWKWJYN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933416AbWKWJYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:24:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:47067 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S933400AbWKWJYJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:24:09 -0500
Message-ID: <456568B3.7000303@fr.ibm.com>
Date: Thu, 23 Nov 2006 10:24:03 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Dmitry Mishin <dim@openvz.org>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, Daniel Lezcano <dlezcano@fr.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W. Biederman" <ebiederm@xmission.com>, netdev@vger.kernel.org
Subject: Re: [patch -mm] net namespace: empty framework
References: <4563007B.9010202@fr.ibm.com> <200611221955.56942.dim@openvz.org>	<20061123023943.GA22931@sergelap.austin.ibm.com> <200611231207.40634.dim@openvz.org>
In-Reply-To: <200611231207.40634.dim@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Mishin wrote:
> On Thursday 23 November 2006 05:39, Serge E. Hallyn wrote:
>> Quoting Dmitry Mishin (dim@openvz.org):
>>> On Wednesday 22 November 2006 19:41, Serge E. Hallyn wrote:
>>>> Quoting Cedric Le Goater (clg@fr.ibm.com):
>>>>> Hello,
>>>>>
>>>>> Dmitry Mishin wrote:
>>>>>> This patch looks acceptable for us.
>>>>> good. shall we merge it then ? see comment below.
>>>>>
>>>>>> BTW, Daniel, we agreed to be based on the Andrey's patchset. I do
>>>>>> not see a reason, why Cedric force us to make some unnecessary work
>>>>>> and move existent patchset over his interface.
>>>>> yeah it's a bit different from andrey's but not that much and it's
>>>>> more in
>>>> Where is Andrey's patch?
>>> This thread - http://thread.gmane.org/gmane.linux.network/42666
>> Thanks, Dmitry.  Now I do recall seeing that before.
>>
>> That patchset appears to go part, but not all the way to fitting in with
>> the existing namespaces.  For instance, you use exit_task_namespaces() for
>> refcounting, but don't put the net_namespace in the nsproxy and use your
>> own mechanism for unsharing.
>>
>> It really seems useful to have all the namespaces be consistent whenever
>> practical, and I don't think your patchset would need much tweaking to
>> fit onto Cedric's patch.  Am I missing a complicating factor?
> No. I've already said, Cedric's patch is acceptable for us.

Cool, so it should reduce the patchsets of everyone working on layer 3, layer 2, 
etc.

Here's a refreshed version for 2.6.19-rc5-mm2. the previous was a bit fuzzy.

thanks,

C.

From: Cedric Le Goater <cedric@legoater.org>

This patch adds an empty net namespace framework

Signed-off-by: Cedric Le Goater <cedric@legoater.org>
---
 include/linux/init_task.h     |    2 +
 include/linux/net_namespace.h |   49 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/nsproxy.h       |    2 +
 kernel/nsproxy.c              |   12 ++++++++++
 net/Kconfig                   |    8 ++++++
 net/core/Makefile             |    2 -
 net/core/net_namespace.c      |   41 +++++++++++++++++++++++++++++++++++
 7 files changed, 115 insertions(+), 1 deletion(-)

Index: 2.6.19-rc5-mm2/include/linux/init_task.h
===================================================================
--- 2.6.19-rc5-mm2.orig/include/linux/init_task.h
+++ 2.6.19-rc5-mm2/include/linux/init_task.h
@@ -8,6 +8,7 @@
 #include <linux/lockdep.h>
 #include <linux/ipc.h>
 #include <linux/pid_namespace.h>
+#include <linux/net_namespace.h>
 
 #define INIT_FDTABLE \
 {							\
@@ -78,6 +79,7 @@ extern struct nsproxy init_nsproxy;
 	.id		= 0,						\
 	.uts_ns		= &init_uts_ns,					\
 	.mnt_ns		= NULL,						\
+	INIT_NET_NS(net_ns)						\
 	INIT_IPC_NS(ipc_ns)						\
 }
 
Index: 2.6.19-rc5-mm2/include/linux/net_namespace.h
===================================================================
--- /dev/null
+++ 2.6.19-rc5-mm2/include/linux/net_namespace.h
@@ -0,0 +1,49 @@
+#ifndef _LINUX_NET_NAMESPACE_H
+#define _LINUX_NET_NAMESPACE_H
+
+#include <linux/kref.h>
+#include <linux/nsproxy.h>
+
+struct net_namespace {
+	struct kref	kref;
+};
+
+extern struct net_namespace init_net_ns;
+
+#ifdef CONFIG_NET_NS
+
+#define INIT_NET_NS(net_ns) .net_ns = &init_net_ns,
+
+static inline void get_net_ns(struct net_namespace *ns)
+{
+	kref_get(&ns->kref);
+}
+
+extern int copy_net_ns(int flags, struct task_struct *tsk);
+
+extern void free_net_ns(struct kref *kref);
+
+static inline void put_net_ns(struct net_namespace *ns)
+{
+	kref_put(&ns->kref, free_net_ns);
+}
+
+#else
+
+#define INIT_NET_NS(net_ns)
+
+static inline void get_net_ns(struct net_namespace *ns)
+{
+}
+
+static inline int copy_net_ns(int flags, struct task_struct *tsk)
+{
+	return 0;
+}
+
+static inline void put_net_ns(struct net_namespace *ns)
+{
+}
+#endif
+
+#endif /* _LINUX_NET_NAMESPACE_H */
Index: 2.6.19-rc5-mm2/include/linux/nsproxy.h
===================================================================
--- 2.6.19-rc5-mm2.orig/include/linux/nsproxy.h
+++ 2.6.19-rc5-mm2/include/linux/nsproxy.h
@@ -8,6 +8,7 @@ struct mnt_namespace;
 struct uts_namespace;
 struct ipc_namespace;
 struct pid_namespace;
+struct net_namespace;
 
 /*
  * A structure to contain pointers to all per-process
@@ -29,6 +30,7 @@ struct nsproxy {
 	struct ipc_namespace *ipc_ns;
 	struct mnt_namespace *mnt_ns;
 	struct pid_namespace *pid_ns;
+	struct net_namespace *net_ns;
 };
 extern struct nsproxy init_nsproxy;
 
Index: 2.6.19-rc5-mm2/kernel/nsproxy.c
===================================================================
--- 2.6.19-rc5-mm2.orig/kernel/nsproxy.c
+++ 2.6.19-rc5-mm2/kernel/nsproxy.c
@@ -20,6 +20,7 @@
 #include <linux/mnt_namespace.h>
 #include <linux/utsname.h>
 #include <linux/pid_namespace.h>
+#include <linux/net_namespace.h>
 
 struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
@@ -71,6 +72,8 @@ struct nsproxy *dup_namespaces(struct ns
 			get_ipc_ns(ns->ipc_ns);
 		if (ns->pid_ns)
 			get_pid_ns(ns->pid_ns);
+		if (ns->net_ns)
+			get_net_ns(ns->net_ns);
 	}
 
 	return ns;
@@ -118,10 +121,17 @@ int copy_namespaces(int flags, struct ta
 	if (err)
 		goto out_pid;
 
+	err = copy_net_ns(flags, tsk);
+	if (err)
+		goto out_net;
+
 out:
 	put_nsproxy(old_ns);
 	return err;
 
+out_net:
+	if (new_ns->pid_ns)
+		put_pid_ns(new_ns->pid_ns);
 out_pid:
 	if (new_ns->ipc_ns)
 		put_ipc_ns(new_ns->ipc_ns);
@@ -147,5 +157,7 @@ void free_nsproxy(struct nsproxy *ns)
 		put_ipc_ns(ns->ipc_ns);
 	if (ns->pid_ns)
 		put_pid_ns(ns->pid_ns);
+	if (ns->net_ns)
+		put_net_ns(ns->net_ns);
 	kfree(ns);
 }
Index: 2.6.19-rc5-mm2/net/core/Makefile
===================================================================
--- 2.6.19-rc5-mm2.orig/net/core/Makefile
+++ 2.6.19-rc5-mm2/net/core/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y := sock.o request_sock.o skbuff.o iovec.o datagram.o stream.o scm.o \
-	 gen_stats.o gen_estimator.o
+	 gen_stats.o gen_estimator.o net_namespace.o
 
 obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 
Index: 2.6.19-rc5-mm2/net/core/net_namespace.c
===================================================================
--- /dev/null
+++ 2.6.19-rc5-mm2/net/core/net_namespace.c
@@ -0,0 +1,41 @@
+/*
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License as
+ *  published by the Free Software Foundation, version 2 of the
+ *  License.
+ */
+
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/nsproxy.h>
+#include <linux/net_namespace.h>
+
+struct net_namespace init_net_ns = {
+	.kref = {
+		.refcount	= ATOMIC_INIT(2),
+	},
+};
+
+#ifdef CONFIG_NET_NS
+
+int copy_net_ns(int flags, struct task_struct *tsk)
+{
+	struct net_namespace *old_ns = tsk->nsproxy->net_ns;
+	int err = 0;
+
+	if (!old_ns)
+		return 0;
+
+	get_net_ns(old_ns);
+	return err;
+}
+
+void free_net_ns(struct kref *kref)
+{
+	struct net_namespace *ns;
+
+	ns = container_of(kref, struct net_namespace, kref);
+	kfree(ns);
+}
+
+#endif /* CONFIG_NET_NS */
Index: 2.6.19-rc5-mm2/net/Kconfig
===================================================================
--- 2.6.19-rc5-mm2.orig/net/Kconfig
+++ 2.6.19-rc5-mm2/net/Kconfig
@@ -67,6 +67,14 @@ source "net/netlabel/Kconfig"
 
 endif # if INET
 
+config NET_NS
+	bool "Network Namespaces"
+	help
+	  This option enables multiple independent network namespaces,
+	  each having own network devices, IP addresses, routes, and so on.
+	  If unsure, answer N.
+
+
 config NETWORK_SECMARK
 	bool "Security Marking"
 	help
