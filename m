Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264267AbUD0SJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbUD0SJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUD0SJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:09:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:16805 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264267AbUD0SId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:08:33 -0400
X-Authenticated: #1226656
Date: Tue, 27 Apr 2004 20:08:30 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Dru <andru@treshna.com>, linux-xfs@oss.sgi.com,
       =?ISO-8859-1?Q?M=E5ns_?= =?ISO-8859-1?Q?Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: status of Linux on Alpha?
Message-Id: <20040427200830.3f485a54@vaio.gigerstyle.ch>
In-Reply-To: <20040427215514.A651@den.park.msu.ru>
References: <20040328204308.C14868@jurassic.park.msu.ru>
	<20040328221806.7fa20502@vaio.gigerstyle.ch>
	<yw1xr7vcn1z2.fsf@ford.guide>
	<20040329205233.5b7905aa@vaio.gigerstyle.ch>
	<20040404121032.7bb42b35@vaio.gigerstyle.ch>
	<20040409134534.67805dfd@vaio.gigerstyle.ch>
	<20040409134828.0e2984e5@vaio.gigerstyle.ch>
	<20040409230651.A727@den.park.msu.ru>
	<20040413194907.7ce8ceb7@vaio.gigerstyle.ch>
	<20040427185124.134073cd@vaio.gigerstyle.ch>
	<20040427215514.A651@den.park.msu.ru>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

Cool!

I will try your patch after I finished moving to my new flat:-)

I wonder why it happens only with the XFS code. What I saw
rw_sem is used all over the place in the kernel.

Thank you and Dru for the work and hopefully it will fix my problem.

Regards

Marc


On Tue, 27 Apr 2004 21:55:14 +0400
Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:

> On Tue, Apr 27, 2004 at 06:51:24PM +0200, Marc Giger wrote:
> > What's the current status of the problem?
> 
> Hopefully resolved - thanks to Dru <andru@treshna.com>, who provided
> an easy way to reproduce the problem.
> 
> What we have in lib/rwsem.c:__rwsem_do_wake():
> 	int woken, loop;
> 	^^^
> and several lines below:
> 	loop = woken;
> 	woken *= RWSEM_ACTIVE_BIAS-RWSEM_WAITING_BIAS;
> 	woken -= RWSEM_ACTIVE_BIAS;
> 
> However, rw_semaphore->count is 64-bit on Alpha, so
> RWSEM_WAITING_BIAS has been defined as -0x0000000100000000L.
> Obviously, this blows up in the write contention case.
> 
> Ivan.
> 
> --- linux.orig/lib/rwsem.c	Mon Apr 26 20:11:36 2004
> +++ linux/lib/rwsem.c	Tue Apr 27 20:04:14 2004
> @@ -40,8 +40,7 @@ static inline struct rw_semaphore *__rws
>  {
>  	struct rwsem_waiter *waiter;
>  	struct list_head *next;
> -	signed long oldcount;
> -	int woken, loop;
> +	signed long oldcount, woken, loop;
>  
>  	rwsemtrace(sem,"Entering __rwsem_do_wake");
>  
> 
> 
