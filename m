Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbWGFECQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWGFECQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 00:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWGFECQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 00:02:16 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:62352 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965164AbWGFECQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 00:02:16 -0400
Date: Wed, 5 Jul 2006 21:02:15 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix poll() nfds check.
In-Reply-To: <20060705203959.53e128ef.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0607052050560.27726@shell3.speakeasy.net>
References: <Pine.LNX.4.58.0607051949460.6604@shell3.speakeasy.net>
 <20060705203959.53e128ef.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006, Andrew Morton wrote:

> On Wed, 5 Jul 2006 20:00:34 -0700 (PDT)
> Vadim Lobanov <vlobanov@speakeasy.net> wrote:
>
> > diff -Npru linux-2.6.17-git25/fs/select.c linux-new/fs/select.c
> > --- linux-2.6.17-git25/fs/select.c	2006-07-05 19:06:56.000000000 -0700
> > +++ linux-new/fs/select.c	2006-07-05 19:10:51.000000000 -0700
> > @@ -671,7 +671,7 @@ int do_sys_poll(struct pollfd __user *uf
> >  	fdt = files_fdtable(current->files);
> >  	max_fdset = fdt->max_fdset;
> >  	rcu_read_unlock();
> > -	if (nfds > max_fdset && nfds > OPEN_MAX)
> > +	if (nfds > max_fdset)
> >  		return -EINVAL;
> >
> >  	poll_initwait(&table);
>
> http://www.opengroup.org/onlinepubs/009695399/functions/poll.html sayeth
>
> [EINVAL]
>     The nfds argument is greater than {OPEN_MAX}, or ...
>
> and afaict, max_fdset can be either less than or greater than OPEN_MAX,
> depending upon how one sets NR_OPEN.

Very good point. My manpages have led me astray to the dark side. :)

> So I think that patch should be s/&&/||/ and s/changelog/new one/

Yikes, I think sticking the OR operator in there would seriously suck,
given that programs would then be unable to poll on more than 256 file
descriptors (which actually happens, or so I've heard). Besides, it
would also kill Tigran's work, as per the comment from the top of
select.c:

012  *  24 January 2000
013  *     Changed sys_poll()/do_poll() to use PAGE_SIZE chunk-based allocation
014  *     of fds to overcome nfds < 16390 descriptors limit (Tigran Aivazian).
015  */

> If anything we do here alters userspace-visible behaviour (and it probably will)
> then it should be *exahustively* documented in the changelog, and probably dropped.

Arguments of the cited standard's sensibilities notwithstanding (given
that it seems silly to limit the API in unnatural ways, as we can easily
and provably handle more than 256 fds), it seems better to leave this as
is. Thanks for the critical eye. :)

- Vadim Lobanov
