Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTJMIok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 04:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTJMIok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 04:44:40 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:11256 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261563AbTJMIoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 04:44:37 -0400
Message-ID: <3F8AAD7A.9ECEF3B0@in.ibm.com>
Date: Mon, 13 Oct 2003 19:19:46 +0530
From: Srikrishnan Sundararajan <srikrish@in.ibm.com>
Reply-To: srikrish@in.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-64GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: anton@samba.org, pavel@suse.cz, pavel@ucw.cz, agruen@suse.de,
       linus@osdl.org
Subject: Fw: [PATCH] For Segmentation Fault when using large external array
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I compile and run an application with a large external array I get a
Segmentation Fault.

<source code of C Application>
int x[3000][3000][30];
int main() {
    return 10;
}

Platform: Linux-2.6.0-test5 on ia-32

Comments: The problem is that we don't reserve the bss region for the app
(via a set_brk/do_brk call) until after we've loaded the loader so they get
mapped to overlapping memory locations. The fix is to move the update to
current->mm.* and the set_brk/do_brk call to before the point we call
load_elf_interp().

Another bug is that the calls to set_brk/do_brk in fs/binfmt_elf.c fail to
check whether the set_brk/do_brk calls succeeded or not, so they implicitly
assume they do.  Fix is to test for failure from the set_brk/do_brk calls.

Here's a patch. This gives a clearer error message. Though I'm not sure id
large external array could be the only trigger for this. I'd appreciate your
comments/suggestions.

Srikrishnan
PS: I'm reposting this as some people had replied that they could not apply the patch.

--- linux-2.6.0-test5/fs/binfmt_elf.c	Thu Oct  2 02:18:37 2003
+++ linux-2.6.0-test5-change/fs/binfmt_elf.c	Mon Oct 13 16:18:05 2003
@@ -82,13 +82,15 @@
 
 #define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
 
-static void set_brk(unsigned long start, unsigned long end)
+static unsigned set_brk(unsigned long start, unsigned long end)
 {
+	int retval=0;
 	start = ELF_PAGEALIGN(start);
 	end = ELF_PAGEALIGN(end);
 	if (end > start)
-		do_brk(start, end - start);
+		retval = do_brk(start, end - start);
 	current->mm->start_brk = current->mm->brk = end;
+	return retval;
 }
 
 
@@ -393,7 +395,7 @@
 	unsigned long text_data, elf_entry = ~0UL;
 	char * addr;
 	loff_t offset;
-
+	int retval;
 	current->mm->end_code = interp_ex->a_text;
 	text_data = interp_ex->a_text + interp_ex->a_data;
 	current->mm->end_data = text_data;
@@ -413,7 +415,9 @@
 		goto out;
 	}
 
-	do_brk(0, text_data);
+	retval = do_brk(0, text_data);
+	if(BAD_ADDR(retval))
+		goto out;
 	if (!interpreter->f_op || !interpreter->f_op->read)
 		goto out;
 	if (interpreter->f_op->read(interpreter, addr, text_data, &offset) < 0)
@@ -421,8 +425,10 @@
 	flush_icache_range((unsigned long)addr,
 	                   (unsigned long)addr + text_data);
 
-	do_brk(ELF_PAGESTART(text_data + ELF_MIN_ALIGN - 1),
+	retval = do_brk(ELF_PAGESTART(text_data + ELF_MIN_ALIGN - 1),
 		interp_ex->a_bss);
+	if(BAD_ADDR(retval))
+		goto out;
 	elf_entry = interp_ex->a_entry;
 
 out:
@@ -726,7 +732,26 @@
 	end_code += load_bias;
 	start_data += load_bias;
 	end_data += load_bias;
+        
+	current->mm->end_code = end_code;
+	current->mm->start_code = start_code;
+	current->mm->start_data = start_data;
+	current->mm->end_data = end_data;
+	current->mm->start_stack = bprm->p;
+
+	/* Calling set_brk effectively mmaps the pages that we need
+	 * for the bss and break sections.
+         * We must do this now before we load the interpreter
+	 * in case we have a huge bss region.
+	 */
+	retval = set_brk(elf_bss, elf_brk);
+	if(retval < 0) {
+		printk(KERN_ERR "unable to map bss section");
+		send_sig(SIGSEGV, current, 0);
+		goto out_free_dentry;
+		}	
 
+	padzero(elf_bss);
 	if (elf_interpreter) {
 		if (interpreter_type == INTERPRETER_AOUT)
 			elf_entry = load_aout_interp(&interp_ex,
@@ -766,19 +791,6 @@
 	/* N.B. passed_fileno might not be initialized? */
 	if (interpreter_type == INTERPRETER_AOUT)
 		current->mm->arg_start += strlen(passed_fileno) + 1;
-	current->mm->end_code = end_code;
-	current->mm->start_code = start_code;
-	current->mm->start_data = start_data;
-	current->mm->end_data = end_data;
-	current->mm->start_stack = bprm->p;
-
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
