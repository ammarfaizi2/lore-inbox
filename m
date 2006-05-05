Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWEEAp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWEEAp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 20:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWEEAp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 20:45:59 -0400
Received: from mx.freeshell.ORG ([192.94.73.18]:16070 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S932229AbWEEAp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 20:45:58 -0400
Date: Fri, 5 May 2006 00:45:37 +0000 (UTC)
From: Alexey Toptygin <alexeyt@freeshell.org>
To: linux-kernel@vger.kernel.org
cc: ak@suse.de, tony.luck@intel.com
Subject: [PATCH] sendfile compat functions on x86_64 and ia64
Message-ID: <Pine.NEB.4.62.0605050030200.18795@norge.freeshell.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm a kernel noob, so I apologise in advance if I completely misunderstood 
something. In arch/x86_64/ia32/sys_ia32.c there is this code:

sys32_sendfile(int out_fd, int in_fd, compat_off_t __user *offset, s32 count)
[snip]
	ret = sys_sendfile(out_fd, in_fd, offset ? &of : NULL, count);

However on ia32, count (a size_t) is u32. I think this is taking the u32 
value from the 32 bit userland, sign-extending it to 64 bits, then giving 
it to sys_sendfile in a u64. So, a count >= 1<<31 passed from the 32 bit 
app will become a count >= ((1<<33)-1)<<31 given to sys_sendfile.

Now, I don't think this actually hurts anything, because sys_sendfile 
passes a max of ((1<<31)-1) to do_sendfile, plus rw_verify_area will 
reject values that are negative when cast to ssize_t; but, this is 
certainly confusing.

Perhaps that s32 should be changed to a compat_size_t? ISTM that's 
what compat_size_t is for. And if so, the equivalent function in 
arch/ia64/ia32/sys_ia32.c:

sys32_sendfile (int out_fd, int in_fd, int __user *offset, unsigned int count)

should probably be changed as well? In case I'm not completely wrong, 
below is a patch. Please CC: me, I'm not on lkml.

Signed-off-by: Alexey Toptygin <alexeyt@freeshell.org>

diff -urpN linux-source-2.6.16/arch/ia64/ia32/sys_ia32.c linux-source-2.6.16-mine/arch/ia64/ia32/sys_ia32.c
--- linux-source-2.6.16/arch/ia64/ia32/sys_ia32.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-source-2.6.16-mine/arch/ia64/ia32/sys_ia32.c	2006-05-04 20:20:44.000000000 -0400
@@ -2306,7 +2306,8 @@ sys32_pwrite (unsigned int fd, void __us
 }
 
 asmlinkage long
-sys32_sendfile (int out_fd, int in_fd, int __user *offset, unsigned int count)
+sys32_sendfile (int out_fd, int in_fd, compat_off_t __user *offset,
+							compat_size_t count)
 {
 	mm_segment_t old_fs = get_fs();
 	long ret;
diff -urpN linux-source-2.6.16/arch/x86_64/ia32/sys_ia32.c linux-source-2.6.16-mine/arch/x86_64/ia32/sys_ia32.c
--- linux-source-2.6.16/arch/x86_64/ia32/sys_ia32.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-source-2.6.16-mine/arch/x86_64/ia32/sys_ia32.c	2006-05-04 20:19:35.000000000 -0400
@@ -760,7 +760,8 @@ sys32_personality(unsigned long personal
 }
 
 asmlinkage long
-sys32_sendfile(int out_fd, int in_fd, compat_off_t __user *offset, s32 count)
+sys32_sendfile(int out_fd, int in_fd, compat_off_t __user *offset,
+							compat_size_t count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
