Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbTISSTC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 14:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTISSTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 14:19:02 -0400
Received: from zok.SGI.COM ([204.94.215.101]:18368 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261662AbTISSSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 14:18:53 -0400
Date: Fri, 19 Sep 2003 11:18:22 -0700
To: "Villacis, Juan" <juan.villacis@intel.com>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.x] additional kernel event notifications
Message-ID: <20030919181822.GA4335@sgi.com>
Mail-Followup-To: "Villacis, Juan" <juan.villacis@intel.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <7F740D512C7C1046AB53446D372001732DEC51@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D372001732DEC51@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 11:20:12PM -0700, Villacis, Juan wrote:
> ...
> 
> We believe that profiling tools such as Oprofile, Perfmon, and VTune
> would benefit from the additional hooks by improving the accuracy and
> completeness of the performance data, especially when working in
> environments that can dynamically create and destroy executable code
> (such as Java). Furthermore, these hooks could be used to measure
> different types of performance data (e.g., "forks per second") which are
> currently not available any other way.
> 
> ...

Any chance of this getting into 2.6?  I for one would like to see it so
that the performance monitoring tools can work properly without having
to resort to syscall table patching.  I've inlined the diffstat and
patch for easy reading.

Thanks,
Jesse

 MAINTAINERS                |    7 +++++
 Makefile                   |    2 -
 arch/i386/oprofile/Kconfig |    8 +++---
 fs/exec.c                  |    3 ++
 include/linux/profile.h    |   25 ++++++++++++++++++-
 kernel/fork.c              |    3 ++
 kernel/module.c            |   16 ++++++++++++
 kernel/profile.c           |   59 +++++++++++++++++++++++++++++++++++++++++++++
 mm/mmap.c                  |    5 +++
 9 files changed, 122 insertions(+), 6 deletions(-)

diff -urN linux-2.6.0-test5/arch/i386/oprofile/Kconfig linux-2.6.0-test5-intel-vtune/arch/i386/oprofile/Kconfig
--- linux-2.6.0-test5/arch/i386/oprofile/Kconfig	Mon Sep  8 12:50:06 2003
+++ linux-2.6.0-test5-intel-vtune/arch/i386/oprofile/Kconfig	Wed Sep 17 21:36:18 2003
@@ -1,16 +1,16 @@
 
 menu "Profiling support"
-	depends on EXPERIMENTAL
 
 config PROFILING
-	bool "Profiling support (EXPERIMENTAL)"
+	bool "Profiling support"
+	default y
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
-	  by profilers such as OProfile.
+	  by profilers such as OProfile and VTune.
 	  
 
 config OPROFILE
-	tristate "OProfile system profiling (EXPERIMENTAL)"
+	tristate "OProfile system profiling"
 	depends on PROFILING
 	help
 	  OProfile is a profiling system capable of profiling the
diff -urN linux-2.6.0-test5/Makefile linux-2.6.0-test5-intel-vtune/Makefile
--- linux-2.6.0-test5/Makefile	Mon Sep  8 12:50:12 2003
+++ linux-2.6.0-test5-intel-vtune/Makefile	Wed Sep 17 21:32:58 2003
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 0
-EXTRAVERSION = -test5
+EXTRAVERSION = -test5-intel-vtune
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
diff -urN linux-2.6.0-test5/MAINTAINERS linux-2.6.0-test5-intel-vtune/MAINTAINERS
--- linux-2.6.0-test5/MAINTAINERS	Mon Sep  8 12:50:07 2003
+++ linux-2.6.0-test5-intel-vtune/MAINTAINERS	Wed Sep 17 21:31:55 2003
@@ -2193,6 +2193,13 @@
 M:	kraxel@bytesex.org
 S:	Maintained
 
+VTUNE
+P:	Juan Villacis
+M:	juan.villacis@intel.com
+W:	http://www.intel.com/software/products/opensource/vdk/
+W:	http://www.intel.com/software/products/vtune/
+S:	Maintained
+
 WAN ROUTER & SANGOMA WANPIPE DRIVERS & API (X.25, FRAME RELAY, PPP, CISCO HDLC)
 P:	Nenad Corbic
 M:	ncorbic@sangoma.com
diff -urN linux-2.6.0-test5/include/linux/profile.h linux-2.6.0-test5-intel-vtune/include/linux/profile.h
--- linux-2.6.0-test5/include/linux/profile.h	Mon Sep  8 12:50:03 2003
+++ linux-2.6.0-test5-intel-vtune/include/linux/profile.h	Wed Sep 17 21:31:03 2003
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <asm/errno.h>
 
 /* parse command line */
