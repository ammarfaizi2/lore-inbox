Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWITRl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWITRl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWITRl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:41:57 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:3013 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932157AbWITRl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:41:56 -0400
Date: Wed, 20 Sep 2006 13:40:26 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Mitch <Mitch@0Bits.COM>
Cc: linux-kernel@vger.kernel.org,
       "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Subject: Re: UML build failure with 2.6.18
Message-ID: <20060920174026.GB5331@ccure.user-mode-linux.org>
References: <45115EC7.2010407@0Bits.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45115EC7.2010407@0Bits.COM>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 07:31:19PM +0400, Mitch wrote:
> It's no distro (built up myself, so you can assume a gentoo type build).
> I'm building from scratch, so it should use no headers since i'm 
> building a kernel.

UML interacts with the host, by making system calls, so it needs the
host's libc headers.

Try the patch below.

				Jeff

Index: linux-2.6.17/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/process.c	2006-09-20 11:15:08.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/process.c	2006-09-20 13:35:24.000000000 -0400
@@ -140,11 +140,9 @@ void os_usr1_process(int pid)
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
Index: linux-2.6.17/arch/um/os-Linux/sys-i386/tls.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/sys-i386/tls.c	2006-06-18 13:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/sys-i386/tls.c	2006-09-20 13:37:27.000000000 -0400
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
Index: linux-2.6.17/arch/um/os-Linux/tls.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/tls.c	2006-08-15 21:59:56.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/tls.c	2006-09-20 13:37:14.000000000 -0400
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
