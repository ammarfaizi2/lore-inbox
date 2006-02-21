Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161383AbWBUFxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161383AbWBUFxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 00:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161384AbWBUFxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 00:53:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17624 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161383AbWBUFxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 00:53:05 -0500
Date: Mon, 20 Feb 2006 21:51:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: FMODE_EXEC or alike?
Message-Id: <20060220215122.7aa8bbe5.akpm@osdl.org>
In-Reply-To: <20060220221948.GC5733@linuxhacker.ru>
References: <20060220221948.GC5733@linuxhacker.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@linuxhacker.ru> wrote:
>
> Hello!
> 
>    We are working on a lustre client that would not require any patches
>    to linux kernel. And there are few things that would be nice to have
>    that I'd like your input on.
> 
>    One of those is FMODE_EXEC - to correctly detect cross-node situations with
>    executing a file that is opened for write or the other way around, we need
>    something like this extra file mode to be present (and used as a file open
>    mode when opening files for exection, e.g. in fs/exec.c)
>    Do you think there is a chance this can be included into vanilla kernel,
>    or is there a better solution I oversee?
>    I am just thinking about something as simple as this
>    (with some suitable FMODE_EXEC define, of course):
> 
> --- linux/fs/exec.c.orig	2006-02-21 00:11:47.000000000 +0200
> +++ linux/fs/exec.c	2006-02-21 00:12:24.000000000 +0200
> @@ -127,7 +127,7 @@ asmlinkage long sys_uselib(const char __
>  	struct nameidata nd;
>  	int error;
>  
> -	error = __user_path_lookup_open(library, LOOKUP_FOLLOW, &nd, FMODE_READ);
> +	error = __user_path_lookup_open(library, LOOKUP_FOLLOW, &nd, FMODE_READ|FMODE_EXEC);
>  	if (error)
>  		goto out;
>  
> @@ -477,7 +477,7 @@ struct file *open_exec(const char *name)
>  	int err;
>  	struct file *file;
>  
> -	err = path_lookup_open(name, LOOKUP_FOLLOW, &nd, FMODE_READ);
> +	err = path_lookup_open(name, LOOKUP_FOLLOW, &nd, FMODE_READ|FMODE_EXEC);
>  	file = ERR_PTR(err);
>  
>  	if (!err) {
> 

Such a patch would have zero runtime cost.  I'd have no problem carrying
that if it makes things easier for lustre, personally.

We would need to understand whether this is needed by other distributed
filesystems and if so, whether the proposed implementation is suitable and
sufficient.

Please send a well-tested patch, include suitable comments around the
definition of FMODE_EXEC.

