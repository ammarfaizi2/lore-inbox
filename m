Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVCTXG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVCTXG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVCTXGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:06:38 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:24787 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261328AbVCTXGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:06:12 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050320223819.25305.90833.26641@clementine.local>
In-Reply-To: <20050320223814.25305.52695.65404@clementine.local>
References: <20050320223814.25305.52695.65404@clementine.local>
Subject: [PATCH 1/5] autoparam: includes
Date: Mon, 21 Mar 2005 00:06:11 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code of autoparam - modified include files. Stores parameter name, type 
and description in a section called __param_strings.  

Signed-off-by: Magnus Damm <damm@opensource.se>

diff -urN linux-2.6.12-rc1/include/linux/init.h linux-2.6.12-rc1-autoparam/include/linux/init.h
--- linux-2.6.12-rc1/include/linux/init.h	2005-03-20 18:09:16.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/include/linux/init.h	2005-03-20 22:24:14.393451896 +0100
@@ -125,7 +125,11 @@
 		__attribute_used__				\
 		__attribute__((__section__(".init.setup")))	\
 		__attribute__((aligned((sizeof(long)))))	\
-		= { __setup_str_##unique_id, fn, early }
+		= { __setup_str_##unique_id, fn, early };	\
+		static const char __setup_doc_##unique_id[]	\
+		__attribute_used__				\
+		__attribute__((section("__param_strings")))	\
+		= str
 
 #define __setup_null_param(str, unique_id)			\
 	__setup_param(str, unique_id, NULL, 0)
diff -urN linux-2.6.12-rc1/include/linux/module.h linux-2.6.12-rc1-autoparam/include/linux/module.h
--- linux-2.6.12-rc1/include/linux/module.h	2005-03-20 18:20:18.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/include/linux/module.h	2005-03-20 22:26:33.666279208 +0100
@@ -128,10 +128,18 @@
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
+	= __stringify(KBUILD_MODNAME) "." #_parm " () " desc
+#endif
 
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
diff -urN linux-2.6.12-rc1/include/linux/moduleparam.h linux-2.6.12-rc1-autoparam/include/linux/moduleparam.h
--- linux-2.6.12-rc1/include/linux/moduleparam.h	2005-03-20 18:20:18.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/include/linux/moduleparam.h	2005-03-20 22:29:09.438598216 +0100
@@ -69,6 +69,12 @@
     __attribute__ ((unused,__section__ ("__param"),aligned(sizeof(void *)))) \
 	= { __param_str_##name, perm, set, get, arg }
 
+#define module_param_doc(prefix, name, type)				\
+	static const char __param_doc_##name[]				\
+	__attribute_used__						\
+	__attribute__((section("__param_strings")))			\
+	= prefix #name " (" #type ")"
+
 #define module_param_call(name, set, get, arg, perm)			      \
 	__module_param_call(MODULE_PARAM_PREFIX, name, set, get, arg, perm)
 
@@ -78,7 +84,8 @@
 #define module_param_named(name, value, type, perm)			   \
 	param_check_##type(name, &(value));				   \
 	module_param_call(name, param_set_##type, param_get_##type, &value, perm); \
-	__MODULE_PARM_TYPE(name, #type)
+	__MODULE_PARM_TYPE(name, #type);				   \
+	module_param_doc(MODULE_PARAM_PREFIX, name, type)
 
 #define module_param(name, type, perm)				\
 	module_param_named(name, name, type, perm)
@@ -89,7 +96,8 @@
 		= { len, string };					\
 	module_param_call(name, param_set_copystring, param_get_string,	\
 		   &__param_string_##name, perm);			\
-	__MODULE_PARM_TYPE(name, "string")
+	__MODULE_PARM_TYPE(name, "string");				\
+	module_param_doc(MODULE_PARAM_PREFIX, name, type)
 
 /* Called on module insert or kernel boot */
 extern int parse_args(const char *name,
@@ -151,7 +159,8 @@
 	    sizeof(array[0]), array };					\
 	module_param_call(name, param_array_set, param_array_get, 	\
 			  &__param_arr_##name, perm);			\
-	__MODULE_PARM_TYPE(name, "array of " #type)
+	__MODULE_PARM_TYPE(name, "array of " #type);			\
+	module_param_doc(MODULE_PARAM_PREFIX, name, type)
 
 #define module_param_array(name, type, nump, perm)		\
 	module_param_array_named(name, name, type, nump, perm)
