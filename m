Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293518AbSCFNov>; Wed, 6 Mar 2002 08:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293526AbSCFNom>; Wed, 6 Mar 2002 08:44:42 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:1540 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S293525AbSCFNof>;
	Wed, 6 Mar 2002 08:44:35 -0500
Date: Wed, 6 Mar 2002 00:34:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        "Marcelo W. Tosatti" <marcelo@conectiva.com.br>
Subject: execve() fails to report errors
Message-ID: <20020305233437.GA130@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Take this trivial .c program. Obviously correct.


struct foo {
        char fill[1*1024*1024*1024];
};

struct foo a;

void
main(void)
{
}

Compile. Run. Segfault.

Whose fault? Kernels; it fails to corectly report not enough address
space.

Now, I do not know if this is the right fix (binfmt_elf looks
spaghetty to me) but its certainly better than it was.

							Pavel

--- clean/fs/binfmt_elf.c	Tue Mar  5 21:52:44 2002
+++ linux/fs/binfmt_elf.c	Wed Mar  6 00:14:31 2002
@@ -79,13 +79,19 @@
 
 #define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
 
-static void set_brk(unsigned long start, unsigned long end)
+static int set_brk(unsigned long start, unsigned long end)
 {
+	int error;
 	start = ELF_PAGEALIGN(start);
 	end = ELF_PAGEALIGN(end);
 	if (end <= start)
-		return;
-	do_brk(start, end - start);
+		return 0;
+	
+	error = do_brk(start, end - start);
+	if (error!=start) {
+		return error;
+	}
+	return 0;
 }
 
 
@@ -606,7 +613,9 @@
 			/* There was a PT_LOAD segment with p_memsz > p_filesz
 			   before this one. Map anonymous pages, if needed,
 			   and clear the area.  */
-			set_brk (elf_bss + load_bias, elf_brk + load_bias);
+			retval = set_brk (elf_bss + load_bias, elf_brk + load_bias);
+			if (retval)
+				goto out_free_dentry;
 			nbyte = ELF_PAGEOFFSET(elf_bss);
 			if (nbyte) {
 				nbyte = ELF_MIN_ALIGN - nbyte;
@@ -721,8 +730,7 @@
 	/* Calling set_brk effectively mmaps the pages that we need
 	 * for the bss and break sections
 	 */
-	set_brk(elf_bss, elf_brk);
-
+	retval = set_brk(elf_bss, elf_brk);
 	padzero(elf_bss);
 
 #if 0
@@ -745,6 +753,7 @@
 		error = do_mmap(NULL, 0, 4096, PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE, 0);
 		up_write(&current->mm->mmap_sem);
+		/* FIXME: Check return from mmap! */
 	}
 
 #ifdef ELF_PLAT_INIT
@@ -760,8 +769,7 @@
 	start_thread(regs, elf_entry, bprm->p);
 	if (current->ptrace & PT_PTRACED)
 		send_sig(SIGTRAP, current, 0);
-	retval = 0;
 out:
 	return retval;
 
 	/* error cleanup */
@@ -842,9 +852,9 @@
 
 	len = ELF_PAGESTART(elf_phdata->p_filesz + elf_phdata->p_vaddr + ELF_MIN_ALIGN - 1);
 	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
-	if (bss > len)
-		do_brk(len, bss - len);
 	error = 0;
+	if (bss > len)
+		error = do_brk(len, bss - len);
 
 out_free_ph:
 	kfree(elf_phdata);

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
