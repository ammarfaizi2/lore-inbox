Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265923AbSKFSMn>; Wed, 6 Nov 2002 13:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265922AbSKFSMm>; Wed, 6 Nov 2002 13:12:42 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:20210 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265921AbSKFSMk>;
	Wed, 6 Nov 2002 13:12:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15817.23845.227983.58235@napali.hpl.hp.com>
Date: Wed, 6 Nov 2002 10:19:17 -0800
From: David Mosberger <davidm@napali.hpl.hp.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: [patch] let binfmt_misc optionally preserve argv[1]
Reply-to: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Below is a patch which makes it possible for binfmt_misc to optionally
preserve the contents of argv[1].  This is needed for building
accurate simulators which are invoked via binfmt_misc.  I had brought
up this patch a while ago (see URL below) and there was no negative
feedback (OK, there was no feedback at all... ;-).

The patch is trivial and the new behavior is triggered only if the
letter "P" (for "preserve") is appended to the binfmt_misc
registration string, so it shold be completely safe.

Thanks,

	--david

http://groups.google.com/groups?q=mosberger+binfmt_misc&hl=en&lr=&ie=UTF-8&oe=UTF-8&selm=200209092241.g89MfPS5001013%40napali.hpl.hp.com&rnum=1

diff -Nru a/fs/binfmt_misc.c b/fs/binfmt_misc.c
--- a/fs/binfmt_misc.c	Tue Sep 24 22:09:20 2002
+++ b/fs/binfmt_misc.c	Tue Sep 24 22:09:20 2002
@@ -36,6 +36,7 @@
 static int enabled = 1;
 
 enum {Enabled, Magic};
+#define MISC_FMT_PRESERVE_ARGV0 (1<<31)
 
 typedef struct {
 	struct list_head list;
@@ -124,7 +125,9 @@
 	bprm->file = NULL;
 
 	/* Build args for interpreter */
-	remove_arg_zero(bprm);
+	if (!(fmt->flags & MISC_FMT_PRESERVE_ARGV0)) {
+		remove_arg_zero(bprm);
+	}
 	retval = copy_strings_kernel(1, &bprm->filename, bprm);
 	if (retval < 0) goto _ret; 
 	bprm->argc++;
@@ -289,6 +292,11 @@
 	*p++ = '\0';
 	if (!e->interpreter[0])
 		goto Einval;
+
+	if (*p == 'P') {
+		p++;
+		e->flags |= MISC_FMT_PRESERVE_ARGV0;
+	}
 
 	if (*p == '\n')
 		p++;
