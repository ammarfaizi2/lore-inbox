Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTIHCnK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 22:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTIHCnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 22:43:10 -0400
Received: from dp.samba.org ([66.70.73.150]:52137 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261885AbTIHCnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 22:43:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re-xmit: Modules: Be stricter recognizing init&exit sesections
Date: Mon, 08 Sep 2003 12:38:21 +1000
Message-Id: <20030908024303.3C9372C241@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Name: .init sections must start with .init
Status: Booted on 2.6.0-test4-bk9

D: Someone pointed out that -ffunction-sections can cause a function
D: called "init<something>" to be put in the init section, and discarded.
D: This hurts PARISC badly.  Get more fussy with identifying them.

--- 1.86/kernel/module.c	Wed Jun 11 00:55:09 2003
+++ edited/kernel/module.c	Thu Jun 12 15:46:13 2003
@@ -1194,7 +1194,8 @@
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL
-			    || strstr(secstrings + s->sh_name, ".init"))
+			    || strncmp(secstrings + s->sh_name,
+				       ".init", 5) == 0)
 				continue;
 			s->sh_entsize = get_offset(&mod->core_size, s);
 			DEBUGP("\t%s\n", secstrings + s->sh_name);
@@ -1209,7 +1210,8 @@
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL
-			    || !strstr(secstrings + s->sh_name, ".init"))
+			    || strncmp(secstrings + s->sh_name,
+				       ".init", 5) != 0)
 				continue;
 			s->sh_entsize = (get_offset(&mod->init_size, s)
 					 | INIT_OFFSET_MASK);
@@ -1413,7 +1415,7 @@
 		}
 #ifndef CONFIG_MODULE_UNLOAD
 		/* Don't load .exit sections */
-		if (strstr(secstrings+sechdrs[i].sh_name, ".exit"))
+		if (strncmp(secstrings+sechdrs[i].sh_name, ".exit", 5) == 0)
 			sechdrs[i].sh_flags &= ~(unsigned long)SHF_ALLOC;
 #endif
 	}

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

