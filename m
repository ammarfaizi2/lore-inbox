Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSHFWsI>; Tue, 6 Aug 2002 18:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSHFWsI>; Tue, 6 Aug 2002 18:48:08 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:38922 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316309AbSHFWsA>; Tue, 6 Aug 2002 18:48:00 -0400
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] module cleanup (2/5)
Message-Id: <E17cDAu-0002uy-00@scrub.xs4all.nl>
From: Roman Zippel <zippel@linux-m68k.org>
Date: Wed, 07 Aug 2002 00:51:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch makes the various query functions more compact. It removes
the second loop to calculate the required space and integrates it into
the main loop.

diff -ur linux-2.5/kernel/module.c linux-mod/kernel/module.c
--- linux-2.5/kernel/module.c	Thu Aug  1 16:43:07 2002
+++ linux-mod/kernel/module.c	Thu Aug  1 14:35:31 2002
@@ -677,40 +649,34 @@
 {
 	struct module *mod;
 	size_t nmod, space, len;
+	int res = 0;
 
 	nmod = space = 0;
 
 	for (mod=module_list; mod != &kernel_module; mod=mod->next, ++nmod) {
 		len = strlen(mod->name)+1;
-		if (len > bufsize)
-			goto calc_space_needed;
-		if (copy_to_user(buf, mod->name, len))
-			return -EFAULT;
-		buf += len;
-		bufsize -= len;
+		if (len <= bufsize) {
+			if (copy_to_user(buf, mod->name, len))
+				return -EFAULT;
+			buf += len;
+			bufsize -= len;
+		} else {
+			bufsize = 0;
+			res = -ENOSPC;
+		}
 		space += len;
 	}
 
-	if (put_user(nmod, ret))
-		return -EFAULT;
-	else
-		return 0;
-
-calc_space_needed:
-	space += len;
-	while ((mod = mod->next) != &kernel_module)
-		space += strlen(mod->name)+1;
-
-	if (put_user(space, ret))
-		return -EFAULT;
-	else
-		return -ENOSPC;
+	if (put_user(res ? space : nmod, ret))
+		res = -EFAULT;
+	return res;
 }
 
 static int
 qm_deps(struct module *mod, char *buf, size_t bufsize, size_t *ret)
 {
 	size_t i, space, len;
+	int res = 0;
 
 	if (mod == &kernel_module)
 		return -EINVAL;
@@ -725,29 +691,21 @@
 		const char *dep_name = mod->deps[i].dep->name;
 
 		len = strlen(dep_name)+1;
-		if (len > bufsize)
-			goto calc_space_needed;
-		if (copy_to_user(buf, dep_name, len))
-			return -EFAULT;
-		buf += len;
-		bufsize -= len;
+		if (len <= bufsize) {
+			if (copy_to_user(buf, dep_name, len))
+				return -EFAULT;
+			buf += len;
+			bufsize -= len;
+		} else {
+			bufsize = 0;
+			res = -ENOSPC;
+		}
 		space += len;
 	}
 
-	if (put_user(i, ret))
-		return -EFAULT;
-	else
-		return 0;
-
-calc_space_needed:
-	space += len;
-	while (++i < mod->ndeps)
-		space += strlen(mod->deps[i].dep->name)+1;
-
-	if (put_user(space, ret))
-		return -EFAULT;
-	else
-		return -ENOSPC;
+	if (put_user(res ? space : i, ret))
+		res = -EFAULT;
+	return res;
 }
 
 static int
@@ -755,6 +713,7 @@
 {
 	size_t nrefs, space, len;
 	struct module_ref *ref;
+	int res = 0;
 
 	if (mod == &kernel_module)
 		return -EINVAL;
@@ -769,29 +728,21 @@
 		const char *ref_name = ref->ref->name;
 
 		len = strlen(ref_name)+1;
-		if (len > bufsize)
-			goto calc_space_needed;
-		if (copy_to_user(buf, ref_name, len))
-			return -EFAULT;
-		buf += len;
-		bufsize -= len;
+		if (len <= bufsize) {
+			if (copy_to_user(buf, ref_name, len))
+				return -EFAULT;
+			buf += len;
+			bufsize -= len;
+		} else {
+			bufsize = 0;
+			res = -ENOSPC;
+		}
 		space += len;
 	}
 
-	if (put_user(nrefs, ret))
-		return -EFAULT;
-	else
-		return 0;
-
-calc_space_needed:
-	space += len;
-	while ((ref = ref->next_ref) != NULL)
-		space += strlen(ref->ref->name)+1;
-
-	if (put_user(space, ret))
-		return -EFAULT;
-	else
-		return -ENOSPC;
+	if (put_user(res ? space : nrefs, ret))
+		res = -EFAULT;
+	return res;
 }
 
 static int
@@ -801,6 +752,7 @@
 	struct module_symbol *s;
 	char *strings;
 	unsigned long *vals;
+	int res = 0;
 
 	if (!MOD_CAN_QUERY(mod))
 		if (put_user(0, ret))
@@ -813,43 +765,37 @@
 	i = len = 0;
 	s = mod->syms;
 
-	if (space > bufsize)
-		goto calc_space_needed;
-
-	if (!access_ok(VERIFY_WRITE, buf, space))
-		return -EFAULT;
+	if (space > bufsize) {
+		bufsize = 0;
+		res = -ENOSPC;
+	} else {
+		bufsize -= space;
+		if (!access_ok(VERIFY_WRITE, buf, space))
+			return -EFAULT;
+	}
 
-	bufsize -= space;
 	vals = (unsigned long *)buf;
 	strings = buf+space;
 
 	for (; i < mod->nsyms ; ++i, ++s, vals += 2) {
 		len = strlen(s->name)+1;
-		if (len > bufsize)
-			goto calc_space_needed;
-
-		if (copy_to_user(strings, s->name, len)
-		    || __put_user(s->value, vals+0)
-		    || __put_user(space, vals+1))
-			return -EFAULT;
+		if (len <= bufsize) {
+			if (copy_to_user(strings, s->name, len)
+			    || __put_user(s->value, vals+0)
+			    || __put_user(space, vals+1))
+				return -EFAULT;
 
-		strings += len;
-		bufsize -= len;
+			strings += len;
+			bufsize -= len;
+		} else {
+			bufsize = 0;
+			res = -ENOSPC;
+		}
 		space += len;
 	}
-	if (put_user(i, ret))
-		return -EFAULT;
-	else
-		return 0;
-
-calc_space_needed:
-	for (; i < mod->nsyms; ++i, ++s)
-		space += strlen(s->name)+1;
-
-	if (put_user(space, ret))
-		return -EFAULT;
-	else
-		return -ENOSPC;
+	if (put_user(res ? space : i, ret))
+		res = -EFAULT;
+	return res;
 }
 
 static int
