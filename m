Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264994AbTFLUzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264996AbTFLUzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:55:49 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:24580 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264994AbTFLUzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:55:39 -0400
Subject: [PATCH] fix insidious bug with init section identification in the
	kernel module loader
From: James Bottomley <James.Bottomley@steeleye.com>
To: Rusty Russell <rusty@au1.ibm.com>, torvalds@transmeta.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-X2Qtycn2Tch6DhIZY6uZ"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Jun 2003 16:09:16 -0500
Message-Id: <1055452158.2117.52.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X2Qtycn2Tch6DhIZY6uZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This problem manifests itself nastily on parisc, where the linker seems
to generate large number of elf sections, often one for each non static
function, with names like

.text.<function name>

The problem is that the kernel/module.c uses the following test to
identify init sections:

                           || strstr(secstrings + s->sh_name, ".init"))

Which will pass if ".init" is matched anywhere in the elf section name. 
Obviously, any parisc sections for functions that begin with "init"
match, and are spuriously dumped into the init code.

The fix that works for me on parisc is just to check the beginning of
the string for ".init".  However, I can't find any document that
guarantees this to be correct.  On the other hand, no non-init section
will begin with ".init", so the patch should be safe, just may be non
optimal.

James


--=-X2Qtycn2Tch6DhIZY6uZ
Content-Disposition: inline; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D kernel/module.c 1.86 vs edited =3D=3D=3D=3D=3D
--- 1.86/kernel/module.c	Wed Jun 11 00:55:09 2003
+++ edited/kernel/module.c	Thu Jun 12 15:46:13 2003
@@ -1194,7 +1194,8 @@
 			if ((s->sh_flags & masks[m][0]) !=3D masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize !=3D ~0UL
-			    || strstr(secstrings + s->sh_name, ".init"))
+			    || strncmp(secstrings + s->sh_name,
+				       ".init", 5) =3D=3D 0)
 				continue;
 			s->sh_entsize =3D get_offset(&mod->core_size, s);
 			DEBUGP("\t%s\n", secstrings + s->sh_name);
@@ -1209,7 +1210,8 @@
 			if ((s->sh_flags & masks[m][0]) !=3D masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize !=3D ~0UL
-			    || !strstr(secstrings + s->sh_name, ".init"))
+			    || strncmp(secstrings + s->sh_name,
+				       ".init", 5) !=3D 0)
 				continue;
 			s->sh_entsize =3D (get_offset(&mod->init_size, s)
 					 | INIT_OFFSET_MASK);
@@ -1413,7 +1415,7 @@
 		}
 #ifndef CONFIG_MODULE_UNLOAD
 		/* Don't load .exit sections */
-		if (strstr(secstrings+sechdrs[i].sh_name, ".exit"))
+		if (strncmp(secstrings+sechdrs[i].sh_name, ".exit", 5) =3D=3D 0)
 			sechdrs[i].sh_flags &=3D ~(unsigned long)SHF_ALLOC;
 #endif
 	}

--=-X2Qtycn2Tch6DhIZY6uZ--

