Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTFKFel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 01:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTFKFel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 01:34:41 -0400
Received: from dp.samba.org ([66.70.73.150]:46220 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261843AbTFKFek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 01:34:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Milton Miller <miltonm@bga.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.5.70-bk1[23]: load_module crashes when aborting module load 
In-reply-to: Your message of "Tue, 10 Jun 2003 03:48:02 EST."
             <200306100848.h5A8m2E1034824@sullivan.realtime.net> 
Date: Wed, 11 Jun 2003 15:47:29 +1000
Message-Id: <20030611054822.F1A872C051@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200306100848.h5A8m2E1034824@sullivan.realtime.net> you write:
> Umm, isn't that the problem?  Once we get past the point where mod points
> inside the module core (ie where we would goto cleanup), we can't 
> reference mod->percpu after freeing mod->mod_core, since that frees mod
> (and hence a the use-after-free bug).

Doh!  Good catch.

	The problem is that mod is moved to point from the sucked-in
file (always freed last) to the module core, after which time the
"free(mod->core), reference mod->percpu" sequence is bogus, eg. when
the module_init function fails.

	This patch keeps the ptr in a local variable, which solves the
problem simply.

Linus, please apply.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.70-bk15/kernel/module.c working-2.5.70-bk15-percpufree/kernel/module.c
--- linux-2.5.70-bk15/kernel/module.c	2003-06-11 12:15:34.000000000 +1000
+++ working-2.5.70-bk15-percpufree/kernel/module.c	2003-06-11 15:39:48.000000000 +1000
@@ -1366,7 +1366,7 @@ static struct module *load_module(void _
 	long arglen;
 	struct module *mod;
 	long err = 0;
-	void *ptr = NULL; /* Stops spurious gcc uninitialized warning */
+	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
 
 	DEBUGP("load_module: umod=%p, len=%lu, uargs=%p\n",
 	       umod, len, uargs);
@@ -1496,13 +1496,14 @@ static struct module *load_module(void _
 
 	if (pcpuindex) {
 		/* We have a special allocation for this section. */
-		mod->percpu = percpu_modalloc(sechdrs[pcpuindex].sh_size,
-					      sechdrs[pcpuindex].sh_addralign);
-		if (!mod->percpu) {
+		percpu = percpu_modalloc(sechdrs[pcpuindex].sh_size,
+					 sechdrs[pcpuindex].sh_addralign);
+		if (!percpu) {
 			err = -ENOMEM;
 			goto free_mod;
 		}
 		sechdrs[pcpuindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
+		mod->percpu = percpu;
 	}
 
 	/* Determine total sizes, and put offsets in sh_entsize.  For now
@@ -1643,8 +1644,8 @@ static struct module *load_module(void _
  free_core:
 	module_free(mod, mod->module_core);
  free_percpu:
-	if (mod->percpu)
-		percpu_modfree(mod->percpu);
+	if (percpu)
+		percpu_modfree(percpu);
  free_mod:
 	kfree(args);
  free_hdr:
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
