Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVDAUrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVDAUrb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVDAUrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:47:31 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:25744 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262878AbVDAUqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:46:30 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [stable] [patch 3/8] uml: quick fix syscall table [urgent]
Date: Fri, 1 Apr 2005 22:45:43 +0200
User-Agent: KMail/1.7.2
Cc: Greg KH <greg@kroah.com>, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org, linux-kernel@vger.kernel.org
References: <20050330173348.63741EFE76@zion> <20050330190509.GA17602@kroah.com>
In-Reply-To: <20050330190509.GA17602@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4LbTC/v2S9AOIft"
Message-Id: <200504012245.44468.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_4LbTC/v2S9AOIft
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 30 March 2005 21:05, Greg KH wrote:
> On Wed, Mar 30, 2005 at 07:33:48PM +0200, blaisorblade@yahoo.it wrote:
> > CC: <stable@kernel.org>
> >
> > *) Uml 2.6.11 does not compile with gcc 2.95.4 because some entries are
> > duplicated, and that GCC does not accept this (unlike gcc 3). Plus
> > various other bugs in the syscall table definitions:
> >
> >   *) 223 is a syscall hole (i.e. ni_syscall) only on i386, on x86_64 it's
> > a valid syscall (thus a duplicated one).
> >
> >   *) __NR_vserver must be only once with sys_ni_syscall, and not multiple
> >   times with different values!
> >
> >   *) syscalls duplicated in SUBARCHs and in common files (thus assigning
> > twice to the same array entry and causing the GCC 2.95.4 failure
> > mentioned above): sys_utimes, which is common, and sys_fadvise64_64,
> > sys_statfs64, sys_fstatfs64, which exist only on i386.
> >
> >   *) syscalls duplicated in each SUBARCH, to put in common files:
> >   sys_remap_file_pages, sys_utimes, sys_fadvise64
> >
> >   *) 285 is a syscall hole (i.e. ni_syscall) only on i386, on x86_64 the
> > range does not arrive to that point.
> >
> >   *) on x86_64, the macro name is __NR_kexec_load and not
> > __NR_sys_kexec_load. Use the correct name in either case.
> >
> > Note: as you can see, part of the syscall table definition in UML is
> > arch-independent (with everywhere defined syscalls), and part is
> > arch-dependant. This has created confusion (some syscalls are listed in
> > both places, some in the wrong one, some are wrong on one arch or
> > another).
> >
> > Also, as add-ons:
> >
> > *) uses __va_copy instead of va_copy since some old versions of gcc
> > (2.95.4 for instance) don't accept va_copy.
> >
> > *) some whitespace cleanups in the syscall table (if you don't like them,
> > feel free to remove them).
>
> For this to be considered for the -stable tree, can you remove the
> whitespace cleanups,
Ok, done
> and break this up into different patches for the 
> different things you are doing (one thing per patch please.)
I've splitout the va_copy fix in a separate patch, which I just sent. It's 
trivial and can go in now, I guess.

For the changes to the syscall table, (i.e. the rest of the patch) I could 
split them if you really need, but I fear that while splitting the patch into 
half a dozen of separate patches, I can introduce new bugs.

I've attached this part so you can judge yourself.

Bye and thanks.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_4LbTC/v2S9AOIft
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-quick-fix-syscall-table-for-stable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="uml-quick-fix-syscall-table-for-stable.patch"


CC: <stable@kernel.org>

*) Uml 2.6.11 does not compile with gcc 2.95.4 because some entries are
duplicated, and that GCC does not accept this (unlike gcc 3). Plus various
other bugs in the syscall table definitions:

  *) 223 is a syscall hole (i.e. ni_syscall) only on i386, on x86_64 it's a
  valid syscall (thus a duplicated one).

  *) __NR_vserver must be only once with sys_ni_syscall, and not multiple
  times with different values!

  *) syscalls duplicated in SUBARCHs and in common files (thus assigning twice
  to the same array entry and causing the GCC 2.95.4 failure mentioned above):
  sys_utimes, which is common, and sys_fadvise64_64, sys_statfs64,
  sys_fstatfs64, which exist only on i386.

  *) syscalls duplicated in each SUBARCH, to put in common files:
  sys_remap_file_pages, sys_utimes, sys_fadvise64

  *) 285 is a syscall hole (i.e. ni_syscall) only on i386, on x86_64 the range
  does not arrive to that point.

  *) on x86_64, the macro name is __NR_kexec_load and not __NR_sys_kexec_load.
  Use the correct name in either case.

Note: as you can see, part of the syscall table definition in UML is
arch-independent (with everywhere defined syscalls), and part is
arch-dependant. This has created confusion (some syscalls are listed in both
places, some in the wrong one, some are wrong on one arch or another).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 clean-linux-2.6.11-paolo/arch/um/include/sysdep-i386/syscalls.h   |   12 +++++-----
 clean-linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/syscalls.h |    5 ----
 clean-linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c          |   11 +++------
 3 files changed, 10 insertions(+), 18 deletions(-)

