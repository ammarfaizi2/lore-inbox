Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269261AbUISQP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269261AbUISQP6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 12:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbUISQP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 12:15:57 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:37382 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269261AbUISQO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 12:14:58 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] reduce stack consumption in load_elf_binary
Date: Sun, 19 Sep 2004 19:14:42 +0300
User-Agent: KMail/1.5.4
Cc: viro@parcelfarce.linux.theplanet.co.uk
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yBbTBmuXc6xSJ2H"
Message-Id: <200409191914.42458.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_yBbTBmuXc6xSJ2H
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Stack usage is reduced from 312 to 120 bytes on i386.

It would be easy to move some of the remaining
local variables from the stack to kmalloced area
(if deemed necessary).

Run tested. Please apply.

On Tuesday 14 September 2004 17:23, Denis Vlasenko wrote:
> I am putting to use an ancient box. Pentium 66.
> It gives me stack overflow errors on 2.6.9-rc2:
... 
> udp_sendmsg+0x35e/0x61a [220]
> sock_sendmsg+0x88/0xa3 [208]
> __nfs_revalidate_inode+0xc7/0x308 [152]
> nfs_lookup_revalidate+0x257/0x4ed [312]
> load_elf_binary+0xc4f/0xcc8 [268]
> load_script+0x1ea/0x220 [136]
> do_execve+0x153/0x1b9 [336]
> Total: 1632
--
vda

--Boundary-00=_yBbTBmuXc6xSJ2H
Content-Type: text/x-diff;
  charset="koi8-r";
  name="linux-2.6.9-rc2.ldelf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.9-rc2.ldelf.patch"

diff -urpN linux-2.6.9-rc2.src/fs/binfmt_elf.c linux-2.6.9-rc2.ldelf/fs/binfmt_elf.c
--- linux-2.6.9-rc2.src/fs/binfmt_elf.c	Mon Sep 13 22:33:29 2004
+++ linux-2.6.9-rc2.ldelf/fs/binfmt_elf.c	Sun Sep 19 18:06:01 2004
@@ -488,25 +488,33 @@ static int load_elf_binary(struct linux_
 	unsigned long elf_entry, interp_load_addr = 0;
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long reloc_func_desc = 0;
-	struct elfhdr elf_ex;
-	struct elfhdr interp_elf_ex;
-  	struct exec interp_ex;
 	char passed_fileno[6];
 	struct files_struct *files;
 	int have_pt_gnu_stack, executable_stack = EXSTACK_DEFAULT;
 	unsigned long def_flags = 0;
+	struct {
+		struct elfhdr elf_ex;
+		struct elfhdr interp_elf_ex;
+  		struct exec interp_ex;
+	} *loc;
+
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc) {
+		retval = -ENOMEM;
+		goto out_ret;
+	}
 	
 	/* Get the exec-header */
-	elf_ex = *((struct elfhdr *) bprm->buf);
+	loc->elf_ex = *((struct elfhdr *) bprm->buf);
 
 	retval = -ENOEXEC;
 	/* First of all, some simple consistency checks */
