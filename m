Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131263AbRCHDBD>; Wed, 7 Mar 2001 22:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131262AbRCHDAp>; Wed, 7 Mar 2001 22:00:45 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:27662 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S131261AbRCHDA1>; Wed, 7 Mar 2001 22:00:27 -0500
Message-ID: <3AA8473E.1A385E4B@sgi.com>
Date: Thu, 08 Mar 2001 21:00:14 -0600
From: Sam Watters <watters@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.2 -- Process Aggregates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applies against the 2.4.2 kernel and supports i386 and ia64 systems.

This patch provides the ability to register support for generic
process groups.  It does this by adding and entry in the task_struct
to maintain a list of pagg (process aggregate) group attachments (or
memberships).  In addition, there are interfaces for modules to register
as providing support for types of process aggregates.  Changes were made
to the fork and exit system calls so that child processes inherits group
memberships from the parent process.

PAGG features:

- Child inherits attachment to the same PAGG
  containers as the parent. 

- PAGG Containers are updated when new processes are
  attached (eg. during process forks). 

- PAGG Containers are updated when a process is
  detached (eg. when a process exits). 

- System call for controlling linux kernel modules
  that implement PAGG containers. 


Another patch will follow that implements a job container using this
pagg interface. The title for that patch will be: "[PATCH] 2.4.2 --
Linux Jobs".  Since the pagg patch provides a generic feature, and jobs
is just one implementation using that feature, the code was split into
two patches.  The pagg patch is useful by itself and does not require
the job patch.

This work was done so that we could provide a job accounting package
(called CSA).

For additional information about process aggregates & jobs, please go
to the home page at:

	http://oss.sgi.com/projects/pagg

At this site you can download these patches and the commands package
(in RPM or tarball format).  Also, there are additional patches for
other 2.4.x kernels.

For additional information about CSA job accounting, please consult the
home page at:

	http://oss.sgicom/projects/csa

patch follows (linux-2.4.2-pagg.patch):
---------------------------------------------------------------
diff -Naur linux-2.4.2/Documentation/Configure.help
linux-2.4.2-pagg/Documentation/Configure.help
--- linux-2.4.2/Documentation/Configure.help	Mon Feb 19 12:18:18 2001
+++ linux-2.4.2-pagg/Documentation/Configure.help	Mon Mar  5 08:46:36 2001
@@ -14648,6 +14648,14 @@
   keys are documented in Documentation/sysrq.txt. Don't say Y unless
   you really know what this hack does.
 
+Process Aggregates support
+CONFIG_PAGG
+  Say Y here if you will be loading modules which provide support
+  for process aggregate containers.  Currently, this option is only
+  applicable to Intel (i386) architectures. Examples of such modules
+  include the Linux Jobs module and the Linux Array Sessions module.
+  If you will not be using such modules, say N.
+
 ISDN subsystem
 CONFIG_ISDN
   ISDN ("Integrated Services Digital Networks", called RNIS in France)
