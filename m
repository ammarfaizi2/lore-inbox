Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270234AbTGWL4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 07:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270237AbTGWL4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 07:56:46 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:11727 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S270234AbTGWL4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 07:56:45 -0400
Date: Wed, 23 Jul 2003 14:11:50 +0200 (MEST)
Message-Id: <200307231211.h6NCBoel010001@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: bgs@callnet.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6-test1 : make *config doesn't work
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 12:44:07 +0200 (MEST), Bgs himself <bgs@callnet.hu> wrote:
>scripts/modpost.c: In function `handle_modversions':
>scripts/modpost.c:302: `STT_REGISTER' undeclared (first use in this
>function)
>scripts/modpost.c:302: (Each undeclared identifier is reported only once
>scripts/modpost.c:302: for each function it appears in.)
>make[1]: *** [scripts/modpost.o] Error 1

I reported this ages ago, but noone cared to fix it.
The problem is (a) modpost was changed to reference a SPARC-only
ELF constant, (b) modpost is compiled against the system's C
library headers instead of the kernel's, and (c) older versions
of glibc don't have this constant defined (at least not on x86).

The same bug exists in module-init-tools, btw, and hits e.g. RH62
which I have on a box designated for glibc compat testing.

The patch below works around the problem in the kernel.

/Mikael

--- linux-2.6.0-test1/scripts/modpost.c.~1~	2003-05-05 22:56:31.000000000 +0200
+++ linux-2.6.0-test1/scripts/modpost.c	2003-07-18 00:28:08.000000000 +0200
@@ -296,12 +296,14 @@
 		/* ignore global offset table */
 		if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
 			break;
+#ifdef STT_REGISTER
 		if (info->hdr->e_machine == EM_SPARC ||
 		    info->hdr->e_machine == EM_SPARCV9) {
 			/* Ignore register directives. */
 			if (ELF_ST_TYPE(sym->st_info) == STT_REGISTER)
 				break;
 		}
+#endif
 		
 		if (memcmp(symname, MODULE_SYMBOL_PREFIX,
 			   strlen(MODULE_SYMBOL_PREFIX)) == 0) {
