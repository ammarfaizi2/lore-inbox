Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbSKSTbu>; Tue, 19 Nov 2002 14:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267133AbSKSTbu>; Tue, 19 Nov 2002 14:31:50 -0500
Received: from 166.Red-80-36-134.pooles.rima-tde.net ([80.36.134.166]:1664
	"EHLO apocalipsis") by vger.kernel.org with ESMTP
	id <S267126AbSKSTbs>; Tue, 19 Nov 2002 14:31:48 -0500
Date: Tue, 19 Nov 2002 20:38:57 +0100
From: "Juan M. de la Torre" <jmtorre@gmx.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sys_init_module refuses to load module without init code/data sections
Message-ID: <20021119193857.GA406@apocalipsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  load_module() stores in mod->init_size the size of init data and init
 code sections, and later allocs (using module_alloc()) mod->init_size
 bytes. 

  If the module has not init data and init code sections mod->init_size
 is 0, so module_alloc() will return NULL and load_module() will abort
 loading the module with -ENOMEM.

 Possible patch attached, sorry if this is a known issue.

 Best regards,
  Juanma


--- linux-2.5.48/kernel/module.c.orig   Tue Nov 19 20:08:52 2002
+++ linux-2.5.48/kernel/module.c        Tue Nov 19 20:37:47 2002
@@ -972,13 +972,15 @@
        memset(ptr, 0, mod->core_size);
        mod->module_core = ptr;

-       ptr = module_alloc(mod->init_size);
-       if (!ptr) {
-               err = -ENOMEM;
-               goto free_core;
-       }
-       memset(ptr, 0, mod->init_size);
-       mod->module_init = ptr;
+       if (mod->init_size) {
+               ptr = module_alloc(mod->init_size);
+               if (!ptr) {
+                       err = -ENOMEM;
+                       goto free_core;
+               }
+               memset(ptr, 0, mod->init_size);
+               mod->module_init = ptr;
+       }

        /* Transfer each section which requires ALLOC, and set sh_offset
           fields to absolute addresses. */

-- 
/jm

