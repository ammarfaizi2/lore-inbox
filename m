Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVIULbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVIULbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 07:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVIULbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 07:31:16 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:41113 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750820AbVIULbP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 07:31:15 -0400
Subject: Re: [AIO] aio-2.6.13-rc6-B1
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Benjamin LaHaise <bcrl@linux.intel.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050920191329.GA6579@linux.intel.com>
References: <20050817184406.GA24961@linux.intel.com>
	 <1127211790.2051.9.camel@frecb000686>
	 <20050920191329.GA6579@linux.intel.com>
Date: Wed, 21 Sep 2005 13:33:03 +0200
Message-Id: <1127302383.2048.31.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/09/2005 13:44:20,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/09/2005 13:44:23,
	Serialize complete at 21/09/2005 13:44:23
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 15:13 -0400, Benjamin LaHaise wrote:
> On Tue, Sep 20, 2005 at 12:23:10PM +0200, Sébastien Dugué wrote:
> >   what's the point of calling wake_up_locked(&sem->wait) in 
> > aio_down_wait? We're already in a wakeup path and end up
> > calling __wake_up_common recursively.
> 
> That's necessary to kick the next semaphore op in the list.  The 
> list_del_init() right above that makes sure that we don't recurse 
> and run the routine again.

  OK, understood.

> 
> >   I think it may be one of the cause of my kernel hanging at the
> > very beginning.
> > 
> >   When I remove this call things go further but at some point a
> > semaphore wait queue gets thrashed and __wake_up_common tries to
> > call an invalid callback function.
> 
> This patch from Zach might make a difference.  Let me know if it changes 
> the symptoms at all.  Sorry if it doesn't apply cleanly, as it is against 
> a base kernel.  Basically, we could sleep while holding ctx_lock, which 
> does Bad Things(tm) on SMP systems.
> 

  Well, it does not change a thing (I was not expecting it to). I think 
the problem rather lies in the async semaphores (aio_down/aio_up)
mechanism and not in the fs aio.

  What leads me to this is that the crash occurs only when there is
contention on an inode semaphore, which seems to happen frequently
with pipes and not so frequently with regular file IO.

  And as the pipes are the only users (aside from xxx_aio_writev) of 
this mecanism it shows right after the kernel is booted. Without the
90_pipe_aio.diff patch, the kernel boots normally but Oopses during
shutdown involving again a semaphore operation.

  Any ideas?

  Sébastien.

-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

