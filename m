Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbTFMBF0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 21:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265092AbTFMBF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 21:05:26 -0400
Received: from dp.samba.org ([66.70.73.150]:27109 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265091AbTFMBFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 21:05:20 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH] fix insidious bug with init section identification in the kernel module loader 
Cc: torvalds@transmeta.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-reply-to: Your message of "12 Jun 2003 16:09:16 EST."
             <1055452158.2117.52.camel@mulgrave> 
Date: Fri, 13 Jun 2003 11:18:33 +1000
Message-Id: <20030613011906.923262C254@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1055452158.2117.52.camel@mulgrave> you write:
> This problem manifests itself nastily on parisc, where the linker seems
> to generate large number of elf sections, often one for each non static
> function, with names like
> 
> .text.<function name>

-ffunction-sections, perhaps?

> The problem is that the kernel/module.c uses the following test to
> identify init sections:
> 
>                            || strstr(secstrings + s->sh_name, ".init"))
> 
> Which will pass if ".init" is matched anywhere in the elf section name. 
> Obviously, any parisc sections for functions that begin with "init"
> match, and are spuriously dumped into the init code.

Yep.  I agree with your fix: there are some archs which haven't
changed over from ".data.init" to ".init.data", and ".data.exit" to
".exit.data", but as you point out, the worst that happens is they
don't discard stuff they could.

Linus, please apply.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

===== kernel/module.c 1.86 vs edited =====
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
