Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVATLyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVATLyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 06:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVATLyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 06:54:54 -0500
Received: from cantor.suse.de ([195.135.220.2]:57065 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262122AbVATLys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 06:54:48 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild 4/5] Include type information as module info where possible
Date: Thu, 20 Jan 2005 12:54:46 +0100
User-Agent: KMail/1.7.1
References: <20050118184123.729034000.suse.de> <20050118192608.578877000.suse.de> <1106151255.8642.11.camel@winden.suse.de>
In-Reply-To: <1106151255.8642.11.camel@winden.suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Rusty Russell <rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501201254.46253.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 January 2005 17:14, you wrote:
> Hello,
>
> MODULE_PARM_TYPE needs to be moved to moduleparam.h: several files
> include moduleparam.h but not module.h.

Ah, and __MODULE_INFO needs to be moved to moduleparam.h now as well:


Index: linux-2.6.10/include/linux/moduleparam.h
===================================================================
--- linux-2.6.10.orig/include/linux/moduleparam.h
+++ linux-2.6.10/include/linux/moduleparam.h
@@ -13,6 +13,21 @@
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
+
+/* Type information for a module parameter. */
+#define MODULE_PARM_TYPE(name, _type) \
+	__MODULE_INFO(parmtype, name##type, #name ":" _type)
+
 struct kernel_param;
 
 /* Returns 0, or -errno.  arg is in kp->arg. */
@@ -64,7 +79,8 @@ struct kparam_array
    param_set_XXX and param_check_XXX. */
 #define module_param_named(name, value, type, perm)			   \
 	param_check_##type(name, &(value));				   \
-	module_param_call(name, param_set_##type, param_get_##type, &value, perm)
+	module_param_call(name, param_set_##type, param_get_##type, &value, perm); \
+	MODULE_PARM_TYPE(name, #type)
 
 #define module_param(name, type, perm)				\
 	module_param_named(name, name, type, perm)
@@ -74,7 +90,8 @@ struct kparam_array
 	static struct kparam_string __param_string_##name		\
 		= { len, string };					\
 	module_param_call(name, param_set_copystring, param_get_string,	\
-		   &__param_string_##name, perm)
+		   &__param_string_##name, perm);			\
+	MODULE_PARM_TYPE(name, "string")
 
 /* Called on module insert or kernel boot */
 extern int parse_args(const char *name,
@@ -135,7 +152,8 @@ extern int param_get_invbool(char *buffe
 	= { ARRAY_SIZE(array), nump, param_set_##type, param_get_##type,\
 	    sizeof(array[0]), array };					\
 	module_param_call(name, param_array_set, param_array_get, 	\
-			  &__param_arr_##name, perm)
+			  &__param_arr_##name, perm);			\
+	MODULE_PARM_TYPE(name, "array of " #type)
 
 #define module_param_array(name, type, nump, perm)		\
 	module_param_array_named(name, name, type, nump, perm)
Index: linux-2.6.10/include/linux/module.h
===================================================================
--- linux-2.6.10.orig/include/linux/module.h
+++ linux-2.6.10/include/linux/module.h
@@ -76,13 +76,6 @@ void sort_main_extable(void);
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
@@ -93,7 +86,6 @@ extern struct module __this_module;
 #else  /* !MODULE */
 
 #define MODULE_GENERIC_TABLE(gtype,name)
-#define __MODULE_INFO(tag, name, info)
 #define THIS_MODULE ((struct module *)0)
 #endif
 
@@ -564,7 +556,8 @@ static inline void MODULE_PARM_(void) { 
 /* DEPRECATED: Do not use. */
 #define MODULE_PARM(var,type)						    \
 struct obsolete_modparm __parm_##var __attribute__((section("__obsparm"))) = \
-{ __stringify(var), type, &MODULE_PARM_ };
+{ __stringify(var), type, &MODULE_PARM_ }; \
+MODULE_PARM_TYPE(var, type);
 #else
 #define MODULE_PARM(var,type) static void __attribute__((__unused__)) *__parm_##var = &MODULE_PARM_;
 #endif


Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
