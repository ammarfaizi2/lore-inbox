Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265866AbTLaAGn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 19:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbTLaAGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 19:06:43 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:13544 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S265866AbTLaAGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 19:06:41 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] let binfmt_misc optionally preserve argv[1]
Date: Tue, 30 Dec 2003 17:06:39 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312301706.39757.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Originally by David Mosberger; here's his description:

This makes it possible for binfmt_misc to optionally preserve the
contents of argv[1].  This is needed for building accurate simulators
which are invoked via binfmt_misc.  I had brought up this patch a while
ago (see URL below) and there was no negative feedback (OK, there was no
feedback at all...  ;-).

The patch is trivial and the new behavior is triggered only if the
letter "P" (for "preserve") is appended to the binfmt_misc registration
string, so it shold be completely safe.

http://groups.google.com/groups?q=mosberger+binfmt_misc&hl=en&lr=&ie=UTF-8&oe=UT
F-8&selm=200209092241.g89MfPS5001013%40napali.hpl.hp.com&rnum=1

This has been in 2.6 for 16 months:
    http://linux.bkbits.net:8080/linux-2.5/diffs/fs/binfmt_misc.c@1.16?nav=index.html|src/.|src/fs|hist/fs/binfmt_misc.c

diff -urN linux-2.4/fs/binfmt_misc.c linux-ia64-2.4/fs/binfmt_misc.c
--- linux-2.4/fs/binfmt_misc.c	2003-12-29 17:05:24.000000000 -0700
+++ linux-ia64-2.4/fs/binfmt_misc.c	2003-12-29 17:06:12.000000000 -0700
@@ -35,6 +35,7 @@
 static int enabled = 1;
 
 enum {Enabled, Magic};
+#define MISC_FMT_PRESERVE_ARGV0 (1<<31)
 
 typedef struct {
 	struct list_head list;
@@ -121,7 +122,9 @@
 	bprm->file = NULL;
 
 	/* Build args for interpreter */
-	remove_arg_zero(bprm);
+	if (!(fmt->flags & MISC_FMT_PRESERVE_ARGV0)) {
+		remove_arg_zero(bprm);
+	}
 	retval = copy_strings_kernel(1, &bprm->filename, bprm);
 	if (retval < 0) goto _ret; 
 	bprm->argc++;
@@ -287,6 +290,11 @@
 	if (!e->interpreter[0])
 		goto Einval;
 
+	if (*p == 'P') {
+		p++;
+		e->flags |= MISC_FMT_PRESERVE_ARGV0;
+	}
+
 	if (*p == '\n')
 		p++;
 	if (p != buf + count)

