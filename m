Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131184AbRCQWnY>; Sat, 17 Mar 2001 17:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbRCQWnP>; Sat, 17 Mar 2001 17:43:15 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:31499 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131184AbRCQWnI>; Sat, 17 Mar 2001 17:43:08 -0500
Date: Sat, 17 Mar 2001 22:42:22 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Junfeng Yang <yjf@stanford.edu>
cc: <linux-kernel@vger.kernel.org>, <mc@cs.stanford.edu>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: [CHECKER] 28 potential interrupt errors
In-Reply-To: <Pine.GSO.4.31.0103162216360.10409-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.LNX.4.30.0103172238030.17004-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, Junfeng Yang wrote:

> ---------------------------------------------------------
> [BUG] return with int disabled in an error path
> 
> /u2/acc/oses/linux/2.4.1/drivers/char/n_r3964.c:1036:add_msg: ERROR:INTR:990:995: Interrupts inconsistent, severity `20':995
> 
> 
>       save_flags(flags);
> Start --->
>       cli();
> 
>       pMsg = kmalloc(sizeof(struct r3964_message), GFP_KERNEL);
>       TRACE_M("add_msg - kmalloc %x",(int)pMsg);
> Return without
> enabling interrupt
>       --->
>       if(pMsg==NULL)
>          return;
> 
> 
> 	... DELETED 44 lines ...
> 
>    if(pClient->sig_flags & R3964_USE_SIGIO)
>    {
>       kill_proc(pClient->pid, SIGIO, 1);
>    }
> Error --->
> }
> 
> static struct r3964_message *remove_msg(struct r3964_info *pInfo,
>                        struct r3964_client_info *pClient)
> {
> ---------------------------------------------------------


The simple 'fix' is to move the offending kmalloc() up above the cli(). 
That might actually be something else to make an automated test for - 
anything which schedules can re-enable interrupts. In general, it's bad to 
call anything which can schedule when interrupts are disabled.

But actually, the cli() is there because of the fundamentally flawed 
assumption that it provides sufficient locking. I've converted the whole 
thing to use spinlocks instead, but haven't got a test setup ATM. I'll 
poke at it more on Monday.

akpm, were you looking at this?

-- 
dwmw2



