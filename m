Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbTGLHQD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 03:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbTGLHQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 03:16:03 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:56593 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S266836AbTGLHP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 03:15:59 -0400
Date: Sat, 12 Jul 2003 17:30:18 +1000
To: zippel@linux-m68k.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [KCONFIG] Optional choice values always get reset
Message-ID: <20030712073018.GA19038@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

As of 2.5.74, make oldconfig always disables existing optional choices
even if they were selected previously.  For example, if all the EICON
ISDN drivers were selected as modules, then make oldconfig will turn
them off.

Part of the problem is that the choice value itself is computed before
the SYMBOL_NEW flag is turned off.  This patch addresses that particular
problem.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/scripts/kconfig/confdata.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/scripts/kconfig/confdata.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 confdata.c
--- kernel-source-2.5/scripts/kconfig/confdata.c	17 Jun 2003 04:20:26 -0000	1.1.1.3
+++ kernel-source-2.5/scripts/kconfig/confdata.c	12 Jul 2003 07:24:35 -0000
@@ -149,7 +149,7 @@
 			sym = sym_find(line + 7);
 			if (!sym) {
 				fprintf(stderr, "%s:%d: trying to assign nonexistent symbol %s\n", name, lineno, line + 7);
-				break;
+				continue;
 			}
 			switch (sym->type) {
 			case S_TRISTATE:
@@ -197,29 +197,28 @@
 			default:
 				;
 			}
-			if (sym_is_choice_value(sym)) {
-				struct symbol *cs = prop_get_symbol(sym_get_choice_prop(sym));
-				switch (sym->user.tri) {
-				case mod:
-					if (cs->user.tri == yes)
-						/* warn? */;
-					break;
-				case yes:
-					if (cs->user.tri != no)
-						/* warn? */;
-					cs->user.val = sym;
-					break;
-				case no:
-					break;
-				}
-				cs->user.tri = sym->user.tri;
-			}
-			break;
-		case '\n':
 			break;
 		default:
 			continue;
 		}
+		if (sym_is_choice_value(sym)) {
+			struct symbol *cs = prop_get_symbol(sym_get_choice_prop(sym));
+			switch (sym->user.tri) {
+			case mod:
+				if (cs->user.tri == yes)
+					/* warn? */;
+				break;
+			case yes:
+				if (cs->user.tri != no)
+					/* warn? */;
+				cs->user.val = sym;
+				break;
+			case no:
+				break;
+			}
+			cs->user.tri = E_OR(cs->user.tri, sym->user.tri);
+			cs->flags &= ~SYMBOL_NEW;
+		}
 	}
 	fclose(in);
 
@@ -241,7 +240,6 @@
 		if (!sym_is_choice(sym))
 			continue;
 		prop = sym_get_choice_prop(sym);
-		sym->flags &= ~SYMBOL_NEW;
 		for (e = prop->expr; e; e = e->left.expr)
 			if (e->right.sym->visible != no)
 				sym->flags |= e->right.sym->flags & SYMBOL_NEW;

--tThc/1wpZn/ma/RB--
