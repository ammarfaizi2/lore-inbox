Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWHXJlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWHXJlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 05:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWHXJlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 05:41:21 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:10723 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1751002AbWHXJlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 05:41:20 -0400
Date: Thu, 24 Aug 2006 02:31:12 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] 2.6.17.9 perfmon2 patch for review: modified x86_64 files
Message-ID: <20060824093112.GC3252@frankl.hpl.hp.com>
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
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 11:20:31AM +0200, Andi Kleen wrote:
> On Thursday 24 August 2006 11:04, Stephane Eranian wrote:
> > Andi,
> > 
> > On Wed, Aug 23, 2006 at 12:09:25PM +0200, Andi Kleen wrote:
> > > Stephane Eranian <eranian@frankl.hpl.hp.com> writes:
> > > 
> > > In general this stuff would be much easier to review if you
> > > really split it into logical pieces: this means not modified/new,
> > > but one patch doing one thing. Then the hooks could be reviewed
> > > together with the code.
> > > 
> > 
> > Yes, I think that would be nice but it is very hard to generate 
> > such patches from the source tree that I have now. I would have to
> > manually edit the new/mod patches to group things based on
> > functionalities.
> 
> You could do it once and then store in quilt (or git/hg if you prefer that) 
> for further editing as patchkits. That will simplify review and merging.

I agree, The problem is doing the first step ;-<

>  
> > > > @@ -934,6 +935,7 @@ void setup_threshold_lvt(unsigned long l
> > > >  void smp_local_timer_interrupt(struct pt_regs *regs)
> > > >  {
> > > >  	profile_tick(CPU_PROFILING, regs);
> > > > + 	pfm_handle_switch_timeout();
> > > 
> > > It is still unclear why you can't use an ordinary add_timer() ?
> > > 
> > 
> > The hook is used to decrement a timeout value used for event set switching.
> > Set switching is upported for both per-thread and system-wide contexts. For
> > per-thread, the timeout must be "saved/restored" when the thread is context
> > switched. The timeout must be handled in the context of the monitored thread.
> > I am not sure add_timer() is a good fit for this. The add_timer looks good but
> > del_timer() does not as  for an active timer, it would need to return the
> > leftover duration so it can be reactivated via a new add_timer() on context
> > switch in.
> 
> If you always add a new add_timer with timeout jiffies+1 it will always run in this 
> context. No extra hooks needed.
> 
I see. Let me try this out.

> 
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

That goes back to patchkit point. I could put it in the ctxsw patch instead of
modified.

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
Thread_info is u32 and we are up to bit 23 with TIF_PERFMON + 3 = 26.
But it looks cleaner and probably more efficient. I'll make the change.

Thanks.

-- 
-Stephane
