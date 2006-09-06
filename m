Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWIFXCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWIFXCr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWIFXCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:02:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:57804 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964996AbWIFXCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:02:13 -0400
Date: Wed, 6 Sep 2006 15:57:08 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ernie Petrides <petrides@redhat.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 23/37] binfmt_elf: fix checks for bad address
Message-ID: <20060906225708.GX15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="binfmt_elf-fix-checks-for-bad-address.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Ernie Petrides <petrides@redhat.com>

[PATCH] binfmt_elf: fix checks for bad address

Fix check for bad address; use macro instead of open-coding two checks.

Taken from RHEL4 kernel update.

  For background, the BAD_ADDR() macro should return TRUE if the address is
  TASK_SIZE, because that's the lowest address that is *not* valid for
  user-space mappings.  The macro was correct in binfmt_aout.c but was wrong
  for the "equal to" case in binfmt_elf.c.  There were two in-line validations
  of user-space addresses in binfmt_elf.c, which have been appropriately
  converted to use the corrected BAD_ADDR() macro in the patch you posted
  yesterday.  Note that the size checks against TASK_SIZE are okay as coded.

  The additional changes that I propose are below.  These are in the error
  paths for bad ELF entry addresses once load_elf_binary() has already
  committed to exec'ing the new image (following the tearing down of the
  task's original address space).

  The 1st hunk deals with the interp-side of the outer "if".  There were two
  problems here.  The printk() should be removed because this path can be
  triggered at will by a bogus interpreter image created and used by a
  malicious user.  Further, the error code should not be ENOEXEC, because that
  causes the loop in search_binary_handler() to continue trying other exec
  handlers (twice, in fact).  But it's too late for this to work correctly,
  because the user address space has already been torn down, and an exec()
  failure cannot be returned to the user code because the code no longer
  exists.  The only recovery is to force a SIGSEGV, but it's best to terminate
  the search loop immediately.  I somewhat arbitrarily chose EINVAL as a
  fallback error code, but any error returned by load_elf_interp() will
  override that (but this value will never be seen by user-space).

  The 2nd hunk deals with the non-interp-side of the outer "if".  There were
  two problems here as well.  The SIGSEGV needs to be forced, because a prior
  sigaction() syscall might have set the associated disposition to SIG_IGN.
  And the ENOEXEC should be changed to EINVAL as described above.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/binfmt_elf.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- linux-2.6.17.11.orig/fs/binfmt_elf.c
+++ linux-2.6.17.11/fs/binfmt_elf.c
@@ -86,7 +86,7 @@ static struct linux_binfmt elf_format = 
 		.min_coredump	= ELF_EXEC_PAGESIZE
 };
 
-#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
+#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)
 
 static int set_brk(unsigned long start, unsigned long end)
 {
@@ -389,7 +389,7 @@ static unsigned long load_elf_interp(str
 	     * <= p_memsize so it is only necessary to check p_memsz.
 	     */
 	    k = load_addr + eppnt->p_vaddr;
-	    if (k > TASK_SIZE || eppnt->p_filesz > eppnt->p_memsz ||
+	    if (BAD_ADDR(k) || eppnt->p_filesz > eppnt->p_memsz ||
 		eppnt->p_memsz > TASK_SIZE || TASK_SIZE - eppnt->p_memsz < k) {
 	        error = -ENOMEM;
 		goto out_close;
@@ -876,7 +876,7 @@ static int load_elf_binary(struct linux_
 		 * allowed task size. Note that p_filesz must always be
 		 * <= p_memsz so it is only necessary to check p_memsz.
 		 */
-		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
+		if (BAD_ADDR(k) || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
 		    elf_ppnt->p_memsz > TASK_SIZE ||
 		    TASK_SIZE - elf_ppnt->p_memsz < k) {
 			/* set_brk can never work.  Avoid overflows.  */
@@ -930,10 +930,9 @@ static int load_elf_binary(struct linux_
 						    interpreter,
 						    &interp_load_addr);
 		if (BAD_ADDR(elf_entry)) {
-			printk(KERN_ERR "Unable to load interpreter %.128s\n",
-				elf_interpreter);
 			force_sig(SIGSEGV, current);
-			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
+			retval = IS_ERR((void *)elf_entry) ?
+					(int)elf_entry : -EINVAL;
 			goto out_free_dentry;
 		}
 		reloc_func_desc = interp_load_addr;
@@ -944,8 +943,8 @@ static int load_elf_binary(struct linux_
 	} else {
 		elf_entry = loc->elf_ex.e_entry;
 		if (BAD_ADDR(elf_entry)) {
-			send_sig(SIGSEGV, current, 0);
-			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
+			force_sig(SIGSEGV, current);
+			retval = -EINVAL;
 			goto out_free_dentry;
 		}
 	}

--
