Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUJWD4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUJWD4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUJWDyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 23:54:39 -0400
Received: from gold.pobox.com ([208.210.124.73]:48580 "EHLO gold.pobox.com")
	by vger.kernel.org with ESMTP id S266319AbUJWDxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 23:53:02 -0400
Date: Fri, 22 Oct 2004 20:52:58 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       roland@redhat.com, jdewand@redhat.com
Subject: [PATCH][2.4] ELF fixes for executables with huge BSS (1/2)
Message-ID: <20041023035258.GA3445@ip68-4-98-123.oc.oc.cox.net>
References: <20041023034127.GA26813@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023034127.GA26813@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a 2.4.27-2.4.28 port of the following patch:

http://linux.bkbits.net:8080/linux-2.5/cset@3ff112802L-9-rs0BbkozDnTnpch9w

> [PATCH] fix ELF exec with huge bss
> 
> From: Roland McGrath <roland@redhat.com>
> 
> The following test program will crash every time if dynamically linked.
> I think this bites all 32-bit platforms, including 32-bit executables on
> 64-bit platforms that support them (and could in theory bite 64-bit
> platforms with bss sizes beyond the bounds of comprehension).
> 
>         volatile char hugebss[1080000000];
>         main() { printf("%p..%p\n", &hugebss[0], &hugebss[sizeof hugebss]);
>          system("cat /proc/$PPID/maps");
>          hugebss[sizeof hugebss - 1] = 1;
>          return 23;
>         }
> 
> The problem is that the kernel maps ld.so at 0x40000000 or some such place,
> before it maps the bss.  Here the bss is so large that it overlaps and
> clobbers that mapping.  I've changed it to map the bss before it loads the
> interpreter, so that part of the address space is reserved before ld.so's
> mapping (which doesn't really care where it goes) is done.
> 
> This patch also adds error checking to the bss setup (and interpreter's bss
> setup).  With the aforementioned change but no error checking, "ulimit -v
> 65536; ./hugebss" will crash in the store after the `system' call, because
> the kernel will have failed to allocate the bss and ignored the error, so
> the program runs without those pages being mapped at all.  With this change
> it dies with a SIGKILL as for a failure to set up stack pages.  It might be
> even better to try to detect the case earlier so that execve can return an
> error before it has wiped out the address space.  But that seems like it
> would always be fragile and miss some corner cases, so I did not try to add
> such complexity.

Signed-off-by: Barry K. Nathan <barryn@pobox.com>


diff -ruN linux-2.4.28-pre4-bk2/fs/binfmt_elf.c linux-2.4.28-pre4-bk2-bkn1/fs/binfmt_elf.c
--- linux-2.4.28-pre4-bk2/fs/binfmt_elf.c	2004-04-14 06:05:40.000000000 -0700
+++ linux-2.4.28-pre4-bk2-bkn1/fs/binfmt_elf.c	2004-10-16 03:44:41.000000000 -0700
@@ -79,13 +79,17 @@
 
 #define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
 
-static void set_brk(unsigned long start, unsigned long end)
+static int set_brk(unsigned long start, unsigned long end)
 {
 	start = ELF_PAGEALIGN(start);
 	end = ELF_PAGEALIGN(end);
-	if (end <= start)
-		return;
-	do_brk(start, end - start);
+	if (end > start) {
+		unsigned long addr = do_brk(start, end - start);
+		if (BAD_ADDR(addr))
+			return addr;
+	}
+	current->mm->start_brk = current->mm->brk = end;
+	return 0;
 }
 
 
@@ -357,8 +361,11 @@
 	elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);	/* What we have mapped so far */
 
 	/* Map the last of the bss segment */
-	if (last_bss > elf_bss)
-		do_brk(elf_bss, last_bss - elf_bss);
+	if (last_bss > elf_bss) {
+		error = do_brk(elf_bss, last_bss - elf_bss);
+		if (BAD_ADDR(error))
+			goto out_close;
+	}
 
 	*interp_load_addr = load_addr;
 	error = ((unsigned long) interp_elf_ex->e_entry) + load_addr;
@@ -655,7 +662,12 @@
 			/* There was a PT_LOAD segment with p_memsz > p_filesz
 			   before this one. Map anonymous pages, if needed,
 			   and clear the area.  */
-			set_brk (elf_bss + load_bias, elf_brk + load_bias);
+			retval = set_brk (elf_bss + load_bias,
+					  elf_brk + load_bias);
+			if (retval) {
+				send_sig(SIGKILL, current, 0);
+				goto out_free_dentry;
+			}
 			nbyte = ELF_PAGEOFFSET(elf_bss);
 			if (nbyte) {
 				nbyte = ELF_MIN_ALIGN - nbyte;
@@ -720,6 +732,18 @@
 	start_data += load_bias;
 	end_data += load_bias;
 
+	/* Calling set_brk effectively mmaps the pages that we need
+	 * for the bss and break sections.  We must do this before
+	 * mapping in the interpreter, to make sure it doesn't wind
+	 * up getting placed where the bss needs to go.
+	 */
+	retval = set_brk(elf_bss, elf_brk);
+	if (retval) {
+		send_sig(SIGKILL, current, 0);
+		goto out_free_dentry;
+	}
+	padzero(elf_bss);
+
 	if (elf_interpreter) {
 		if (interpreter_type == INTERPRETER_AOUT)
 			elf_entry = load_aout_interp(&interp_ex,
@@ -768,13 +792,6 @@
 	current->mm->end_data = end_data;
 	current->mm->start_stack = bprm->p;
 
-	/* Calling set_brk effectively mmaps the pages that we need
-	 * for the bss and break sections
-	 */
-	set_brk(elf_bss, elf_brk);
-
-	padzero(elf_bss);
-
 #if 0
 	printk("(start_brk) %lx\n" , (long) current->mm->start_brk);
 	printk("(end_code) %lx\n" , (long) current->mm->end_code);
