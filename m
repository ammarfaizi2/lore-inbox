Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTJWNcY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 09:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263556AbTJWNcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 09:32:24 -0400
Received: from mail-08.iinet.net.au ([203.59.3.40]:9856 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261305AbTJWNcW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 09:32:22 -0400
Date: Thu, 23 Oct 2003 21:37:45 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Ingo Oeser <ioe-lkml@rameria.de>
cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] RE: [autofs] multiple servers per automount
In-Reply-To: <200310151228.02741.ioe-lkml@rameria.de>
Message-ID: <Pine.LNX.4.44.0310232127520.2983-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please forgive my ignorance Ingo but ...

I suffer from race condition blindness. A terible afflicition when one is 
trying to understand the sublties of the kernel, but I'm trying.

While I am not questioning your suggestion, I have thought about the code 
and fail to see the race you point out. Please help me along.

On Wed, 15 Oct 2003, Ingo Oeser wrote:

> On Wednesday 15 October 2003 01:12, Mike Waychison wrote:
> > The problem still remains in 2.6 that we limit the count to 256.  I've
> > attached a quick patch that I've compiled and tested.  I don't know if
> > there is a better way to handle dynamic assignment of minors (haven't
> > kept up to date in that realm), but if there is, then we should probably
> >   use it instead.
> 
> 
> In your patch you allocate inside the spinlock.

Do you mean we don't want to sleep under the spin lock?
Would a GFP_ATOMIC make a difference to the analysis?

> 
> I would suggest to do sth. like the following:
> 
> void *local;
> if (!unamed_dev_inuse) {
>     local = get_zeroed_page(GFP_KERNEL);
> 
>     if (!local) 
>         return -ENOMEM;
> }
> 
> spinlock(&unamed_dev_lock);
> mb();
> if (!unamed_dev_inuse) {
>     unamed_dev_inuse = local;
> 
>     /* Used globally, don't free now */
>     local = NULL;
> }
> 
> /* 
>   Do the lookup and alloc
>  */
> 
> spinunlock(&unamed_dev_lock);
> 
> /* Free page, because of race on allocation. */
> if (local) 
>     free_page(local);
> 
> 
> Which will swap the pointers atomically and still alloc outside the
> non-sleeping locking.

As I said please give me a hint about your thinking here.
And the use of a memory barrier as well ... umm?

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

