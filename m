Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbUKJTI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUKJTI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUKJTI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:08:58 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:57506
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262100AbUKJTIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:08:46 -0500
Subject: [patch 1/1] uml: use sys_getpid bypassing glibc (fixes UML on Gentoo)
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       user-mode-linux-user@lists.sourceforge.net, blaisorblade_spam@yahoo.it,
       bstroesser@fujitsu-siemens.com, drepper@redhat.com
From: blaisorblade_spam@yahoo.it
Date: Wed, 10 Nov 2004 18:59:06 +0100
Message-Id: <20041110175907.AD85EA1FA@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Cc: Ulrich Drepper <drepper@redhat.com>

Using NPTL, getpid() sometimes delivers the wrong pid, since it uses the one
buffered in TLS from previous calls.  This buffered pid isn't discarded, when
a child is created by a clone().

So, as a workaround, UML should use a direct kernel call to bypass the lib.

Also, I (Paolo) went replacing all remaining calls of getpid() with
os_getpid(), to make sure they use the syscall and not the normal glibc
definition.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/kernel/frame.c        |    8 ++++----
 linux-2.6.10-rc-paolo/arch/um/kernel/main.c         |    3 ++-
 linux-2.6.10-rc-paolo/arch/um/kernel/skas/process.c |    2 +-
 linux-2.6.10-rc-paolo/arch/um/os-Linux/process.c    |    4 ++++
 4 files changed, 11 insertions(+), 6 deletions(-)

diff -puN arch/um/os-Linux/process.c~uml-use-sys-getpid-bypassing-glibc arch/um/os-Linux/process.c
--- linux-2.6.10-rc/arch/um/os-Linux/process.c~uml-use-sys-getpid-bypassing-glibc	2004-11-10 18:24:10.000000000 +0100
+++ linux-2.6.10-rc-paolo/arch/um/os-Linux/process.c	2004-11-10 18:24:10.000000000 +0100
@@ -107,6 +107,10 @@ void os_usr1_process(int pid)
 	kill(pid, SIGUSR1);
 }
 
+/*Don't use the glibc version, which caches the result in TLS. It misses some
+ * syscalls, and also breaks with clone(), which does not unshare the TLS.*/
+inline _syscall0(pid_t, getpid)
+
 int os_getpid(void)
 {
 	return(getpid());
diff -puN arch/um/kernel/skas/process.c~uml-use-sys-getpid-bypassing-glibc arch/um/kernel/skas/process.c
--- linux-2.6.10-rc/arch/um/kernel/skas/process.c~uml-use-sys-getpid-bypassing-glibc	2004-11-10 18:45:59.529650720 +0100
+++ linux-2.6.10-rc-paolo/arch/um/kernel/skas/process.c	2004-11-10 18:46:52.166648680 +0100
@@ -30,7 +30,7 @@
 
 int is_skas_winch(int pid, int fd, void *data)
 {
-	if(pid != getpid())
+	if(pid != os_getpid())
 		return(0);
 
 	register_winch_irq(-1, fd, -1, data);
diff -puN arch/um/kernel/frame.c~uml-use-sys-getpid-bypassing-glibc arch/um/kernel/frame.c
--- linux-2.6.10-rc/arch/um/kernel/frame.c~uml-use-sys-getpid-bypassing-glibc	2004-11-10 18:45:59.564645400 +0100
+++ linux-2.6.10-rc-paolo/arch/um/kernel/frame.c	2004-11-10 18:46:52.168648376 +0100
@@ -140,7 +140,7 @@ static void child_common(struct common_r
 	}
 	if(sigaltstack(&ss, NULL) < 0){
 		printf("sigaltstack failed - errno = %d\n", errno);
-		kill(getpid(), SIGKILL);
+		kill(os_getpid(), SIGKILL);
 	}
 
 	if(restorer){
@@ -162,7 +162,7 @@ static void child_common(struct common_r
 	
 	if(err < 0){
 		printf("sigaction failed - errno = %d\n", errno);
-		kill(getpid(), SIGKILL);
+		kill(os_getpid(), SIGKILL);
 	}
 
 	os_stop_process(os_getpid());
@@ -191,7 +191,7 @@ static void sc_handler(int sig, struct s
 	setup_arch_frame_raw(&raw_sc->common.arch, &sc + 1, raw_sc->common.sr);
 
 	os_stop_process(os_getpid());
-	kill(getpid(), SIGKILL);
+	kill(os_getpid(), SIGKILL);
 }
 
 static int sc_child(void *arg)
@@ -229,7 +229,7 @@ static void si_handler(int sig, siginfo_
 			     ucontext->uc_mcontext.fpregs, raw_si->common.sr);
 	
 	os_stop_process(os_getpid());
-	kill(getpid(), SIGKILL);
+	kill(os_getpid(), SIGKILL);
 }
 
 static int si_child(void *arg)
diff -puN arch/um/kernel/main.c~uml-use-sys-getpid-bypassing-glibc arch/um/kernel/main.c
--- linux-2.6.10-rc/arch/um/kernel/main.c~uml-use-sys-getpid-bypassing-glibc	2004-11-10 18:45:59.575643728 +0100
+++ linux-2.6.10-rc-paolo/arch/um/kernel/main.c	2004-11-10 18:49:05.002454568 +0100
@@ -26,6 +26,7 @@
 #include "uml-config.h"
 #include "irq_user.h"
 #include "time_user.h"
+#include "os.h"
 
 /* Set in set_stklim, which is called from main and __wrap_malloc.
  * __wrap_malloc only calls it if main hasn't started.
@@ -175,7 +176,7 @@ int main(int argc, char **argv, char **e
 }
 
 #define CAN_KMALLOC() \
-	(kmalloc_ok && CHOOSE_MODE((getpid() != tracing_pid), 1))
+	(kmalloc_ok && CHOOSE_MODE((os_getpid() != tracing_pid), 1))
 
 extern void *__real_malloc(int);
 
_
