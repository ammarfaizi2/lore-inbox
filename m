Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbSJRTCO>; Fri, 18 Oct 2002 15:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbSJRTBc>; Fri, 18 Oct 2002 15:01:32 -0400
Received: from [198.149.18.6] ([198.149.18.6]:58790 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265200AbSJRS7x>;
	Fri, 18 Oct 2002 14:59:53 -0400
Date: Fri, 18 Oct 2002 14:05:46 -0500
From: John Hesterberg <jh@sgi.com>
To: Christoph Hellwig <hch@sgi.com>, linux-kernel@vger.kernel.org,
       Robin Holt <holt@sgi.com>
Cc: Dan Higgins <djh@sgi.com>
Subject: Re: [PATCH] 2.5.43 CSA, Job, and PAGG
Message-ID: <20021018140546.M25310@sgi.com>
References: <20021017102146.A17642@sgi.com> <20021017223328.B25777@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021017223328.B25777@sgi.com>; from hch@sgi.com on Thu, Oct 17, 2002 at 10:33:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,
Thanks for your comments!
I'm making all the changes, except the items noted below,
which might need more discussion.

On Thu, Oct 17, 2002 at 10:33:28PM -0400, Christoph Hellwig wrote:
> diff -Naur 2.5.42/include/linux/sched.h job25p/include/linux/sched.h
> --- 2.5.42/include/linux/sched.h	Tue Oct  8 17:52:35 2002
> +++ job25p/include/linux/sched.h	Wed Oct 16 15:38:31 2002
> @@ -29,6 +29,7 @@
>  #include <linux/compiler.h>
>  #include <linux/completion.h>
>  #include <linux/pid.h>
> +#include <linux/pagg.h>
>  
>  struct exec_domain;
>  
> @@ -401,6 +402,9 @@
>  	void *journal_info;
>  	struct dentry *proc_dentry;
>  	struct backing_dev_info *backing_dev_info;
> +
> +/* List of pagg (process aggregate) attachments */
> +	struct pagg_list_s pagg_list;
>  };
> 
> You don't need the header for an unreferences structure pointer.
> And sched.h already includes far to many other headers..

It's not a structure pointer, it's the structure itself.

> 
> +/* Host ID for the localhost */
> +static uint32_t   jid_hid = DISABLED;
> +
> +static char 	   *hid = NULL;	    
> +MODULE_PARM(hid, "s");
> 
> What's this for?

A host id (hid) is used as the top 32 bits of the job id.
It gets initialized when you load the module, and can be
changed with the JOB_SETHID call.

> 
> +#if defined(CONFIG_CSA_JOB_ACCT) || defined(CONFIG_CSA_JOB_ACCT_MODULE)
> +		/* - CSA accounting */
> +		if (acct_list[JOB_ACCT_CSA]) {
> +			job_acctmod_t *acct = acct_list[JOB_ACCT_CSA];
> +			if (try_inc_mod_count(acct->module)) {
> +				if (acct->do_jobend) {
> +					int res = 0;
> +					job_csa_t csa;
> 
> Shouldn't this use a proper interface instead of the ugly conditional?

We agree, but haven't had the time to fix this yet.

On IRIX, where this is ported from, this is how CSA is hooked into Job.
When it was ported over, they kept it the same way.

> 
> +	/* Setup our /proc entry file */
> +	job_proc_entry = create_proc_entry(JOB_PROC_ENTRY,
> +		S_IFREG | S_IRUGO, &proc_root);
> +
> +	if (!job_proc_entry) {
> +		unregister_pagg_hook(&pagg_hook);
> +		return -1;
> +	}
> +
> +	job_proc_entry->proc_fops = &job_file_ops;
> +	job_proc_entry->proc_iops = NULL;
> 
> Umm, no, ioctl on procfs is not the proper interfaces.  It looks like
> all ioctl subcalls were syscalls initially (on unicos?), so doing the
> as actual syscalls would at least be better.  Defining a proper
> ascii file interface (i.e. echo start <arg1> <arg2> <etc.. > file)
> sounds better.

What we *really* want would be a new syscall, but we can't lock down
the syscall number in an external patch.  If we get integrated by Linus,
then we'd love to cut over to a new syscall.  For now, the ioctl on
/proc behaves almost identically to how a new syscall would,
in that we pass down arguments in binary format, can copyout
results, etc.  This is what the code on both ends is expecting.

I don't like the ascii file interface in this case, as it would require
the code on both sides to munge the arguments to/from ascii, and
would break the interfaces that are not just passing in arguments.

John
