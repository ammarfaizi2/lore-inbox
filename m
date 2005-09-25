Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVIYHIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVIYHIG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 03:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVIYHIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 03:08:05 -0400
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:26014 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751198AbVIYHIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 03:08:04 -0400
Date: Sun, 25 Sep 2005 00:08:03 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andrew Morton <akpm@osdl.org>, Davide Libenzi <davidel@xmailserver.org>
cc: willy@w.ods.org, nish.aravamudan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
In-Reply-To: <20050924230545.3245da3f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0509250000470.5772@shell3.speakeasy.net>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
 <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com>
 <20050924061500.GA24628@alpha.home.local> <Pine.LNX.4.63.0509240800020.31060@localhost.localdomain>
 <20050924172011.GA25997@alpha.home.local> <Pine.LNX.4.63.0509241113370.31327@localhost.localdomain>
 <20050924230545.3245da3f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2005, Andrew Morton wrote:

> Davide Libenzi <davidel@xmailserver.org> wrote:
> >
> > The attached patch uses the kernel min() macro, that is optimized has
> >  single compare by gcc-O2. Andrew, this goes over (hopefully ;) the bits
> >  you already have in -mm.
>
> OK, well I've rather lost the plot with all the patches flying around.
>
> I now have one single patch against epoll.c, below.  Please confirm that
> this is what was intended.   If not, I'll drop it and let's start again.
>

I hate to be the squeaky wheel here, but the attached patch is not 100%
right -

>
> From: Davide Libenzi <davidel@xmailserver.org>
>
> The sys_epoll_wait() function was not handling correctly negative timeouts
> (besides -1), and like sys_poll(), was comparing millisec to secs in
> testing the upper timeout limit.
>
> Signed-off-by: Davide Libenzi <davidel@xmailserver.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  fs/eventpoll.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff -puN fs/eventpoll.c~sys_epoll_wait-fix-handling-of-negative-timeouts fs/eventpoll.c
> --- devel/fs/eventpoll.c~sys_epoll_wait-fix-handling-of-negative-timeouts	2005-09-24 23:01:00.000000000 -0700
> +++ devel-akpm/fs/eventpoll.c	2005-09-24 23:02:50.000000000 -0700
> @@ -101,6 +101,10 @@
>  /* Maximum number of poll wake up nests we are allowing */
>  #define EP_MAX_POLLWAKE_NESTS 4
>
> +/* Maximum msec timeout value storeable in a long int */
> +#define EP_MAX_MSTIMEO min(1000ULL * MAX_SCHEDULE_TIMEOUT / HZ, LONG_MAX / HZ - 1000ULL)

This should instead be:
#define EP_MAX_MSTIMEO min(1000ULL * MAX_SCHEDULE_TIMEOUT / HZ, (LONG_MAX - 999ULL) / HZ)
Here's why:
We want to avoid overflow of (timeout * HZ + 999), or, in other words,
the case where (timeout * HZ + 999) >= LONG_MAX
Unwrapping the equation, we get timeout >= (LONG_MAX - 999) / HZ

The original code isn't _wrong_, but more restrictive than it should be.
In any case, better to fix up the base patch now, before all the other
patches go in. I could do this, or Davide can... it's all good. :-)

> +
> +
>  struct epoll_filefd {
>  	struct file *file;
>  	int fd;
> @@ -1506,8 +1510,8 @@ static int ep_poll(struct eventpoll *ep,
>  	 * and the overflow condition. The passed timeout is in milliseconds,
>  	 * that why (t * HZ) / 1000.
>  	 */
> -	jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
> -		MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
> +	jtimeout = (timeout < 0 || timeout >= EP_MAX_MSTIMEO) ?
> +		MAX_SCHEDULE_TIMEOUT : (timeout * HZ + 999) / 1000;
>
>  retry:
>  	write_lock_irqsave(&ep->lock, flags);
> _
>
> -

-Vadim Lobanov
