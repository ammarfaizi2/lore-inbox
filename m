Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWGKNod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWGKNod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWGKNoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:44:32 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:47152 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750771AbWGKNob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:44:31 -0400
Subject: Re: [PATCH -mm 2/7] add execns syscall to s390
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060711075409.113248000@localhost.localdomain>
References: <20060711075051.382004000@localhost.localdomain>
	 <20060711075409.113248000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 11 Jul 2006 15:44:30 +0200
Message-Id: <1152625470.18034.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 09:50 +0200, Cedric Le Goater wrote: 
> The 32bits syscall is not implemented. 

The attached patch implements compat_do_execns (untested).

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
--

[patch] Add execns compat function.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Andrey Savochkin <saw@sw.ru>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com> 

--

--
 fs/compat.c            |   83 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/compat.h |    2 +
 2 files changed, 85 insertions(+)

diff -urpN linux-2.6/fs/compat.c linux-2.6-execns/fs/compat.c
--- linux-2.6/fs/compat.c	2006-07-11 15:37:46.000000000 +0200
+++ linux-2.6-execns/fs/compat.c	2006-07-11 15:35:59.000000000 +0200
@@ -46,6 +46,8 @@
 #include <linux/rwsem.h>
 #include <linux/acct.h>
 #include <linux/mm.h>
+#include <linux/ipc.h>
+#include <linux/utsname.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
 
@@ -1584,6 +1586,87 @@ out_ret:
 	return retval;
 }
 
+#ifdef CONFIG_UTS_NS
+
+static void flush_all_old_files(struct files_struct * files)
+{
+       /* flush it all even close_on_exec == 0 */
+}
+
+int compat_do_execns(int unshare_flags, char * filename,
+		     compat_uptr_t __user *argv,
+		     compat_uptr_t __user *envp,
+		     struct pt_regs * regs)
+{
+       int err = 0;
+       struct nsproxy *new_nsproxy = NULL, *old_nsproxy = NULL;
+       struct uts_namespace *uts, *new_uts = NULL;
+       struct ipc_namespace *ipc, *new_ipc = NULL;
+
+       err = unshare_utsname(unshare_flags, &new_uts);
+       if (err)
+               goto bad_execns_out;
+       err = unshare_ipcs(unshare_flags, &new_ipc);
+       if (err)
+               goto bad_execns_cleanup_uts;
+
+       if (new_uts || new_ipc) {
+               old_nsproxy = current->nsproxy;
+               new_nsproxy = dup_namespaces(old_nsproxy);
+               if (!new_nsproxy) {
+                       err = -ENOMEM;
+                       goto bad_execns_cleanup_ipc;
+               }
+       }
+
+       err = compat_do_execve(filename, argv, envp, regs);
+       if (err)
+               goto bad_execns_cleanup_ipc;
+
+       /* make sure all files are flushed */
+       flush_all_old_files(current->files);
+
+       if (new_uts || new_ipc) {
+
+               task_lock(current);
+
+               if (new_nsproxy) {
+                       current->nsproxy = new_nsproxy;
+                       new_nsproxy = old_nsproxy;
+               }
+
+               if (new_uts) {
+                       uts = current->nsproxy->uts_ns;
+                       current->nsproxy->uts_ns = new_uts;
+                       new_uts = uts;
+               }
+
+               if (new_ipc) {
+                       ipc = current->nsproxy->ipc_ns;
+                       current->nsproxy->ipc_ns = new_ipc;
+                       new_ipc = ipc;
+               }
+
+               task_unlock(current);
+       }
+
+       if (new_nsproxy)
+               put_nsproxy(new_nsproxy);
+
+bad_execns_cleanup_ipc:
+       if (new_ipc)
+               put_ipc_ns(new_ipc);
+
+bad_execns_cleanup_uts:
+       if (new_uts)
+               put_uts_ns(new_uts);
+
+bad_execns_out:
+       return err;
+}
+
+#endif /* CONFIG_UTS_NS */
+
 #define __COMPAT_NFDBITS       (8 * sizeof(compat_ulong_t))
 
 #define ROUND_UP(x,y) (((x)+(y)-1)/(y))
diff -urpN linux-2.6/include/linux/compat.h linux-2.6-execns/include/linux/compat.h
--- linux-2.6/include/linux/compat.h	2006-07-11 15:37:46.000000000 +0200
+++ linux-2.6-execns/include/linux/compat.h	2006-07-11 14:54:56.000000000 +0200
@@ -185,6 +185,8 @@ asmlinkage ssize_t compat_sys_writev(uns
 
 int compat_do_execve(char * filename, compat_uptr_t __user *argv,
 	        compat_uptr_t __user *envp, struct pt_regs * regs);
+int compat_do_execns(int flags, char * filename, compat_uptr_t __user *argv,
+	        compat_uptr_t __user *envp, struct pt_regs * regs);
 
 asmlinkage long compat_sys_select(int n, compat_ulong_t __user *inp,
 		compat_ulong_t __user *outp, compat_ulong_t __user *exp,


