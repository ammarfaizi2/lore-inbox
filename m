Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSLPTKA>; Mon, 16 Dec 2002 14:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSLPTJ7>; Mon, 16 Dec 2002 14:09:59 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:45447 "HELO atlrel8.hp.com")
	by vger.kernel.org with SMTP id <S261486AbSLPTJ6>;
	Mon, 16 Dec 2002 14:09:58 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] let binfmt_misc optionally preserve argv[1]
Date: Mon, 16 Dec 2002 12:17:54 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212161217.54715.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This patch applies to 2.4.20 and is due to David Mosberger]

This makes it possible for binfmt_misc to optionally preserve the
contents of argv[1].  This is needed for building accurate simulators
which are invoked via binfmt_misc.  I had brought up this patch a while
ago (see URL below) and there was no negative feedback (OK, there was no
feedback at all...  ;-).

The patch is trivial and the new behavior is triggered only if the
letter "P" (for "preserve") is appended to the binfmt_misc registration
string, so it shold be completely safe.

http://groups.google.com/groups?q=mosberger+binfmt_misc&hl=en&lr=&ie=UTF-8&oe=UTF-8&selm=200209092241.g89MfPS5001013%40napali.hpl.hp.com&rnum=1

diff -Nru a/fs/binfmt_misc.c b/fs/binfmt_misc.c
--- a/fs/binfmt_misc.c	Mon Dec 16 12:06:58 2002
+++ b/fs/binfmt_misc.c	Mon Dec 16 12:06:58 2002
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
@@ -286,6 +289,11 @@
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

