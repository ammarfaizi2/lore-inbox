Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTLQI4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 03:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbTLQI4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 03:56:46 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:6071 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264142AbTLQI4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 03:56:43 -0500
Message-ID: <004101c3c47c$114a32d0$0d0fb609@srikrishnan>
From: "srikrish" <srikrish@in.ibm.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Anton Blanchard" <anton@samba.org>
Subject: [PATCH] binfmt_elf.c SIGILL with large external static array on PPC64
Date: Wed, 17 Dec 2003 14:29:19 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using the follow code compiled as an ELF32 binary on a PPC64 machine, application terminates with a SIGILL.
<source code of C Application>
int x[3000][3000][30];
int main() {
    return 0;
}

Platform: Linux-2.6.0-test11 on PPC64

Comments: The problem is that we don't reserve the bss region for the app (via a set_brk/do_brk call) until after we've loaded the
loader so they get mapped to overlapping memory locations. The fix is to move the set_brk/do_brk call to before the point we call
load_elf_interp().
Here's a patch. This gives a clearer error message and terminates with a SEGFAULT. Though I'm not sure if a large external array
could be the only trigger for this. I'd appreciate your comments/suggestions.
 In case of difficulty in applying the patch enclosed, you could find it at
http://www.geocities.com/ssrikrishnan/binfmtelf.htm

Thanks,
Srikrishnan

--- linux-2.6.0-test11/fs/binfmt_elf.c	2003-12-16 18:50:46.000000000 +0530
+++ linux-2.6.0-test11.patched/fs/binfmt_elf.c	2003-12-16 18:58:51.000000000 +0530
@@ -82,13 +82,15 @@

 #define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)

-static void set_brk(unsigned long start, unsigned long end)
+static unsigned long set_brk(unsigned long start, unsigned long end)
 {
+	unsigned long retval;
 	start = ELF_PAGEALIGN(start);
 	end = ELF_PAGEALIGN(end);
 	if (end > start)
-		do_brk(start, end - start);
+		retval = do_brk(start, end - start);
 	current->mm->start_brk = current->mm->brk = end;
+	return retval;
 }


@@ -737,6 +739,19 @@
 	start_data += load_bias;
 	end_data += load_bias;

+        /* Calling set_brk effectively mmaps the pages that we need
+         * for the bss and break sections. We must do this before
+         * before we load the interpreter, in case we have a
+         * huge bss region.
+         */
+	if(BAD_ADDR(set_brk(elf_bss, elf_brk)) {
+		printk(KERN_ERR "unable to map bss region \n");
+		send_sig(SIGSEGV, current, 0);
+		goto out_free_dentry;
+
+	}
+
+	padzero(elf_bss);
 	if (elf_interpreter) {
 		if (interpreter_type == INTERPRETER_AOUT)
 			elf_entry = load_aout_interp(&interp_ex,
@@ -782,13 +797,6 @@
 	current->mm->end_data = end_data;
 	current->mm->start_stack = bprm->p;

-	/* Calling set_brk effectively mmaps the pages that we need
-	 * for the bss and break sections
-	 */
-	set_brk(elf_bss, elf_brk);
-
-	padzero(elf_bss);
-
 	if (current->personality & MMAP_PAGE_ZERO) {
 		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
 		   and some applications "depend" upon this behavior.

