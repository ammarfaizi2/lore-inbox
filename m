Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVGGL26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVGGL26 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVGGL1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:27:34 -0400
Received: from coderock.org ([193.77.147.115]:24970 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261299AbVGGL1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:27:00 -0400
Message-Id: <20050707112633.998206000@homer>
References: <20050707112551.331553000@homer>
Date: Thu, 07 Jul 2005 13:25:52 +0200
From: domen@coderock.org
To: linux-kernel@vger.kernel.org
Cc: damm@opensource.se, domen@coderock.org
Subject: [patch 1/5] autoparam: includes
Content-Disposition: inline; filename=autoparam_1-includes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Damm <damm@opensource.se>


The code of autoparam - modified include files. Stores parameter name, type
and description in a section called __param_strings.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Domen Puncer <domen@coderock.org>

 include/linux/init.h        |   24 ++++++++++++++++++------
 include/linux/module.h      |    8 ++++++++
 include/linux/moduleparam.h |   15 ++++++++++++---
 3 files changed, 38 insertions(+), 9 deletions(-)

Index: a/include/linux/init.h
===================================================================
--- a.orig/include/linux/init.h
+++ a/include/linux/init.h
@@ -119,19 +119,30 @@ struct obs_kernel_param {
  * Force the alignment so the compiler doesn't space elements of the
  * obs_kernel_param "array" too far apart in .init.setup.
  */
-#define __setup_param(str, unique_id, fn, early)			\
+#define __setup_param(str, unique_id, fn, early, mark)		\
 	static char __setup_str_##unique_id[] __initdata = str;	\
 	static struct obs_kernel_param __setup_##unique_id	\
 		__attribute_used__				\
 		__attribute__((__section__(".init.setup")))	\
 		__attribute__((aligned((sizeof(long)))))	\
-		= { __setup_str_##unique_id, fn, early }
+		= { __setup_str_##unique_id, fn, early };	\
+		static const char __setup_doc_##unique_id[]	\
+		__attribute_used__				\
+		__attribute__((section("__param_strings")))	\
+		= mark str
 
 #define __setup_null_param(str, unique_id)			\
-	__setup_param(str, unique_id, NULL, 0)
+	__setup_param(str, unique_id, NULL, 0, "o:")
 
 #define __setup(str, fn)					\
-	__setup_param(str, fn, fn, 0)
+	__setup_param(str, fn, fn, 0, "s:")
+
+#define __setup_desc(str, fn, desc)				\
+	__setup(str, fn);					\
+	static const char __param_doc_desc_##_parm[]		\
+	__attribute_used__					\
+	__attribute__((section("__param_strings")))		\
+	= "d:" str ":" desc
 
 #define __obsolete_setup(str)					\
 	__setup_null_param(str, __LINE__)
@@ -139,7 +150,7 @@ struct obs_kernel_param {
 /* NOTE: fn is as per module_param, not __setup!  Emits warning if fn
  * returns non-zero. */
 #define early_param(str, fn)					\
-	__setup_param(str, fn, fn, 1)
+	__setup_param(str, fn, fn, 1, "e:")
 
 /* Relies on saved_command_line being set */
 void __init parse_early_param(void);
@@ -198,9 +209,10 @@ void __init parse_early_param(void);
 	{ return exitfn; }					\
 	void cleanup_module(void) __attribute__((alias(#exitfn)));
 
-#define __setup_param(str, unique_id, fn)	/* nothing */
+#define __setup_param(str, unique_id, fn, early, mark)	/* nothing */
 #define __setup_null_param(str, unique_id) 	/* nothing */
 #define __setup(str, func) 			/* nothing */
+#define __setup_desc(str, fn, desc)		/* nothing */
 #define __obsolete_setup(str) 			/* nothing */
 #endif
 
Index: a/include/linux/module.h
===================================================================
--- a.orig/include/linux/module.h
+++ a/include/linux/module.h
@@ -131,10 +131,18 @@ extern struct module __this_module;
 /* What your module does. */
 #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
 
+#ifdef MODULE
 /* One for each parameter, describing how to use it.  Some files do
    multiple of these per line, so can't just use MODULE_INFO. */
 #define MODULE_PARM_DESC(_parm, desc) \
 	__MODULE_INFO(parm, _parm, #_parm ":" desc)
+#else
+#define MODULE_PARM_DESC(_parm, desc)				\
+	static const char __param_doc_desc_##_parm[]		\
+	__attribute_used__					\
+	__attribute__((section("__param_strings")))		\
+	= "d:" __stringify(KBUILD_MODNAME) "." #_parm ":" desc
+#endif
 
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
Index: a/include/linux/moduleparam.h
===================================================================
--- a.orig/include/linux/moduleparam.h
+++ a/include/linux/moduleparam.h
@@ -69,6 +69,12 @@ struct kparam_array
     __attribute__ ((unused,__section__ ("__param"),aligned(sizeof(void *)))) \
 	= { __param_str_##name, perm, set, get, arg }
 
+#define module_param_doc(prefix, name, type)				\
+	static const char __param_doc_##name[]				\
+	__attribute_used__						\
+	__attribute__((section("__param_strings")))			\
+	= "m:" prefix #name ":" #type
+
 #define module_param_call(name, set, get, arg, perm)			      \
 	__module_param_call(MODULE_PARAM_PREFIX, name, set, get, arg, perm)
 
@@ -78,7 +84,8 @@ struct kparam_array
 #define module_param_named(name, value, type, perm)			   \
 	param_check_##type(name, &(value));				   \
 	module_param_call(name, param_set_##type, param_get_##type, &value, perm); \
-	__MODULE_PARM_TYPE(name, #type)
+	__MODULE_PARM_TYPE(name, #type);				   \
+	module_param_doc(MODULE_PARAM_PREFIX, name, type)
 
 #define module_param(name, type, perm)				\
 	module_param_named(name, name, type, perm)
@@ -89,7 +96,8 @@ struct kparam_array
 		= { len, string };					\
 	module_param_call(name, param_set_copystring, param_get_string,	\
 		   &__param_string_##name, perm);			\
-	__MODULE_PARM_TYPE(name, "string")
+	__MODULE_PARM_TYPE(name, "string");				\
+	module_param_doc(MODULE_PARAM_PREFIX, name, type)
 
 /* Called on module insert or kernel boot */
 extern int parse_args(const char *name,
@@ -151,7 +159,8 @@ extern int param_get_invbool(char *buffe
 	    sizeof(array[0]), array };					\
 	module_param_call(name, param_array_set, param_array_get, 	\
 			  &__param_arr_##name, perm);			\
-	__MODULE_PARM_TYPE(name, "array of " #type)
+	__MODULE_PARM_TYPE(name, "array of " #type);			\
+	module_param_doc(MODULE_PARAM_PREFIX, name, type)
 
 #define module_param_array(name, type, nump, perm)		\
 	module_param_array_named(name, name, type, nump, perm)

--
