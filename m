Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269676AbTGULYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 07:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269685AbTGULXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 07:23:04 -0400
Received: from dp.samba.org ([66.70.73.150]:30445 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269676AbTGULWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 07:22:55 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Be more strict on recognising init sections
Date: Mon, 21 Jul 2003 21:22:10 +1000
Message-Id: <20030721113757.90D992C752@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomly prodded me to re-xmit this for parisc...

Name: .init sections must start with .init
Status: Trivial

D: Someone pointed out that -ffunction-sections can cause a function
D: called "init<something>" to be put in the init section, and discarded.
D: Get more fussy with identifying them.

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

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
