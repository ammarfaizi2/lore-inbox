Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVDYShX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVDYShX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 14:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVDYShX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 14:37:23 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:19626 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262722AbVDYSgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 14:36:55 -0400
Subject: [patch 1/1] uml: fix oops related to exception table [for 2.6.12, urgent]
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Mon, 25 Apr 2005 20:28:02 +0200
Message-Id: <20050425182805.E9B6F45820@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

In short: avoid that the kernel oopses during the extable sorting, as it can
do now, because the extable is in the readonly section of the binary.

>From Jeff: The exception table turned RO in 2.6.11-rc3-mm1 for some reason.
Moving it causes it to land in the writable data section of the binary.

>From Paolo: This patch fixes a oops on startup, which can be easily triggered
by compiling with CONFIG_MODE_TT disabled, and STATIC_LINK either disabled or
enabled. The resulting kernel will always Oops on startup, after printing this
simple output:

Checking for /proc/mm...found
Checking for the skas3 patch in the host...found
Checking PROT_EXEC mmap in /tmp...OK

Debugging shows that it's a SIGSEGV during the extable sorting, which is
caused by the fact that the table is in the read-only section of the binary.

The oops is a 2.6.11-bk7 (more or less) regression, which I already reported
on uml-devel. In fact, the original patch had already been totally dropped
because it seemed useless. Also, I don't know why the moved section becomes
writable, actually. And on i386 the current layout is like the one we have
*before* this patch. Still, it does fix the problem for me.

I've verified, by binary search on the BitKeeper repository (synced up as of
2.6.12-rc2), starting from the range 2.6.11-2.6.12-rc1, that this bug shows up
on BitKeeper revisions in the range [@1.1994.11.168,+inf), i.e. starting from
this:

[PATCH] lib/sort: Replace insertion sort in exception tables

Since UML does not use the exception table, it's likely that insertion sort
didn't happen to write anything on the table.

$ bk prs -d':KEY: :MD5KEY:\n' -r@1.1994.11.168 ChangeSet
======== ChangeSet 1.1994.11.168 ========
mpm@selenic.com[torvalds]|ChangeSet|20050308180540|47678
422de974WUZpIt5eM36-PMJe_h6Nfg

(the 2nd thing ought to be the unique hex key for the changeset).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/include/asm-um/common.lds.S |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff -puN include/asm-um/common.lds.S~uml-exception-table-oops-fix include/asm-um/common.lds.S
--- linux-2.6.12/include/asm-um/common.lds.S~uml-exception-table-oops-fix	2005-04-25 20:22:38.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/common.lds.S	2005-04-25 20:22:38.000000000 +0200
@@ -8,11 +8,6 @@
   _sdata = .;
   PROVIDE (sdata = .);
 
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
   RODATA
 
   .unprotected : { *(.unprotected) }
@@ -20,6 +15,10 @@
   PROVIDE (_unprotected_end = .);
 
   . = ALIGN(4096);
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
   __uml_setup_start = .;
   .uml.setup.init : { *(.uml.setup.init) }
   __uml_setup_end = .;
_
