Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVASQO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVASQO2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 11:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVASQO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 11:14:28 -0500
Received: from cantor.suse.de ([195.135.220.2]:33224 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261767AbVASQOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 11:14:16 -0500
Subject: Re: [kbuild 4/5] Include type information as module info where
	possible
From: Andreas Gruenbacher <agruen@suse.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20050118192608.578877000.suse.de>
References: <20050118184123.729034000.suse.de>
	 <20050118192608.578877000.suse.de>
Content-Type: multipart/mixed; boundary="=-pJBY60ffPsZ0tG98IOGA"
Organization: SUSE Labs
Message-Id: <1106151255.8642.11.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 Jan 2005 17:14:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pJBY60ffPsZ0tG98IOGA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

MODULE_PARM_TYPE needs to be moved to moduleparam.h: several files
include moduleparam.h but not module.h.

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

--=-pJBY60ffPsZ0tG98IOGA
Content-Disposition: attachment; filename=mod_param-typeinfo.diff
Content-Type: message/rfc822; name=mod_param-typeinfo.diff

From: Andreas Gruenbacher <agruen@suse.de>
Originally-from: Rusty Russell <rusty@rustcorp.com.au>
Subject: Include type information as module info where possible
References: 48396
Date: Wed, 19 Jan 2005 17:12:48 +0100
Message-Id: <1106151168.8642.9.camel@winden.suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

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
@@ -13,6 +13,10 @@
 #define MODULE_PARAM_PREFIX __stringify(KBUILD_MODNAME) "."
 #endif
 
+/* Type information for a module parameter. */
+#define MODULE_PARM_TYPE(name, _type) \
+	__MODULE_INFO(parmtype, name##type, #name ":" _type)
+
 struct kernel_param;
 
 /* Returns 0, or -errno.  arg is in kp->arg. */
@@ -64,7 +68,8 @@ struct kparam_array
    param_set_XXX and param_check_XXX. */
 #define module_param_named(name, value, type, perm)			   \
 	param_check_##type(name, &(value));				   \
-	module_param_call(name, param_set_##type, param_get_##type, &value, perm)
+	module_param_call(name, param_set_##type, param_get_##type, &value, perm); \
+	MODULE_PARM_TYPE(name, #type)
 
 #define module_param(name, type, perm)				\
 	module_param_named(name, name, type, perm)
@@ -74,7 +79,8 @@ struct kparam_array
 	static struct kparam_string __param_string_##name		\
 		= { len, string };					\
 	module_param_call(name, param_set_copystring, param_get_string,	\
-		   &__param_string_##name, perm)
+		   &__param_string_##name, perm);			\
+	MODULE_PARM_TYPE(name, "string")
 
 /* Called on module insert or kernel boot */
 extern int parse_args(const char *name,
@@ -135,7 +141,8 @@ extern int param_get_invbool(char *buffe
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
@@ -560,7 +560,8 @@ static inline void MODULE_PARM_(void) { 
 /* DEPRECATED: Do not use. */
 #define MODULE_PARM(var,type)						    \
 struct obsolete_modparm __parm_##var __attribute__((section("__obsparm"))) = \
-{ __stringify(var), type, &MODULE_PARM_ };
+{ __stringify(var), type, &MODULE_PARM_ }; \
+MODULE_PARM_TYPE(var, type);
 #else
 #define MODULE_PARM(var,type) static void __attribute__((__unused__)) *__parm_##var = &MODULE_PARM_;
 #endif

--=-pJBY60ffPsZ0tG98IOGA--

