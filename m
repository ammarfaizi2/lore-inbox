Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268005AbUIJXO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268005AbUIJXO1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 19:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268014AbUIJXO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 19:14:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7820 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268005AbUIJXOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 19:14:17 -0400
Message-ID: <41423480.8090104@sgi.com>
Date: Fri, 10 Sep 2004 16:10:56 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
CC: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, John Hesterberg <jh@sgi.com>
Subject: Re: [patch 2.6.8.1] BSD accounting: update chars transferred value
References: <20040908112909.GA10036@frec.bull.fr>
In-Reply-To: <20040908112909.GA10036@frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

This patch is a subset of csa_io with your patch deals with character
IO only.

I can see that merge csa_io's change at vfs_writev() and vfs_readv()
into your change at do_readv_writev(). However, the code change is
not really common code in that a) the operation type is different and
2) the fields to add to are different, so you end up doing extra check 
of file operation type (READ vs WRITE). I would be happy if either
your patch or mine is accepted, but i think it does extra work to put
the changes into the common routine (ie do_readv_writev).

Shall we combine your patch and SGI's csa_io patch?

Andrew, csa_io, csa_mm, and csa_eop patches can be considered
separately. Please consider taking in csa_io since we have another
accounting IO data collection patch in this one. :)

Cheers,
  - jay


Guillaume Thouvenin wrote:
> Hello,
> 
>   The goal of this patch is to improve BSD accounting by using what
> is done in the CSA into BSD accounting. The final goal is to have a
> uniform accounting structure.
> 
>   This patch updates information given by BSD accounting concerning
> bytes read and written. A field is already present in the BSD accounting
> structure but it is never updated. We don't add information about blocks
> read and written because, as it was discussed in previous email, the
> information is inaccurate. Most writes which are flushed delayed would
> get accounted to pdflushd. Thus, one solution to get this kind of
> information is to add counters when the write back is performed. The
> problem is that we don't know how to get information about the PID at
> the page level (ie from struct page). So we remove this information for
> the moment and it will be provided in another patch.
> 
> Changelog:
> 
>   - Adds two counters in the task_struct (rchar, wchar)
>   - Init fields during the creation of the process (during the fork)
>   - File I/O operations are done through sys_read(), sys_write(),
>     sys_readv(), sys_writev() and sys_sendfile(). Some file system, like 
>     NFS, are using vfs_readv() and if we don't add counters here, we
>     will miss something. sys_read() and sys_write() used respectively
>     vfs_read() and vfs_write(). Routines sys_readv() and sys_writev()
>     are using vfs_readv() and vfs_writev(). Both functions are calling
>     do_readv_writev(). Thus we increment counters in vfs_read(), 
>     vfs_write(), do_readv_writev() and do_sendfile(). For the
>     latter, the incrementation is done in the do_sendfile() because this
>     routine is directly called from the return of sys_sendfile(). 
> 
> 
> Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
> 
> diff -uprN -X dontdiff linux-2.6.8.1-vanilla/fs/read_write.c linux-2.6.8.1-char_IO_acct/fs/read_write.c
> --- linux-2.6.8.1-vanilla/fs/read_write.c	2004-08-14 12:55:35.000000000 +0200
> +++ linux-2.6.8.1-char_IO_acct/fs/read_write.c	2004-09-08 13:11:43.832260408 +0200
> @@ -216,8 +216,10 @@ ssize_t vfs_read(struct file *file, char
>  				ret = file->f_op->read(file, buf, count, pos);
>  			else
>  				ret = do_sync_read(file, buf, count, pos);
> -			if (ret > 0)
> +			if (ret > 0) {
>  				dnotify_parent(file->f_dentry, DN_ACCESS);
> +				current->rchar += ret;
> +			}
>  		}
>  	}
>  
> @@ -260,8 +262,10 @@ ssize_t vfs_write(struct file *file, con
>  				ret = file->f_op->write(file, buf, count, pos);
>  			else
>  				ret = do_sync_write(file, buf, count, pos);
> -			if (ret > 0)
> +			if (ret > 0) {
>  				dnotify_parent(file->f_dentry, DN_MODIFY);
> +				current->wchar += ret;
> +			}
>  		}
>  	}
>  
> @@ -496,6 +500,14 @@ out:
>  	if ((ret + (type == READ)) > 0)
>  		dnotify_parent(file->f_dentry,
>  				(type == READ) ? DN_ACCESS : DN_MODIFY);
> +
> +	if (ret > 0) {
> +		if (type == READ)
> +			current->rchar += ret;
> +		else /* type == WRITE */
> +			current->wchar += ret;
> +	}
> +
>  	return ret;
>  }
>  
> @@ -644,6 +656,11 @@ fput_out:
>  fput_in:
>  	fput_light(in_file, fput_needed_in);
>  out:
> +	if (retval > 0) {
> +		current->rchar += retval;
> +		current->wchar += retval;
> +	}
> +	
>  	return retval;
>  }
>  
> diff -uprN -X dontdiff linux-2.6.8.1-vanilla/include/linux/sched.h linux-2.6.8.1-char_IO_acct/include/linux/sched.h
> --- linux-2.6.8.1-vanilla/include/linux/sched.h	2004-08-14 12:54:49.000000000 +0200
> +++ linux-2.6.8.1-char_IO_acct/include/linux/sched.h	2004-09-08 12:49:35.634177208 +0200
> @@ -523,6 +523,9 @@ struct task_struct {
>  	unsigned long ptrace_message;
>  	siginfo_t *last_siginfo; /* For ptrace use.  */
>  
> +/* IO counters: bytes read, bytes written */
> +	unsigned long rchar, wchar;
> +
>  #ifdef CONFIG_NUMA
>    	struct mempolicy *mempolicy;
>    	short il_next;		/* could be shared with used_math */
> diff -uprN -X dontdiff linux-2.6.8.1-vanilla/kernel/acct.c linux-2.6.8.1-char_IO_acct/kernel/acct.c
> --- linux-2.6.8.1-vanilla/kernel/acct.c	2004-08-14 12:55:33.000000000 +0200
> +++ linux-2.6.8.1-char_IO_acct/kernel/acct.c	2004-09-08 12:50:50.058862936 +0200
> @@ -464,8 +464,8 @@ static void do_acct_process(long exitcod
>  	}
>  	vsize = vsize / 1024;
>  	ac.ac_mem = encode_comp_t(vsize);
> -	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
> -	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
> +	ac.ac_io = encode_comp_t(current->rchar + current->wchar);
> +	ac.ac_rw = encode_comp_t(0 /* ac.ac_io / 1024 */);
>  	ac.ac_minflt = encode_comp_t(current->min_flt);
>  	ac.ac_majflt = encode_comp_t(current->maj_flt);
>  	ac.ac_swaps = encode_comp_t(0);
> diff -uprN -X dontdiff linux-2.6.8.1-vanilla/kernel/fork.c linux-2.6.8.1-char_IO_acct/kernel/fork.c
> --- linux-2.6.8.1-vanilla/kernel/fork.c	2004-08-14 12:54:49.000000000 +0200
> +++ linux-2.6.8.1-char_IO_acct/kernel/fork.c	2004-09-08 12:50:07.931267304 +0200
> @@ -965,6 +965,7 @@ struct task_struct *copy_process(unsigne
>  	p->security = NULL;
>  	p->io_context = NULL;
>  	p->audit_context = NULL;
> +	p->rchar = p->wchar = 0;
>  #ifdef CONFIG_NUMA
>   	p->mempolicy = mpol_copy(p->mempolicy);
>   	if (IS_ERR(p->mempolicy)) {