@@ -23,7 +24,11 @@
 enum profile_type {
 	EXIT_TASK,
 	EXIT_MMAP,
-	EXEC_UNMAP
+	EXEC_UNMAP,
+        DO_FORK,
+        DO_EXECVE,
+        LOAD_KERNEL_IMAGE,
+        LOAD_USER_IMAGE
 };
 
 #ifdef CONFIG_PROFILING
@@ -41,6 +46,20 @@
 /* exit of all vmas for a task */
 void profile_exit_mmap(struct mm_struct * mm);
 
+/* handler for DO_FORK event */
+void profile_do_fork(struct task_struct * task);
+
+/* handler for DO_EXECVE event */
+void profile_do_execve(struct task_struct * task);
+
+/* handler for LOAD_KERNEL_IMAGE event */
+void profile_load_kernel_image(struct module * mod, unsigned int sechdr_index,
+        unsigned long addr, unsigned long size);
+
+/* handler for LOAD_USER_IMAGE */
+void profile_load_user_image(struct task_struct * task,
+        struct vm_area_struct * vma);
+
 int profile_event_register(enum profile_type, struct notifier_block * n);
 
 int profile_event_unregister(enum profile_type, struct notifier_block * n);
@@ -66,6 +85,10 @@
 #define profile_exit_task(a) do { } while (0)
 #define profile_exec_unmap(a) do { } while (0)
 #define profile_exit_mmap(a) do { } while (0)
+#define profile_do_fork(a) do { } while (0)
+#define profile_do_execve(a) do { } while (0)
+#define profile_load_kernel_image(a) do { } while (0)
+#define profile_load_user_image(a) do { } while (0)
 
 static inline int register_profile_notifier(struct notifier_block * nb)
 {
diff -urN linux-2.6.0-test5/kernel/profile.c linux-2.6.0-test5-intel-vtune/kernel/profile.c
--- linux-2.6.0-test5/kernel/profile.c	Mon Sep  8 12:50:31 2003
+++ linux-2.6.0-test5-intel-vtune/kernel/profile.c	Tue Sep 16 22:32:33 2003
@@ -50,6 +50,10 @@
 static struct notifier_block * exit_task_notifier;
 static struct notifier_block * exit_mmap_notifier;
 static struct notifier_block * exec_unmap_notifier;
+static struct notifier_block * do_fork_notifier;
+static struct notifier_block * do_execve_notifier;
+static struct notifier_block * load_kernel_image_notifier;
+static struct notifier_block * load_user_image_notifier;
  
 void profile_exit_task(struct task_struct * task)
 {
@@ -72,6 +76,37 @@
 	up_read(&profile_rwsem);
 }
 
+void profile_do_fork(struct task_struct * task)
+{
+        down_read(&profile_rwsem);
+        notifier_call_chain(&do_fork_notifier, 0, task);
+        up_read(&profile_rwsem);
+}
+
+void profile_do_execve(struct task_struct * task)
+{
+        down_read(&profile_rwsem);
+        notifier_call_chain(&do_execve_notifier, 0, task);
+        up_read(&profile_rwsem);
+}
+
+void profile_load_kernel_image(struct module * mod, unsigned int sechdr_index,
+        unsigned long addr, unsigned long size)
+{
+        down_read(&profile_rwsem);
+        notifier_call_chain(&load_kernel_image_notifier, sechdr_index, mod);
+        up_read(&profile_rwsem);
+}
+
+void profile_load_user_image(struct task_struct * task,
+        struct vm_area_struct * vma)
+{
+        down_read(&profile_rwsem);
+        notifier_call_chain(&load_user_image_notifier,(unsigned long) task,
+                vma);
+        up_read(&profile_rwsem);
+}
+
 int profile_event_register(enum profile_type type, struct notifier_block * n)
 {
 	int err = -EINVAL;
@@ -88,6 +123,18 @@
 		case EXEC_UNMAP:
 			err = notifier_chain_register(&exec_unmap_notifier, n);
 			break;
+		case DO_FORK:
+			err = notifier_chain_register(&do_fork_notifier, n);
+			break;
+		case DO_EXECVE:
+			err = notifier_chain_register(&do_execve_notifier, n);
+			break;
+		case LOAD_KERNEL_IMAGE:
+			err = notifier_chain_register(&load_kernel_image_notifier, n);
+			break;
+		case LOAD_USER_IMAGE:
+			err = notifier_chain_register(&load_user_image_notifier, n);
+			break;
 	}
  
 	up_write(&profile_rwsem);
@@ -112,6 +159,18 @@
 		case EXEC_UNMAP:
 			err = notifier_chain_unregister(&exec_unmap_notifier, n);
 			break;
+		case DO_FORK:
+			err = notifier_chain_unregister(&do_fork_notifier, n);
+			break;
+		case DO_EXECVE:
+			err = notifier_chain_unregister(&do_execve_notifier, n);
+			break;
+		case LOAD_KERNEL_IMAGE:
+			err = notifier_chain_unregister(&load_kernel_image_notifier, n);
+			break;
+		case LOAD_USER_IMAGE:
+			err = notifier_chain_unregister(&load_user_image_notifier, n);
+			break;
 	}
 
 	up_write(&profile_rwsem);
