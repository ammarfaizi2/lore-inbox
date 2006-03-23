Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWCWHuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWCWHuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 02:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965306AbWCWHuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 02:50:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5328 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965294AbWCWHuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 02:50:15 -0500
Date: Wed, 22 Mar 2006 23:46:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix bug: flat binary loader doesn't check fd table full
Message-Id: <20060322234652.10f6afee.akpm@osdl.org>
In-Reply-To: <489ecd0c0603222310j3f2b9804k30bca1adce33804d@mail.gmail.com>
References: <489ecd0c0603222310j3f2b9804k30bca1adce33804d@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luke Yang" <luke.adi@gmail.com> wrote:
>
> Hi all,
> 
>    In the binfmt_flat.c, the flat binary loader should check file
> descriptor table and install the fd on the file.
> 

Please put the Signed-off-by: at the end of the changelog, not at the end
of the email.

By convention, Signed-off-by: starts with an upper-case 'S'.

> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c

gmail mangles patches by replacing tabs with spaces.  I don't think there's
a fix for that apart from using text/plain attachments or switching mail
setups.  Using attachments is unpopular because it makes it harder to reply
to the email, quoting parts of the patch.

> index 108d56b..6388187 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -493,6 +493,13 @@ static int load_flat_file(struct linux_b
>         if (data_len + bss_len > rlim)
>                 return -ENOMEM;
> 
> +       /* check file descriptor */
> +       int retval = get_unused_fd();

Please don't declare variables in the middle of functions like this.  It's
contrary to kernel style and some gcc versions will emit warnings.

> +       if (retval < 0)
> +               return -EMFILE;
> +       get_file(bprm->file);
> +       fd_install(retval, bprm->file);
> +

But if this function returns an error from this point on, we'll leak a
reference on bprm->file.  Note how load_elf_binary() does
sys_close(elf_exec_fileno) in various places.

You'll find it's a pain in the ass to fix this, because load_flat_file()
has no fewer than 17 return statements in it.  Here we learn why we
shouldn't do that.

The preferred fix would be to convert load_flat_file() to have a single
exit-point (via gotos) (or maybe one return point for success and one for
errors.  No more).  And to then layer this bugfix on top of that.  All the
gotos after the get_file() should be to a different label: one which does
the sys_close() and then falls through to the final return statement.


err, I did this really quickly.  Please review and test:

diff -puN fs/binfmt_flat.c~fix-bug-flat-binary-loader-doesnt-check-fd-table-full fs/binfmt_flat.c
--- devel/fs/binfmt_flat.c~fix-bug-flat-binary-loader-doesnt-check-fd-table-full	2006-03-22 23:28:34.000000000 -0800
+++ devel-akpm/fs/binfmt_flat.c	2006-03-22 23:45:34.000000000 -0800
@@ -426,6 +426,8 @@ static int load_flat_file(struct linux_b
 	int i, rev, relocs = 0;
 	loff_t fpos;
 	unsigned long start_code, end_code;
+	int ret;
+	int exec_fileno;
 
 	hdr = ((struct flat_hdr *) bprm->buf);		/* exec-header */
 	inode = bprm->file->f_dentry->d_inode;
@@ -450,7 +452,8 @@ static int load_flat_file(struct linux_b
 		 */
 		if (strncmp(hdr->magic, "#!", 2))
 			printk("BINFMT_FLAT: bad header magic\n");
-		return -ENOEXEC;
+		ret = -ENOEXEC;
+		goto err;
 	}
 
 	if (flags & FLAT_FLAG_KTRACE)
@@ -458,14 +461,16 @@ static int load_flat_file(struct linux_b
 
 	if (rev != FLAT_VERSION && rev != OLD_FLAT_VERSION) {
 		printk("BINFMT_FLAT: bad flat file version 0x%x (supported 0x%x and 0x%x)\n", rev, FLAT_VERSION, OLD_FLAT_VERSION);
-		return -ENOEXEC;
+		ret = -ENOEXEC;
+		goto err;
 	}
 	
 	/* Don't allow old format executables to use shared libraries */
 	if (rev == OLD_FLAT_VERSION && id != 0) {
 		printk("BINFMT_FLAT: shared libraries are not available before rev 0x%x\n",
 				(int) FLAT_VERSION);
-		return -ENOEXEC;
+		ret = -ENOEXEC;
+		goto err;
 	}
 
 	/*
@@ -478,7 +483,8 @@ static int load_flat_file(struct linux_b
 #ifndef CONFIG_BINFMT_ZFLAT
 	if (flags & (FLAT_FLAG_GZIP|FLAT_FLAG_GZDATA)) {
 		printk("Support for ZFLAT executables is not enabled.\n");
-		return -ENOEXEC;
+		ret = -ENOEXEC;
+		goto err;
 	}
 #endif
 
@@ -490,14 +496,27 @@ static int load_flat_file(struct linux_b
 	rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
 	if (rlim >= RLIM_INFINITY)
 		rlim = ~0;
-	if (data_len + bss_len > rlim)
-		return -ENOMEM;
+	if (data_len + bss_len > rlim) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/* check file descriptor */
+	exec_fileno = get_unused_fd();
+	if (exec_fileno < 0) {
+		ret = -EMFILE;
+		goto err;
+	}
+	get_file(bprm->file);
+	fd_install(exec_fileno, bprm->file);
 
 	/* Flush all traces of the currently running executable */
 	if (id == 0) {
 		result = flush_old_exec(bprm);
-		if (result)
-			return result;
+		if (result) {
+			ret = result;
+			goto err_close;
+		}
 
 		/* OK, This is the point of no return */
 		set_personality(PER_LINUX);
@@ -527,7 +546,8 @@ static int load_flat_file(struct linux_b
 			if (!textpos)
 				textpos = (unsigned long) -ENOMEM;
 			printk("Unable to mmap process text, errno %d\n", (int)-textpos);
-			return(textpos);
+			ret = textpos;
+			goto err_close;
 		}
 
 		down_write(&current->mm->mmap_sem);
@@ -542,7 +562,8 @@ static int load_flat_file(struct linux_b
 			printk("Unable to allocate RAM for process data, errno %d\n",
 					(int)-datapos);
 			do_munmap(current->mm, textpos, text_len);
-			return realdatastart;
+			ret = realdatastart;
+			goto err_close;
 		}
 		datapos = realdatastart + MAX_SHARED_LIBS * sizeof(unsigned long);
 
@@ -564,7 +585,8 @@ static int load_flat_file(struct linux_b
 			printk("Unable to read data+bss, errno %d\n", (int)-result);
 			do_munmap(current->mm, textpos, text_len);
 			do_munmap(current->mm, realdatastart, data_len + extra);
-			return result;
+			ret = result;
+			goto err_close;
 		}
 
 		reloc = (unsigned long *) (datapos+(ntohl(hdr->reloc_start)-text_len));
@@ -582,7 +604,8 @@ static int load_flat_file(struct linux_b
 				textpos = (unsigned long) -ENOMEM;
 			printk("Unable to allocate RAM for process text/data, errno %d\n",
 					(int)-textpos);
-			return(textpos);
+			ret = textpos;
+			goto err_close;
 		}
 
 		realdatastart = textpos + ntohl(hdr->data_start);
@@ -627,7 +650,8 @@ static int load_flat_file(struct linux_b
 			printk("Unable to read code+data+bss, errno %d\n",(int)-result);
 			do_munmap(current->mm, textpos, text_len + data_len + extra +
 				MAX_SHARED_LIBS * sizeof(unsigned long));
-			return result;
+			ret = result;
+			goto err_close;
 		}
 	}
 
@@ -690,8 +714,10 @@ static int load_flat_file(struct linux_b
 			unsigned long addr;
 			if (*rp) {
 				addr = calc_reloc(*rp, libinfo, id, 0);
-				if (addr == RELOC_FAILED)
-					return -ENOEXEC;
+				if (addr == RELOC_FAILED) {
+					ret = -ENOEXEC;
+					goto err_close;
+				}
 				*rp = addr;
 			}
 		}
@@ -718,8 +744,10 @@ static int load_flat_file(struct linux_b
 			relval = ntohl(reloc[i]);
 			addr = flat_get_relocate_addr(relval);
 			rp = (unsigned long *) calc_reloc(addr, libinfo, id, 1);
-			if (rp == (unsigned long *)RELOC_FAILED)
-				return -ENOEXEC;
+			if (rp == (unsigned long *)RELOC_FAILED) {
+				ret = -ENOEXEC;
+				goto err_close;
+			}
 
 			/* Get the pointer's value.  */
 			addr = flat_get_addr_from_rp(rp, relval, flags);
@@ -731,8 +759,10 @@ static int load_flat_file(struct linux_b
 				if ((flags & FLAT_FLAG_GOTPIC) == 0)
 					addr = ntohl(addr);
 				addr = calc_reloc(addr, libinfo, id, 0);
-				if (addr == RELOC_FAILED)
-					return -ENOEXEC;
+				if (addr == RELOC_FAILED) {
+					ret = -ENOEXEC;
+					goto err_close;
+				}
 
 				/* Write back the relocated pointer.  */
 				flat_put_addr_at_rp(rp, addr, relval);
@@ -752,6 +782,10 @@ static int load_flat_file(struct linux_b
 			stack_len);
 
 	return 0;
+err_close:
+	sys_close(exec_fileno);
+err:
+	return ret;
 }
 
 
_

