Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWGFDkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWGFDkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWGFDkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:40:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965153AbWGFDkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:40:04 -0400
Date: Wed, 5 Jul 2006 20:39:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix poll() nfds check.
Message-Id: <20060705203959.53e128ef.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0607051949460.6604@shell3.speakeasy.net>
References: <Pine.LNX.4.58.0607051949460.6604@shell3.speakeasy.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 20:00:34 -0700 (PDT)
Vadim Lobanov <vlobanov@speakeasy.net> wrote:

> Hi,
> 
> This is a trivial patch to fix the nfds check in the poll system call
> implementation. Namely, OPEN_MAX no longer does anything important in
> the kernel, and checking that nfds is greater than max_fdset AND greater
> than OPEN_MAX therefore just seems wrong.
> 
> This brings up a slightly-tangential question: Why do the nfds checks
> exist in select()/poll()? They're not strictly necessary, since bad
> input will be caught later when we validate all the fds, one by one.
> Furthermore, these checks optimize the handling of error cases (which
> should be uncommon) while pessimizing correct usage of the syscalls
> (which should be more common).
> 
> Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>
> 
> diff -Npru linux-2.6.17-git25/fs/select.c linux-new/fs/select.c
> --- linux-2.6.17-git25/fs/select.c	2006-07-05 19:06:56.000000000 -0700
> +++ linux-new/fs/select.c	2006-07-05 19:10:51.000000000 -0700
> @@ -671,7 +671,7 @@ int do_sys_poll(struct pollfd __user *uf
>  	fdt = files_fdtable(current->files);
>  	max_fdset = fdt->max_fdset;
>  	rcu_read_unlock();
> -	if (nfds > max_fdset && nfds > OPEN_MAX)
> +	if (nfds > max_fdset)
>  		return -EINVAL;
> 
>  	poll_initwait(&table);

http://www.opengroup.org/onlinepubs/009695399/functions/poll.html sayeth

[EINVAL]
    The nfds argument is greater than {OPEN_MAX}, or ...

and afaict, max_fdset can be either less than or greater than OPEN_MAX,
depending upon how one sets NR_OPEN.

So I think that patch should be s/&&/||/ and s/changelog/new one/

If anything we do here alters userspace-visible behaviour (and it probably will)
then it should be *exahustively* documented in the changelog, and probably dropped.
