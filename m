Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVC0M5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVC0M5e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 07:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVC0M5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 07:57:34 -0500
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:22151 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S261631AbVC0M5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 07:57:31 -0500
Date: Sun, 27 Mar 2005 14:57:24 +0200 (MEST)
From: Bert Wesarg <wesarg@informatik.uni-halle.de>
Subject: [PATCH] kernel/param.c: don't use .max when .num is NULL in
 param_array_set()
X-X-Sender: wesarg@turing
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Message-id: <Pine.GSO.4.56.0503271455190.25037@turing>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
X-Scan-Signature: 629ca88677f1133e8c9b638e5f64dd99
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

there seems to be a bug, at least for me, in kernel/param.c for arrays
with .num == NULL. If .num == NULL, the function param_array_set() uses
&.max for the call to param_array(), wich alters the .max value to the
number of arguments. The result is, you can't set more array arguments as
the last time you set the parameter.

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

Patch is against 2.6.12-rc1.

Signed-off-by: Bert Wesarg <wesarg@informatik.uni-halle.de>

--- linux-2.6.12-rc1.orig/kernel/params.c	2005-03-27 14:44:00.000000000 +0200
+++ linux-2.6.12-rc1/kernel/params.c	2005-03-27 14:45:55.000000000 +0200
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