-	if (memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
+	if (memcmp(loc->elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
 		goto out;
 
-	if (elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN)
+	if (loc->elf_ex.e_type != ET_EXEC && loc->elf_ex.e_type != ET_DYN)
 		goto out;
-	if (!elf_check_arch(&elf_ex))
+	if (!elf_check_arch(&loc->elf_ex))
 		goto out;
 	if (!bprm->file->f_op||!bprm->file->f_op->mmap)
 		goto out;
@@ -514,16 +522,16 @@ static int load_elf_binary(struct linux_
 	/* Now read in all of the header information */
 
 	retval = -ENOMEM;
-	if (elf_ex.e_phentsize != sizeof(struct elf_phdr))
+	if (loc->elf_ex.e_phentsize != sizeof(struct elf_phdr))
 		goto out;
-	if (elf_ex.e_phnum > 65536U / sizeof(struct elf_phdr))
+	if (loc->elf_ex.e_phnum > 65536U / sizeof(struct elf_phdr))
 		goto out;
-	size = elf_ex.e_phnum * sizeof(struct elf_phdr);
+	size = loc->elf_ex.e_phnum * sizeof(struct elf_phdr);
 	elf_phdata = (struct elf_phdr *) kmalloc(size, GFP_KERNEL);
 	if (!elf_phdata)
 		goto out;
 
-	retval = kernel_read(bprm->file, elf_ex.e_phoff, (char *) elf_phdata, size);
+	retval = kernel_read(bprm->file, loc->elf_ex.e_phoff, (char *) elf_phdata, size);
 	if (retval < 0)
 		goto out_free_ph;
 
@@ -554,7 +562,7 @@ static int load_elf_binary(struct linux_
 	start_data = 0;
 	end_data = 0;
 
-	for (i = 0; i < elf_ex.e_phnum; i++) {
+	for (i = 0; i < loc->elf_ex.e_phnum; i++) {
 		if (elf_ppnt->p_type == PT_INTERP) {
 			/* This is the program interpreter used for
 			 * shared libraries - for now assume that this
@@ -601,7 +609,7 @@ static int load_elf_binary(struct linux_
 			 * switch really is going to happen - do this in
 			 * flush_thread().	- akpm
 			 */
-			SET_PERSONALITY(elf_ex, ibcs2_interpreter);
+			SET_PERSONALITY(loc->elf_ex, ibcs2_interpreter);
 
 			interpreter = open_exec(elf_interpreter);
 			retval = PTR_ERR(interpreter);
@@ -612,15 +620,15 @@ static int load_elf_binary(struct linux_
 				goto out_free_dentry;
 
 			/* Get the exec headers */
-			interp_ex = *((struct exec *) bprm->buf);
-			interp_elf_ex = *((struct elfhdr *) bprm->buf);
+			loc->interp_ex = *((struct exec *) bprm->buf);
+			loc->interp_elf_ex = *((struct elfhdr *) bprm->buf);
 			break;
 		}
 		elf_ppnt++;
 	}
 
 	elf_ppnt = elf_phdata;
-	for (i = 0; i < elf_ex.e_phnum; i++, elf_ppnt++)
+	for (i = 0; i < loc->elf_ex.e_phnum; i++, elf_ppnt++)
 		if (elf_ppnt->p_type == PT_GNU_STACK) {
 			if (elf_ppnt->p_flags & PF_X)
 				executable_stack = EXSTACK_ENABLE_X;
@@ -628,19 +636,19 @@ static int load_elf_binary(struct linux_
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
 		}
-	have_pt_gnu_stack = (i < elf_ex.e_phnum);
+	have_pt_gnu_stack = (i < loc->elf_ex.e_phnum);
 
 	/* Some simple consistency checks for the interpreter */
 	if (elf_interpreter) {
 		interpreter_type = INTERPRETER_ELF | INTERPRETER_AOUT;
 
 		/* Now figure out which format our binary is */
-		if ((N_MAGIC(interp_ex) != OMAGIC) &&
-		    (N_MAGIC(interp_ex) != ZMAGIC) &&
-		    (N_MAGIC(interp_ex) != QMAGIC))
+		if ((N_MAGIC(loc->interp_ex) != OMAGIC) &&
+		    (N_MAGIC(loc->interp_ex) != ZMAGIC) &&
+		    (N_MAGIC(loc->interp_ex) != QMAGIC))
 			interpreter_type = INTERPRETER_ELF;
 
-		if (memcmp(interp_elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
+		if (memcmp(loc->interp_elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
 			interpreter_type &= ~INTERPRETER_ELF;
 
 		retval = -ELIBBAD;
@@ -656,11 +664,11 @@ static int load_elf_binary(struct linux_
 		}
 		/* Verify the interpreter has a valid arch */
 		if ((interpreter_type == INTERPRETER_ELF) &&
-		    !elf_check_arch(&interp_elf_ex))
+		    !elf_check_arch(&loc->interp_elf_ex))
 			goto out_free_dentry;
 	} else {
 		/* Executables without an interpreter also need a personality  */
-		SET_PERSONALITY(elf_ex, ibcs2_interpreter);
+		SET_PERSONALITY(loc->elf_ex, ibcs2_interpreter);
 	}
 
 	/* OK, we are done with that, now set up the arg stuff,
@@ -700,8 +708,8 @@ static int load_elf_binary(struct linux_
 
 	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
 	   may depend on the personality.  */
-	SET_PERSONALITY(elf_ex, ibcs2_interpreter);
-	if (elf_read_implies_exec(elf_ex, have_pt_gnu_stack))
+	SET_PERSONALITY(loc->elf_ex, ibcs2_interpreter);
+	if (elf_read_implies_exec(loc->elf_ex, have_pt_gnu_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
 	arch_pick_mmap_layout(current->mm);
@@ -723,7 +731,7 @@ static int load_elf_binary(struct linux_
 	   the image should be loaded at fixed address, not at a variable
 	   address. */
 
-	for(i = 0, elf_ppnt = elf_phdata; i < elf_ex.e_phnum; i++, elf_ppnt++) {
+	for(i = 0, elf_ppnt = elf_phdata; i < loc->elf_ex.e_phnum; i++, elf_ppnt++) {
 		int elf_prot = 0, elf_flags;
 		unsigned long k, vaddr;
 
@@ -758,9 +766,9 @@ static int load_elf_binary(struct linux_
 		elf_flags = MAP_PRIVATE|MAP_DENYWRITE|MAP_EXECUTABLE;
 
 		vaddr = elf_ppnt->p_vaddr;
-		if (elf_ex.e_type == ET_EXEC || load_addr_set) {
+		if (loc->elf_ex.e_type == ET_EXEC || load_addr_set) {
 			elf_flags |= MAP_FIXED;
-		} else if (elf_ex.e_type == ET_DYN) {
+		} else if (loc->elf_ex.e_type == ET_DYN) {
 			/* Try and get dynamic programs out of the way of the default mmap
 			   base, as well as whatever program they might try to exec.  This
 			   is because the brk will follow the loader, and is not movable.  */
@@ -774,7 +782,7 @@ static int load_elf_binary(struct linux_
 		if (!load_addr_set) {
 			load_addr_set = 1;
 			load_addr = (elf_ppnt->p_vaddr - elf_ppnt->p_offset);
-			if (elf_ex.e_type == ET_DYN) {
+			if (loc->elf_ex.e_type == ET_DYN) {
 				load_bias += error -
 				             ELF_PAGESTART(load_bias + vaddr);
 				load_addr += load_bias;
@@ -811,7 +819,7 @@ static int load_elf_binary(struct linux_
 			elf_brk = k;
 	}
 
-	elf_ex.e_entry += load_bias;
+	loc->elf_ex.e_entry += load_bias;
 	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
@@ -833,10 +841,10 @@ static int load_elf_binary(struct linux_
 
 	if (elf_interpreter) {
 		if (interpreter_type == INTERPRETER_AOUT)
-			elf_entry = load_aout_interp(&interp_ex,
+			elf_entry = load_aout_interp(&loc->interp_ex,
 						     interpreter);
 		else
-			elf_entry = load_elf_interp(&interp_elf_ex,
+			elf_entry = load_elf_interp(&loc->interp_elf_ex,
 						    interpreter,
 						    &interp_load_addr);
 		if (BAD_ADDR(elf_entry)) {
@@ -851,7 +859,7 @@ static int load_elf_binary(struct linux_
 		fput(interpreter);
 		kfree(elf_interpreter);
 	} else {
-		elf_entry = elf_ex.e_entry;
+		elf_entry = loc->elf_ex.e_entry;
 	}
 
 	kfree(elf_phdata);
@@ -863,7 +871,7 @@ static int load_elf_binary(struct linux_
 
 	compute_creds(bprm);
 	current->flags &= ~PF_FORKNOEXEC;
-	create_elf_tables(bprm, &elf_ex, (interpreter_type == INTERPRETER_AOUT),
+	create_elf_tables(bprm, &loc->elf_ex, (interpreter_type == INTERPRETER_AOUT),
 			load_addr, interp_load_addr);
 	/* N.B. passed_fileno might not be initialized? */
 	if (interpreter_type == INTERPRETER_AOUT)
@@ -908,6 +916,8 @@ static int load_elf_binary(struct linux_
 	}
 	retval = 0;
 out:
+	kfree(loc);
+out_ret:
 	return retval;
 
 	/* error cleanup */

--Boundary-00=_yBbTBmuXc6xSJ2H--

