Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVA3WGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVA3WGW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVA3WGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:06:22 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:24283 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261798AbVA3WGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:06:15 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [kbuild 4/5] Include type information as module info where possible
Date: Sun, 30 Jan 2005 23:06:11 +0100
User-Agent: KMail/1.7.1
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
References: <1106151255.8642.11.camel@winden.suse.de> <200501201254.46253.agruen@suse.de> <20050130155623.GA8408@mars.ravnborg.org>
In-Reply-To: <20050130155623.GA8408@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UpV/BBz+FRq5ofS"
Message-Id: <200501302306.12139.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_UpV/BBz+FRq5ofS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 30 January 2005 16:56, Sam Ravnborg wrote:
> Rusty got the original patch applied.

Not completely. The fix is attached.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

--Boundary-00=_UpV/BBz+FRq5ofS
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="module-parmtype.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="module-parmtype.diff"

From: Andreas Gruenbacher <agruen@suse.de>
Subject: Module parameter type fixes

The wrong version of the parmtype patch was merged, incompletely, and
the part that got merged got broken on the way.  Here are the fixes:

Move __MODULE_INFO to modparam.h: This macro is used in modparam.h;
there are users who include this header but not module.h.  The latter
includes modparam.h already.

__MODULE_INFO(parmtype, name##type, #name ":" #type) does not evaluate
to __MODULE_INFO(parmtype, footype, "foo:int") as was the idea, but to
__MODULE_INFO(parmtype, fooint, "foo:int") when type is bound to int.
In more complicated cases, we get syntax erros.  Re-introduce the
__MODULE_PARM_TYPE macro; this is cleaner than renaming the type parameter.

Add the parmtype definition which was dropped during the merge to to the
obsolete but still heavily used MODULE_PARM macro.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc2-bk8/include/linux/module.h
===================================================================
--- linux-2.6.11-rc2-bk8.orig/include/linux/module.h
+++ linux-2.6.11-rc2-bk8/include/linux/module.h
@@ -77,24 +77,14 @@ void sort_main_extable(void);
 extern struct subsystem module_subsys;
 
 #ifdef MODULE
-#define ___module_cat(a,b) __mod_ ## a ## b
-#define __module_cat(a,b) ___module_cat(a,b)
-#define __MODULE_INFO(tag, name, info)					  \
-static const char __module_cat(name,__LINE__)[]				  \
-  __attribute_used__							  \
-  __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
-
 #define MODULE_GENERIC_TABLE(gtype,name)			\
 extern const struct gtype##_id __mod_##gtype##_table		\
   __attribute__ ((unused, alias(__stringify(name))))
 
 extern struct module __this_module;
 #define THIS_MODULE (&__this_module)
-
 #else  /* !MODULE */
-
 #define MODULE_GENERIC_TABLE(gtype,name)
-#define __MODULE_INFO(tag, name, info)
 #define THIS_MODULE ((struct module *)0)
 #endif
 
@@ -560,7 +550,8 @@ static inline void MODULE_PARM_(void) { 
 /* DEPRECATED: Do not use. */
 #define MODULE_PARM(var,type)						    \
 struct obsolete_modparm __parm_##var __attribute__((section("__obsparm"))) = \
-{ __stringify(var), type, &MODULE_PARM_ };
+{ __stringify(var), type, &MODULE_PARM_ }; \
+__MODULE_PARM_TYPE(var, type);
 #else
 #define MODULE_PARM(var,type) static void __attribute__((__unused__)) *__parm_##var = &MODULE_PARM_;
 #endif
Index: linux-2.6.11-rc2-bk8/include/linux/moduleparam.h
===================================================================
--- linux-2.6.11-rc2-bk8.orig/include/linux/moduleparam.h
+++ linux-2.6.11-rc2-bk8/include/linux/moduleparam.h
@@ -13,6 +13,19 @@
 #define MODULE_PARAM_PREFIX __stringify(KBUILD_MODNAME) "."
 #endif
 
+#ifdef MODULE
+#define ___module_cat(a,b) __mod_ ## a ## b
+#define __module_cat(a,b) ___module_cat(a,b)
+#define __MODULE_INFO(tag, name, info)					  \
+static const char __module_cat(name,__LINE__)[]				  \
+  __attribute_used__							  \
+  __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
+#else  /* !MODULE */
+#define __MODULE_INFO(tag, name, info)
+#endif
+#define __MODULE_PARM_TYPE(name, _type)					  \
+  __MODULE_INFO(parmtype, name##type, #name ":" _type)
+
 struct kernel_param;
 
 /* Returns 0, or -errno.  arg is in kp->arg. */
@@ -65,7 +78,7 @@ struct kparam_array
 #define module_param_named(name, value, type, perm)			   \
 	param_check_##type(name, &(value));				   \
 	module_param_call(name, param_set_##type, param_get_##type, &value, perm); \
-	__MODULE_INFO(parmtype, name##type, #name ":" #type)
+	__MODULE_PARM_TYPE(name, #type)
 
 #define module_param(name, type, perm)				\
 	module_param_named(name, name, type, perm)
@@ -76,7 +89,7 @@ struct kparam_array
 		= { len, string };					\
 	module_param_call(name, param_set_copystring, param_get_string,	\
 		   &__param_string_##name, perm);			\
-	__MODULE_INFO(parmtype, name##type, #name ":string")
+	__MODULE_PARM_TYPE(name, "string")
 
 /* Called on module insert or kernel boot */
 extern int parse_args(const char *name,
@@ -138,7 +151,7 @@ extern int param_get_invbool(char *buffe
 	    sizeof(array[0]), array };					\
 	module_param_call(name, param_array_set, param_array_get, 	\
 			  &__param_arr_##name, perm);			\
-	__MODULE_INFO(parmtype, name##type, #name ":array of " #type)
+	__MODULE_PARM_TYPE(name, "array of " #type)
 
 #define module_param_array(name, type, nump, perm)		\
 	module_param_array_named(name, name, type, nump, perm)

--Boundary-00=_UpV/BBz+FRq5ofS--