diff -urN linux-2.6.0-test5/kernel/fork.c linux-2.6.0-test5-intel-vtune/kernel/fork.c
--- linux-2.6.0-test5/kernel/fork.c	Mon Sep  8 12:49:53 2003
+++ linux-2.6.0-test5-intel-vtune/kernel/fork.c	Tue Sep 16 22:00:16 2003
@@ -30,6 +30,7 @@
 #include <linux/futex.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
+#include <linux/profile.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1113,6 +1114,8 @@
 			set_tsk_thread_flag(p, TIF_SIGPENDING);
 		}
 
+		profile_do_fork(p);
+
 		p->state = TASK_STOPPED;
 		if (!(clone_flags & CLONE_STOPPED))
 			wake_up_forked_process(p);	/* do this last */
diff -urN linux-2.6.0-test5/kernel/module.c linux-2.6.0-test5-intel-vtune/kernel/module.c
--- linux-2.6.0-test5/kernel/module.c	Mon Sep  8 12:50:18 2003
+++ linux-2.6.0-test5-intel-vtune/kernel/module.c	Tue Sep 16 22:03:00 2003
@@ -27,6 +27,7 @@
 #include <linux/fcntl.h>
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
+#include <linux/profile.h>
 #include <linux/moduleparam.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -1655,6 +1656,21 @@
 	if (err < 0)
 		goto cleanup;
 
+	/* track address of each loaded section in kernel module;
+	 * only profile those which lie within the module's address
+	 * range; we do it here since by this time all the sections
+	 * have been properly layed out 
+	 */
+	for (i = 0; i < hdr->e_shnum; i++) {
+	  if ( (sechdrs[i].sh_addr >= (unsigned long) mod->module_core) &&
+		(sechdrs[i].sh_addr < (unsigned long) (mod->module_core +
+						       mod->core_size))) {
+	    profile_load_kernel_image(mod, i,
+                    (unsigned long)(sechdrs[i].sh_addr),
+                    (unsigned long)(sechdrs[i].sh_size));
+	  }
+	}
+
 	/* Get rid of temporary copy */
 	vfree(hdr);
 
diff -urN linux-2.6.0-test5/fs/exec.c linux-2.6.0-test5-intel-vtune/fs/exec.c
--- linux-2.6.0-test5/fs/exec.c	Mon Sep  8 12:50:02 2003
+++ linux-2.6.0-test5-intel-vtune/fs/exec.c	Tue Sep 16 22:28:33 2003
@@ -45,6 +45,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/rmap-locking.h>
+#include <linux/profile.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -1103,6 +1104,8 @@
 	if (retval >= 0) {
 		free_arg_pages(&bprm);
 
+                profile_do_execve(current);
+
 		/* execve success */
 		security_bprm_free(&bprm);
 		return retval;
diff -urN linux-2.6.0-test5/mm/mmap.c linux-2.6.0-test5-intel-vtune/mm/mmap.c
--- linux-2.6.0-test5/mm/mmap.c	Mon Sep  8 12:50:08 2003
+++ linux-2.6.0-test5-intel-vtune/mm/mmap.c	Tue Sep 16 22:04:42 2003
@@ -651,6 +651,11 @@
 		}
 		kmem_cache_free(vm_area_cachep, vma);
 	}
+
+        if (vma->vm_flags & VM_EXEC) {
+            profile_load_user_image(current, vma);
+        }
+
 out:	
 	mm->total_vm += len >> PAGE_SHIFT;
 	if (vm_flags & VM_LOCKED) {
