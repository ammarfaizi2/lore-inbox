Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWH1ABS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWH1ABS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 20:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWH0X7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:59:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:30193 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932317AbWH0X65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:58:57 -0400
Message-Id: <20060827215636.797086000@klappe.arndb.de>
References: <20060827214734.252316000@klappe.arndb.de>
Date: Sun, 27 Aug 2006 23:47:38 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au
Subject: [PATCH 4/7] Remove the use of _syscallX macros in UML
Content-Disposition: inline; filename=uml-syscalls.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

User mode linux uses _syscallX() to call into the host kernel.
The recommended way to do this is to use the syscall() function
from libc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-cg/arch/um/os-Linux/process.c
===================================================================
--- linux-cg.orig/arch/um/os-Linux/process.c	2006-08-16 12:08:06.000000000 +0200
+++ linux-cg/arch/um/os-Linux/process.c	2006-08-27 21:51:06.000000000 +0200
@@ -12,6 +12,7 @@
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
+#include <sys/syscall.h>
 #include "ptrace_user.h"
 #include "os.h"
 #include "user.h"
@@ -141,11 +142,9 @@
  * syscalls, and also breaks with clone(), which does not unshare the TLS.
  */
 
-inline _syscall0(pid_t, getpid)
-
 int os_getpid(void)
 {
-	return(getpid());
+	return(syscall(__NR_getpid));
 }
 
 int os_getpgrp(void)
Index: linux-cg/arch/um/os-Linux/sys-i386/tls.c
===================================================================
--- linux-cg.orig/arch/um/os-Linux/sys-i386/tls.c	2006-04-14 13:18:17.000000000 +0200
+++ linux-cg/arch/um/os-Linux/sys-i386/tls.c	2006-08-27 21:51:21.000000000 +0200
@@ -1,10 +1,9 @@
 #include <errno.h>
 #include <linux/unistd.h>
+#include <sys/syscall.h>
 #include "sysdep/tls.h"
 #include "user_util.h"
 
-static _syscall1(int, get_thread_area, user_desc_t *, u_info);
-
 /* Checks whether host supports TLS, and sets *tls_min according to the value
  * valid on the host.
  * i386 host have it == 6; x86_64 host have it == 12, for i386 emulation. */
@@ -17,7 +16,7 @@
 		user_desc_t info;
 		info.entry_number = val[i];
 
-		if (get_thread_area(&info) == 0) {
+		if (syscall(__NR_get_thread_area, &info) == 0) {
 			*tls_min = val[i];
 			*supports_tls = 1;
 			return;
Index: linux-cg/arch/um/os-Linux/tls.c
===================================================================
--- linux-cg.orig/arch/um/os-Linux/tls.c	2006-04-02 23:16:55.000000000 +0200
+++ linux-cg/arch/um/os-Linux/tls.c	2006-08-27 21:52:23.000000000 +0200
@@ -1,5 +1,6 @@
 #include <errno.h>
 #include <sys/ptrace.h>
+#include <sys/syscall.h>
 #include <asm/ldt.h>
 #include "sysdep/tls.h"
 #include "uml-config.h"
@@ -48,14 +49,11 @@
 #ifdef UML_CONFIG_MODE_TT
 #include "linux/unistd.h"
 
-static _syscall1(int, get_thread_area, user_desc_t *, u_info);
-static _syscall1(int, set_thread_area, user_desc_t *, u_info);
-
 int do_set_thread_area_tt(user_desc_t *info)
 {
 	int ret;
 
-	ret = set_thread_area(info);
+	ret = syscall(__NR_set_thread_area,info);
 	if (ret < 0) {
 		ret = -errno;
 	}
@@ -66,7 +64,7 @@
 {
 	int ret;
 
-	ret = get_thread_area(info);
+	ret = syscall(__NR_get_thread_area,info);
 	if (ret < 0) {
 		ret = -errno;
 	}
Index: linux-cg/arch/um/sys-i386/unmap.c
===================================================================
--- linux-cg.orig/arch/um/sys-i386/unmap.c	2005-11-05 01:59:23.000000000 +0100
+++ linux-cg/arch/um/sys-i386/unmap.c	2006-08-27 21:50:44.000000000 +0200
@@ -5,20 +5,17 @@
 
 #include <linux/mman.h>
 #include <asm/unistd.h>
+#include <sys/syscall.h>
 
-static int errno;
-
-static inline _syscall2(int,munmap,void *,start,size_t,len)
-static inline _syscall6(void *,mmap2,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
 int switcheroo(int fd, int prot, void *from, void *to, int size)
 {
-	if(munmap(to, size) < 0){
+	if (syscall(__NR_munmap, to, size) < 0){
 		return(-1);
 	}
-	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1 ){
+	if (syscall(__NR_mmap2, to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1 ){
 		return(-1);
 	}
-	if(munmap(from, size) < 0){
+	if (syscall(__NR_munmap, from, size) < 0){
 		return(-1);
 	}
 	return(0);
Index: linux-cg/arch/um/sys-x86_64/unmap.c
===================================================================
--- linux-cg.orig/arch/um/sys-x86_64/unmap.c	2005-11-05 01:59:23.000000000 +0100
+++ linux-cg/arch/um/sys-x86_64/unmap.c	2006-08-27 21:54:04.000000000 +0200
@@ -5,20 +5,17 @@
 
 #include <linux/mman.h>
 #include <asm/unistd.h>
+#include <sys/syscall.h>
 
-static int errno;
-
-static inline _syscall2(int,munmap,void *,start,size_t,len)
-static inline _syscall6(void *,mmap,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
 int switcheroo(int fd, int prot, void *from, void *to, int size)
 {
-	if(munmap(to, size) < 0){
+	if (syscall(munmap, to, size) < 0){
 		return(-1);
 	}
-	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){
+	if (syscall(mmap, to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){
 		return(-1);
 	}
-	if(munmap(from, size) < 0){
+	if (syscall(munmap, from, size) < 0){
 		return(-1);
 	}
 	return(0);

--

