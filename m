Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbUCVMRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 07:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUCVMRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 07:17:04 -0500
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:23551 "EHLO
	kartuli.timesys") by vger.kernel.org with ESMTP id S261912AbUCVMQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 07:16:51 -0500
Message-ID: <405ED918.2010803@timesys.com>
Date: Mon, 22 Mar 2004 07:16:24 -0500
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] Fix sys_time() to get subtick correction from the new
 xtim
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Scott Wood patch against 2.6.3.  He's shy, so I'm volunteering 
to represent him in
public :-).  The Change number and BUG number are TimeSys internal 
references.

Change 22531 by scott@scott-50 on 2004/01/22 15:30:22

        Use gettimeofday() rather than xtime.tv_sec in sys_time(),
        since sys_stime() uses settimeofday() and thus subtracts
        the subtick correction from the new xtime.
       
        Fixes BUG05331 Command line LTP test stime01 fails.

      stime() used settimeofday(), but time() did not use 
gettimeofday().  Since
      settimeofday() subtracts out the current intra-tick correction, 
and nsec
      was 0 (since stime() only allows seconds), this resulted in xtime 
being
      slightly earlier than the time that was set.  If time() had used 
gettimeofday(),
      the correction would have been applied, and everything would be fine.
      However, instead time just reads the current xtime.tv_sec, so if 
time() is
      called immediately after stime(), you'll usually get a value one 
second earlier.


diff -puN kernel/arch/ia64/ia32/sys_ia32.c~fix-all-time-sys_time 
kernel/arch/ia64/ia32/sys_ia32.c
--- lkml/arch/ia64/ia32/sys_ia32.c~fix-all-time-sys_time        
2004-03-16 10:01:23.000000000 -0500
+++ lkml-piggy/arch/ia64/ia32/sys_ia32.c        2004-03-16 
10:01:23.000000000 -0500
@@ -1678,10 +1678,11 @@ asmlinkage long
 sys32_time (int *tloc)
 {
        int i;
+       struct timeval tv;
+
+       do_gettimeofday(&tv);
+       i = tv.tv_sec;

-       /* SMP: This is fairly trivial. We grab CURRENT_TIME and
-          stuff it to user space. No side effects */
-       i = get_seconds();
        if (tloc) {
                if (put_user(i, tloc))
                        i = -EFAULT;
diff -puN -L kernel/arch/ia64/ia32/sys_ia32.c-orig /dev/null /dev/null
diff -puN kernel/arch/parisc/kernel/sys_parisc32.c~fix-all-time-sys_time 
kernel/arch/parisc/kernel/sys_parisc32.c
--- lkml/arch/parisc/kernel/sys_parisc32.c~fix-all-time-sys_time        
2004-03-16 10:01:23.000000000 -0500
+++ lkml-piggy/arch/parisc/kernel/sys_parisc32.c        2004-03-16 
10:01:23.000000000 -0500
@@ -388,14 +388,16 @@ static inline long get_ts32(struct times

 asmlinkage long sys32_time(compat_time_t *tloc)
 {
-    time_t now = get_seconds();
-    compat_time_t now32 = now;
+       struct timeval tv;

-    if (tloc)
-       if (put_user(now32, tloc))
-               now32 = -EFAULT;
+       do_gettimeofday(&tv);
+       compat_time_t now32 = tv.tv_sec;

-    return now32;
+       if (tloc)
+               if (put_user(now32, tloc))
+                       now32 = -EFAULT;
+
+       return now32;
 }

 asmlinkage int
diff -puN -L kernel/arch/parisc/kernel/sys_parisc32.c-orig /dev/null 
/dev/null
diff -puN kernel/arch/x86_64/ia32/sys_ia32.c~fix-all-time-sys_time 
kernel/arch/x86_64/ia32/sys_ia32.c
--- lkml/arch/x86_64/ia32/sys_ia32.c~fix-all-time-sys_time      
2004-03-16 10:01:23.000000000 -0500
+++ lkml-piggy/arch/x86_64/ia32/sys_ia32.c      2004-03-16 
10:01:23.000000000 -0500
@@ -833,10 +833,11 @@ sys32_writev(int fd, struct compat_iovec
 asmlinkage long sys32_time(int * tloc)
 {
        int i;
+       struct timeval tv;
+
+       do_gettimeofday(&tv);
+       i = tv.tv_sec;

-       /* SMP: This is fairly trivial. We grab CURRENT_TIME and
-          stuff it to user space. No side effects */
-       i = get_seconds();
        if (tloc) {
                if (put_user(i,tloc))
                        i = -EFAULT;
diff -puN -L kernel/arch/x86_64/ia32/sys_ia32.c-orig /dev/null /dev/null
diff -puN kernel/kernel/time.c~fix-all-time-sys_time kernel/kernel/time.c
--- lkml/kernel/time.c~fix-all-time-sys_time    2004-03-16 
10:01:23.000000000 -0500
+++ lkml-piggy/kernel/time.c    2004-03-16 10:01:23.000000000 -0500
@@ -51,10 +51,11 @@ EXPORT_SYMBOL(sys_tz);
 asmlinkage long sys_time(int * tloc)
 {
        int i;
+       struct timeval tv;
+
+       do_gettimeofday(&tv);
+       i = tv.tv_sec;

-       /* SMP: This is fairly trivial. We grab CURRENT_TIME and
-          stuff it to user space. No side effects */
-       i = get_seconds();
        if (tloc) {
                if (put_user(i,tloc))
                        i = -EFAULT;
diff -puN -L kernel/kernel/time.c-orig /dev/null /dev/null

_

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell's sig

