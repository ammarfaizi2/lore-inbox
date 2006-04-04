Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWDDDbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWDDDbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 23:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWDDDbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 23:31:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:49603 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964990AbWDDDbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 23:31:42 -0400
Date: Tue, 4 Apr 2006 05:31:41 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <Pine.LNX.4.64.0604032011040.30048@alien.or.mcafeemobile.com>
Subject: Re: [patch] uniform POLLRDHUP handling between epoll and poll/select ...
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <12469.1144121501@www102.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide,

> Like reported by Michael Kerrisk, POLLRDHUP handling was not consistent 
> between epoll and poll/select, since in epoll it was unmaskeable. This 
> patch brings uniformity in POLLRDHUP handling.
[...]
> diff -Nru linux-2.6.16/fs/eventpoll.c linux-2.6.16.mod/fs/eventpoll.c
> --- linux-2.6.16/fs/eventpoll.c	2006-04-03 20:08:23.000000000 -0700
> +++ linux-2.6.16.mod/fs/eventpoll.c	2006-04-03 20:09:51.000000000 -0700
> @@ -599,7 +599,7 @@
>   	switch (op) {
>   	case EPOLL_CTL_ADD:
>   		if (!epi) {
> -			epds.events |= POLLERR | POLLHUP | POLLRDHUP;
> +			epds.events |= POLLERR | POLLHUP;
> 
>   			error = ep_insert(ep, &epds, tfile, fd);
>   		} else
> @@ -613,7 +613,7 @@
>   		break;
>   	case EPOLL_CTL_MOD:
>   		if (epi) {
> -			epds.events |= POLLERR | POLLHUP | POLLRDHUP;
> +			epds.events |= POLLERR | POLLHUP;
>   			error = ep_modify(ep, epi, &epds);
>   		} else
>   			error = -ENOENT;

This makes things consistent -- but in the opposite way
from what I thought they might be.  (The alternative would of 
course have been to make POLLRDHUP un-maskable in both epoll 
and poll().)

So I'm curious: what is the rationale for making POLLRDHUP 
maskable when POLLHUP is not?   Is it an issue of ABI 
compatibility; or something else?

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
