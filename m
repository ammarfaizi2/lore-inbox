Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbUKWPvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbUKWPvx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 10:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUKWPuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 10:50:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:19648 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261306AbUKWPa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 10:30:59 -0500
Date: Tue, 23 Nov 2004 07:29:36 -0800
From: Greg KH <greg@kroah.com>
To: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       linux-security-module@wirex.com
Subject: Re: [PATCH 2.6.9] fork: move security_task_alloc() after p->parent initialization
Message-ID: <20041123152936.GB29107@kroah.com>
References: <1101220731.6210.142.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101220731.6210.142.camel@frecb000711.frec.bull.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 03:38:51PM +0100, Guillaume Thouvenin wrote:
> If we register a LSM hook and if we use the parameter passed to
> security_task_alloc(struct task_struct *p), the value of p->parent is
> wrong. This patch move the call to security_task_alloc() after the
> initialization of the field p->parent. 

No, that's way too late for this hook.

> --- kernel/fork.c.orig	2004-10-19 08:41:53.000000000 +0200
> +++ kernel/fork.c	2004-11-23 15:29:25.799903744 +0100
> @@ -1006,8 +1006,6 @@ static task_t *copy_process(unsigned lon
>   	}
>  #endif
>  
> -	if ((retval = security_task_alloc(p)))
> -		goto bad_fork_cleanup_policy;
>  	if ((retval = audit_alloc(p)))
>  		goto bad_fork_cleanup_security;
>  	/* copy all the process information */
> @@ -1092,6 +1090,9 @@ static task_t *copy_process(unsigned lon
>  		p->real_parent = current;
>  	p->parent = p->real_parent;
>  
> +	if ((retval = security_task_alloc(p)))
> +		goto bad_fork_cleanup_policy;
> +

And the error path is wrong :)

thanks,

greg k-h
