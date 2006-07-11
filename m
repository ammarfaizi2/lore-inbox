Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWGKPnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWGKPnp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWGKPnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:43:45 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:42625 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751295AbWGKPno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:43:44 -0400
Message-ID: <44B3C728.2000008@fr.ibm.com>
Date: Tue, 11 Jul 2006 17:43:36 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: schwidefsky@de.ibm.com
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 2/7] add execns syscall to s390
References: <20060711075051.382004000@localhost.localdomain>	 <20060711075409.113248000@localhost.localdomain>	 <1152625488.18034.13.camel@localhost>  <44B3B95E.6020206@fr.ibm.com> <1152629675.18034.23.camel@localhost>
In-Reply-To: <1152629675.18034.23.camel@localhost>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> On Tue, 2006-07-11 at 16:44 +0200, Cedric Le Goater wrote:
>> Thanks !
>>
>> Both patches are in my patchset now which compiles and boots fine on s390x.
>> I'll build 32 bits binaries to try them.
>>
>> Why did you protect sys32_execns, sys_execns and compat_do_execns () with
>> #ifdef CONFIG_UTS_NS ? Did you need to ?
> 
> Yes, without the #ifdefs I get compile time warnings.


fs/exec.c: In function `do_execns':
fs/exec.c:1262: warning: implicit declaration of function `unshare_ipcs'
fs/compat.c: In function `compat_do_execns':
fs/compat.c:1608: warning: implicit declaration of function `unshare_ipcs'

I think the issue comes from unshare_ipcs which needs a dummy version when
the namespace config options are not set. Here's a fix.

thanks,

C.

From: Cedric Le Goater <clg@fr.ibm.com>
Subject: export dummy unshare_ipcs when CONFIG_IPC_NS is not set

This patch exports a dummy unshare_ipcs when CONFIG_IPC_NS is not set.

This is needed by do_execns in fs/exec.c which also uses this
routine.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Pavel Emelianov <xemul@openvz.org>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Andrey Savochkin <saw@sw.ru>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>

---
 include/linux/ipc.h |    3 ++-
 ipc/util.c          |    9 ++++++++-
 kernel/fork.c       |   10 ----------
 3 files changed, 10 insertions(+), 12 deletions(-)

Index: 2.6.18-rc1-mm1/include/linux/ipc.h
===================================================================
--- 2.6.18-rc1-mm1.orig/include/linux/ipc.h
+++ 2.6.18-rc1-mm1/include/linux/ipc.h
@@ -95,10 +95,11 @@ extern struct ipc_namespace init_ipc_ns;
 #define INIT_IPC_NS(ns)
 #endif

+extern int unshare_ipcs(unsigned long flags, struct ipc_namespace **ns);
+
 #ifdef CONFIG_IPC_NS
 extern void free_ipc_ns(struct kref *kref);
 extern int copy_ipcs(unsigned long flags, struct task_struct *tsk);
-extern int unshare_ipcs(unsigned long flags, struct ipc_namespace **ns);
 #else
 static inline int copy_ipcs(unsigned long flags, struct task_struct *tsk)
 {
Index: 2.6.18-rc1-mm1/kernel/fork.c
===================================================================
--- 2.6.18-rc1-mm1.orig/kernel/fork.c
+++ 2.6.18-rc1-mm1/kernel/fork.c
@@ -1575,16 +1575,6 @@ static int unshare_semundo(unsigned long
 	return 0;
 }

-#ifndef CONFIG_IPC_NS
-static inline int unshare_ipcs(unsigned long flags, struct ipc_namespace **ns)
-{
-	if (flags & CLONE_NEWIPC)
-		return -EINVAL;
-
-	return 0;
-}
-#endif
-
 /*
  * unshare allows a process to 'unshare' part of the process
  * context which was originally shared using clone.  copy_*
Index: 2.6.18-rc1-mm1/ipc/util.c
===================================================================
--- 2.6.18-rc1-mm1.orig/ipc/util.c
+++ 2.6.18-rc1-mm1/ipc/util.c
@@ -144,7 +144,14 @@ void free_ipc_ns(struct kref *kref)
 	shm_exit_ns(ns);
 	kfree(ns);
 }
-#endif
+#else
+int unshare_ipcs(unsigned long unshare_flags, struct ipc_namespace **new_ipc)
+{
+	if (unshare_flags & CLONE_NEWIPC)
+		return -EINVAL;
+	return 0;
+}
+#endif /* CONFIG_IPC_NS */

 /**
  *	ipc_init	-	initialise IPC subsystem


