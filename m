Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWITVFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWITVFl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWITVFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:05:41 -0400
Received: from [80.227.95.181] ([80.227.95.181]:18128 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S932091AbWITVFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:05:40 -0400
Message-ID: <4511AD17.8040108@0Bits.COM>
Date: Thu, 21 Sep 2006 01:05:27 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Thunderbird 3.0a1 (X11/20060912)
MIME-Version: 1.0
To: jdike@addtoit.com, brugolsky@telemetry-investments.com,
       linux-kernel@vger.kernel.org
Subject: Re: UML build failure with 2.6.18
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

That works perfectly as did the previous patch. I knew how to fix the 
problem anyhow, just wanted to know why i/if was the only person having 
thr problem. I'm running glibc-2.3.6 and gcc-4.0.3.

Cheers
Mithc

-------- Original Message --------
Subject: Re: UML build failure with 2.6.18
Date: Wed, 20 Sep 2006 13:40:26 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Mitch <Mitch@0Bits.COM>
CC: linux-kernel@vger.kernel.org,        "Bill Rugolsky Jr." 
<brugolsky@telemetry-investments.com>
References: <45115EC7.2010407@0Bits.COM>

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
--- linux-2.6.17.orig/arch/um/os-Linux/process.c	2006-09-20 
11:15:08.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/process.c	2006-09-20 
13:35:24.000000000 -0400
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
--- linux-2.6.17.orig/arch/um/os-Linux/sys-i386/tls.c	2006-06-18 
13:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/sys-i386/tls.c	2006-09-20 
13:37:27.000000000 -0400
@@ -3,8 +3,6 @@
  #include "sysdep/tls.h"
  #include "user_util.h"

-static _syscall1(int, get_thread_area, user_desc_t *, u_info);
-
  /* Checks whether host supports TLS, and sets *tls_min according to 
the value
   * valid on the host.
   * i386 host have it == 6; x86_64 host have it == 12, for i386 
emulation. */
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
--- linux-2.6.17.orig/arch/um/os-Linux/tls.c	2006-08-15 
21:59:56.000000000 -0400
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
