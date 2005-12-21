Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVLUBpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVLUBpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 20:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVLUBpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 20:45:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:56009 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932236AbVLUBpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 20:45:54 -0500
Date: Tue, 20 Dec 2005 19:45:50 -0600
From: Robin Holt <holt@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch 1/5] Fix genksyms handling of DEFINE_PER_CPU(struct foo_s *, bar);
Message-ID: <20051221014550.GA2784@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a one-line change to parse.y.  It results in rebuilding the
scripts/genksyms/*_shipped files.  Those are the next four patches.

When a .c file contains:
DEFINE_PER_CPU(struct foo_s *, bar);

the .cpp output looks like:
__attribute__((__section__(".data.percpu"))) __typeof__(struct foo_s *) per_cpu__bar;

With the existing parse.y, the value inside the paranthesis of
__typeof__() does not evaluate as a type_specifier and therefore
per_cpu__bar does not get assigned a type for genksyms which results in
the EXPORT_PER_CPU_SYMBOL() not generating a CRC value.

I have compared the Modules.symvers with and without this
patch and for ia64's defconfig, the only change is:
Before 0x00000000    per_cpu____sn_nodepda   vmlinux
After  0x9d3f3faa    per_cpu____sn_nodepda   vmlinux

per_cpu____sn_nodepda was the original source of my problems.

Signed-off-by: Robin Holt <holt@sgi.com>


Index: linux-2.6/scripts/genksyms/parse.y
===================================================================
--- linux-2.6.orig/scripts/genksyms/parse.y	2005-12-20 14:24:41.736350197 -0600
+++ linux-2.6/scripts/genksyms/parse.y	2005-12-20 14:24:55.843371218 -0600
@@ -197,6 +197,7 @@ storage_class_specifier:
 type_specifier:
 	simple_type_specifier
 	| cvar_qualifier
+	| TYPEOF_KEYW '(' decl_specifier_seq '*' ')'
 	| TYPEOF_KEYW '(' decl_specifier_seq ')'
 
 	/* References to s/u/e's defined elsewhere.  Rearrange things
