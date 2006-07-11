Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWGKRit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWGKRit (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWGKRis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:38:48 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45232 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751145AbWGKRir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:38:47 -0400
Message-ID: <44B3E21E.7090205@fr.ibm.com>
Date: Tue, 11 Jul 2006 19:38:38 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain> <20060711075420.937831000@localhost.localdomain> <44B3D435.8090706@sw.ru>
In-Reply-To: <44B3D435.8090706@sw.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> I wonder about another namespace coupling I found thinking
> about your patches.
> 
> Lets take a look at sys_setpriority() or any other function calling
> find_user():
> it can change the priority for all user or group processes like:
> 
> do_each_thread_ve(g, p) {
>    if (p->uid == who)
>        error = set_one_prio(p, niceval, error);
> } while_each_thread_ve(g, p);

eh. this is openvz code ! thanks :)

> which essentially means that user-namespace becomes coupled with
> process-namespace. Sure, we can check in every such place for
>  p->nsproxy->user_ns == current->nsproxy->user_ns
> condition. But this a way IMHO leading to kernel full of security
> crap which is hardly maintainable.

only 4 syscalls use find_user() : sys_setpriority, sys_getpriority,
sys_ioprio_set, sys_ioprio_get and they use it very simply to check if a
user_struct exists for a given uid. So, it should be OK. But please see the
attached patch.

> Another example of not so evident coupling here:
> user structure maintains number of processes/opened
> files/sigpending/locked_shm etc.
> if a single user can belong to different proccess/ipc/... namespaces
> all these becomes unusable.

this is the purpose of execns.

user namespace can't be unshared through the unshare syscall(). they can
only be unshared through execns() which flushes the previous image of the
process. However, the execns patch still needs to close files without the
close-on-exec flag. I didn't do it yet. lazy me :)

> Small patch comment:
> - what is the reason in adding 2nd arg to find_user()?

The main reason is alloc_uid() in clone_user_ns() and find_user() inherited
the same prototype maybe abusively. Here's a patch.

thanks,

C.

From: Cedric Le Goater <clg@fr.ibm.com>
Subject: remove user namespace arg from find_user

This patch removes the user namespace argument from find_user().

find_user() is always called from the current context, hence the user
namespace can be determined with current->nsproxy->user_ns in
find_user().

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Andrey Savochkin <saw@sw.ru>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>

---
 fs/ioprio.c           |    4 ++--
 include/linux/sched.h |    2 +-
 kernel/sys.c          |    4 ++--
 kernel/user.c         |    3 ++-
 4 files changed, 7 insertions(+), 6 deletions(-)

Index: 2.6.18-rc1-mm1/fs/ioprio.c
===================================================================
--- 2.6.18-rc1-mm1.orig/fs/ioprio.c
+++ 2.6.18-rc1-mm1/fs/ioprio.c
@@ -102,7 +102,7 @@ asmlinkage long sys_ioprio_set(int which
 			if (!who)
 				user = current->user;
 			else
-				user = find_user(current->nsproxy->user_ns, who);
+				user = find_user(who);

 			if (!user)
 				break;
@@ -172,7 +172,7 @@ asmlinkage long sys_ioprio_get(int which
 			if (!who)
 				user = current->user;
 			else
-				user = find_user(current->nsproxy->user_ns, who);
+				user = find_user(who);

 			if (!user)
 				break;
Index: 2.6.18-rc1-mm1/include/linux/sched.h
===================================================================
--- 2.6.18-rc1-mm1.orig/include/linux/sched.h
+++ 2.6.18-rc1-mm1/include/linux/sched.h
@@ -539,7 +539,7 @@ struct user_struct {
 	uid_t uid;
 };

-extern struct user_struct *find_user(struct user_namespace *, uid_t);
+extern struct user_struct *find_user(uid_t);

 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
Index: 2.6.18-rc1-mm1/kernel/sys.c
===================================================================
--- 2.6.18-rc1-mm1.orig/kernel/sys.c
+++ 2.6.18-rc1-mm1/kernel/sys.c
@@ -545,7 +545,7 @@ asmlinkage long sys_setpriority(int whic
 				who = current->uid;
 			else
 				if ((who != current->uid) &&
-					!(user = find_user(current->nsproxy->user_ns, who)))
+					!(user = find_user(who)))
 					goto out_unlock;	/* No processes for this user */

 			do_each_thread(g, p)
@@ -604,7 +604,7 @@ asmlinkage long sys_getpriority(int whic
 				who = current->uid;
 			else
 				if ((who != current->uid) &&
-					!(user = find_user(current->nsproxy->user_ns, who)))
+					!(user = find_user(who)))
 					goto out_unlock;	/* No processes for this user */

 			do_each_thread(g, p)
Index: 2.6.18-rc1-mm1/kernel/user.c
===================================================================
--- 2.6.18-rc1-mm1.orig/kernel/user.c
+++ 2.6.18-rc1-mm1/kernel/user.c
@@ -205,10 +205,11 @@ void free_user_ns(struct kref *kref)
  *
  * If the user_struct could not be found, return NULL.
  */
-struct user_struct *find_user(struct user_namespace *ns, uid_t uid)
+struct user_struct *find_user(uid_t uid)
 {
 	struct user_struct *ret;
 	unsigned long flags;
+	struct user_namespace *ns = current->nsproxy->user_ns;

 	spin_lock_irqsave(&uidhash_lock, flags);
 	ret = uid_hash_find(uid, uidhashentry(ns, uid));

