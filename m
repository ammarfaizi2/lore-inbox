Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbUDLJpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 05:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUDLJpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 05:45:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:35278 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262754AbUDLJpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 05:45:03 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, linux-kernel@vger.kernel.org
Subject: Re: fix must_not_trace_exec() test (was: 2.6.5-mm4)
References: <20040410200551.31866667.akpm@osdl.org>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Mon, 12 Apr 2004 11:44:51 +0200
Message-ID: <878yh1y1gs.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm4/
>
> +compute-creds-race-fix.patch
> +compute-creds-race-fix-fix.patch
>
>  Fix possible race in permission calculation across exec()

this is a small fix for the modified must_not_trace_exec() test.
I have tested neither the compute-creds-race-fix nor my patch.
It is on top of 2.6.5 + compute-creds-race-fix.patch +
compute-creds-race-fix-fix.patch.

Although, I'd rather not lump together unrelated tests without
renaming must_not_trace_exec(). Btw, can someone enlighten me what
this atomic_read() test is all about.

Regards, Olaf.

diff -urN a/security/commoncap.c b/security/commoncap.c
--- a/security/commoncap.c	Mon Apr 12 10:38:17 2004
+++ b/security/commoncap.c	Mon Apr 12 11:10:38 2004
@@ -118,9 +118,9 @@
 static inline int must_not_trace_exec (struct task_struct *p)
 {
 	return ((p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP))
-		|| atomic_read(&current->fs->count) > 1
-		|| atomic_read(&current->files->count) > 1
-		|| atomic_read(&current->sighand->count) > 1;
+		|| atomic_read(&p->fs->count) > 1
+		|| atomic_read(&p->files->count) > 1
+		|| atomic_read(&p->sighand->count) > 1;
 }
 
 void cap_bprm_apply_creds (struct linux_binprm *bprm)
diff -urN a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Mon Apr 12 10:38:17 2004
+++ b/security/dummy.c	Mon Apr 12 11:10:50 2004
@@ -174,9 +174,9 @@
 static inline int must_not_trace_exec (struct task_struct *p)
 {
 	return ((p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP))
-		|| atomic_read(&current->fs->count) > 1
-		|| atomic_read(&current->files->count) > 1
-		|| atomic_read(&current->sighand->count) > 1;
+		|| atomic_read(&p->fs->count) > 1
+		|| atomic_read(&p->files->count) > 1
+		|| atomic_read(&p->sighand->count) > 1;
 }
 
 static void dummy_bprm_apply_creds (struct linux_binprm *bprm)
