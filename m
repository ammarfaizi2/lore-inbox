Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVARTiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVARTiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 14:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVARTgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 14:36:50 -0500
Received: from news.suse.de ([195.135.220.2]:63114 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261407AbVARTff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 14:35:35 -0500
Message-Id: <20050118192608.578877000.suse.de>
References: <20050118184123.729034000.suse.de>
Date: Tue, 18 Jan 2005 19:41:23 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [kbuild 4/5] Include type information as module info where possible
Content-Disposition: inline; filename=mod_param-typeinfo.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Originally-from: Rusty Russell <rusty@rustcorp.com.au>
Subject: Include type information as module info where possible
References: 48396

Module parameters no longer have a type in general, as we use a callback
system (module_param_call()).  However, it's useful to include type
information in the commonly-used wrappers: module_param,
module_param_string and module_param_array.

This adds a parmtype modinfo tag for each parameter defined using
module_param() or MODULE_PARM(). This allows modinfo to easily print all
parameters and their types, independent of whether or not the parameter
has a description (MODULE_PARM_DESC()).

Originally-signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc1-bk6/include/linux/moduleparam.h
===================================================================
--- linux-2.6.11-rc1-bk6.orig/include/linux/moduleparam.h
+++ linux-2.6.11-rc1-bk6/include/linux/moduleparam.h
@@ -64,7 +64,8 @@ struct kparam_array
    param_set_XXX and param_check_XXX. */
 #define module_param_named(name, value, type, perm)			   \
 	param_check_##type(name, &(value));				   \
-	module_param_call(name, param_set_##type, param_get_##type, &value, perm)
+	module_param_call(name, param_set_##type, param_get_##type, &value, perm); \
+	MODULE_PARM_TYPE(name, #type)
 
 #define module_param(name, type, perm)				\
 	module_param_named(name, name, type, perm)
@@ -74,7 +75,8 @@ struct kparam_array
 	static struct kparam_string __param_string_##name		\
 		= { len, string };					\
 	module_param_call(name, param_set_copystring, param_get_string,	\
-		   &__param_string_##name, perm)
+		   &__param_string_##name, perm);			\
+	MODULE_PARM_TYPE(name, "string")
 
 /* Called on module insert or kernel boot */
 extern int parse_args(const char *name,
@@ -135,7 +137,8 @@ extern int param_get_invbool(char *buffe
 	= { ARRAY_SIZE(array), nump, param_set_##type, param_get_##type,\
 	    sizeof(array[0]), array };					\
 	module_param_call(name, param_array_set, param_array_get, 	\
-			  &__param_arr_##name, perm)
+			  &__param_arr_##name, perm);			\
+	MODULE_PARM_TYPE(name, "array of " #type)
 
 #define module_param_array(name, type, nump, perm)		\
 	module_param_array_named(name, name, type, nump, perm)
Index: linux-2.6.11-rc1-bk6/include/linux/module.h
===================================================================
--- linux-2.6.11-rc1-bk6.orig/include/linux/module.h
+++ linux-2.6.11-rc1-bk6/include/linux/module.h
@@ -138,6 +138,10 @@ extern struct module __this_module;
 /* What your module does. */
 #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
 
+/* Type information for a module parameter. */
+#define MODULE_PARM_TYPE(name, _type) \
+	__MODULE_INFO(parmtype, name##type, #name ":" _type)
+
 /* One for each parameter, describing how to use it.  Some files do
    multiple of these per line, so can't just use MODULE_INFO. */
 #define MODULE_PARM_DESC(_parm, desc) \
@@ -560,7 +564,8 @@ static inline void MODULE_PARM_(void) { 
 /* DEPRECATED: Do not use. */
 #define MODULE_PARM(var,type)						    \
 struct obsolete_modparm __parm_##var __attribute__((section("__obsparm"))) = \
-{ __stringify(var), type, &MODULE_PARM_ };
+{ __stringify(var), type, &MODULE_PARM_ }; \
+MODULE_PARM_TYPE(var, type);
 #else
 #define MODULE_PARM(var,type) static void __attribute__((__unused__)) *__parm_##var = &MODULE_PARM_;
 #endif

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

