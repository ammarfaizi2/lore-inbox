Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318986AbSIIWg4>; Mon, 9 Sep 2002 18:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318987AbSIIWg4>; Mon, 9 Sep 2002 18:36:56 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:65533 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318986AbSIIWgu>;
	Mon, 9 Sep 2002 18:36:50 -0400
Date: Mon, 9 Sep 2002 15:41:25 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200209092241.g89MfPS5001013@napali.hpl.hp.com>
To: linux-kernel@vger.kernel.org
cc: rguenth@tat.physik.uni-tuebingen.de
Subject: [RFC] small binfmt_misc patch
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The binfmt_misc format currently has the property that the argv[1]
string passed to the interpreter consists of the fully qualified path
to the script that is to be interpreted.  AFAIK, there is no way for
the interpreter to retrieve/reconstruct the original value of argv[1]
(as it existed at the time execve() was invoked).  This is a problem
for simulators (such as the Ski simulator for ia64) because there are
programs that expect certain values in argv[1] (yes, you could argue
that such programs are broken, but that's a different topic: we still
need to be able to run such "broken" programs under a simulator).  The
patch below is a proposal to optionally change the behavior of
binfmt_misc so that it preserves the original value of argv[1].

The idea is as follows: by default, the standard behavior applies.  To
request the alternate behavior, the character "P" (for "preserve") is
added to the end of the binfmt_misc registration string.

For example, consider the case:

	execve("ls", {"arg0", "arg1", NULL}, envp);

If this execve() were to be redirected to the "ski" interpreter,
binfmt_misc would normally invoke it like this:

	argv[0] = /usr/bin/ski
	argv[1] = /bin/ls
	argv[2] = "arg1"

With the alternate behavior, "ski" would be invoked as:

	argv[0] = /usr/bin/ski
	argv[1] = /bin/ls
	argv[2] = arg0
	argv[3] = arg1

In other words, this way, an interpreter has access both to the full
path (as determined by the kernel) and the original value of arg0.
(Obviously the interpreter needs to know whether the binfmt_misc
registration occurred with or without 'P', but that's the
interpreter's problem and we can deal with that.)

Comments?

	--david

--- a/fs/binfmt_misc.c	Mon Aug 19 11:44:32 2002
+++ b/fs/binfmt_misc.c	Sun Aug 25 10:07:41 2002
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