diff -Naur linux-2.4.2/Documentation/pagg.txt
linux-2.4.2-pagg/Documentation/pagg.txt
--- linux-2.4.2/Documentation/pagg.txt	Wed Dec 31 18:00:00 1969
+++ linux-2.4.2-pagg/Documentation/pagg.txt	Mon Mar  5 08:46:36 2001
@@ -0,0 +1,253 @@
+Linux Process Aggregates (PAGG)
+-------------------------------
+
+Comments by:	Sam Watters <watters@sgi.com>
+Last Update: 	2001.01.30
+
+
+1. Description
+
+Borrowing the process aggregate concept found in IRIX 6.5 and implementing
+that concept in the Linux kernel provides a generalized mechanism for
+providing arbitrary process groups.  The process aggregate or PAGG
+consists of a series of functions for registering and unregistering
+support for PAGG's with the kernel.  This is similar to the support
+currently provided within Linux that allows for dynamic support
+of filesystems, block and character devices, symbol tables, network
+devices, serial devices, and execution domains.  Implementation of the
+PAGG provides developers the basic hooks necessary  to implement kernel
+modules for specific process containers, such as the job container.
+
+The fork(2) system call was altered to support PAGGs.  If a process is
+attached to any PAGG containers and that process forks, the child process
+will also be attached to the same PAGG containers.  The PAGG containers
+are be updated to indicate that a new process has been attached.
+The update is accomplished via a callback function provided by the
+PAGG module.
+
+The exit notification function in the kernel has also been altered.  If a
+process is attached to any PAGG containers and that process is exiting,
+the PAGG containers are updated to indicate that a process has detached
+from the container.  The update is accomplished via a callback function
+provided by the PAGG module.
+
+
+2.  Kernel Changes
+
+This section will describe files and data structures that need to be 
+modified to implement PAGGs.  In addition, new files and data 
+structures will also be introduced.
+
+3.1. Modified Files
+
+The following files require changes to implement PAGGs:
+
+-  Documentation/Configure.help
+-  arch/i386/config.in
+-  include/asm-i386/unistd.h  
+-  include/linux/sched.h
+-  arch/i386/kernel/entry.S
+-  kernel/Makefile  
+-  kernel/exit.c
+-  kernel/fork.c
+-  kernel/ksyms.c
+
+These changes only implement PAGGs for i386 architectures.  When testing
+volunteers appear for other architectures, support will be added for
+those additional architectures.
+
+2.2. New Files
+
+The following files will be added to implement PAGGs:
+
+-  include/linux/pagg.h
+-  kernel/pagg.c
+
+2.3. Modified Data Structures
+
+The following existing data structures need to be altered to implement 
+PAGGs:
+
+-  struct task_struct:          (include/linux/sched.h)
+     struct pagg_task_s *pagg;     /* List of pagg containers */
+
+The new member in task_struct, pagg,  points to a linked list of 
+pagg_task_s structures.
+
+2.4. New Data Structures
+
+The following new data structures will be introduced to implement 
+PAGGs.  The pagg_task_s structure will be
+
+-  struct pagg_task_s:          (include/linux/pagg.h)
+     char *name;                          /* PAGG module name */
+     int  (*attach)(struct task_struct *, /* Function to attach */
+               void *,
+               struct pagg_task_s *);
+     int  (*detach)(struct task_struct *, /* Function to detach */
+               struct pagg_task_s *);
+     void *data;                          /* Task specific data */
+     struct pagg_task_s *prev;            /* Ptr to prev container */
+     struct pagg_task_s *next;            /* Ptr to next container */
+     
+-  struct pagg_module_s:        (include/linux/pagg.h)
+     char *name;                          /* PAGG module name */
+     int  (*attach)(struct task_struct *, /* Function to attach */
+               void *,
+               struct pagg_task_s *);
+     int  (*detach)(struct task_struct *, /* Function to detach */
+               struct pagg_task_s *);
+     int  (*init)(struct task_struct *,   /* Load task init func. */
+     int  (*do_paggctl)(int, void *);     /* Funtion for paggctl */
+     void *data;                          /* Module specific data */
+     struct module *module;               /* Ptr to PAGG module */
+     struct pagg_module_s *prev;          /* Ptr to prev container */
+     struct pagg_module_s *next;          /* Ptr to next container */
+
+The pagg_task_s structure provides the process' reference to the PAGG 
+containers provided by the modules.  The attach function pointer is 
+the function used to update the referenced PAGG container that the 
+process is being attached.  The detach function pointer is used to 
+update the referenced PAGG container when the process is exiting or 
+otherwise detaching from the container.
+
+The pagg_module_s structure provides the reference to the PAGG module 
+that implements a type of PAGG container.  In addition to the function 
+pointers described concerning pagg_task_s, this structure provides two 
+addition function pointers.  The init function pointer is optional and 
+is used to attach currently running processes to a default PAGG 
+container.  If the init function is not defined, then it is assumed 
+that NULL represents the default PAGG container for that module.  The 
+do_paggctl function provides this modules interface for the paggctl 
+system call.  If paggctl is called using this modules name, this 
+function will  be used, passing it a request code and data pointer. 
+The pagg_module_s structures will be stored in a simple hash table to 
+provide quick table lookup capability for the paggctl system call.
+     
+
+2.5. Modified Functions
+
+The following functions require changed to implement PAGGs:
+
+-  do_fork:     (kernel/fork.c)
+     /* execute the following pseudocode before add to run-queue  */  
+     If parent process pagg list is not empty
+          Call attach_pagg function with child task_struct as argument
+-  do_exit:     (kernel/exit.c)
+     /* execute the following pseudocode prior to schedule call */
+     If current process pagg list is not empty
+               Call detach_pagg function with current task_struct 
+
+2.6 New Functions
+
+The following new functions will be added to implement PAGGs:
+
+-  int  register_pagg(struct pagg_module_s *);  (kernel/pagg.c)
+     Add module entry into table of pagg modules
+     If module provides init function
+          Foreach task
+               Add initial pagg container as defined by module
+     Else
+          The default container is NULL
+-  int unregister_pagg(struct pagg_module_s *); (kernel/pagg.c)
+     Find module entry in table of pagg modules
+          Foreach task
+               Detach each task from containers provided by module
+-  int attach_pagg(struct task_struct *);       (kernel/pagg.c)
+     /* Assumed task pagg list pts to paggs that it attaches to */
+     While another pagg container reference
+          Make copy of pagg container reference & insert into new list
+          Attach task to pagg container using new container reference
+          Get next pagg container reference
+     Make task pagg list use the new pagg list
+-  int detach_pagg(struct task_struct *);       (kernel/pagg.c)
+     While another pagg container reference
+          Detach task form pagg container using reference
+
+     
+2.7 New System Calls
+
+The following new system call will be added to implement a control 
+interface for PAGG modules:
+
+-  int sys_paggctl(const char *, int, void *);  (kernel/pagg.c)
+     If requested name is invalid
+          Return -EINVAL      
+     If requested module name not found in pagg module table
+          Return -ENOSYS
+     If requested module does not provide do_paggctl function
+          Return -ENOSYS
+     Else
+          Call pagg module do_paggctl function
+          Return result
+
+The paggctl system call provides the necessary interface for 
+controlling the function of the pagg container modules.
+
+
+3.  Paggctl System Call Man Page
+
+
+paggctl(3c)					      paggctl(3c)
+
+
+NAME
+       paggctl	- controls and provides status for Process Aggre-
+       gation (PAGG) modules
+
+SYNOPSIS
+       int paggctl (char *module_name, int request, void *data);
+
+DESCRIPTION
+       The paggctl system call is used as the system call  inter-
+       face  for  Process Aggregation (PAGG) modules.  For a PAGG
+       module to support the paggctl interface, it must have pro-
+       vided  a reference to a processing function that is imple-
+       mented in the module to handle paggctl calls  the  request
+       the module.  It is not required that a PAGG module support
+       the paggctl system call.
+
+       The paggctl system call allows processes to obtain  infor-
+       mation  from the PAGG modules, such as status information.
+       In addition, this interface provides  processes	with  the
+       ability to provide information to the PAGG module.
+
+       The  use of the paggctl system call requires three parame-
+       ters.  The first, module_name, is a string  that	 provides
+       the name module that should service the request.	 The sec-
+       ond argument, request, is a code	 that  indicates  to  the
+       module  what  the operation the caller is requesting.  The
+       final argument, data, is a pointer to a strucuture used to
+       transfer	 data  between	the  process and the module.  The
+       module servicing the request will  provide  the	structure
+       definitions for the data argument.
+
+       Each  PAGG  module  that implements a service function for
+       paggctl should provide a manual page that  provides  addi-
+       itonal  details.	  The Linux Job module is an example of a
+       PAGG module.  The Job module manual page, job_paggctl(3c),
+       provides	 additional  details  about the requests that the
+       service function provided by the Job module may handle and
+       any required header files.
+
+ERRORS
+       Under the following conditions, the acctctl function fails
+       and sets errno to:
+
+       [ENOSYS]	      The module could not be found,  or  it  did
+		      not provide a service function.  Additional
+		      errno codes are listed on the manual  pages
+		      provided by the PAGG modules
+
+DIAGNOSTICS
+       Upon  successful completion, paggctl returns a value of 0.
+       Otherwise, a value of -1 is returned and errno is  set  to
+       indicate the error.
+
+
+
+
+
+								1
+
+
diff -Naur linux-2.4.2/arch/i386/config.in linux-2.4.2-pagg/arch/i386/config.in
--- linux-2.4.2/arch/i386/config.in	Mon Jan  8 15:27:56 2001
+++ linux-2.4.2-pagg/arch/i386/config.in	Mon Mar  5 08:46:36 2001
@@ -218,6 +218,7 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+bool 'Support for process aggregates (PAGGs)' CONFIG_PAGG
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    choice 'Kernel core (/proc/kcore) format' \
 	"ELF		CONFIG_KCORE_ELF	\
diff -Naur linux-2.4.2/arch/i386/kernel/entry.S
linux-2.4.2-pagg/arch/i386/kernel/entry.S
--- linux-2.4.2/arch/i386/kernel/entry.S	Wed Nov  8 19:09:50 2000
+++ linux-2.4.2-pagg/arch/i386/kernel/entry.S	Mon Mar  5 08:46:36 2001
@@ -646,6 +646,12 @@
 	.long SYMBOL_NAME(sys_getdents64)	/* 220 */
 	.long SYMBOL_NAME(sys_fcntl64)
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for TUX */
+#if defined(CONFIG_PAGG)
+	.long SYMBOL_NAME(sys_paggctl)
+#else
+	.long SYMBOL_NAME(sys_ni_syscall)
+#endif
+
 
 	/*
 	 * NOTE!! This doesn't have to be exact - we just have
diff -Naur linux-2.4.2/arch/ia64/config.in linux-2.4.2-pagg/arch/ia64/config.in
--- linux-2.4.2/arch/ia64/config.in	Fri Feb 16 17:53:08 2001
+++ linux-2.4.2-pagg/arch/ia64/config.in	Mon Mar  5 08:46:36 2001
@@ -93,6 +93,7 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+bool 'Support for process aggregates (PAGGs)' CONFIG_PAGG
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
diff -Naur linux-2.4.2/arch/ia64/kernel/entry.S
linux-2.4.2-pagg/arch/ia64/kernel/entry.S
--- linux-2.4.2/arch/ia64/kernel/entry.S	Thu Jan  4 14:50:17 2001
+++ linux-2.4.2-pagg/arch/ia64/kernel/entry.S	Mon Mar  5 08:46:36 2001
@@ -1247,7 +1247,11 @@
 	data8 sys_newfstat
 	data8 sys_clone2
 	data8 sys_getdents64
+#if defined(CONFIG_PAGG)
+	data8 sys_paggctl			// 1215
+#else
 	data8 ia64_ni_syscall			// 1215
+#endif
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
diff -Naur linux-2.4.2/include/asm-i386/unistd.h
linux-2.4.2-pagg/include/asm-i386/unistd.h
--- linux-2.4.2/include/asm-i386/unistd.h	Fri Aug 11 16:39:23 2000
+++ linux-2.4.2-pagg/include/asm-i386/unistd.h	Mon Mar  5 08:46:36 2001
@@ -227,6 +227,11 @@
 #define __NR_madvise1		219	/* delete when C lib stub is removed */
 #define __NR_getdents64		220
 #define __NR_fcntl64		221
+#if defined(CONFIG_PAGG)
+#define __NR_paggctl          	223 
+#endif
+
+
 
 /* user-visible error numbers are in the range -1 - -124: see
<asm-i386/errno.h> */
 
diff -Naur linux-2.4.2/include/asm-ia64/unistd.h
linux-2.4.2-pagg/include/asm-ia64/unistd.h
--- linux-2.4.2/include/asm-ia64/unistd.h	Thu Jan  4 14:50:18 2001
+++ linux-2.4.2-pagg/include/asm-ia64/unistd.h	Mon Mar  5 08:46:37 2001
@@ -204,6 +204,11 @@
 #define __NR_fstat			1212
 #define __NR_clone2			1213
 #define __NR_getdents64			1214
+#if defined(CONFIG_PAGG)
+#define __NR_paggctl			1215
+#endif
+
+
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
diff -Naur linux-2.4.2/include/linux/pagg.h
linux-2.4.2-pagg/include/linux/pagg.h
--- linux-2.4.2/include/linux/pagg.h	Wed Dec 31 18:00:00 1969
+++ linux-2.4.2-pagg/include/linux/pagg.h	Mon Mar  5 08:46:37 2001
@@ -0,0 +1,180 @@
+/* 
+ * PAGG (Process Aggregates) interface
+ *
+ * 
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ * 
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * 
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ * 
+ * Contact information:  Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ * 
+ * http://www.sgi.com
+ * 
+ * For further information regarding this notice, see:
+ * 
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan
+ *
+ * Description:	This file, include/linux/pagg.h, contains the data
+ *              structure definitions and function prototypes used to
+ *              implement process aggrefates (paggs). Paggs provides a
+ *              generalized was to implement process groupings or
+ *              containers.  Modules use these functions to register
+ *              with the kernel as providers of process aggregation
+ *              containers. The pagg data structures define the
+ *              callback functions and data access pointers back into
+ *              the pagg modules.
+ *
+ * Created: 	2000.05.23	Sam Watters <watters@sgi.com>
+ *
+ * Changes:  	2000.07.15	Sam Watters <watters@sgi.com>
+ * 		Changed definitions of structures.
+ *
+ */
+#ifndef _PAGG_H
+#define _PAGG_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_PAGG
+
+#include <linux/linkage.h>
+#include <linux/ptrace.h>
+
+
+/*
+ * Used by task_struct to manage list of pagg attachments for the process.  
+ * Each pagg_task_s provides the link between the process and the 
+ * correct pagg container.
+ *
+ * STRUCT MEMBERS:
+ *     name:           The name of the pagg container type referenced.
+ *                     This will be set by the pagg module.
+ *     do_attach:      Function pointer to function used when attaching
+ *                     a process to the pagg container referenced by 
+ *                     this struct.
+ *     do_detach:      Function pointer to function used when detaching
+ *                     a process to the pagg container referenced by 
+ *                     this struct.
+ *     data:           Opaque data pointer - defined by pagg modules.
+ *     prev:           Pointer to previous pagg_task_s in processes list.
+ *     next:           Pointer to next pagg_task_s in processes list.
+ */
+struct pagg_task_s {
+       char                    *name;  
+       int                     (*do_attach)(struct task_struct *, 
+                                           void *, 
+                                           struct pagg_task_s *);
+       int                     (*do_detach)(struct task_struct *, 
+                                           struct pagg_task_s *);
+       void                    *data;
+       struct list_head	       entry;
+}; /* pagg_task_s */
+
+/*
+ * Used by pagg modules to define the callback functions into the 
+ * module.
+ *
+ * STRUCT MEMBERS:
+ *     name:           The name of the pagg container type provided by
+ *                     the module. This will be set by the pagg module.
+ *     do_attach:      Function pointer to function used when attaching
+ *                     a process to the pagg container referenced by 
+ *                     this struct.
+ *     do_detach:      Function pointer to function used when detaching
+ *                     a process to the pagg container referenced by 
+ *                     this struct.
+ *     do_init:        Function pointer to initialization function.  This
+ *                     function is used when the module is loaded to attach
+ *                     existing processes to a default container as defined by
+ *                     the pagg module. This is optional and may be set to 
+ *                     NULL if it is not needed by the pagg module.
+ *     do_paggctl:     Function pointer to paggctl() system call handler
+ *                     for the pagg module.  This is optional and may be set
+ *                     to NULL if it is not needed by the pagg module.
+ *     data:           Opaque data pointer - defined by pagg modules.
+ *     module:         Pointer to kernel module struct.  Used to increment & 
+ *                     decrement the use count for the module.
+ *     prev:           Pointer to previous pagg_module_s entry in hashtable 
+ *                     chain list.     
+ *     next:           Pointer to next pagg_module_s entry in the hashtable
+ *                     chain list.
+ */
+struct pagg_module_s {
+       char                    *name;
+       int                     (*do_attach)(struct task_struct *, 
+                                           void *, 
+                                           struct pagg_task_s *);
+       int                     (*do_detach)(struct task_struct *, 
+                                           struct pagg_task_s *);
+       int                     (*do_init)(struct task_struct *,
+                                                struct pagg_task_s *);
+       int                     (*do_paggctl)(int, void *);
+       void                    *data;
+       struct module           *module;
+       struct pagg_module_s    *next;
+}; /* pagg_module_s */ 
+
+
+/* Kernel service functions for providing PAGG support */
+extern struct pagg_task_s *find_pagg(struct task_struct *, char *);
+extern int register_pagg(struct pagg_module_s *);
+extern int unregister_pagg(struct pagg_module_s *);
+extern int attach_pagg(struct list_head *, struct task_struct *);
+extern int detach_pagg(struct task_struct *);
+
+/* 
+ *  Macro used when a child process must inherit attachment to pagg 
+ * containers from the parent.
+ */
+#define attach_pagg_chk(parent, child)                                    \
+do {                                                                      \
+       /* Need this check until we go into INIT_TASK */			  \
+       if (parent->pid == 0) INIT_LIST_HEAD(&parent->pagg_list);	  \
+       INIT_LIST_HEAD(&child->pagg_list);				  \
+       if (!list_empty(&parent->pagg_list)) {                             \
+               if (attach_pagg(&parent->pagg_list, child) != 0)           \
+                       goto bad_fork_cleanup;                             \
+       }                                                                  \
+} while(0);
+
+/* 
+ * Macro used when a process must detach form pagg containers to which it
+ * is currenlty a member.
+ */
+#define detach_pagg_chk(tsk)                                              \
+do {                                                                      \
+       if (!list_empty(&tsk->pagg_list)) {                                \
+               detach_pagg(tsk);                                          \
+       }                                                                  \
+} while(0);
+
+#else  /* CONFIG_PAGG */
+
+/* 
+ * Replacement macros used when PAGG (Process Aggregates) support is not
+ * compiled into the kernel.
+ */
+#define detach_pagg_chk(tsk)  do {  } while(0);        
+#define attach_pagg_chk(parent, child)  do { } while(0);
+
+#endif /* CONFIG_PAGG */
+
+#endif /* _PAGG_H */
diff -Naur linux-2.4.2/include/linux/paggctl.h
linux-2.4.2-pagg/include/linux/paggctl.h
--- linux-2.4.2/include/linux/paggctl.h	Wed Dec 31 18:00:00 1969
+++ linux-2.4.2-pagg/include/linux/paggctl.h	Mon Mar  5 08:46:37 2001
@@ -0,0 +1,51 @@
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information:  Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ *
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan
+ *
+ * Description:	This file, include/linux/paggctl.h, contains the data
+ * 		structure definitions used by user-mode programs to 
+ * 		communicate with the PAGG modules via the paggctl 
+ * 		function.
+ *
+ * Created:	2000.07.15	Sam Watters <watters@sgi.com>
+ *
+ * Changes:	2001.01.30	Sam Watters <watters@sgi.com>
+ * 		Moved file to include/linux/paggctl.h & cleanup
+ */
+
+#ifndef _LINUX_PAGGCTL_H
+#define _LINUX_PAGGCTL_H
+#ifndef __KERNEL__
+#include <stdint.h>
+#include <sys/types.h>
+#endif
+
+
+/*
+ * =====================================================
+ * NEW definitions for PAGG module support would go here
+ * =====================================================
+ */
+#endif /* _LINUX_PAGGCTL_H */
diff -Naur linux-2.4.2/include/linux/sched.h
linux-2.4.2-pagg/include/linux/sched.h
--- linux-2.4.2/include/linux/sched.h	Wed Feb 21 18:09:58 2001
+++ linux-2.4.2-pagg/include/linux/sched.h	Mon Mar  5 08:46:37 2001
@@ -26,6 +26,7 @@
 #include <linux/signal.h>
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
+#include <linux/pagg.h>
 
 /*
  * cloning flags:
@@ -395,6 +396,10 @@
    	u32 self_exec_id;
 /* Protection of (de-)allocation: mm, files, fs, tty */
 	spinlock_t alloc_lock;
+#if defined(CONFIG_PAGG)
+/* List of pagg (process aggregate) attachments */
+	struct list_head pagg_list;
+#endif
 };
 
 /*
diff -Naur linux-2.4.2/kernel/Makefile linux-2.4.2-pagg/kernel/Makefile
--- linux-2.4.2/kernel/Makefile	Fri Dec 29 16:07:24 2000
+++ linux-2.4.2-pagg/kernel/Makefile	Mon Mar  5 08:46:37 2001
@@ -12,6 +12,7 @@
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
+	    pagg.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o
diff -Naur linux-2.4.2/kernel/exit.c linux-2.4.2-pagg/kernel/exit.c
--- linux-2.4.2/kernel/exit.c	Fri Feb  9 13:29:44 2001
+++ linux-2.4.2-pagg/kernel/exit.c	Mon Mar  5 08:49:15 2001
@@ -10,6 +10,7 @@
 #include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/tty.h>
+#include <linux/pagg.h>
 #ifdef CONFIG_BSD_PROCESS_ACCT
 #include <linux/acct.h>
 #endif
@@ -454,6 +455,17 @@
 
 	tsk->exit_code = code;
 	exit_notify();
+
+	/*
+	 * If config'd for PAGG support:
+	 *      call pagg modules to detach 
+	 *      from process aggregates to which the current process is 
+	 *      attached.
+	 * Else
+	 *      This is a no-op.
+	 */
+	detach_pagg_chk(tsk);
+ 
 	schedule();
 	BUG();
 /*
diff -Naur linux-2.4.2/kernel/fork.c linux-2.4.2-pagg/kernel/fork.c
--- linux-2.4.2/kernel/fork.c	Fri Feb  9 13:29:44 2001
+++ linux-2.4.2-pagg/kernel/fork.c	Mon Mar  5 08:46:37 2001
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
+#include <linux/pagg.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -660,6 +661,16 @@
 	   
 	p->parent_exec_id = p->self_exec_id;
 
+	/*
+	 * If config'd for PAGG support:
+	 *      call pagg modules to properly attach new process
+	 *      to the same process aggregate containers as the 
+	 *      parent process.
+	 * Else
+	 *      this is a no-op.
+	 */
+	attach_pagg_chk(current, p);
+
 	/* ok, now we should be set up.. */
 	p->swappable = 1;
 	p->exit_signal = clone_flags & CSIGNAL;
