Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUAUEf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUAUEf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:35:57 -0500
Received: from dp.samba.org ([66.70.73.150]:24289 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261779AbUAUEfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:35:53 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] v4l-05 add infrared remote support 
In-reply-to: Your message of "Tue, 20 Jan 2004 10:30:54 BST."
             <20040120093054.GC18096@bytesex.org> 
Date: Wed, 21 Jan 2004 14:49:09 +1100
Message-Id: <20040121043608.515032C090@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040120093054.GC18096@bytesex.org> you write:
> No.  The code in question must also build on 2.4 kernels which don't
> have module_param().  And I don't want to clutter up the code with
> #ifdefs unless I absolutely have to.

Marcelo, please read and apply.

This provides simple forwards compat for 2.4.  It doesn't do arrays or
strings, but they can be added if required (this will cover the easy
90%).

Tested on 2.5.24-pre6.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: 2.4 module_param Forward Compatibility Macros
Author: Rusty Russell
Status: Tested on 2.5.24-pre6
Version: 2.4

D: Simple uses of module_param() (implemented in 2.6) can be mapped
D: onto the old MODULE_PARM macros.
D: 
D: New code should use module_param() because:
D: 1) Types are checked,
D: 2) Existence of parameters are checked,
D: 3) Customized types are possible [1]
D: 4) Customized set/get routines are possible [1]
D: 5) Parameters appear as boot params with prefix "<modname>." [1]
D: 6) Optional viewing and control through sysfs [2]
D: 
D: [1] Not for 2.4 compatibility macros
D: [2] Not in 2.6.1 or 2.4, and only if third arg non-zero.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25425-linux-2.4.25-pre6/include/linux/moduleparam.h .25425-linux-2.4.25-pre6.updated/include/linux/moduleparam.h
--- .25425-linux-2.4.25-pre6/include/linux/moduleparam.h	1970-01-01 10:00:00.000000000 +1000
+++ .25425-linux-2.4.25-pre6.updated/include/linux/moduleparam.h	2004-01-21 14:24:41.000000000 +1100
@@ -0,0 +1,25 @@
+#ifndef _LINUX_MODULE_PARAMS_H
+#define _LINUX_MODULE_PARAMS_H
+/* Macros for (very simple) module parameter compatibility with 2.6. */
+#include <linux/module.h>
+
+/* type is byte, short, ushort, int, uint, long, ulong, bool. (2.6
+   has more, but they are not supported).  perm is permissions when
+   it appears in sysfs: 0 means doens't appear, 0444 means read-only
+   by everyone, 0644 means changable dynamically by root, etc.  name
+   must be in scope (unlike MODULE_PARM).
+*/
+#define module_param(name, type, perm)					     \
+	static inline void *__check_existence_##name(void) { return &name; } \
+	MODULE_PARM(name, _MODULE_PARM_STRING_ ## type)
+
+#define _MODULE_PARM_STRING_byte "b"
+#define _MODULE_PARM_STRING_short "h"
+#define _MODULE_PARM_STRING_ushort "h"
+#define _MODULE_PARM_STRING_int "i"
+#define _MODULE_PARM_STRING_uint "i"
+#define _MODULE_PARM_STRING_long "l"
+#define _MODULE_PARM_STRING_ulong "l"
+#define _MODULE_PARM_STRING_bool "i"
+
+#endif /* _LINUX_MODULE_PARAM_TYPES_H */
