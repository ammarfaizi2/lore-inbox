Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318705AbSHEQeZ>; Mon, 5 Aug 2002 12:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318712AbSHEQeZ>; Mon, 5 Aug 2002 12:34:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:9600 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318705AbSHEQeZ>;
	Mon, 5 Aug 2002 12:34:25 -0400
Date: Mon, 5 Aug 2002 09:37:43 -0700
From: Bob Miller <rem@osdl.org>
To: =?iso-8859-1?Q?Edward_Shao_=28=AA=F2=AAv=B0=EA=29?= 
	<szg90@cs.ccu.edu.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a question about __down() in Linux/arch/i386/kernel/semaphore.c
Message-ID: <20020805093743.A9689@doc.pdx.osdl.net>
References: <021b01c23c8d$22becc60$74667b8c@edward> <024c01c23c8e$5804d710$74667b8c@edward>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <024c01c23c8e$5804d710$74667b8c@edward>; from szg90@cs.ccu.edu.tw on Mon, Aug 05, 2002 at 10:42:37PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 10:42:37PM +0800, Edward Shao \(邵治國\) wrote:
> sorry, i found it!
> wake_up_locked(&sem->wait);
> but why do we need to wake up the sleepers again?
> Thank you very much.
> 
> -Edward Shao-
> 
> ----- Original Message -----
> From: "Edward Shao (邵治國)" <szg90@cs.ccu.edu.tw>
> To: <linux-kernel@vger.kernel.org>
> Sent: Monday, August 05, 2002 10:33 PM
> Subject: a question about __down() in Linux/arch/i386/kernel/semaphore.c
> 
> 
> > Hi,
> >
> > I have a question about __down() in kernel 2.4.18
> > (Linux/arch/i386/kernel/semaphore.c)
> > I found the last line of __down() is
> > wake_up(&sem->wait);
> > but in kernel 2.5.28, i didn't see this line..
> > is this line necessary in kernel 2.4.18?
> > why?
> >
> > Thank you very much.
> >
> > Best Regard!!!
> >
> > -Edward Shao-
> >
> >

The quick answer: so we don't miss waking someone up.  But, seriously,
the semaphore code is very subtle.

This semaphore implementation allows more than one process to be in the
critical section at a time (a.k.a. a counting semaphore).  In order to
support those semantics, more than one wakeup may occur before a process
is pulled off the wake_q and changed to running.  Because the process that
is waiting to run (in the __down() code) is responsible for pulling itself 
off the wait_q, if the 2 __up()s happen before the __down() can finish,
the 2 __up()s will wakeup the same process twice.  So, the __down() code
needs to protect agaist this.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
