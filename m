Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292557AbSBPVsr>; Sat, 16 Feb 2002 16:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292553AbSBPVr3>; Sat, 16 Feb 2002 16:47:29 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:24079 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S292555AbSBPVrM>;
	Sat, 16 Feb 2002 16:47:12 -0500
Date: Sat, 16 Feb 2002 01:53:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, viro@math.psu.edu
Subject: binfmt_elf fails to detect errors
Message-ID: <20020216005317.GA120@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Error handling is just not there in binfmt_elf.c. Try this test
program:


#define MAXLEN 20
#define MAXTAG 10
double speedup[MAXLEN][MAXLEN][MAXLEN][MAXLEN][MAXTAG][MAXTAG][MAXTAG];

void
init_speedup(void)
{
	int i, j, k, l, o, m, n;
	for (i=0; i<MAXLEN; i++)
		for (j=0; j<MAXLEN; j++)
			for (k=0; k<MAXLEN; k++)
				for (l=0; l<MAXLEN; l++)
					for (o=0; o<MAXTAG; o++)
						for (m=0; m<MAXTAG; m++)
							for (n=0; n<MAXTAG; n++)
								speedup[i][j][k][l][o][m][n] = -1.0;
}

void main(void)
{
	init_speedup();
}

Compile, run, segfault. Okay, but its because binfmt_elf.c fails to
check error returns. Here is would-be patch (it makes it oops, its
probably broken); but there are more non-checked errors in there.

--- clean/fs/binfmt_elf.c	Mon Feb 11 20:51:04 2002
+++ linux/fs/binfmt_elf.c	Sat Feb 16 01:46:48 2002
@@ -79,13 +79,20 @@
 
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
+		printk("Error %d doing do_brk\n", error);
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
@@ -721,7 +730,9 @@
 	/* Calling set_brk effectively mmaps the pages that we need
 	 * for the bss and break sections
 	 */
-	set_brk(elf_bss, elf_brk);
+	retval = set_brk(elf_bss, elf_brk);
+	if (retval)
+		goto out_free_dentry;
 
 	padzero(elf_bss);
 
@@ -745,6 +756,7 @@
 		error = do_mmap(NULL, 0, 4096, PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE, 0);
 		up_write(&current->mm->mmap_sem);
+		/* FIXME: Check return from mmap! */
 	}
 
 #ifdef ELF_PLAT_INIT
@@ -762,6 +774,8 @@
 		send_sig(SIGTRAP, current, 0);
 	retval = 0;
 out:
+	if (retval)
+		printk("binfmt_elf: Returnning %d\n", retval);
 	return retval;
 
 	/* error cleanup */
@@ -842,9 +856,9 @@
 
 	len = ELF_PAGESTART(elf_phdata->p_filesz + elf_phdata->p_vaddr + ELF_MIN_ALIGN - 1);
 	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
-	if (bss > len)
-		do_brk(len, bss - len);
 	error = 0;
+	if (bss > len)
+		error = do_brk(len, bss - len);
 
 out_free_ph:
 	kfree(elf_phdata);
 
									Pavel
PS: Who is right person to talk with? I choose Al because he likes to
kill bugs in fs/ where binfmt_elf resides, but...

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
