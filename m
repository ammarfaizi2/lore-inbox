Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWHUXgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWHUXgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 19:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWHUXgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 19:36:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34025 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750710AbWHUXgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 19:36:52 -0400
Message-Id: <200608212336.k7LNa1E8008716@pasta.boston.redhat.com>
To: Willy Tarreau <w@1wt.eu>
cc: Marcelo Tosatti <marcelo@kvack.org>, Solar Designer <solar@openwall.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf.c : the BAD_ADDR macro again
In-Reply-To: Your message of "Mon, 21 Aug 2006 23:11:04 +0200."
             <20060821211104.GA7790@1wt.eu>
Date: Mon, 21 Aug 2006 19:36:01 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 21-Aug-2006 at 23:11 +0200, Willy Tarreau wrote:

> > > [...]   But before this, I'd like to get comments from
> > > the people who discussed the subject recently.
> >
> > Thus, I think that both 2.4.33 and 2.6.<latest> are okay without any
> > further changes.
>
> At least 2.4 needs the fix to use the correct BAD_ADDR (which is not
> OK in 2.4.33 yet).

Ah, right.  (Sorry, I was verifying the change in a RHEL3 tree.)

In that case, I support your patch as posted.  But the whole point of
that investigation was to fix an exec() vulnerability with a bad ELF
entry address.  This is addressed in the final hunk of the 2.4.33-based
patch below, which includes the changes that you previously posted.

Cheers.  -ernie



Signed-off-by: Ernie Petrides <petrides@redhat.com>

--- linux-2.4.33/fs/binfmt_elf.c.orig
+++ linux-2.4.33/fs/binfmt_elf.c
@@ -77,7 +77,7 @@ static struct linux_binfmt elf_format = 
 	NULL, THIS_MODULE, load_elf_binary, load_elf_library, elf_core_dump, ELF_EXEC_PAGESIZE
 };
 
-#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
+#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)
 
 static int set_brk(unsigned long start, unsigned long end)
 {
@@ -345,7 +345,7 @@ elf_type, total_size);
 	     * <= p_memsize so it is only necessary to check p_memsz.
 	     */
 	    k = load_addr + eppnt->p_vaddr;
-	    if (k > TASK_SIZE || eppnt->p_filesz > eppnt->p_memsz ||
+	    if (BAD_ADDR(k) || eppnt->p_filesz > eppnt->p_memsz ||
 		eppnt->p_memsz > TASK_SIZE || TASK_SIZE - eppnt->p_memsz < k) {
 	        error = -ENOMEM;
 		goto out_close;
@@ -772,7 +772,7 @@ static int load_elf_binary(struct linux_
 		 * allowed task size. Note that p_filesz must always be
 		 * <= p_memsz so it is only necessary to check p_memsz.
 		 */
-		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
+		if (BAD_ADDR(k) || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
 		    elf_ppnt->p_memsz > TASK_SIZE ||
 		    TASK_SIZE - elf_ppnt->p_memsz < k) {
 			/* set_brk can never work.  Avoid overflows.  */
@@ -822,10 +822,9 @@ static int load_elf_binary(struct linux_
 						    interpreter,
 						    &interp_load_addr);
 		if (BAD_ADDR(elf_entry)) {
-			printk(KERN_ERR "Unable to load interpreter %.128s\n",
-				elf_interpreter);
 			force_sig(SIGSEGV, current);
-			retval = IS_ERR((void *)elf_entry) ? PTR_ERR((void *)elf_entry) : -ENOEXEC;
+			retval = IS_ERR((void *)elf_entry) ?
+					(int)elf_entry : -EINVAL;
 			goto out_free_dentry;
 		}
 		reloc_func_desc = interp_load_addr;
@@ -833,6 +832,12 @@ static int load_elf_binary(struct linux_
 		allow_write_access(interpreter);
 		fput(interpreter);
 		kfree(elf_interpreter);
+	} else {
+		if (BAD_ADDR(elf_entry)) {
+			force_sig(SIGSEGV, current);
+			retval = -EINVAL;
+			goto out_free_dentry;
+		}
 	}
 
 	kfree(elf_phdata);
