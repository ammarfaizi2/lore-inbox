Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWDUAI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWDUAI6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWDUAI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:08:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750740AbWDUAI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:08:57 -0400
Date: Thu, 20 Apr 2006 17:07:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, sct@redhat.com, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] FS-Cache: Avoid ENFILE checking for kernel-specific
 open files
Message-Id: <20060420170754.39294603.akpm@osdl.org>
In-Reply-To: <20060420165932.9968.40376.stgit@warthog.cambridge.redhat.com>
References: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
	<20060420165932.9968.40376.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Make it possible to avoid ENFILE checking for kernel specific open files, such
> as are used by the CacheFiles module.
> 
> After, for example, tarring up a kernel source tree over the network, the
> CacheFiles module may easily have 20000+ files open in the backing filesystem,
> thus causing all non-root processes to be given error ENFILE when they try to
> open a file, socket, pipe, etc..
> 
>  ...
>
>  
>  static struct percpu_counter nr_files __cacheline_aligned_in_smp;
> +static atomic_t nr_kernel_files;

So it's not performance-critical.

> -struct file *get_empty_filp(void)
> +struct file *get_empty_filp(int kernel)

I'd suggest a new get_empty_kernel_filp(void) rather than providing a magic
argument.  (we can still have the magic argument in the new
__get_empty_filp(int), but it shouldn't be part of the caller-visible API).

> +	if (!kernel) {
> +		if (get_nr_files() >= files_stat.max_files &&
> +		    !capable(CAP_SYS_ADMIN)
> +		    ) {

ugly.

> +	f->f_kernel_flags = kernel ? FKFLAGS_KERNEL : 0;

It would be more flexible to make the caller pass in the flags directly.

>  	f->f_uid = tsk->fsuid;
>  	f->f_gid = tsk->fsgid;
>  	eventpoll_init_file(f);
> @@ -235,6 +250,7 @@ struct file fastcall *fget_light(unsigne
>  	return file;
>  }
>  
> +EXPORT_SYMBOL(fget_light);

fget_light is not otherwise referenced in this patch.

this change is not changelogged.

why non-GPL?

> +EXPORT_SYMBOL(dentry_open_kernel);

_GPL?

> @@ -640,6 +643,7 @@ struct file {
>  	atomic_t		f_count;
>  	unsigned int 		f_flags;
>  	mode_t			f_mode;
> +	unsigned short		f_kernel_flags;
>  	loff_t			f_pos;
>  	struct fown_struct	f_owner;
>  	unsigned int		f_uid, f_gid;

That's unfortunate.  There's still room in f_flags.  Was it hard to use that?

> @@ -943,7 +943,7 @@ static ctl_table fs_table[] = {
>  		.ctl_name	= FS_NRFILE,
>  		.procname	= "file-nr",
>  		.data		= &files_stat,
> -		.maxlen		= 3*sizeof(int),
> +		.maxlen		= 4*sizeof(int),
>  		.mode		= 0444,
>  		.proc_handler	= &proc_nr_files,

This changes the format of /proc/sys/fs/file-nr.  What will break?


