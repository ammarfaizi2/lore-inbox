Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWEPOxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWEPOxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWEPOxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:53:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751117AbWEPOxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:53:45 -0400
Date: Tue, 16 May 2006 07:50:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernd Schmidt <bernds_cb1@t-online.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, luke.yang@analog.com,
       gerg@snapgear.com
Subject: Re: Please revert git commit 1ad3dcc0
Message-Id: <20060516075016.036f6cf5.akpm@osdl.org>
In-Reply-To: <4469E1AF.7040908@t-online.de>
References: <4469B63B.6000502@t-online.de>
	<20060516065848.13028f9f.akpm@osdl.org>
	<4469E1AF.7040908@t-online.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schmidt <bernds_cb1@t-online.de> wrote:
>
> Andrew Morton wrote:
> > Bernd Schmidt <bernds_cb1@t-online.de> wrote:
> >> please revert 1ad3dcc0.  That was a patch to the binfmt_flat loader, 
> >> which was motivated by an LTP testcase which checks that execve returns 
> >> EMFILE when the file descriptor table is full.
> >>
> >> The patch is buggy: the code now keeps file descriptors open for the 
> >> executable and its libraries, which has confused at least one 
> >> application.  It's also unnecessary, since there is no code that uses 
> >> the file descriptor, so the new EMFILE error return is totally artificial.
> 
> > I don't get it.  The substance of the patch is
> > 
> > +	/* check file descriptor */
> > +	exec_fileno = get_unused_fd();
> > +	if (exec_fileno < 0) {
> > +		ret = -EMFILE;
> > +		goto err;
> > +	}
> > +	get_file(bprm->file);
> > +	fd_install(exec_fileno, bprm->file);
> > 
> > and that get_file() will be undone by exit().  Without this change we'll
> > forget to do file limit checking.
> 
> It's not the get_file that's the problem, it's the get_unused_fd and 
> fd_install.  These files are now open while the process lives and 
> consume file descriptors.  This does not happen with the ELF loader, 
> which does
> 
>          if (interpreter_type != INTERPRETER_AOUT)
>                  sys_close(elf_exec_fileno);
> 
> before transferring control to the application.  So, fewer file 
> descriptors are available for the app, and they start at a higher number.

OIC.

> Before the change, we didn't allocate or install a file descriptor, 
> hence there wasn't any reason to return EMFILE.  The spec at
>    http://www.opengroup.org/onlinepubs/009695399/functions/exec.html
> doesn't list EMFILE as a possible error.
> 
> If you're unconvinced, then at the very least we need to add a sys_close 
> call in the success path.
> 

If we do that, we lose the ability to fail the exec if the fd table is
full.  So we permit applications to temporarily exceed their limit by one
fd.  Big deal.

And yes, the fact that the kernel internally and temporarily uses a file*
is an implementation detail which userspace doesn't need to care about
(yes?).  In which case LTP is being silly.

It'd be nice not to lose the coding cleanups which that patch needed.  Can
you review-n-test this form of reversion?


diff -puN fs/binfmt_flat.c~binfmt_flat-dont-check-for-emfile fs/binfmt_flat.c
--- devel/fs/binfmt_flat.c~binfmt_flat-dont-check-for-emfile	2006-05-16 07:42:55.000000000 -0700
+++ devel-akpm/fs/binfmt_flat.c	2006-05-16 07:44:07.000000000 -0700
@@ -428,7 +428,6 @@ static int load_flat_file(struct linux_b
 	loff_t fpos;
 	unsigned long start_code, end_code;
 	int ret;
-	int exec_fileno;
 
 	hdr = ((struct flat_hdr *) bprm->buf);		/* exec-header */
 	inode = bprm->file->f_dentry->d_inode;
@@ -502,21 +501,12 @@ static int load_flat_file(struct linux_b
 		goto err;
 	}
 
-	/* check file descriptor */
-	exec_fileno = get_unused_fd();
-	if (exec_fileno < 0) {
-		ret = -EMFILE;
-		goto err;
-	}
-	get_file(bprm->file);
-	fd_install(exec_fileno, bprm->file);
-
 	/* Flush all traces of the currently running executable */
 	if (id == 0) {
 		result = flush_old_exec(bprm);
 		if (result) {
 			ret = result;
-			goto err_close;
+			goto err;
 		}
 
 		/* OK, This is the point of no return */
@@ -548,7 +538,7 @@ static int load_flat_file(struct linux_b
 				textpos = (unsigned long) -ENOMEM;
 			printk("Unable to mmap process text, errno %d\n", (int)-textpos);
 			ret = textpos;
-			goto err_close;
+			goto err;
 		}
 
 		down_write(&current->mm->mmap_sem);
@@ -564,7 +554,7 @@ static int load_flat_file(struct linux_b
 					(int)-datapos);
 			do_munmap(current->mm, textpos, text_len);
 			ret = realdatastart;
-			goto err_close;
+			goto err;
 		}
 		datapos = realdatastart + MAX_SHARED_LIBS * sizeof(unsigned long);
 
@@ -587,7 +577,7 @@ static int load_flat_file(struct linux_b
 			do_munmap(current->mm, textpos, text_len);
 			do_munmap(current->mm, realdatastart, data_len + extra);
 			ret = result;
-			goto err_close;
+			goto err;
 		}
 
 		reloc = (unsigned long *) (datapos+(ntohl(hdr->reloc_start)-text_len));
@@ -606,7 +596,7 @@ static int load_flat_file(struct linux_b
 			printk("Unable to allocate RAM for process text/data, errno %d\n",
 					(int)-textpos);
 			ret = textpos;
-			goto err_close;
+			goto err;
 		}
 
 		realdatastart = textpos + ntohl(hdr->data_start);
@@ -652,7 +642,7 @@ static int load_flat_file(struct linux_b
 			do_munmap(current->mm, textpos, text_len + data_len + extra +
 				MAX_SHARED_LIBS * sizeof(unsigned long));
 			ret = result;
-			goto err_close;
+			goto err;
 		}
 	}
 
@@ -717,7 +707,7 @@ static int load_flat_file(struct linux_b
 				addr = calc_reloc(*rp, libinfo, id, 0);
 				if (addr == RELOC_FAILED) {
 					ret = -ENOEXEC;
-					goto err_close;
+					goto err;
 				}
 				*rp = addr;
 			}
@@ -747,7 +737,7 @@ static int load_flat_file(struct linux_b
 			rp = (unsigned long *) calc_reloc(addr, libinfo, id, 1);
 			if (rp == (unsigned long *)RELOC_FAILED) {
 				ret = -ENOEXEC;
-				goto err_close;
+				goto err;
 			}
 
 			/* Get the pointer's value.  */
@@ -762,7 +752,7 @@ static int load_flat_file(struct linux_b
 				addr = calc_reloc(addr, libinfo, id, 0);
 				if (addr == RELOC_FAILED) {
 					ret = -ENOEXEC;
-					goto err_close;
+					goto err;
 				}
 
 				/* Write back the relocated pointer.  */
@@ -783,8 +773,6 @@ static int load_flat_file(struct linux_b
 			stack_len);
 
 	return 0;
-err_close:
-	sys_close(exec_fileno);
 err:
 	return ret;
 }
_