diff -puN arch/um/include/sysdep-i386/syscalls.h~uml-quick-fix-syscall-table-for-stable arch/um/include/sysdep-i386/syscalls.h
--- clean-linux-2.6.11/arch/um/include/sysdep-i386/syscalls.h~uml-quick-fix-syscall-table-for-stable	2005-04-01 22:40:17.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/include/sysdep-i386/syscalls.h	2005-04-01 22:40:17.000000000 +0200
@@ -23,6 +23,9 @@ extern long sys_mmap2(unsigned long addr
 		      unsigned long prot, unsigned long flags,
 		      unsigned long fd, unsigned long pgoff);
 
+/* On i386 they choose a meaningless naming.*/
+#define __NR_kexec_load __NR_sys_kexec_load
+
 #define ARCH_SYSCALLS \
 	[ __NR_waitpid ] = (syscall_handler_t *) sys_waitpid, \
 	[ __NR_break ] = (syscall_handler_t *) sys_ni_syscall, \
@@ -101,15 +104,12 @@ extern long sys_mmap2(unsigned long addr
 	[ 223 ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ __NR_set_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ __NR_get_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64, \
 	[ 251 ] = (syscall_handler_t *) sys_ni_syscall, \
-        [ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages, \
-	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes, \
-	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall,
-        
+	[ 285 ] = (syscall_handler_t *) sys_ni_syscall,
+
 /* 222 doesn't yet have a name in include/asm-i386/unistd.h */
 
-#define LAST_ARCH_SYSCALL __NR_vserver
+#define LAST_ARCH_SYSCALL 285
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN arch/um/include/sysdep-x86_64/syscalls.h~uml-quick-fix-syscall-table-for-stable arch/um/include/sysdep-x86_64/syscalls.h
--- clean-linux-2.6.11/arch/um/include/sysdep-x86_64/syscalls.h~uml-quick-fix-syscall-table-for-stable	2005-04-01 22:40:17.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/syscalls.h	2005-04-01 22:40:17.000000000 +0200
@@ -71,12 +71,7 @@ extern syscall_handler_t sys_arch_prctl;
 	[ __NR_iopl ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ __NR_set_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ __NR_get_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
-        [ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages, \
 	[ __NR_semtimedop ] = (syscall_handler_t *) sys_semtimedop, \
-	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64, \
-	[ 223 ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes, \
-	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ 251 ] = (syscall_handler_t *) sys_ni_syscall,
 
 #define LAST_ARCH_SYSCALL 251
diff -puN arch/um/kernel/sys_call_table.c~uml-quick-fix-syscall-table-for-stable arch/um/kernel/sys_call_table.c
--- clean-linux-2.6.11/arch/um/kernel/sys_call_table.c~uml-quick-fix-syscall-table-for-stable	2005-04-01 22:40:17.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/kernel/sys_call_table.c	2005-04-01 22:40:17.000000000 +0200
@@ -48,7 +48,6 @@ extern syscall_handler_t sys_vfork;
 extern syscall_handler_t old_select;
 extern syscall_handler_t sys_modify_ldt;
 extern syscall_handler_t sys_rt_sigsuspend;
-extern syscall_handler_t sys_vserver;
 extern syscall_handler_t sys_mbind;
 extern syscall_handler_t sys_get_mempolicy;
 extern syscall_handler_t sys_set_mempolicy;
@@ -242,6 +241,7 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_epoll_create ] = (syscall_handler_t *) sys_epoll_create,
 	[ __NR_epoll_ctl ] = (syscall_handler_t *) sys_epoll_ctl,
 	[ __NR_epoll_wait ] = (syscall_handler_t *) sys_epoll_wait,
+	[ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages,
         [ __NR_set_tid_address ] = (syscall_handler_t *) sys_set_tid_address,
 	[ __NR_timer_create ] = (syscall_handler_t *) sys_timer_create,
 	[ __NR_timer_settime ] = (syscall_handler_t *) sys_timer_settime,
@@ -252,12 +252,10 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_clock_gettime ] = (syscall_handler_t *) sys_clock_gettime,
 	[ __NR_clock_getres ] = (syscall_handler_t *) sys_clock_getres,
 	[ __NR_clock_nanosleep ] = (syscall_handler_t *) sys_clock_nanosleep,
-	[ __NR_statfs64 ] = (syscall_handler_t *) sys_statfs64,
-	[ __NR_fstatfs64 ] = (syscall_handler_t *) sys_fstatfs64,
 	[ __NR_tgkill ] = (syscall_handler_t *) sys_tgkill,
 	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes,
-	[ __NR_fadvise64_64 ] = (syscall_handler_t *) sys_fadvise64_64,
-	[ __NR_vserver ] = (syscall_handler_t *) sys_vserver,
+	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64,
+	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_mbind ] = (syscall_handler_t *) sys_mbind,
 	[ __NR_get_mempolicy ] = (syscall_handler_t *) sys_get_mempolicy,
 	[ __NR_set_mempolicy ] = (syscall_handler_t *) sys_set_mempolicy,
@@ -267,9 +265,8 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
 	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
 	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
-	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
+	[ __NR_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
-	[ 285 ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
 	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
 	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
_

--Boundary-00=_4LbTC/v2S9AOIft--

