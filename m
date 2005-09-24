Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVIXVZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVIXVZn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 17:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVIXVZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 17:25:43 -0400
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:32946 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750760AbVIXVZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 17:25:42 -0400
Date: Sat, 24 Sep 2005 14:25:41 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Nishanth Aravamudan <nacc@us.ibm.com>, Willy Tarreau <willy@w.ods.org>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
In-Reply-To: <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0509241423350.25466@shell3.speakeasy.net>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
 <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com>
 <20050924061500.GA24628@alpha.home.local> <20050924171928.GF3950@us.ibm.com>
 <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2005, Davide Libenzi wrote:

> On Sat, 24 Sep 2005, Nishanth Aravamudan wrote:
>
> > Description: The @timeout parameter to ep_poll() is in milliseconds but
> > we compare it to (MAX_SCHEDULE_TIMEOUT - 1000 / HZ), which is
> > (jiffies/jiffies-per-sec) or seconds. That seems blatantly broken.  This
> > led to improper overflow checking for @timeout. As Andrew Morton pointed
> > out in a similar fix for sys_poll(), the best solution is to to check
> > for potential overflow first, then either select an indefinite value or
> > convert @timeout.
> >
> > To achieve this and clean-up the code, change the prototype of the
> > ep_poll() to make it clear that the parameter is in milliseconds and
> > rename jtimeout to timeout_jiffies to hold the corresonding jiffies
> > value.
> >
> > fs/eventpoll.c |   46 ++++++++++++++++++++++++++++++++++++++--------
> > 1 files changed, 38 insertions(+), 8 deletions(-)
>
> Eh? "To achieve this and clean-up the code"? :)
>
>
> - Davide
>
>
> eventpoll.c |    7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
> --- a/fs/eventpoll.c	2005-09-24 11:07:04.000000000 -0700
> +++ b/fs/eventpoll.c	2005-09-24 11:11:06.000000000 -0700
> @@ -101,6 +101,10 @@
>   /* Maximum number of poll wake up nests we are allowing */
>   #define EP_MAX_POLLWAKE_NESTS 4
>
> +/* Maximum msec timeout value storeable in a long int */
> +#define EP_MAX_MSTIMEO min(1000ULL * MAX_SCHEDULE_TIMEOUT / HZ, LONG_MAX / HZ - 1000ULL)

Not quite. It really should be:
#define EP_MAX_MSTIMEO min(1000ULL * MAX_SCHEDULETIMEOUT / HZ, (LONG_MAX - 999ULL) / HZ);

> +
> +
>   struct epoll_filefd {
>   	struct file *file;
>   	int fd;
> @@ -1507,8 +1511,7 @@
>   	 * and the overflow condition. The passed timeout is in milliseconds,
>   	 * that why (t * HZ) / 1000.
>   	 */
> -	jtimeout = (timeout < 0 ||
> -		    (timeout / 1000) >= (MAX_SCHEDULE_TIMEOUT / HZ)) ?
> +	jtimeout = (timeout < 0 || timeout >= EP_MAX_MSTIMEO) ?
>   		MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
>
>   retry:
> -

-Vadim Lobanov
