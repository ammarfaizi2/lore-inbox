Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751568AbWHXOxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWHXOxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 10:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWHXOxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 10:53:14 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:64704 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1751560AbWHXOxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 10:53:13 -0400
Date: Thu, 24 Aug 2006 07:42:59 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] 2.6.17.9 perfmon2 patch for review: modified x86_64 files
Message-ID: <20060824144259.GG4086@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N8689P000540@frankl.hpl.hp.com> <p73k64z7oh6.fsf@verdi.suse.de> <20060824090409.GB3252@frankl.hpl.hp.com> <200608241120.31258.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608241120.31258.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Thu, Aug 24, 2006 at 11:20:31AM +0200, Andi Kleen wrote:
> > > > -	/*
> > > > -	 * Now maybe reload the debug registers and handle I/O bitmaps
> > > > -	 */
> > > > -	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
> > > > -	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
> > > > -		__switch_to_xtra(prev_p, next_p, tss);
> > > > +  	/*
> > > > + 	 * Now maybe reload the debug registers and handle I/O bitmaps
> > > > +  	 */
> > > > + 	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
> > > > + 	    || (task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW)))
> > > > + 		__switch_to_xtra(prev_p, next_p, tss);
> > > 
> > > 
> > > This should be a separate patch for once (creating _TIF_WORK_CTXSW)
> > 
> > The _TIF_WORK_CTXSW is already in a separate patch which you have accepted
> > into your tree if I recall. It was part of the TIF_DEBUG/TIF_IO_BITMAP patch.
> > Unless you are repeating the first point you have at the top of this message
> > about group by functionality.
> 
> 
> Such a hunk just shouldn't be a hidden in a huge patch. Individual patches please.
> 
> > to get to pfm_handle_work(), we set TIF_NOTIFY_RESUME. Once in pfm_handle_work()
> > with the context properly locked, we check the reason for coming here. To mimic,
> > what we do with TIF flags in __switch_to(). I would have to add 3 new TIF flags.
> > The TIF_PERFMON flag means something different. When you come to notify_resume()
> > for a signal in a monitored thread, you may not need to go into pfm_handle_work().
> > But what is sure, is that if you do not have TIF_PERFMON set you never need to
> > get into pfm_handle_work(). So one thing I could do if to check for TIF_PERFMON
> > to miinize the number of useless calls to pfm_handle_work().
> 
> flags are cheap. Just add three if you need them.
> 
I  looked at that in more details. I can get by with 2 extra TIF flags. The problem
is that I have still hooked up to the TIF_NOTIFY_RESUME mechanism to get to  the
do_notify_resume() function. To make this work I have to either set TIF_NOTIFY_RESUME
*and* TIF_PERFMON_XXX or I have to add TIF_PERFMON_XXX to this kind of code in
entry.S:
	sysret_signal:
        	sti
        	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
        	jz    1f

        	/* Really a signal */
        	/* edx: work flags (arg3) */
        	leaq do_notify_resume(%rip),%rax
        	leaq -ARGOFFSET(%rsp),%rdi # &pt_regs -> arg1
        	xorl %esi,%esi # oldset -> arg2

But there seems to be some limitations on the low order 16 bits for the _TIF_ALLWORK_MASK
which is also being checked in entry.S and my TIF_PERFMON are 20 and above.

-- 
-Stephane
