Return-Path: <linux-kernel-owner+w=401wt.eu-S1762659AbWLKI42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762659AbWLKI42 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 03:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762662AbWLKI41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 03:56:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60156 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762659AbWLKI41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 03:56:27 -0500
Date: Mon, 11 Dec 2006 00:55:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
Message-Id: <20061211005557.04643a75.akpm@osdl.org>
In-Reply-To: <200612110330_MC3-1-D49B-BC0F@compuserve.com>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 03:27:37 -0500
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> Prevent oops when an app tries to create a pipe while pipefs
> is not mounted.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
> --- 2.6.19.1-pre1-32.orig/fs/pipe.c
> +++ 2.6.19.1-pre1-32/fs/pipe.c
> @@ -839,9 +839,11 @@ static struct dentry_operations pipefs_d
>  
>  static struct inode * get_pipe_inode(void)
>  {
> -	struct inode *inode = new_inode(pipe_mnt->mnt_sb);
> +	struct inode *inode = NULL;
>  	struct pipe_inode_info *pipe;
>  
> +	if (pipe_mnt)
> +		inode = new_inode(pipe_mnt->mnt_sb);
>  	if (!inode)
>  		goto fail_inode;
>  

That's pretty lame.  It means that pipes just won't work, so people who are
using pipes in their initramfs setups will just get mysterious failures
running userspace on a crippled kernel.

I think the bug really is the running of populate_rootfs() before running
the initcalls, in init/main.c:init().  It's just more sensible to start
running userspace after the initcalls have been run.  Statically-linked
drivers which want to load firmware files will lose.  To fix that we'd need
a new callback.  It could be with a new linker section or perhaps simply a
notifier chain.



