Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTJ2Xf6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 18:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTJ2Xf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 18:35:58 -0500
Received: from dp.samba.org ([66.70.73.150]:54226 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262052AbTJ2Xf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 18:35:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH] Fix for module initialization failure
Date: Thu, 30 Oct 2003 10:35:53 +1100
Message-Id: <20031029233556.939E52C472@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need a module_arch_cleanup() after a successful module_finalize()
call: it was missing in the case where module->init() fails.  Since
module_arch_cleanup() is a noop on x86, I didn't spot it earlier.

Thanks to Paul Mackerras for prodding me about this again...

Rusty.

Name: Always call module_arch_cleanup
Author: Rusty Russell
Status: Booted on 2.6.0-test5-bk1

D: Bug reported by Paul Mackerras: if a module parameter fails, we didn't
D: call module_arch_cleanup().

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test5-bk1/kernel/module.c working-2.6.0-test5-bk1-module-greg-orig/kernel/module.c
--- linux-2.6.0-test5-bk1/kernel/module.c	2003-09-09 10:35:05.000000000 +1000
+++ working-2.6.0-test5-bk1-module-greg-orig/kernel/module.c	2003-09-11 15:14:32.000000000 +1000
@@ -1653,7 +1660,7 @@ static struct module *load_module(void _
 				 NULL);
 	}
 	if (err < 0)
-		goto cleanup;
+		goto arch_cleanup;
 
 	/* Get rid of temporary copy */
 	vfree(hdr);
@@ -1661,6 +1668,8 @@ static struct module *load_module(void _
 	/* Done! */
 	return mod;
 
+ arch_cleanup:
+	module_arch_cleanup(mod);
  cleanup:
 	module_unload_free(mod);
 	module_free(mod, mod->module_init);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
