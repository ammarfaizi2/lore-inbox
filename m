Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268557AbTBZBTX>; Tue, 25 Feb 2003 20:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268562AbTBZBTX>; Tue, 25 Feb 2003 20:19:23 -0500
Received: from dp.samba.org ([66.70.73.150]:44720 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268557AbTBZBTW>;
	Tue, 25 Feb 2003 20:19:22 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Modules race fix
Date: Wed, 26 Feb 2003 12:25:13 +1100
Message-Id: <20030226012938.DB6662C2D2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Name: Fix two module races
Author: Bob Miller, Rusty Russell
Status: Trivial

D: Bob Miller points out that the try_module_get in use_module() can,
D: of course, fail.  Secondly, there is a race between setting the module
D: live, and a simultaneous removal of it.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.62-bk6/kernel/module.c working-2.5.62-bk6-modraces/kernel/module.c
--- linux-2.5.62-bk6/kernel/module.c	2003-02-18 11:18:57.000000000 +1100
+++ working-2.5.62-bk6-modraces/kernel/module.c	2003-02-24 13:42:44.000000000 +1100
@@ -173,16 +173,19 @@ static int use_module(struct module *a, 
 	struct module_use *use;
 	if (b == NULL || already_uses(a, b)) return 1;
 
+	if (!strong_try_module_get(b))
+		return 0;
+
 	DEBUGP("Allocating new usage for %s.\n", a->name);
 	use = kmalloc(sizeof(*use), GFP_ATOMIC);
 	if (!use) {
 		printk("%s: out of memory loading\n", a->name);
+		module_put(b);
 		return 0;
 	}
 
 	use->module_which_uses = a;
 	list_add(&use->list, &b->modules_which_use_me);
-	try_module_get(b); /* Can't fail */
 	return 1;
 }
 
@@ -1456,10 +1459,12 @@ sys_init_module(void *umod,
 	}
 
 	/* Now it's a first class citizen! */
+	down(&module_mutex);
 	mod->state = MODULE_STATE_LIVE;
 	module_free(mod, mod->module_init);
 	mod->module_init = NULL;
 	mod->init_size = 0;
+	up(&module_mutex);
 
 	return 0;
 }


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
