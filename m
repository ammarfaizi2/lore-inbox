Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136768AbRAHEvm>; Sun, 7 Jan 2001 23:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136784AbRAHEvd>; Sun, 7 Jan 2001 23:51:33 -0500
Received: from smtp.sw.oz.au ([203.31.96.1]:5638 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id <S136768AbRAHEvX>;
	Sun, 7 Jan 2001 23:51:23 -0500
Date: Mon, 8 Jan 2001 15:51:03 +1100 (EST)
Message-Id: <200101080451.PAA00857@smtp.sw.oz.au>
From: Peter Chubb <peterc@aurema.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM fixes + RSS limits 2.4.0-test13-pre5
CC: ingo.oeser@informatik.tu-chemnitz.de, riel@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo wrote:
> On Wed, Jan 03, 2001 at 09:43:54AM -0200, Rik van Riel wrote:
> > On Fri, 28 Dec 2000, Mike Sklar wrote:
> > > If I wanted to adjust the rlim_cur value of a running
> > > processes, is there any sort of interface for that?
> > 
> > Hmmm, I don't think there is an interface to adjust the
> > per-process ulimit settings on-the-fly ...
> > 
> > Does anybody know if there's an interface for this ?

> If you don't mean "kill -TERM", no there isn't. It would be evil
> to the process anyway.

The RSS limits patch I sent to linux-kernel some time ago provided an
experimental /proc interface to allow exactly this.
The patch against 2.2.16 is still on our FTP server at 

ftp://ftp-au.aurema.com/private/aurpjc31/linux-2216-rsslimit.diff.bz2

Here's the patch against 2.4.0.  The main differences between this and 
Rik's patch are:
      -- you  choose soft or hard limits at kernel config time with my 
      patch; with Rik's you get both (rlim_cur is `soft' rlim_max is
      `hard') 
      -- Rik's patch does some extra stuff to the VM code as well as
         the RSS limits
      -- Rik's patch doesn't affect swap behaviour (except in so far
         as processes over their RSS limit will tend to swap, which reduces
         memory pressure on all other processes); my patch means that
	 processes over RSS limit suffer somewhat
      -- My patch puts the limit into the struct mm for slightly more
         cache-friendly behaviour, and to allow later interfacing with
	 per-user resource-management software (it should be possible
	 to write a kernel module to adjust RSS limits to implement per-user 
	 limits without affecting per-process RLIMIT values)
      -- My patch has a /proc interface to allow setting
         rlimit[RLIMIT_RSS]
      -- my patch implements the rss accounting fields so that time -v 
         gives reasonable output


Index: linux-2.4.0/CREDITS
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/CREDITS,v
retrieving revision 1.1.1.5
diff -u -b -u -r1.1.1.5 CREDITS
--- linux-2.4.0/CREDITS	2001/01/04 23:02:54	1.1.1.5
+++ linux-2.4.0/CREDITS	2001/01/08 04:41:41
@@ -491,6 +491,24 @@
 S: Stanford, California 94305
 S: USA
 
+N: Kingsley Cheung
+E: kingsley@aurema.com
+D: Page fault calculation
+D: /proc/<pid>/rss support
+D: kswapd improvements regarding process RSS limits 
+S: Aurema Pty Limited
+S: PO Box 305, Strawberry Hills NSW 2012, 
+S: Australia 
+
+N: Peter Chubb
+E: peterc@aurema.com
+D: Page fault calculation
+D: /proc/<pid>/rss support
+D: kswapd improvements regarding process RSS limits 
+S: Aurema Pty Limited
+S: PO Box 305, Strawberry Hills NSW 2012, 
+S: Australia 
+
 N: Juan Jose Ciarlante
 W: http://juanjox.kernelnotes.org/
 E: jjciarla@raiz.uncu.edu.ar
Index: linux-2.4.0/Documentation/Configure.help
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/Documentation/Configure.help,v
retrieving revision 1.1.1.6
diff -u -b -u -r1.1.1.6 Configure.help
--- linux-2.4.0/Documentation/Configure.help	2001/01/07 21:44:33	1.1.1.6
+++ linux-2.4.0/Documentation/Configure.help	2001/01/08 04:41:41
@@ -16955,6 +16955,50 @@
   another UltraSPARC-IIi-cEngine boardset with a 7-segment display,
   you should say N to this option. 
 
+RSS Softlimits (EXPERIMENTAL)
+CONFIG_RSS_SOFTLIMIT
+  If you want the setrlimit(RLIMIT_RSS, ...) system call to work, say
+  Y either here or for RSS Hardlimits.  If you don't understand this
+  you don't need it, so say N.
+
+  RSS Softlimits will make it more likely that pages will be stolen
+  from processes that have a resident set size (i.e., real memory
+  footprint) greater than their limit.  Processes with a limit set
+  that is below their actual need may still exceed their limits, and
+  in this instance kswapd may work excessively hard.
+
+  Because of the way that RSS is measured and controlled, the limit is
+  approximate only.
+
+  It is harmless to have RSS Softlimits and RSS Hardlimits both set.
+
+RSS Hardlimits (EXPERIMENTAL)
+CONFIG_RSS_HARDLIMIT
+  If you want the setrlimit(RLIMIT_RSS, ...) system call to work, say
+  Y either here or for RSS Softlimits.  If you don't understand this
+  you don't need it, so say N.
+
+  RSS Hardlimits changes the behaviour of the kernel at page-fault
+  time.  If a process is over its RSS limit when it wants to get a new
+  page, then with this configuration option enabled the process's
+  memory space will be reduced before the page-fault continues.
+
+  Because of the way that RSS is measured and controlled, the actual
+  memory footprint of a process may exceed the set limit for a short
+  time.
+
+  It is harmless to have RSS Softlimits and RSS Hardlimits both set.
+
+Support for /proc/pid/rss (EXPERIMENTAL)
+CONFIG_PROC_RSS
+  Saying Y here adds an extra file inside each process directory in the
+  /proc file system that allows measurement and control of resident
+  set size (real memory footprint).  The file format is documented in
+  Documentation/proc_rss.txt
+
+  The main purpose of this file is for testing the results of the RSS
+  Hardlimits or Softlimits configuration options.
+
 IA-64 system type
 CONFIG_IA64_GENERIC
   This selects the system type of your hardware.  A "generic" kernel
Index: linux-2.4.0/arch/alpha/config.in
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/alpha/config.in,v
retrieving revision 1.1.1.5
diff -u -b -u -r1.1.1.5 config.in
--- linux-2.4.0/arch/alpha/config.in	2001/01/04 23:31:47	1.1.1.5
+++ linux-2.4.0/arch/alpha/config.in	2001/01/08 04:41:42
@@ -231,6 +231,10 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+  bool 'RSS Softlimits (EXPERIMENTAL)' CONFIG_RSS_SOFTLIMIT
+  bool 'RSS Hardlimits (EXPERIMENTAL)' CONFIG_RSS_HARDLIMIT
+fi
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    choice 'Kernel core (/proc/kcore) format' \
 	"ELF		CONFIG_KCORE_ELF	\
Index: linux-2.4.0/arch/alpha/kernel/osf_sys.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/alpha/kernel/osf_sys.c,v
retrieving revision 1.1.1.1
diff -u -b -u -r1.1.1.1 osf_sys.c
--- linux-2.4.0/arch/alpha/kernel/osf_sys.c	2000/10/04 00:17:47	1.1.1.1
+++ linux-2.4.0/arch/alpha/kernel/osf_sys.c	2001/01/08 04:41:42
@@ -1164,6 +1164,10 @@
 		r.ru_minflt = current->min_flt;
 		r.ru_majflt = current->maj_flt;
 		r.ru_nswap = current->nswap;
+		r.ru_maxrss =  current->maxrss;
+		r.ru_ixrss = 0;
+		r.ru_idrss = current->irss;
+		r.ru_isrss = 0;
 		break;
 	case RUSAGE_CHILDREN:
 		r.ru_utime.tv_sec = CT_TO_SECS(current->times.tms_cutime);
@@ -1173,6 +1177,10 @@
 		r.ru_minflt = current->cmin_flt;
 		r.ru_majflt = current->cmaj_flt;
 		r.ru_nswap = current->cnswap;
+		r.ru_maxrss = current->cmaxrss;
+		r.ru_ixrss = 0;
+		r.ru_idrss = current->cirss;
+		r.ru_isrss = 0;
 		break;
 	default:
 		r.ru_utime.tv_sec = CT_TO_SECS(current->times.tms_utime +
@@ -1186,6 +1194,10 @@
 		r.ru_minflt = current->min_flt + current->cmin_flt;
 		r.ru_majflt = current->maj_flt + current->cmaj_flt;
 		r.ru_nswap = current->nswap + current->cnswap;
+		r.ru_maxrss = current->maxrss  >  current->cmaxrss ? current->maxrss : current->cmaxrss;
+		r.ru_ixrss = 0;
+		r.ru_idrss = current->irss + current>cirss;
+		r.ru_isrss = 0;
 		break;
 	}
 
Index: linux-2.4.0/arch/arm/config.in
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/arm/config.in,v
retrieving revision 1.1.1.3
diff -u -b -u -r1.1.1.3 config.in
--- linux-2.4.0/arch/arm/config.in	2000/12/13 00:39:26	1.1.1.3
+++ linux-2.4.0/arch/arm/config.in	2001/01/08 04:41:42
@@ -251,6 +251,10 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+  bool 'RSS Softlimits (EXPERIMENTAL)' CONFIG_RSS_SOFTLIMIT
+  bool 'RSS Hardlimits (EXPERIMENTAL)' CONFIG_RSS_HARDLIMIT
+fi
 tristate 'NWFPE math emulation' CONFIG_NWFPE
 choice 'Kernel core (/proc/kcore) format' \
 	"ELF		CONFIG_KCORE_ELF	\
Index: linux-2.4.0/arch/arm/mm/fault-common.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/arm/mm/fault-common.c,v
retrieving revision 1.1.1.2
diff -u -b -u -r1.1.1.2 fault-common.c
--- linux-2.4.0/arch/arm/mm/fault-common.c	2000/12/13 05:19:47	1.1.1.2
+++ linux-2.4.0/arch/arm/mm/fault-common.c	2001/01/08 04:41:42
@@ -100,9 +100,15 @@
 	switch (fault) {
 	case 2:
 		tsk->maj_flt++;
+#if CONFIG_PROC_RSS
+		update_flt_rate(&(tsk->maj_flt_rate), &(tsk->maj_flt_time));
+#endif		
 		return fault;
 	case 1:
 		tsk->min_flt++;
+#if CONFIG_PROC_RSS
+		update_flt_rate(&(tsk->min_flt_rate), &(tsk->min_flt_time));
+#endif		
 	case 0:
 		return fault;
 	}
Index: linux-2.4.0/arch/i386/config.in
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/i386/config.in,v
retrieving revision 1.1.1.5
diff -u -b -u -r1.1.1.5 config.in
--- linux-2.4.0/arch/i386/config.in	2001/01/04 23:31:17	1.1.1.5
+++ linux-2.4.0/arch/i386/config.in	2001/01/08 04:41:42
@@ -226,6 +226,10 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+  bool 'RSS Softlimits (EXPERIMENTAL)' CONFIG_RSS_SOFTLIMIT
+  bool 'RSS Hardlimits (EXPERIMENTAL)' CONFIG_RSS_HARDLIMIT
+fi
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    choice 'Kernel core (/proc/kcore) format' \
 	"ELF		CONFIG_KCORE_ELF	\
Index: linux-2.4.0/arch/i386/mm/fault.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/i386/mm/fault.c,v
retrieving revision 1.1.1.3
diff -u -b -u -r1.1.1.3 fault.c
--- linux-2.4.0/arch/i386/mm/fault.c	2000/12/13 00:20:39	1.1.1.3
+++ linux-2.4.0/arch/i386/mm/fault.c	2001/01/08 04:41:42
@@ -4,6 +4,7 @@
  *  Copyright (C) 1995  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -18,6 +19,10 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 
+#ifdef CONFIG_PROC_RSS
+#include <linux/rss.h>
+#endif
+
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -196,9 +201,15 @@
 	switch (handle_mm_fault(mm, vma, address, write)) {
 	case 1:
 		tsk->min_flt++;
+#if CONFIG_PROC_RSS
+		update_flt_rate(&(tsk->maj_flt_rate), &(tsk->maj_flt_time));
+#endif		
 		break;
 	case 2:
 		tsk->maj_flt++;
+#if CONFIG_PROC_RSS
+		update_flt_rate(&(tsk->min_flt_rate), &(tsk->min_flt_time));
+#endif		
 		break;
 	case 0:
 		goto do_sigbus;
Index: linux-2.4.0/arch/ia64/config.in
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/ia64/config.in,v
retrieving revision 1.1.1.4
diff -u -b -u -r1.1.1.4 config.in
--- linux-2.4.0/arch/ia64/config.in	2001/01/07 21:44:41	1.1.1.4
+++ linux-2.4.0/arch/ia64/config.in	2001/01/08 04:41:42
@@ -93,6 +93,10 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+  bool 'RSS Softlimits (EXPERIMENTAL)' CONFIG_RSS_SOFTLIMIT
+  bool 'RSS Hardlimits (EXPERIMENTAL)' CONFIG_RSS_HARDLIMIT
+fi
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
Index: linux-2.4.0/arch/ia64/ia32/binfmt_elf32.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/ia64/ia32/binfmt_elf32.c,v
retrieving revision 1.1.1.3
diff -u -b -u -r1.1.1.3 binfmt_elf32.c
--- linux-2.4.0/arch/ia64/ia32/binfmt_elf32.c	2001/01/07 21:44:41	1.1.1.3
+++ linux-2.4.0/arch/ia64/ia32/binfmt_elf32.c	2001/01/08 04:41:42
@@ -204,7 +204,8 @@
 
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
 		if (bprm->page[i]) {
-			current->mm->rss++;
+			if (++(current->mm->rss) > current->mm->maxrss)
+				current->mm->maxrss = current->mm->rss;
 			put_dirty_page(current,bprm->page[i],stack_base);
 		}
 		stack_base += PAGE_SIZE;
Index: linux-2.4.0/arch/m68k/config.in
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/m68k/config.in,v
retrieving revision 1.1.1.4
diff -u -b -u -r1.1.1.4 config.in
--- linux-2.4.0/arch/m68k/config.in	2001/01/07 21:44:42	1.1.1.4
+++ linux-2.4.0/arch/m68k/config.in	2001/01/08 04:41:42
@@ -91,6 +91,10 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+  bool 'RSS Softlimits (EXPERIMENTAL)' CONFIG_RSS_SOFTLIMIT
+  bool 'RSS Hardlimits (EXPERIMENTAL)' CONFIG_RSS_HARDLIMIT
+fi
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    choice 'Kernel core (/proc/kcore) format' \
 	"ELF		CONFIG_KCORE_ELF	\
Index: linux-2.4.0/arch/m68k/atari/stram.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/m68k/atari/stram.c,v
retrieving revision 1.1.1.2
diff -u -b -u -r1.1.1.2 stram.c
--- linux-2.4.0/arch/m68k/atari/stram.c	2000/12/13 05:12:51	1.1.1.2
+++ linux-2.4.0/arch/m68k/atari/stram.c	2001/01/08 04:41:43
@@ -642,7 +642,8 @@
 	set_pte(dir, pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	swap_free(entry);
 	get_page(page);
-	++vma->vm_mm->rss;
+	if (++vma->vm_mm->rss > vma->vm_mm->maxrss)
+		vma->vm_mm->maxrss = vma->vm_mm->rss;
 }
 
 static inline void unswap_pmd(struct vm_area_struct * vma, pmd_t *dir,
Index: linux-2.4.0/arch/mips/config.in
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/mips/config.in,v
retrieving revision 1.1.1.2
diff -u -b -u -r1.1.1.2 config.in
--- linux-2.4.0/arch/mips/config.in	2000/12/13 00:26:37	1.1.1.2
+++ linux-2.4.0/arch/mips/config.in	2001/01/08 04:41:43
@@ -168,6 +168,10 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+  bool 'RSS Softlimits (EXPERIMENTAL)' CONFIG_RSS_SOFTLIMIT
+  bool 'RSS Hardlimits (EXPERIMENTAL)' CONFIG_RSS_HARDLIMIT
+fi
 
 source drivers/parport/Config.in
 
Index: linux-2.4.0/arch/mips64/config.in
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/mips64/config.in,v
retrieving revision 1.1.1.3
diff -u -b -u -r1.1.1.3 config.in
--- linux-2.4.0/arch/mips64/config.in	2000/12/13 05:22:46	1.1.1.3
+++ linux-2.4.0/arch/mips64/config.in	2001/01/08 04:41:43
@@ -104,6 +104,10 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+  bool 'RSS Softlimits (EXPERIMENTAL)' CONFIG_RSS_SOFTLIMIT
+  bool 'RSS Hardlimits (EXPERIMENTAL)' CONFIG_RSS_HARDLIMIT
+fi
 tristate 'Kernel support for 64-bit ELF binaries' CONFIG_BINFMT_ELF
 bool 'Kernel support for Linux/MIPS 32-bit binary compatibility' CONFIG_MIPS32_COMPAT
 if [ "$CONFIG_MIPS32_COMPAT" = "y" ]; then
Index: linux-2.4.0/arch/ppc/config.in
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/ppc/config.in,v
retrieving revision 1.1.1.3
diff -u -b -u -r1.1.1.3 config.in
--- linux-2.4.0/arch/ppc/config.in	2000/12/13 00:28:43	1.1.1.3
+++ linux-2.4.0/arch/ppc/config.in	2001/01/08 04:41:43
@@ -118,6 +118,10 @@
 
 bool 'Networking support' CONFIG_NET
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+  bool 'RSS Softlimits (EXPERIMENTAL)' CONFIG_RSS_SOFTLIMIT
+  bool 'RSS Hardlimits (EXPERIMENTAL)' CONFIG_RSS_HARDLIMIT
+fi
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 
Index: linux-2.4.0/arch/s390/config.in
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/s390/config.in,v
retrieving revision 1.1.1.3
diff -u -b -u -r1.1.1.3 config.in
--- linux-2.4.0/arch/s390/config.in	2000/12/13 00:47:02	1.1.1.3
+++ linux-2.4.0/arch/s390/config.in	2001/01/08 04:41:43
@@ -44,6 +44,10 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+  bool 'RSS Softlimits (EXPERIMENTAL)' CONFIG_RSS_SOFTLIMIT
+  bool 'RSS Hardlimits (EXPERIMENTAL)' CONFIG_RSS_HARDLIMIT
+fi
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 
 endmenu
Index: linux-2.4.0/arch/sh/config.in
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/sh/config.in,v
retrieving revision 1.1.1.3
diff -u -b -u -r1.1.1.3 config.in
--- linux-2.4.0/arch/sh/config.in	2001/01/07 21:44:52	1.1.1.3
+++ linux-2.4.0/arch/sh/config.in	2001/01/08 04:41:43
@@ -129,6 +129,10 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+  bool 'RSS Softlimits (EXPERIMENTAL)' CONFIG_RSS_SOFTLIMIT
+  bool 'RSS Hardlimits (EXPERIMENTAL)' CONFIG_RSS_HARDLIMIT
+fi
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    choice 'Kernel core (/proc/kcore) format' \
 	"ELF		CONFIG_KCORE_ELF	\
Index: linux-2.4.0/arch/sparc/config.in
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/sparc/config.in,v
retrieving revision 1.1.1.4
diff -u -b -u -r1.1.1.4 config.in
--- linux-2.4.0/arch/sparc/config.in	2000/12/13 05:04:31	1.1.1.4
+++ linux-2.4.0/arch/sparc/config.in	2001/01/08 04:41:43
@@ -59,6 +59,10 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+  bool 'RSS Softlimits (EXPERIMENTAL)' CONFIG_RSS_SOFTLIMIT
+  bool 'RSS Hardlimits (EXPERIMENTAL)' CONFIG_RSS_HARDLIMIT
+fi
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    define_bool CONFIG_KCORE_ELF y
 fi
Index: linux-2.4.0/arch/sparc64/config.in
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/arch/sparc64/config.in,v
retrieving revision 1.1.1.3
diff -u -b -u -r1.1.1.3 config.in
--- linux-2.4.0/arch/sparc64/config.in	2000/12/13 00:36:42	1.1.1.3
+++ linux-2.4.0/arch/sparc64/config.in	2001/01/08 04:41:43
@@ -51,6 +51,10 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+  bool 'RSS Softlimits (EXPERIMENTAL)' CONFIG_RSS_SOFTLIMIT
+  bool 'RSS Hardlimits (EXPERIMENTAL)' CONFIG_RSS_HARDLIMIT
+fi
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    define_bool CONFIG_KCORE_ELF y
 fi
Index: linux-2.4.0/drivers/acpi/include/acgcc.h
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/drivers/acpi/include/acgcc.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.1
diff -u -b -u -r1.1.1.2 -r1.1.1.1
--- linux-2.4.0/drivers/acpi/include/acgcc.h	2001/01/07 21:44:56	1.1.1.2
+++ linux-2.4.0/drivers/acpi/include/acgcc.h	2001/01/04 23:30:27	1.1.1.1
@@ -1,7 +1,7 @@
 /******************************************************************************
  *
  * Name: acgcc.h - GCC specific defines, etc.
- *       $Revision: 1.1.1.2 $
+ *       $Revision: 1.1.1.1 $
  *
  *****************************************************************************/
 
Index: linux-2.4.0/drivers/acpi/include/aclinux.h
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/drivers/acpi/include/aclinux.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.1
diff -u -b -u -r1.1.1.2 -r1.1.1.1
--- linux-2.4.0/drivers/acpi/include/aclinux.h	2001/01/07 21:44:56	1.1.1.2
+++ linux-2.4.0/drivers/acpi/include/aclinux.h	2001/01/04 23:30:27	1.1.1.1
@@ -1,7 +1,7 @@
 /******************************************************************************
  *
  * Name: aclinux.h - OS specific defines, etc.
- *       $Revision: 1.1.1.2 $
+ *       $Revision: 1.1.1.1 $
  *
  *****************************************************************************/
 
Index: linux-2.4.0/drivers/acpi/include/actbl1.h
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/drivers/acpi/include/actbl1.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.1
diff -u -b -u -r1.1.1.2 -r1.1.1.1
--- linux-2.4.0/drivers/acpi/include/actbl1.h	2001/01/07 21:44:56	1.1.1.2
+++ linux-2.4.0/drivers/acpi/include/actbl1.h	2001/01/04 23:30:27	1.1.1.1
@@ -1,7 +1,7 @@
 /******************************************************************************
  *
  * Name: actbl1.h - ACPI 1.0 tables
- *       $Revision: 1.1.1.2 $
+ *       $Revision: 1.1.1.1 $
  *
  *****************************************************************************/
 
Index: linux-2.4.0/drivers/acpi/include/actbl2.h
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/drivers/acpi/include/actbl2.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.1
diff -u -b -u -r1.1.1.2 -r1.1.1.1
--- linux-2.4.0/drivers/acpi/include/actbl2.h	2001/01/07 21:44:56	1.1.1.2
+++ linux-2.4.0/drivers/acpi/include/actbl2.h	2001/01/04 23:30:27	1.1.1.1
@@ -1,7 +1,7 @@
 /******************************************************************************
  *
  * Name: actbl2.h - ACPI Specification Revision 2.0 Tables
- *       $Revision: 1.1.1.2 $
+ *       $Revision: 1.1.1.1 $
  *
  *****************************************************************************/
 
Index: linux-2.4.0/drivers/acpi/include/actbl71.h
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/drivers/acpi/include/actbl71.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.1
diff -u -b -u -r1.1.1.2 -r1.1.1.1
--- linux-2.4.0/drivers/acpi/include/actbl71.h	2001/01/07 21:44:56	1.1.1.2
+++ linux-2.4.0/drivers/acpi/include/actbl71.h	2001/01/04 23:30:24	1.1.1.1
@@ -3,7 +3,7 @@
  * Name: actbl71.h - IA-64 Extensions to the ACPI Spec Rev. 0.71
  *                   This file includes tables specific to this
  *                   specification revision.
- *       $Revision: 1.1.1.2 $
+ *       $Revision: 1.1.1.1 $
  *
  *****************************************************************************/
 
Index: linux-2.4.0/drivers/acpi/namespace/nsinit.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/drivers/acpi/namespace/nsinit.c,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.1
diff -u -b -u -r1.1.1.2 -r1.1.1.1
--- linux-2.4.0/drivers/acpi/namespace/nsinit.c	2001/01/07 21:44:56	1.1.1.2
+++ linux-2.4.0/drivers/acpi/namespace/nsinit.c	2001/01/04 23:30:33	1.1.1.1
@@ -1,7 +1,7 @@
 /******************************************************************************
  *
  * Module Name: nsinit - namespace initialization
- *              $Revision: 1.1.1.2 $
+ *              $Revision: 1.1.1.1 $
  *
  *****************************************************************************/
 
Index: linux-2.4.0/drivers/acpi/tables/tbconvrt.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/drivers/acpi/tables/tbconvrt.c,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.1
diff -u -b -u -r1.1.1.2 -r1.1.1.1
--- linux-2.4.0/drivers/acpi/tables/tbconvrt.c	2001/01/07 21:44:57	1.1.1.2
+++ linux-2.4.0/drivers/acpi/tables/tbconvrt.c	2001/01/04 23:30:38	1.1.1.1
@@ -1,7 +1,7 @@
 /******************************************************************************
  *
  * Module Name: tbconvrt - ACPI Table conversion utilities
- *              $Revision: 1.1.1.2 $
+ *              $Revision: 1.1.1.1 $
  *
  *****************************************************************************/
 
Index: linux-2.4.0/drivers/acpi/tables/tbxfroot.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/drivers/acpi/tables/tbxfroot.c,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.1
diff -u -b -u -r1.1.1.2 -r1.1.1.1
--- linux-2.4.0/drivers/acpi/tables/tbxfroot.c	2001/01/07 21:44:57	1.1.1.2
+++ linux-2.4.0/drivers/acpi/tables/tbxfroot.c	2001/01/04 23:30:37	1.1.1.1
@@ -1,7 +1,7 @@
 /******************************************************************************
  *
  * Module Name: tbxfroot - Find the root ACPI table (RSDT)
- *              $Revision: 1.1.1.2 $
+ *              $Revision: 1.1.1.1 $
  *
  *****************************************************************************/
 
Index: linux-2.4.0/drivers/scsi/README.osst
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/drivers/scsi/README.osst,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.1
diff -u -b -u -r1.1.1.2 -r1.1.1.1
--- linux-2.4.0/drivers/scsi/README.osst	2001/01/07 21:45:39	1.1.1.2
+++ linux-2.4.0/drivers/scsi/README.osst	2001/01/04 23:22:35	1.1.1.1
@@ -189,7 +189,7 @@
 #!/bin/sh
 # Script to create OnStream SC-x0 device nodes (major 206)
 # Usage: Makedevs.sh [nos [path to dev]]
-# $Id: README.osst,v 1.1.1.2 2001/01/07 21:45:39 peterc Exp $
+# $Id: README.osst,v 1.1.1.1 2001/01/04 23:22:35 peterc Exp $
 major=206
 nrs=4
 dir=/dev
Index: linux-2.4.0/drivers/scsi/osst.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/drivers/scsi/osst.c,v
retrieving revision 1.1.1.2
diff -u -b -u -r1.1.1.2 osst.c
--- linux-2.4.0/drivers/scsi/osst.c	2001/01/07 21:45:39	1.1.1.2
+++ linux-2.4.0/drivers/scsi/osst.c	2001/01/08 04:41:46
@@ -16,14 +16,14 @@
   Copyright 1992 - 2000 Kai Makisara
 		 email Kai.Makisara@metla.fi
 
-  $Header: /wrk/CVSROOT/linux-2.4/drivers/scsi/osst.c,v 1.1.1.2 2001/01/07 21:45:39 peterc Exp $
+  $Header: /wrk/CVSROOT/linux-2.4/drivers/scsi/osst.c,v 1.1.1.1 2001/01/04 23:22:39 peterc Exp $
 
   Microscopic alterations - Rik Ling, 2000/12/21
   Last modified: Wed Feb  2 22:04:05 2000 by makisara@kai.makisara.local
   Some small formal changes - aeb, 950809
 */
 
-static const char * cvsid = "$Id: osst.c,v 1.1.1.2 2001/01/07 21:45:39 peterc Exp $";
+static const char * cvsid = "$Id: osst.c,v 1.1.1.1 2001/01/04 23:22:39 peterc Exp $";
 const char * osst_version = "0.9.4.3";
 
 /* The "failure to reconnect" firmware bug */
Index: linux-2.4.0/drivers/scsi/osst.h
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/drivers/scsi/osst.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.1
diff -u -b -u -r1.1.1.2 -r1.1.1.1
--- linux-2.4.0/drivers/scsi/osst.h	2001/01/07 21:45:39	1.1.1.2
+++ linux-2.4.0/drivers/scsi/osst.h	2001/01/04 23:22:39	1.1.1.1
@@ -1,5 +1,5 @@
 /*
- *	$Header: /wrk/CVSROOT/linux-2.4/drivers/scsi/osst.h,v 1.1.1.2 2001/01/07 21:45:39 peterc Exp $
+ *	$Header: /wrk/CVSROOT/linux-2.4/drivers/scsi/osst.h,v 1.1.1.1 2001/01/04 23:22:39 peterc Exp $
  */
 
 #include <asm/byteorder.h>
Index: linux-2.4.0/drivers/scsi/osst_options.h
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/drivers/scsi/osst_options.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.1
diff -u -b -u -r1.1.1.2 -r1.1.1.1
--- linux-2.4.0/drivers/scsi/osst_options.h	2001/01/07 21:45:39	1.1.1.2
+++ linux-2.4.0/drivers/scsi/osst_options.h	2001/01/04 23:22:39	1.1.1.1
@@ -8,7 +8,7 @@
    Changed (and renamed) for OnStream SCSI drives garloff@suse.de
    2000-06-21
 
-   $Header: /wrk/CVSROOT/linux-2.4/drivers/scsi/osst_options.h,v 1.1.1.2 2001/01/07 21:45:39 peterc Exp $
+   $Header: /wrk/CVSROOT/linux-2.4/drivers/scsi/osst_options.h,v 1.1.1.1 2001/01/04 23:22:39 peterc Exp $
 */
 
 #ifndef _OSST_OPTIONS_H
Index: linux-2.4.0/fs/Config.in
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/fs/Config.in,v
retrieving revision 1.1.1.2
diff -u -b -u -r1.1.1.2 Config.in
--- linux-2.4.0/fs/Config.in	2000/12/12 21:49:13	1.1.1.2
+++ linux-2.4.0/fs/Config.in	2001/01/08 04:41:51
@@ -43,6 +43,10 @@
 
 bool '/proc file system support' CONFIG_PROC_FS
 
+if [ "$CONFIG_PROC_FS" = "y" -a "$CONFIG_EXPERIMENTAL" = "y" ]; then
+  bool 'Support for /proc/pid/rss? (EXPERIMENTAL)' CONFIG_PROC_RSS
+fi
+
 dep_bool '/dev file system support (EXPERIMENTAL)' CONFIG_DEVFS_FS $CONFIG_EXPERIMENTAL
 dep_bool '  Automatically mount at boot' CONFIG_DEVFS_MOUNT $CONFIG_DEVFS_FS
 dep_bool '  Debug devfs' CONFIG_DEVFS_DEBUG $CONFIG_DEVFS_FS
Index: linux-2.4.0/fs/exec.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/fs/exec.c,v
retrieving revision 1.1.1.6
diff -u -b -u -r1.1.1.6 exec.c
--- linux-2.4.0/fs/exec.c	2001/01/07 21:45:49	1.1.1.6
+++ linux-2.4.0/fs/exec.c	2001/01/08 04:41:52
@@ -321,7 +321,8 @@
 		struct page *page = bprm->page[i];
 		if (page) {
 			bprm->page[i] = NULL;
-			current->mm->rss++;
+			if (++current->mm->rss > current->mm->maxrss)
+				current->mm->maxrss = current->mm->rss;
 			put_dirty_page(current,page,stack_base);
 		}
 		stack_base += PAGE_SIZE;
Index: linux-2.4.0/fs/proc/Makefile
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/fs/proc/Makefile,v
retrieving revision 1.1.1.2
diff -u -b -u -r1.1.1.2 Makefile
--- linux-2.4.0/fs/proc/Makefile	2001/01/04 23:03:09	1.1.1.2
+++ linux-2.4.0/fs/proc/Makefile	2001/01/08 04:41:52
@@ -14,8 +14,7 @@
 obj-y    := inode.o root.o base.o generic.o array.o \
 		kmsg.o proc_tty.o proc_misc.o kcore.o procfs_syms.o
 
-ifeq ($(CONFIG_PROC_DEVICETREE),y)
-obj-y += proc_devtree.o
-endif
+obj-$(CONFIG_PROC_DEVICETREE) += proc_devtree.o
+obj-$(CONFIG_PROC_RSS) += rss.o
 
 include $(TOPDIR)/Rules.make
Index: linux-2.4.0/fs/proc/base.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/fs/proc/base.c,v
retrieving revision 1.1.1.3
diff -u -b -u -r1.1.1.3 base.c
--- linux-2.4.0/fs/proc/base.c	2000/12/12 21:49:25	1.1.1.3
+++ linux-2.4.0/fs/proc/base.c	2001/01/08 04:41:52
@@ -11,6 +11,8 @@
  *  go into icache. We cache the reference to task_struct upon lookup too.
  *  Eventually it should become a filesystem in its own. We don't use the
  *  rest of procfs anymore.
+ *
+ *  Added support for /proc/<pid>/rss, 20.01.2000, Kingsley Cheung *
  */
 
 #include <asm/uaccess.h>
@@ -39,6 +41,10 @@
 int proc_pid_status(struct task_struct*,char*);
 int proc_pid_statm(struct task_struct*,char*);
 int proc_pid_cpu(struct task_struct*,char*);
+#ifdef CONFIG_PROC_RSS
+int proc_pid_rss_read(struct task_struct*,char*);
+ssize_t proc_pid_rss_write(struct task_struct*,struct file*,char*,size_t,loff_t*);
+#endif
 
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
@@ -309,6 +315,14 @@
 	read:		proc_info_read,
 };
 
+#ifdef CONFIG_PROC_RSS
+static struct file_operations proc_rss_file_operations = {
+	read:		proc_info_read,
+	write:		proc_pid_rss_write,
+};
+#endif
+
+
 #define MAY_PTRACE(p) \
 (p==current||(p->p_pptr==current&&(p->ptrace & PT_PTRACED)&&p->state==TASK_STOPPED))
 
@@ -495,6 +509,9 @@
 	PROC_PID_STATM,
 	PROC_PID_MAPS,
 	PROC_PID_CPU,
+#ifdef CONFIG_PROC_RSS
+	PROC_PID_RSS,
+#endif /* CONFIG_PROC_RSS */
 	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
 
@@ -514,6 +531,9 @@
   E(PROC_PID_CWD,	"cwd",		S_IFLNK|S_IRWXUGO),
   E(PROC_PID_ROOT,	"root",		S_IFLNK|S_IRWXUGO),
   E(PROC_PID_EXE,	"exe",		S_IFLNK|S_IRWXUGO),
+#ifdef CONFIG_PROC_RSS
+  E(PROC_PID_RSS,	"rss",		S_IFREG|S_IRUGO|S_IWUSR),
+#endif
   {0,0,NULL,0}
 };
 #undef E
@@ -860,6 +880,12 @@
 			inode->i_op = &proc_mem_inode_operations;
 			inode->i_fop = &proc_mem_operations;
 			break;
+#ifdef CONFIG_PROC_RSS
+		case PROC_PID_RSS:
+			inode->i_fop = &proc_info_file_operations;
+			inode->u.proc_i.op.proc_read = proc_pid_rss_read;
+			break;
+#endif
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
Index: linux-2.4.0/include/linux/sched.h
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/include/linux/sched.h,v
retrieving revision 1.1.1.6
diff -u -b -u -r1.1.1.6 sched.h
--- linux-2.4.0/include/linux/sched.h	2001/01/07 21:46:10	1.1.1.6
+++ linux-2.4.0/include/linux/sched.h	2001/01/08 04:41:55
@@ -216,7 +216,9 @@
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
-	unsigned long rss, total_vm, locked_vm;
+	unsigned long rss;
+	unsigned long maxrss, rss_limit;
+	unsigned long total_vm, locked_vm;
 	unsigned long def_flags;
 	unsigned long cpu_vm_mask;
 	unsigned long swap_cnt;	/* number of pages to swap on next pass */
@@ -351,6 +353,14 @@
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 	int swappable:1;
+/* #if CONFIG_PROC_RSS keep same size, but do we remove ifdefs in fork too? */
+/* major and minor page fault rates and time of occurence */
+	unsigned long maj_flt_rate, min_flt_rate;  /* in pages per second */
+	unsigned long maj_flt_time, min_flt_time;  /* in seconds */
+/* #endif */
+/* rss statistics -- maxrss is in the struct mm */
+	unsigned long irss;
+	unsigned long cmaxrss, cirss;
 /* process credentials */
 	uid_t uid,euid,suid,fsuid;
 	gid_t gid,egid,sgid,fsgid;
Index: linux-2.4.0/include/linux/swap.h
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/include/linux/swap.h,v
retrieving revision 1.1.1.4
diff -u -b -u -r1.1.1.4 swap.h
--- linux-2.4.0/include/linux/swap.h	2001/01/04 23:06:01	1.1.1.4
+++ linux-2.4.0/include/linux/swap.h	2001/01/08 04:41:55
@@ -109,6 +109,9 @@
 extern int inactive_shortage(void);
 extern void wakeup_kswapd(int);
 extern int try_to_free_pages(unsigned int gfp_mask);
+#ifdef CONFIG_RSS_HARDLIMIT 
+extern int try_to_swap_out_page(unsigned int gfp_mask);
+#endif
 
 /* linux/mm/page_io.c */
 extern void rw_swap_page(int, struct page *, int);
Index: linux-2.4.0/kernel/exit.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/kernel/exit.c,v
retrieving revision 1.1.1.5
diff -u -b -u -r1.1.1.5 exit.c
--- linux-2.4.0/kernel/exit.c	2001/01/07 21:46:13	1.1.1.5
+++ linux-2.4.0/kernel/exit.c	2001/01/08 04:41:56
@@ -49,6 +49,8 @@
 		current->cmin_flt += p->min_flt + p->cmin_flt;
 		current->cmaj_flt += p->maj_flt + p->cmaj_flt;
 		current->cnswap += p->nswap + p->cnswap;
+		if (p->cmaxrss > current->cmaxrss)
+			current->cmaxrss = p->cmaxrss;
 		/*
 		 * Potentially available timeslices are retrieved
 		 * here - this way the parent does not get penalized
@@ -308,6 +310,14 @@
 		if (mm != tsk->active_mm) BUG();
 		/* more a memory barrier than a real lock */
 		task_lock(tsk);
+		/* 
+		 * can't do this at wait() time, because mm is gone by then.
+		 */
+		if (tsk->p_pptr) {
+			if (mm->maxrss > tsk->p_pptr->cmaxrss)
+				tsk->p_pptr->cmaxrss = mm->maxrss;
+		}
+
 		tsk->mm = NULL;
 		task_unlock(tsk);
 		enter_lazy_tlb(mm, current, smp_processor_id());
Index: linux-2.4.0/kernel/fork.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/kernel/fork.c,v
retrieving revision 1.1.1.5
diff -u -b -u -r1.1.1.5 fork.c
--- linux-2.4.0/kernel/fork.c	2001/01/07 21:46:13	1.1.1.5
+++ linux-2.4.0/kernel/fork.c	2001/01/08 04:41:56
@@ -202,6 +202,7 @@
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
 	init_MUTEX(&mm->mmap_sem);
+	mm->maxrss = mm->rss;
 	mm->page_table_lock = SPIN_LOCK_UNLOCKED;
 	mm->pgd = pgd_alloc();
 	if (mm->pgd)
@@ -284,6 +285,12 @@
 	tsk->min_flt = tsk->maj_flt = 0;
 	tsk->cmin_flt = tsk->cmaj_flt = 0;
 	tsk->nswap = tsk->cnswap = 0;
+	tsk->irss = 0;
+	tsk->cmaxrss = tsk->cirss = 0;
+#if CONFIG_PROC_RSS
+	tsk->maj_flt_time = tsk->min_flt_time = tsk->start_time / HZ;
+	tsk->maj_flt_rate = tsk->min_flt_rate = 0;
+#endif
 
 	tsk->mm = NULL;
 	tsk->active_mm = NULL;
Index: linux-2.4.0/kernel/sys.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/kernel/sys.c,v
retrieving revision 1.1.1.2
diff -u -b -u -r1.1.1.2 sys.c
--- linux-2.4.0/kernel/sys.c	2000/11/25 02:56:24	1.1.1.2
+++ linux-2.4.0/kernel/sys.c	2001/01/08 04:41:56
@@ -1077,6 +1077,10 @@
 			return -EPERM;
 	}
 	*old_rlim = new_rlim;
+
+	if (resource == RLIMIT_RSS && current->mm != &init_mm)
+		current->mm->rss_limit = (new_rlim.rlim_cur == RLIM_INFINITY) ? ULONG_MAX : (new_rlim.rlim_cur >> PAGE_SHIFT);
+
 	return 0;
 }
 
@@ -1111,6 +1115,10 @@
 			r.ru_minflt = p->min_flt;
 			r.ru_majflt = p->maj_flt;
 			r.ru_nswap = p->nswap;
+			r.ru_maxrss = p->mm->maxrss;
+			r.ru_ixrss = 0;
+			r.ru_idrss = p->irss;
+			r.ru_isrss = 0;
 			break;
 		case RUSAGE_CHILDREN:
 			r.ru_utime.tv_sec = CT_TO_SECS(p->times.tms_cutime);
@@ -1120,6 +1128,10 @@
 			r.ru_minflt = p->cmin_flt;
 			r.ru_majflt = p->cmaj_flt;
 			r.ru_nswap = p->cnswap;
+			r.ru_maxrss = p->cmaxrss;
+			r.ru_ixrss = 0;
+			r.ru_idrss = p->cirss;
+			r.ru_isrss = 0;
 			break;
 		default:
 			r.ru_utime.tv_sec = CT_TO_SECS(p->times.tms_utime + p->times.tms_cutime);
@@ -1129,6 +1141,10 @@
 			r.ru_minflt = p->min_flt + p->cmin_flt;
 			r.ru_majflt = p->maj_flt + p->cmaj_flt;
 			r.ru_nswap = p->nswap + p->cnswap;
+			r.ru_maxrss = p->mm->maxrss  >  p->cmaxrss ? p->mm->maxrss : p->cmaxrss;
+			r.ru_ixrss = 0;
+			r.ru_idrss = p->irss + p->cirss;
+			r.ru_isrss = 0;
 			break;
 	}
 	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
Index: linux-2.4.0/kernel/timer.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/kernel/timer.c,v
retrieving revision 1.1.1.3
diff -u -b -u -r1.1.1.3 timer.c
--- linux-2.4.0/kernel/timer.c	2000/12/13 02:41:08	1.1.1.3
+++ linux-2.4.0/kernel/timer.c	2001/01/08 04:41:56
@@ -567,6 +567,9 @@
 {
 	p->per_cpu_utime[cpu] += user;
 	p->per_cpu_stime[cpu] += system;
+	if (p->mm)
+		p->irss += p->mm->rss;
+	
 	do_process_times(p, user, system);
 	do_it_virt(p, user);
 	do_it_prof(p);
Index: linux-2.4.0/mm/filemap.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/mm/filemap.c,v
retrieving revision 1.1.1.6
diff -u -b -u -r1.1.1.6 filemap.c
--- linux-2.4.0/mm/filemap.c	2001/01/07 21:46:13	1.1.1.6
+++ linux-2.4.0/mm/filemap.c	2001/01/08 04:41:57
@@ -1967,8 +1967,12 @@
 
 	/* Make sure this doesn't exceed the process's max rss. */
 	error = -EIO;
+#if defined(CONFIG_RSS_HARDLIMIT) || defined(CONFIG_RSS_SOFTLIMIT)
+	rlim_rss = vma->vm_mm->rss_limit;
+#else
 	rlim_rss = current->rlim ?  current->rlim[RLIMIT_RSS].rlim_cur :
 				LONG_MAX; /* default: see resource.h */
+#endif
 	if ((vma->vm_mm->rss + (end - start)) > rlim_rss)
 		return error;
 
Index: linux-2.4.0/mm/memory.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/mm/memory.c,v
retrieving revision 1.1.1.6
diff -u -b -u -r1.1.1.6 memory.c
--- linux-2.4.0/mm/memory.c	2001/01/07 21:46:13	1.1.1.6
+++ linux-2.4.0/mm/memory.c	2001/01/08 04:41:57
@@ -872,7 +872,8 @@
 	 */
 	if (pte_same(*page_table, pte)) {
 		if (PageReserved(old_page))
-			++mm->rss;
+			if (++mm->rss > mm->maxrss)
+				mm->maxrss = mm->rss;
 		break_cow(vma, old_page, new_page, address, page_table);
 
 		/* Free the old page.. */
@@ -1019,9 +1020,15 @@
 	struct vm_area_struct * vma, unsigned long address,
 	pte_t * page_table, swp_entry_t entry, int write_access)
 {
-	struct page *page = lookup_swap_cache(entry);
+	struct page *page;
 	pte_t pte;
 
+#ifdef CONFIG_RSS_HARDLIMIT
+	if (mm->rss >= mm->rss_limit)
+		try_to_shrink_rss(mm, GFP_USER);
+#endif
+
+	page = lookup_swap_cache(entry);
 	if (!page) {
 		lock_kernel();
 		swapin_readahead(entry);
@@ -1034,7 +1041,8 @@
 		flush_icache_page(vma, page);
 	}
 
-	mm->rss++;
+	if (++mm->rss > mm->maxrss)
+		mm->maxrss = mm->rss;
 
 	pte = mk_pte(page, vma->vm_page_prot);
 
@@ -1062,13 +1070,18 @@
 {
 	struct page *page = NULL;
 	pte_t entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
+#ifdef CONFIG_RSS_HARDLIMIT
+	if (mm->rss > mm->rss_limit)
+		try_to_shrink_rss(mm, GFP_USER);
+#endif
 	if (write_access) {
 		page = alloc_page(GFP_HIGHUSER);
 		if (!page)
 			return -1;
 		clear_user_highpage(page, addr);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
-		mm->rss++;
+		if (++mm->rss > mm->maxrss)
+			mm->maxrss = mm->rss;
 		flush_page_to_ram(page);
 	}
 	set_pte(page_table, entry);
@@ -1107,7 +1120,8 @@
 		return 0;
 	if (new_page == NOPAGE_OOM)
 		return -1;
-	++mm->rss;
+	if (++mm->rss > mm->maxrss)
+		mm->maxrss = mm->rss;
 	/*
 	 * This silly early PAGE_DIRTY setting removes a race
 	 * due to the bad i386 page protection. But it's valid
Index: linux-2.4.0/mm/swapfile.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/mm/swapfile.c,v
retrieving revision 1.1.1.3
diff -u -b -u -r1.1.1.3 swapfile.c
--- linux-2.4.0/mm/swapfile.c	2001/01/04 23:05:35	1.1.1.3
+++ linux-2.4.0/mm/swapfile.c	2001/01/08 04:41:58
@@ -231,7 +231,8 @@
 	set_pte(dir, pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 	swap_free(entry);
 	get_page(page);
-	++vma->vm_mm->rss;
+	if (++vma->vm_mm->rss > vma->vm_mm->maxrss)
+		vma->vm_mm->maxrss = vma->vm_mm->rss;
 }
 
 static inline void unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
Index: linux-2.4.0/mm/vmscan.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/mm/vmscan.c,v
retrieving revision 1.1.1.6
diff -u -b -u -r1.1.1.6 vmscan.c
--- linux-2.4.0/mm/vmscan.c	2001/01/07 21:46:13	1.1.1.6
+++ linux-2.4.0/mm/vmscan.c	2001/01/08 04:41:58
@@ -294,6 +294,96 @@
 	return result;
 }
 
+#if CONFIG_RSS_SOFTLIMIT
+int krssd(void *unused)
+{
+	struct task_struct *tsk = current;
+#define MAX_NPROCS 10
+	pid_t procs[MAX_NPROCS];
+	struct task_struct *p, *oldp;
+	unsigned long rss;
+	int nprocs, i;
+	
+	nprocs = 0;
+	(void)unused;
+
+	
+	tsk->session = 1;
+	tsk->pgrp = 1;
+	strcpy(tsk->comm, "krssd");
+	sigfillset(&tsk->blocked);
+
+	printk("Starting krssd\n");
+
+	for (;;) {
+		
+		/*
+		 * Try not to wake up at the same time every second.
+		 */
+		tsk->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(HZ + 3);
+
+		/*
+		 * Find up to MAX_NPROCS processes that exceed their RSS
+		 * limit and attempt to shrink them.
+		 * Save the PIDs of any over-limit processes in an array,
+		 * so that swap_out_mm can sleep (processes can 
+		 * die while we're asleep)
+		 * Using PIDS rather than proc_t pointers also 
+		 * reduces the time holding tasklist_lock. 
+		 */
+		read_lock(&tasklist_lock);
+
+		/* select next processes to scan */
+		oldp = NULL;
+		while (nprocs && !(oldp = find_task_by_pid(procs[--nprocs])))
+			;
+
+		/* select init if no process found */
+		if (!oldp)
+			oldp = &init_task;	
+
+		/* choose at most next MAX_NPROCS */
+		nprocs = 0; p = oldp;
+		while ((p = p->next_task) != oldp && nprocs < MAX_NPROCS)
+			if (p != &init_task && p->swappable && p->mm &&
+			    p->mm->rss > p->mm->rss_limit)
+				procs[nprocs++] = p->pid;
+		read_unlock(&tasklist_lock);
+
+		/* Attempt to shrink RSS till under limit  */
+		for (i = 0; i < nprocs; i ++) {
+			struct mm_struct *mm;
+			read_lock(&tasklist_lock);
+			p = find_task_by_pid(procs[i]);
+			if (p && (mm = p->mm))
+				atomic_inc(&mm->mm_count);
+			read_unlock(&tasklist_lock);
+
+			if (!p)
+				continue;
+
+			/*
+			 * If pages are freed from the process but
+			 * are still in use elsewhere,
+			 * swap_out_process may return 0
+			 * but still shrink rss.
+			 * Keep calling it until it cannot do any more work,
+			 * or the limit is no longer exceeded.
+			 * TODO: think about hysteresis --- track 
+			 * persistent offenders and reduce RSS even further
+			 */
+			while ((rss = mm->rss) > mm->rss_limit && 
+			    (swap_out_mm(mm, GFP_KSWAPD) || 
+				rss != mm->rss))
+				;
+			mmdrop(mm);
+		}
+	}
+}
+
+#endif /* CONFIG_RSS_SOFTLIMIT */
+
 /*
  * Select the task with maximal swap_cnt and try to swap out a page.
  * N.B. This function returns only 0 or 1.  Return values != 1 from
@@ -1149,7 +1239,17 @@
 	swap_setup();
 	kernel_thread(kswapd, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
 	kernel_thread(kreclaimd, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+#ifdef CONFIG_RSS_SOFTLIMIT
+	kernel_thread(krssd, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+#endif
 	return 0;
 }
+
+#ifdef CONFIG_RSS_HARDLIMIT
+void try_to_shrink_rss(struct mm_struct *mm, int gfp_mask)
+{
+	swap_out_mm(mm, gfp_mask);
+}
+#endif
 
 module_init(kswapd_init)
Index: linux-2.4.0/fs/proc/rss.c
===================================================================
RCS file: /wrk/CVSROOT/linux-2.4/fs/proc/rss.c
retrieving revision 1.1
diff -u -b -u -r1.1 rss.c
--- /dev/null	Wed May  6 06:32:27 1998
+++ linux-2.4.0/fs/proc/rss.c	Mon Jan  8 15:31:22 2001
@@ -0,0 +1,239 @@
+/* fs/proc/rss.c 
+ *
+ * 15 March 2000, Kingsley Cheung 
+ * Support added for page fault calculation and /proc/pid/rss. 
+ */
+#include <linux/ctype.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/resource.h>
+#include <linux/rss.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/uaccess.h>
+
+
+/* 
+ * Below is a table of constants for ((k-1)/k)^n = (4/5)^n, where k is
+ * 5 seconds, n is [0..34] seconds. For n >= 35, (4/5)^n = 0.0
+ * These constants are scaled by 1000, as are the page fault
+ * rates displayed in /proc/<pid>/rss.  
+ */
+
+unsigned long mov_ave_table[MOV_AVE_TABLE_SIZE] = 
+{ 1000, 800, 640, 512, 410, 328, 262, 210, 168, 134, 107, 86, 
+  69, 55, 44, 35, 28, 23, 18, 14, 12, 9, 7, 6, 5, 4, 
+  3, 2, 2, 2, 1, 1, 1, 1, 1 };
+
+
+
+
+/* Support for /proc/<pid>/rss 
+ *
+ * pid_rss_read can integrated into array_read in fs/proc/array.c, but
+ * since we are required to support writing, we have a different set
+ * of file operations.  
+ *
+ * The data listed is the following:
+ *	- current RSS limit 
+ *	- maximum RSS limit
+ *	- RSS
+ *	- major fault rate
+ *	- minor fault rate
+ *
+ * Reading /proc/<pid>/rss is allowed only once through an open
+ * descriptor. To obtain more recent data, the file must be 
+ * closed and opened again. The file is readable by all everyone. 
+ */
+
+int proc_pid_rss_read(struct task_struct *tsk, char *buf)
+{
+	int count;
+	task_lock(tsk);
+
+	/* recalculate page fault rates due to decay */
+	decay_flt_rate(&(tsk->maj_flt_rate), &(tsk->maj_flt_time));
+	decay_flt_rate(&(tsk->min_flt_rate), &(tsk->min_flt_time)); 
+		
+	count = sprintf(buf,
+	    "%ld %ld %lu %lu %lu\n",
+	    tsk->rlim[RLIMIT_RSS].rlim_cur >> PAGE_SHIFT,
+	    tsk->rlim[RLIMIT_RSS].rlim_max >> PAGE_SHIFT,
+	    tsk->mm ? tsk->mm->rss : 0,
+	    tsk->maj_flt_rate,
+	    tsk->min_flt_rate);
+
+	task_unlock(tsk);
+	return count;
+}
+
+
+
+#define skip_space(buffer)                   \
+do {                                         \
+    while (*(buffer) && isspace(*(buffer)))  \
+      (buffer)++;                            \
+} while(0)
+
+
+static int get_unsigned_numbers(const char *buf, unsigned long *numbers, int count)
+/* Pre:  'numbers' is array of longs of length 'count'
+ * Post:  returns number of integers read and sets values in numbers
+ *        returns -1 whenever non-digit or white-space encountered
+ */	       
+{
+	char *p; int i, neg;
+
+	/* loop and get integers, assuming all are in the buffer */
+	for (p = (char *) buf, i = 0; i < count && *p; i++) {
+		/* skip whitespace */
+		skip_space(p);
+		if (!(*p))
+			break;
+		
+		/* test for negative values */
+		neg = 0;
+		if (*p == '-' && isdigit(*(p+1))) {
+			neg = 1; p++;
+		}
+		
+		/* convert number */
+		numbers[i] = simple_strtoul(p, &p, 0);
+		if (neg)
+			numbers[i] = - numbers[i];
+
+		if (*p && !isspace(*p))
+			return -1;
+	}
+	
+	/* ensure remaining numbers are non-white space */
+	skip_space(p);
+	if (*p)
+		return -1;
+
+	return i;
+}
+
+
+#define bad_rss_limit(new_limit) \
+((new_limit) < 0 || (new_limit) > RLIM_INFINITY)
+
+#define getnextline(buf)    \
+({                          \
+        while (*(buf))      \
+                (buf)++;    \
+        (buf)++;            \
+})
+
+
+/*
+ * Only the user has write permission to proc/<pid>/rss. The contents
+ * that may be written to it specify the current and maximum RSS limits 
+ * the user wishes to set for that process. The contents written to the
+ * pseudo file must adhere to the following:
+ *
+ *	1. There can be at most two numbers per line: the new current
+ *	   RSS limit followed by whitespace and the new maximum RSS
+ *	   limit.
+ *
+ *      2. Whenever one number is specified on a line, the number is 
+ *         interpreted as the new current RSS limit.
+ * 
+ *      3. The current RSS limit must never exceed the maximum RSS
+ *         limit.
+ *
+ *	4. The maximum RSS limit cannot be increased except by
+ *	   processes with system resource capabilities.
+ *
+ *      5. The limits must lie between the range 0 and 
+ *         RLIM_INFINITY / PAGE_SIZE inclusive.
+ *
+ * Violation of these rules will produce invalid or write permission
+ * errors. Attempts to write to /proc/<pid>/rss for non-existent
+ * processes will produce an I/O error.
+ *
+ * Writing to /proc/<pid>/rss can continue forever through an open
+ * descriptor as long as one abides by the rules stated above.
+ * Currently, ppos is not used to limit the number of characters
+ * written.  
+ */
+
+ssize_t proc_pid_rss_write(struct task_struct *tsk, struct file *file, const char *buf, size_t count, loff_t *ppos)
+{
+	struct rlimit new_rss;
+	unsigned long numbers[2];
+	
+	char *page, *p; 
+	int res, ret;
+	
+	/* buffer to write to */   
+	if (!(page = (char * ) __get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+	
+	/* read user buffer up to one page only */
+	if (count > PAGE_SIZE - 1)
+		count = PAGE_SIZE - 1;
+
+	ret = count;
+
+	if (copy_from_user(page, buf, count))
+		return -EFAULT;
+
+	page[count] = 0;
+	for (p = page; *p; p++)
+		if (*p == '\n')
+			*p = 0;
+	
+	/* obtain process current rss limits */
+	new_rss = tsk->rlim[RLIMIT_RSS];
+
+	/* for each line, read at most two integers */
+	for (p = page; p - page < count; getnextline(p)) {
+		/* read numbers from the line */
+		if ((res = get_unsigned_numbers(p, numbers, 2)) < 0) {
+			ret = -EINVAL; 
+			goto pid_rss_end;
+		}
+
+		/* if numbers where read from the line */
+		if (res) {
+			/* assign values of new limits */
+			new_rss.rlim_cur = numbers[0] * PAGE_SIZE;
+			if (res == 2)
+				new_rss.rlim_max = numbers[1] * PAGE_SIZE;
+			
+			/* ensure rss limits within defined range */
+			if (bad_rss_limit(new_rss.rlim_cur) || 
+			    bad_rss_limit(new_rss.rlim_max) ||
+			    new_rss.rlim_cur > new_rss.rlim_max) {
+				ret = -EINVAL; 
+				goto pid_rss_end;
+			} 
+			
+			if (new_rss.rlim_max > tsk->rlim[RLIMIT_RSS].rlim_max
+			    && !capable(CAP_SYS_RESOURCE)) {
+				ret = -EPERM; 
+				goto pid_rss_end;
+			}
+			
+			tsk->rlim[RLIMIT_RSS] = new_rss;
+			if (new_rss.rlim_cur == RLIM_INFINITY)
+				tsk->mm->rss_limit = ULONG_MAX;
+			else
+				tsk->mm->rss_limit = new_rss.rlim_cur >> PAGE_SHIFT;
+		}
+	}
+	
+	*ppos += ret;	
+	file->f_pos += ret;
+	
+pid_rss_end:
+	free_page((unsigned long) page);  
+	
+	return ret;
+}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
