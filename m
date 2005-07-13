Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVGMG0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVGMG0C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 02:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVGMG0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 02:26:02 -0400
Received: from port49.ds1-van.adsl.cybercity.dk ([212.242.141.114]:3906 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id S262471AbVGMGZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 02:25:59 -0400
To: davem@davemloft.net, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: [PATCH] modpost needs to cope with new glibc elf header on sparc (resend - my MTA did eat the previous one apparently)
Message-Id: <20050713062549.1ED325032@trider-g7.fabbione.net>
Date: Wed, 13 Jul 2005 08:25:49 +0200 (CEST)
From: fabbione@fabbione.net (Fabio Massimo Di Nitto)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,
  recently a change in the glibc elf.h header has been introduced causing
modpost to spawn tons of warnings (like the one below) building the kernel on sparc:

[SNIP]
*** Warning: "current_thread_info_reg" [net/sunrpc/auth_gss/auth_rpcgss.ko] undefined!
*** Warning: "" [net/sunrpc/auth_gss/auth_rpcgss.ko] undefined!
*** Warning: "" [net/sunrpc/auth_gss/auth_rpcgss.ko] undefined!
[SNIP]

Ben Collins discovered that the STT_REGISTERED did change and that this change
needs to be propagated to modpost.

-#define STT_REGISTER   13              /* Global register reserved to app. */
+#define STT_SPARC_REGISTER     13      /* Global register reserved to app. */

I did and tested this simple patch to maintain compatibility with newer (>= 2.3.4)
and older (<= 2.3.2) glibc.

Please apply.

Signed-off-by: Fabio M. Di Nitto <fabbione@fabbione.net>

Cheers
Fabio

diff -urNad --exclude=CVS --exclude=.svn ./scripts/mod/modpost.c /usr/src/dpatchtemp/dpep-work.EcxGXN/linux-source-2.6.12-2.6.12/scripts/mod/modpost.c
--- ./scripts/mod/modpost.c	2005-06-17 21:48:29.000000000 +0200
+++ /usr/src/dpatchtemp/dpep-work.EcxGXN/linux-source-2.6.12-2.6.12/scripts/mod/modpost.c	2005-06-30 09:29:54.000000000 +0200
@@ -359,11 +359,16 @@
 		/* ignore __this_module, it will be resolved shortly */
 		if (strcmp(symname, MODULE_SYMBOL_PREFIX "__this_module") == 0)
 			break;
-#ifdef STT_REGISTER
+/* cope with newer glibc (2.3.4 or higher) STT_ definition in elf.h */
+#if defined(STT_REGISTER) || defined(STT_SPARC_REGISTER)
+/* add compatibility with older glibc */
+#ifndef STT_SPARC_REGISTER
+#define STT_SPARC_REGISTER STT_REGISTER
+#endif
 		if (info->hdr->e_machine == EM_SPARC ||
 		    info->hdr->e_machine == EM_SPARCV9) {
 			/* Ignore register directives. */
-			if (ELF_ST_TYPE(sym->st_info) == STT_REGISTER)
+			if (ELF_ST_TYPE(sym->st_info) == STT_SPARC_REGISTER)
 				break;
 		}
 #endif
