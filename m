Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWA2IoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWA2IoG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 03:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWA2IoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 03:44:06 -0500
Received: from elvis.mu.org ([192.203.228.196]:46822 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S1750744AbWA2IoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 03:44:05 -0500
Message-ID: <43DC804B.4060900@FreeBSD.org>
Date: Sun, 29 Jan 2006 00:43:55 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 5/5] file: Modify struct fown_struct to contain a tref
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>	<m1lkwza479.fsf@ebiederm.dsl.xmission.com>	<m1hd7na44b.fsf_-_@ebiederm.dsl.xmission.com>	<m1d5iba3xf.fsf_-_@ebiederm.dsl.xmission.com>	<m18xsza3p4.fsf_-_@ebiederm.dsl.xmission.com> <m14q3na3ma.fsf_-_@ebiederm.dsl.xmission.com>
In-Reply-To: <m14q3na3ma.fsf_-_@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> @@ -317,7 +326,9 @@ static long do_fcntl(int fd, unsigned in
>  		 * current syscall conventions, the only way
>  		 * to fix this will be in libc.
>  		 */
> -		err = filp->f_owner.pid;
> +		err = 0;
> +		if (filp->f_owner.tref->task)
> +			err = filp->f_owner.pid;

Probably not very important, but why don't you use 
filp->f_owner.tref->task->pid? This way you could completely get rid of 
the pid field in fown_struct.

> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -855,7 +855,10 @@ static long sock_ioctl(struct file *file
>  			break;
>  		case FIOGETOWN:
>  		case SIOCGPGRP:
> -			err = put_user(sock->file->f_owner.pid, (int __user *)argp);
> +			pid = 0;
> +			if (sock->file->f_owner.tref->task)
> +				pid = sock->file->f_owner.pid;
> +			err = put_user(pid, (int __user *)argp);

Same here.

-- Suleiman
