Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265666AbTFNLyw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 07:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265669AbTFNLyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 07:54:52 -0400
Received: from ppp-217-133-190-246.cust-adsl.tiscali.it ([217.133.190.246]:26286
	"EHLO home.lb.ods.org") by vger.kernel.org with ESMTP
	id S265666AbTFNLyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 07:54:51 -0400
Subject: [PATCH] Fix use-after-free when trying to load an invalid module
From: Luca Barbieri <lb@lb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>, rusty@rustcorp.com.au
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1055592512.3810.12.camel@home.lb.ods.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 14 Jun 2003 14:08:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mod->module_core contains the mod structure, so it must be freed after
mod->percpu.
However, initialization happens in the opposite order because mod is
moved after that, so we need to initialize module_core to 0 and check it
later.

--- linux-2.5.70/kernel/module.c~	2003-06-02 10:50:57.000000000 +0200
+++ linux-2.5.70/kernel/module.c	2003-06-11 18:08:47.000000000 +0200
@@ -1417,6 +1417,7 @@ static struct module *load_module(void _
 	if (err < 0)
 		goto free_mod;
 
+	mod->module_core = NULL;
 	if (pcpuindex) {
 		/* We have a special allocation for this section. */
 		mod->percpu = percpu_modalloc(sechdrs[pcpuindex].sh_size,
@@ -1565,10 +1566,12 @@ static struct module *load_module(void _
 	module_unload_free(mod);
 	module_free(mod, mod->module_init);
  free_core:
-	module_free(mod, mod->module_core);
  free_percpu:
 	if (mod->percpu)
 		percpu_modfree(mod->percpu);
+
+	if(mod->module_core)
+		module_free(mod, mod->module_core);
  free_mod:
 	kfree(args);
  free_hdr:


-- 
Luca Barbieri <lb@lb.ods.org>