@@ -713,6 +724,7 @@
 bad_fork_cleanup_files:
 	exit_files(p); /* blocking */
 bad_fork_cleanup:
+	detach_pagg_chk(p);	/* no-op unless CONFIG_PAGG=y  */
 	put_exec_domain(p->exec_domain);
 	if (p->binfmt && p->binfmt->module)
 		__MOD_DEC_USE_COUNT(p->binfmt->module);
diff -Naur linux-2.4.2/kernel/ksyms.c linux-2.4.2-pagg/kernel/ksyms.c
--- linux-2.4.2/kernel/ksyms.c	Fri Feb  9 13:29:44 2001
+++ linux-2.4.2-pagg/kernel/ksyms.c	Mon Mar  5 08:50:17 2001
@@ -46,6 +46,7 @@
 #include <linux/brlock.h>
 #include <linux/fs.h>
 #include <linux/tty.h>
+#include <linux/pagg.h>
 
 #if defined(CONFIG_PROC_FS)
 #include <linux/proc_fs.h>
@@ -474,6 +475,14 @@
 
 /* Miscellaneous access points */
 EXPORT_SYMBOL(si_meminfo);
+#if defined(CONFIG_PAGG)
+EXPORT_SYMBOL(find_pagg);
+EXPORT_SYMBOL(register_pagg);
+EXPORT_SYMBOL(unregister_pagg);
+EXPORT_SYMBOL(attach_pagg);
+EXPORT_SYMBOL(detach_pagg);
+#endif
+
 
 /* Added to make file system as module */
 EXPORT_SYMBOL(sys_tz);
