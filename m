Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWBSRkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWBSRkB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 12:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWBSRkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 12:40:01 -0500
Received: from ns1.suse.de ([195.135.220.2]:34506 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932169AbWBSRkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 12:40:00 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE LINUX Products GMBH
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Modules with old-style parameters won't load
Date: Sun, 19 Feb 2006 18:39:59 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_v1K+DNWidvZjCQ1"
Message-Id: <200602191839.59667.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_v1K+DNWidvZjCQ1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Modules may define static variables as old-style MODULE_PARM() parameters. If
those variables are not actually used the compiler may optimize them out,
which currently leads to a `module: falsely claims to have parameter param'
error, and the module won't load.

Just ignore old-style parameter definitions for parameters that aren't 
actually there.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

---

Note: currently the CONFIG_OBSOLETE_MODPARM option is hardwired to y. I don't 
know when old-style module parameters are expected to go away, but until then 
we should make sure that they actually work.

Andreas

Index: linux-2.6.15/kernel/module.c
===================================================================
--- linux-2.6.15.orig/kernel/module.c
+++ linux-2.6.15/kernel/module.c
@@ -763,6 +763,10 @@ static int set_obsolete(const char *val,
 		max = simple_strtol(p, &endp, 10);
 	} else
 		max = min;
+	if (!obsparm->addr) {
+		/* Assume the compiler optimized out an unused parameter. */
+		return 0;
+	}
 	switch (*endp) {
 	case 'b':
 		return param_array(kp->name, val, min, max, obsparm->addr,
@@ -834,12 +838,6 @@ static int obsolete_params(const char *n
 		obsparm[i].addr
 			= (void *)find_local_symbol(sechdrs, symindex, strtab,
 						    sym_name);
-		if (!obsparm[i].addr) {
-			printk("%s: falsely claims to have parameter %s\n",
-			       name, obsparm[i].name);
-			ret = -EINVAL;
-			goto out;
-		}
 		kp[i].arg = &obsparm[i];
 	}

--Boundary-00=_v1K+DNWidvZjCQ1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="module-obsparm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="module-obsparm.diff"

From: Andreas Gruenbacher <agruen@suse.de>
Subject: Modules with old-style parameters won't load
References: 148245

Modules may define static variables as old-style MODULE_PARM()
parameters. If those variables are not actually used, the compiler
may optimize them out, which currently leads to a `module: falsely
claims to have parameter param' error, and the module won't load.
Just ignore parameter definitions for parameters that aren't
actually there.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.15/kernel/module.c
===================================================================
--- linux-2.6.15.orig/kernel/module.c
+++ linux-2.6.15/kernel/module.c
@@ -763,6 +763,10 @@ static int set_obsolete(const char *val,
 		max = simple_strtol(p, &endp, 10);
 	} else
 		max = min;
+	if (!obsparm->addr) {
+		/* Assume the compiler optimized out an unused parameter. */
+		return 0;
+	}
 	switch (*endp) {
 	case 'b':
 		return param_array(kp->name, val, min, max, obsparm->addr,
@@ -834,12 +838,6 @@ static int obsolete_params(const char *n
 		obsparm[i].addr
 			= (void *)find_local_symbol(sechdrs, symindex, strtab,
 						    sym_name);
-		if (!obsparm[i].addr) {
-			printk("%s: falsely claims to have parameter %s\n",
-			       name, obsparm[i].name);
-			ret = -EINVAL;
-			goto out;
-		}
 		kp[i].arg = &obsparm[i];
 	}
 

--Boundary-00=_v1K+DNWidvZjCQ1--
