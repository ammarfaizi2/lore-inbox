Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267803AbTBVAAN>; Fri, 21 Feb 2003 19:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267804AbTBVAAN>; Fri, 21 Feb 2003 19:00:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:3968 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267803AbTBVAAL>;
	Fri, 21 Feb 2003 19:00:11 -0500
Date: Fri, 21 Feb 2003 16:10:12 -0800
From: Bob Miller <rem@osdl.org>
To: rusty@rustcorp.com.au, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.62] Fix two races in module code.
Message-ID: <20030222001012.GA1394@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two bugs.

The first is that use_module() was ignoring the return value of
try_module_get().  This causes an OOPs if a module needs symbols
from a module that is halfway unloaded.  The fix is to not ignore
the error.

The second is a race in sys_init_module().  There is code at the
bottom that changes the modules state from COMING to LIVE.  After
the LIVE is set it is possible for another thread to unload the
module making the mod pointer used for the next few statements
invalid.  It would take a lot of interrupts or preempt but it could
happen.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
 

diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Fri Feb 21 15:57:53 2003
+++ b/kernel/module.c	Fri Feb 21 15:57:53 2003
@@ -173,16 +173,22 @@
 	struct module_use *use;
 	if (b == NULL || already_uses(a, b)) return 1;
 
+	/*
+	 * If the module is being unloaded don't attach.
+	 */
+	if (try_module_get(b) == 0) {
+		return 0;
+	}
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
 
@@ -1456,10 +1462,15 @@
 	}
 
 	/* Now it's a first class citizen! */
-	mod->state = MODULE_STATE_LIVE;
 	module_free(mod, mod->module_init);
 	mod->module_init = NULL;
 	mod->init_size = 0;
+	/*
+	 * Hold off setting state to "LIVE" until now.  If set any
+	 * sooner there is a race with an unload making the mod
+	 * pointer invalid.
+	 */
+	mod->state = MODULE_STATE_LIVE;
 
 	return 0;
 }