diff -Naur linux-2.4.2/kernel/pagg.c linux-2.4.2-pagg/kernel/pagg.c
--- linux-2.4.2/kernel/pagg.c	Wed Dec 31 18:00:00 1969
+++ linux-2.4.2-pagg/kernel/pagg.c	Mon Mar  5 08:46:37 2001
@@ -0,0 +1,426 @@
+/* 
+ * PAGG (Process Aggregates) interface
+ *
+ * 
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ * 
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * 
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ * 
+ * Contact information:  Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ * 
+ * http://www.sgi.com
+ * 
+ * For further information regarding this notice, see:
+ * 
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan
+ *
+ * Description:  This file, kernel/pagg.c, contains the routines used
+ *               to implement process aggregates (paggs).  The pagg
+ *               extends the task_struct to allow for various process
+ *               aggregation continers.  Examples of such containers
+ *               include "jobs" and cluster applications IDs.  Process
+ *               sessions and groups could have been implemented using
+ *               paggs (although there would be little purpose in
+ *               making that change at this juncture).  The pagg
+ *               structure maintains pointers to callback functions and
+ *               data strucures maintained in modules that have
+ *               registered with the kernel as pagg container
+ *               providers.
+ *
+ * Created:	2000.05.23	Sam Watters <watters@sgi.com>
+ *
+ * Changes:	2001.01.30	Sam Watters <watters@sgi.com>
+ * 		Changes so PAGG modules can be compiled into the kernel
+ *
+ */
+
+#include <linux/config.h>
+
+#if defined(CONFIG_PAGG)
+
+#include <linux/malloc.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/module.h>
+#include <linux/pagg.h>
+
+
+/* Hash table for pagg modules entries */
+
+static struct pagg_module_s *pagg_module_table[] = {
+	NULL /* A */ , NULL, NULL, NULL, NULL, NULL, NULL, NULL /* H */ ,
+	NULL /* I */ , NULL, NULL, NULL, NULL, NULL, NULL, NULL /* P */ ,
+	NULL /* Q */ , NULL, NULL, NULL, NULL, NULL, NULL, NULL /* X */ ,
+	NULL /* Y */ , NULL, NULL, NULL, NULL, NULL, NULL, NULL /* f */ ,
+	NULL /* g */ , NULL, NULL, NULL, NULL, NULL, NULL, NULL /* n */ ,
+	NULL /* o */ , NULL, NULL, NULL, NULL, NULL, NULL, NULL /* u */ ,
+	NULL /* w */ , NULL, NULL, NULL	/* z */
+};
+
+rwlock_t pagg_module_table_lock = RW_LOCK_UNLOCKED;
+
+/* 
+ * find_pagg
+ *
+ * Given a task and the pagg ID key (name), this function will 
+ * return a pointer to the pagg_task_s struct.  If the key is not
+ * found, the function will return NULL
+ */
+struct pagg_task_s *
+find_pagg(struct task_struct *task, char *key)
+{
+	struct list_head *entry;
+
+	list_for_each(entry, &task->pagg_list) {
+		struct pagg_task_s *pagg = list_entry(entry, 
+						      struct pagg_task_s, 
+						     entry);
+		if (pagg->name == key) {
+			return pagg;
+		}
+	}
+	return NULL;
+}
+
+
+
+/*
+ * register_pagg
+ *
+ * Used to register a new pagg module and enter it into the pagg_module_table.
+ * If the pagg module defines an init function, then all existing tasks
+ * (processes) are attached to the initial pagg container.  If no init 
+ * function is defined, then the module default container is assumed to be
+ * NULL (absent).
+ *
+ * If a memory error is encountered, the pagg module is unregistered and any
+ * tasks that have been attached to the initial pagg container are detached
+ * from that container.
+ */
+int register_pagg(struct pagg_module_s *pm_new)
+{
+	struct pagg_module_s **pm;
+
+	/* ADD NEW PAGG MODULE TO ACCESS LIST */
+	if (!pm_new)
+		return -EINVAL;			/* error */
+	if (pm_new->next)
+		return -EINVAL;			/* error */
+	if (pm_new->name == NULL)
+		return -EINVAL;			/* error */
+	if (pm_new->name[0] < 'A' || pm_new->name[0] > 'z')
+		return -EINVAL;			/* error */
+
+	/* insert new module entry into hash table */
+	write_lock_irq(&pagg_module_table_lock);
+	pm = &pagg_module_table[(pm_new->name[0] - 'A')];
+	while (*pm) {
+		if (strcmp((*pm)->name, pm_new->name) == 0) {
+			printk(KERN_WARNING
+					"Attempt to register duplicate"
+					" PAGG support (name=%s)\n",
+					pm_new->name);
+			write_unlock_irq(&pagg_module_table_lock);
+			return -EBUSY;
+		}
+		pm = &(*pm)->next;
+	}
+	*pm = pm_new;
+	write_unlock_irq(&pagg_module_table_lock);
+
+	printk(KERN_INFO "Registering PAGG support for (name=%s)\n",
+			pm_new->name);
+
+
+	/* UPDATE ALL PROCESSES FOR NEW PAGG MODULE */
+
+	/* 
+	 * If the module has a init function defined, we need 
+	 * to touch each process so that it can be attached to a 
+	 * container for the new pagg.  This container will
+	 * be the default container defined for the new module. If no
+	 * init is defined, then we assume that the default
+	 * container for the new pagg module is defined as NULL.
+	 * Perfectly valid.
+	 */
+	if (pm_new->module)
+		__MOD_INC_USE_COUNT(pm_new->module);
+	if (pm_new->do_init) {
+		struct task_struct *task;
+
+		read_lock(&tasklist_lock);
+		for_each_task(task) {
+			struct pagg_task_s *pt;
+
+			pt = kmalloc(sizeof(struct pagg_task_s), GFP_KERNEL);
+			if (!pt) {
+				/* Error: unregister module and fail */
+
+				printk(KERN_ERR "Initialization for PAGG"
+						" support failed (name=%s)"
+						" - memory allocation"
+						" failure in kernel\n",
+						pm_new->name);
+
+				/* 
+				 * Release locks and dec module use count so it
+				 * can be released.
+				 */
+				read_unlock(&tasklist_lock);
+				if (pm_new->module)
+					__MOD_DEC_USE_COUNT(pm_new->module);
+
+				unregister_pagg(pm_new);
+				return -ENOMEM;	/* error */
+			}
+
+			pt->do_attach = pm_new->do_attach;
+			pt->do_detach = pm_new->do_detach;
+			pm_new->do_init(task, pt);
+			list_add(&pt->entry, &task->pagg_list);
+		}
+		read_unlock(&tasklist_lock);
+	}
+	if (pm_new->module)
+		__MOD_DEC_USE_COUNT(pm_new->module);
+
+	return 0;					/* success */
+
+}
+
+
+/*
+ * unregister_pagg
+ *
+ * Used to unregister pagg modules and remove them from the pagg_module_table.
+ * Once the pagg module entry in the pagg_module_table is found, all of the
+ * tasks are scanned and detached from any pagg containers defined by the
+ * pagg module.
+ */
+int unregister_pagg(struct pagg_module_s *pm_old)
+{
+	struct pagg_module_s **pm;
+	struct task_struct *task;
+
+
+	/* Check the validity of the arguments */
+	if (!pm_old)
+		return -EINVAL;			/* error */
+	if (pm_old->next)
+		return -EINVAL;			/* error */
+	if (pm_old->name == NULL)
+		return -EINVAL;			/* error */
+	if (pm_old->name[0] < 'A' || pm_old->name[0] > 'z')
+		return -EINVAL;			/* error */
+
+	write_lock_irq(&pagg_module_table_lock);
+	pm = &pagg_module_table[(pm_old->name[0] - 'A')];
+	while (*pm) {
+		if (pm_old == *pm) {
+			/* 
+			 * Scan through processes on system and remove all
+			 * references to pagg containers for this pagg module.
+			 * 
+			 * Since the processes will not exit as a result of 
+			 * unloading the module, we do not detach them.  We
+			 * just remove all references to the container. All
+			 * information in the container referenced will be 
+			 * discarded as this module is unloaded.
+			 */
+			read_lock(&tasklist_lock);
+			for_each_task(task) {
+				struct pagg_task_s *pagg;
+				
+				pagg = find_pagg(task, pm_old->name);
+				if (pagg) {
+					list_del(&pagg->entry);
+					pagg->do_detach(task, pagg);
+					kfree(pagg);
+				}
+			}
+			read_unlock(&tasklist_lock);
+
+			*pm = pm_old->next;
+			pm_old->next = NULL;
+			write_unlock_irq(&pagg_module_table_lock);
+
+			printk(KERN_INFO "Unregistering PAGG support for"
+					" (name=%s)\n", pm_old->name);
+
+			return 0;			/* success */
+		}
+		pm = &(*pm)->next;
+
+	}
+	write_unlock_irq(&pagg_module_table_lock);
+
+	printk(KERN_WARNING "Attempt to unregister PAGG support (name=%s)"
+			" failed - not found\n", pm_old->name);
+	
+	return -EINVAL;				/* error */
+}
+
+
+/*
+ * attach_pagg
+ *
+ * Used to attach a new task to the same pagg containers to which it's parent
+ * is attached.
+ */
+int attach_pagg(struct list_head *pagg_list, struct task_struct *task)
+{
+	struct list_head   *entry;
+	int  		   retcode = 0;
+
+	if (!task) {
+		return -EINVAL;
+	}
+
+	INIT_LIST_HEAD(&task->pagg_list);
+
+	list_for_each(entry, pagg_list) {
+		struct pagg_task_s *pagg = NULL;
+		struct pagg_task_s *ppagg = list_entry(entry, 
+				struct pagg_task_s, entry);
+
+		pagg = kmalloc(sizeof(struct pagg_task_s), GFP_KERNEL);
+		if (!pagg) {
+			retcode = -ENOMEM;
+			goto error_return;
+		}
+		pagg->name = ppagg->name;
+		pagg->do_attach = ppagg->do_attach;
+		pagg->do_detach = ppagg->do_detach;
+		pagg->data = NULL;
+		retcode = pagg->do_attach(task, ppagg->data, pagg);
+		if (retcode != 0) {
+			/* do_attach should issue error message */
+			goto error_return;
+		}
+		list_add(&pagg->entry, &task->pagg_list);
+	}
+
+	return 0;					/* success */
+
+  error_return:
+	/* 
+	 * Clean up all the pagg attachments made on behalf of the new
+	 * task.  Set new task pagg ptr to NULL for return.
+	 */
+	detach_pagg(task);
+	return retcode;				/* failure */
+}
+
+
+/*
+ * detach_pagg
+ *
+ * Used to detach a task from all pagg containers to which it is attached.
+ */
+int detach_pagg(struct task_struct *task)
+{
+	struct list_head   head;
+	struct list_head   *entry;
+	int retcode = 0;
+	int rettmp = 0;
+
+	/* Remove ref. to paggs from task immediately */
+	list_add(&head, &task->pagg_list);
+	list_del_init(&task->pagg_list);
+
+	/* Visit each pagg and detach from pagg container */
+	list_for_each(entry, &head) {
+		struct pagg_task_s *pagg = list_entry(entry, 
+				struct pagg_task_s, entry);
+
+		rettmp = pagg->do_detach(task, pagg);
+		if (retcode) {
+			/* do_detach should log error message */
+			retcode = rettmp;
+		}
+		list_del(&pagg->entry);
+		kfree(pagg);
+	}
+
+	return retcode;	/* 0 = success, else return last code for failure */
+}
+
+
+/* 
+ * sys_paggctl
+ *
+ * The paggctl() system call.  This system call uses "name" to determine
+ * which module will handle the system call.  The "request" and "data"
+ * arguments are passed to the module via the module's callback function
+ * accessed via the do_paggctl() function pointer.
+ */
+asmlinkage int sys_paggctl(char *name, int request, void *data)
+{
+	struct pagg_module_s *list;
+
+	/* Validate the name argument */
+	if (name == NULL) {
+		return -EINVAL;
+	}
+
+	if (name[0] < 'A' || name[0] > 'z') {
+		return -EINVAL;
+	}
+
+	/* Find the module's entry and issue the callback function */
+	read_lock(&pagg_module_table_lock);
+	list = pagg_module_table[(name[0] - 'A')];
+	while (list) {
+		if (strcmp(name, list->name) == 0) {
+			/* We found the target module */
+			int retcode = 0;
+
+			/* 
+			 * Increment module use count so that it cannot be
+			 * removed. At this point the read lock on the 
+			 * pagg_module_table can be released.
+			 */
+			if (list->module)
+				__MOD_INC_USE_COUNT(list->module);
+			read_unlock(&pagg_module_table_lock);
+			if (list->do_paggctl == NULL)
+				/*  module does not provide callback */
+				retcode = -ENOSYS;
+			else
+				/* return result of module callback */
+				retcode = list->do_paggctl(request, data);
+			if (list->module)
+				__MOD_DEC_USE_COUNT(list->module);
+			return retcode;
+
+		}
+		list = list->next;
+	}
+	/* 
+	 * If we are here, we didn't find the appropriate module entry.
+	 * release the read lock on the pagg_module_table and return
+	 * ENOSYS (system service not implemented.
+	 */
+	read_unlock(&pagg_module_table_lock);
+	return -ENOSYS;
+}
+
+#endif							/* CONFIG_PAGG */
