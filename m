Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVGOUQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVGOUQc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVGOUQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:16:32 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:3254 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261921AbVGOUQb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:16:31 -0400
Date: Fri, 15 Jul 2005 22:12:21 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: dierbro <dierbro@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] add rlimit file to /proc/PID
Message-ID: <20050715201221.GA10017@electric-eye.fr.zoreil.com>
References: <42D80BBC.3020301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D80BBC.3020301@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dierbro <dierbro@gmail.com> :
[...]
> with a friend i have made this patch that add rlimit file to /proc/PID
> directory.
> Trought this file you can set and get rlimit of a running process.

I am not sure that new proc-functions will be welcome, anyway...

[...]
> --- linux-2.6.13-rc3/fs/proc/base.c	2005-07-15 20:57:25.000000000 +0200
> +++ linux-2.6.13-rc3/fs/proc/base.c.rlimit	2005-07-15 20:57:05.000000000 +0200
> +static int rlimit_read(struct file * file, char __user * buf,
> +		                        size_t count, loff_t *ppos)
> +{
> +	struct task_struct *task = proc_task(file->f_dentry->d_inode);
> +	int res = 0, i;
> +	unsigned long len;
> +	char buffer[2048];
                    ^^^^
Ahem...

> +	if(task){
> +	
> +		for(i=0; i<RLIM_NLIMITS;i++)
> +			switch(i){
> +				case RLIMIT_AS:
> +					len = sprintf(buffer+res, "RLIMIT_AS %d %d\n",
> +							(int) task->signal->rlim[i].rlim_cur,
> +							(int)task->signal->rlim[i].rlim_max);
> +					res+=len;
> +					break;
[generous code duplication deleted]

You want an initialized array for the strings "RLIMIT_AS", "RLIMIT_CORE", etc.

[...]
> +static ssize_t rlimit_write(struct file * file, const char * buffer,
> +			 size_t count, loff_t *ppos)
> +{
> +	struct task_struct *task = proc_task(file->f_dentry->d_inode);
> +	unsigned long cur,max;
> +	char *c;
> +	char *endptr;
> +	char *buf=NULL;

Unneeded initialization

[...]
> +	if( (buf=kmalloc(GFP_KERNEL,count))==NULL){

GFP_XXX must be the second arg.

> +		return  -ENOMEM;
> +	}
> +
> +	memcpy(buf,buffer,count); 
> +
> +	
> +	c=strchr(buf,' ');
> +	if(!c) goto out_err;

CodingStyle (the whole patch is terrible).

> +	
> +	*c='\0';
> +	int resource=-1;
> +	
> +	if(strcmp("RLIMIT_AS",buf)==0)
> +		resource=RLIMIT_AS;
> +	else if(strcmp("RLIMIT_CORE",buf)==0)
> +		resource=RLIMIT_CORE;
> +	else if(strcmp("RLIMIT_CPU",buf)==0)
> +		resource=RLIMIT_CPU;
[...]

More code duplication. Use a loop instead.

[...]
> +	out_err:
> +		kfree(buf);
> +		return EINVAL;

-EINVAL

--
Ueimor
