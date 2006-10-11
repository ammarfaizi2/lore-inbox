Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161386AbWJKVdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161386AbWJKVdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161391AbWJKVFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:05:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:18334 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161388AbWJKVEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:04:46 -0400
Date: Wed, 11 Oct 2006 14:03:44 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jeff Dike <jdike@addtoit.com>,
       Paolo Giarrusso <blaisorblade@yahoo.it>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 04/67] UML: Fix UML build failure
Message-ID: <20061011210344.GE16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="uml-fix-uml-build-failure.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jeff Dike <jdike@addtoit.com>

don't know if the following is already queued, it fixes an ARCH=um build
failure, evidence here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=115875912525137&w=2
and following thread.
Cc-ing uml maintainers and I hope I didn't follow too many
Submitting-patches rules...

The patch is taken from:
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.18/patches/no-syscallx

Since the syscallx macros seem to be under threat, this patch stops
using them, using syscall instead.

Acked-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 arch/um/os-Linux/process.c      |    4 +---
 arch/um/os-Linux/sys-i386/tls.c |    4 +---
 arch/um/os-Linux/tls.c          |    7 ++-----
 3 files changed, 4 insertions(+), 11 deletions(-)

--- linux-2.6.18.orig/arch/um/os-Linux/process.c
+++ linux-2.6.18/arch/um/os-Linux/process.c
@@ -141,11 +141,9 @@ void os_usr1_process(int pid)
  * syscalls, and also breaks with clone(), which does not unshare the TLS.
  */
 
-inline _syscall0(pid_t, getpid)
-
 int os_getpid(void)
 {
-	return(getpid());
+	return syscall(__NR_getpid);
 }
 
 int os_getpgrp(void)
--- linux-2.6.18.orig/arch/um/os-Linux/sys-i386/tls.c
+++ linux-2.6.18/arch/um/os-Linux/sys-i386/tls.c
@@ -3,8 +3,6 @@
 #include "sysdep/tls.h"
 #include "user_util.h"
 
-static _syscall1(int, get_thread_area, user_desc_t *, u_info);
-
 /* Checks whether host supports TLS, and sets *tls_min according to the value
  * valid on the host.
  * i386 host have it == 6; x86_64 host have it == 12, for i386 emulation. */
@@ -17,7 +15,7 @@ void check_host_supports_tls(int *suppor
 		user_desc_t info;
 		info.entry_number = val[i];
 
-		if (get_thread_area(&info) == 0) {
+		if(syscall(__NR_get_thread_area, &info) == 0){
 			*tls_min = val[i];
 			*supports_tls = 1;
 			return;
--- linux-2.6.18.orig/arch/um/os-Linux/tls.c
+++ linux-2.6.18/arch/um/os-Linux/tls.c
@@ -48,14 +48,11 @@ int os_get_thread_area(user_desc_t *info
 #ifdef UML_CONFIG_MODE_TT
 #include "linux/unistd.h"
 
-static _syscall1(int, get_thread_area, user_desc_t *, u_info);
-static _syscall1(int, set_thread_area, user_desc_t *, u_info);
-
 int do_set_thread_area_tt(user_desc_t *info)
 {
 	int ret;
 
-	ret = set_thread_area(info);
+	ret = syscall(__NR_set_thread_area, info);
 	if (ret < 0) {
 		ret = -errno;
 	}
@@ -66,7 +63,7 @@ int do_get_thread_area_tt(user_desc_t *i
 {
 	int ret;
 
-	ret = get_thread_area(info);
+	ret = syscall(__NR_get_thread_area, info);
 	if (ret < 0) {
 		ret = -errno;
 	}

--
