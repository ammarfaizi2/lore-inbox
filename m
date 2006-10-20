Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992607AbWJTNqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992607AbWJTNqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992610AbWJTNqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:46:34 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:59354 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S2992607AbWJTNqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:46:33 -0400
Date: Fri, 20 Oct 2006 07:46:32 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Sam Ravnborg <sam@ravnborg.org>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: [PATCH] PA-RISC: Fix bogus warnings from modpost
Message-ID: <20061020134632.GW2602@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


parisc and parisc64 seem to name sections a little differently from other
targets.  parisc64 gives spurious warnings like:

WARNING: drivers/net/dummy.o - Section mismatch: reference to .init.text:dummy_setup from .data.rel.ro between '.LC1' (at offset 0x0) and '.LC6'

and parisc gives spurious warnings like:

WARNING: drivers/net/dummy.o - Section mismatch: reference to .init.text:dummy_setup from .rodata.cst4 between '.LC1' (at offset 0x0) and '.LC6'

Given the other comments in modpost.c, it seems that the best solution
is to move rodata down to the 'match at start of name' section and add
.data.rel.ro to the 'match entire name' section.

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4127796..582b58f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -910,7 +910,7 @@ static int init_section_ref_ok(const cha
 		".opd",   /* see comment [OPD] at exit_section_ref_ok() */
 		".toc1",  /* used by ppc64 */
 		".stab",
-		".rodata",
+		".data.rel.ro", /* used by parisc64 */
 		".text.lock",
 		"__bug_table", /* used by powerpc for BUG() */
 		".pci_fixup_header",
@@ -929,6 +929,7 @@ static int init_section_ref_ok(const cha
 		".altinstructions",
 		".eh_frame",
 		".debug",
+		".rodata",
 		NULL
 	};
 	/* part of section name */
