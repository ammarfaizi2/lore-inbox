Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUELT1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUELT1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265184AbUELT0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:26:09 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.74]:20453 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265199AbUELTOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 15:14:14 -0400
Date: Wed, 12 May 2004 15:13:48 -0400
From: Mathieu Chouquet-Stringer <mchouque@online.fr>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w
 3:{EoxBR
Subject: [PATCH] Fix endianess in modpost when cross-compiling for sparc on i386
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: torvalds@osdl.org
Mail-followup-to: Mathieu Chouquet-Stringer <mchouque@online.fr>,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, torvalds@osdl.org
Message-id: <20040512191348.GA14674@localhost>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

this simple patch makes the following code work again:

#ifdef STT_REGISTER
                if (info->hdr->e_machine == EM_SPARC ||
                    info->hdr->e_machine == EM_SPARCV9) {
                        /* Ignore register directives. */
                        if (ELF_ST_TYPE(sym->st_info) == STT_REGISTER)
                                break;
                }
#endif

This portion of code is sparc specific and nothing else in modpost.c uses
e_machine meaning cross-compiling for sparc on i386 (or any little endian
machine) is the only way to experience the bug.

Without it, e_machine has the wrong value and modpost then generates a lot
of "*** Warning: \"symbol\" [filename.ko] undefined" messages.

--- scripts/modpost.c.orig	2004-05-12 13:58:58.000000000 -0400
+++ scripts/modpost.c	2004-05-12 14:05:20.000000000 -0400
@@ -267,6 +267,7 @@
 	hdr->e_shoff    = TO_NATIVE(hdr->e_shoff);
 	hdr->e_shstrndx = TO_NATIVE(hdr->e_shstrndx);
 	hdr->e_shnum    = TO_NATIVE(hdr->e_shnum);
+	hdr->e_machine  = TO_NATIVE(hdr->e_machine);
 	sechdrs = (void *)hdr + hdr->e_shoff;
 	info->sechdrs = sechdrs;
 


-- 
Mathieu Chouquet-Stringer                 E-Mail: mchouque@online.fr
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
