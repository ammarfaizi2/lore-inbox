Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTABPsw>; Thu, 2 Jan 2003 10:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbTABPsw>; Thu, 2 Jan 2003 10:48:52 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:45507 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262258AbTABPsv>;
	Thu, 2 Jan 2003 10:48:51 -0500
Date: Thu, 2 Jan 2003 16:57:19 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301021557.QAA06497@harpo.it.uu.se>
To: rusty@rustcorp.com.au
Subject: [PATCH] 2.5.54 kill module.h compiler warnings
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty,

Compiling kernel 2.5.54 with CONFIG_MODULES=n results in
tons and tons of the following warnings:

include/linux/module.h:317: warning: statement with no effect
include/linux/module.h:353: warning: statement with no effect

patch-2.5.54 changed *MOD_INC_USE_COUNT from macros to
__deprecated functions, but also dropped the (void) casts
in front of the try_module_get() calls. Without modules,
try_module_get() is the constant 1, hence the warnings.

The patch below silences the warnings by adding back the
missing (void) casts. Works for me.

/Mikael

--- linux-2.5.54/include/linux/module.h.~1~	2003-01-02 14:27:56.000000000 +0100
+++ linux-2.5.54/include/linux/module.h	2003-01-02 16:39:49.000000000 +0100
@@ -314,7 +314,7 @@
 	/*
 	 * Yes, we ignore the retval here, that's why it's deprecated.
 	 */
-	try_module_get(module);
+	(void)try_module_get(module);
 }
 
 static inline void __deprecated __MOD_DEC_USE_COUNT(struct module *module)
@@ -350,7 +350,7 @@
 	local_inc(&module->ref[get_cpu()].count);
 	put_cpu();
 #else
-	try_module_get(module);
+	(void)try_module_get(module);
 #endif
 }
 #define MOD_INC_USE_COUNT \
