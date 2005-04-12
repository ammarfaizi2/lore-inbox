Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVDLS6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVDLS6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVDLSuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:50:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:2250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262227AbVDLKcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:48 -0400
Message-Id: <200504121032.j3CAWcVT005641@shell0.pdx.osdl.net>
Subject: [patch 126/198] kernel/param.c: don't use .max when .num is NULL in param_array_set()
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       wesarg@informatik.uni-halle.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bert Wesarg <wesarg@informatik.uni-halle.de>

there seems to be a bug, at least for me, in kernel/param.c for arrays with
.num == NULL.  If .num == NULL, the function param_array_set() uses &.max
for the call to param_array(), wich alters the .max value to the number of
arguments.  The result is, you can't set more array arguments as the last
time you set the parameter.

example:

# a module 'example' with
# static int array[10] = { 0, };
# module_param_array(array, int, NULL, 0644);

$ insmod example.ko array=1,2,3
$ cat /sys/module/example/parameters/array
1,2,3
$ echo "4,3,2,1" > /sys/module/example/parameters/array
$ dmesg | tail -n 1
kernel: array: can take only 3 arguments

Signed-off-by: Bert Wesarg <wesarg@informatik.uni-halle.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/params.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN kernel/params.c~kernel-paramc-dont-use-max-when-num-is-null-in kernel/params.c
--- 25/kernel/params.c~kernel-paramc-dont-use-max-when-num-is-null-in	2005-04-12 03:21:33.817995784 -0700
+++ 25-akpm/kernel/params.c	2005-04-12 03:21:33.821995176 -0700
@@ -314,9 +314,10 @@ int param_array(const char *name,
 int param_array_set(const char *val, struct kernel_param *kp)
 {
 	struct kparam_array *arr = kp->arg;
+	unsigned int temp_num;
 
 	return param_array(kp->name, val, 1, arr->max, arr->elem,
-			   arr->elemsize, arr->set, arr->num ?: &arr->max);
+			   arr->elemsize, arr->set, arr->num ?: &temp_num);
 }
 
 int param_array_get(char *buffer, struct kernel_param *kp)
_
