Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267605AbSLFFsd>; Fri, 6 Dec 2002 00:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267606AbSLFFsd>; Fri, 6 Dec 2002 00:48:33 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:42975 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267605AbSLFFsb>;
	Fri, 6 Dec 2002 00:48:31 -0500
Date: Fri, 6 Dec 2002 11:27:56 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: lkcd-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Update to LKCD - notifiers, nmi ipi, scheduler spin
Message-ID: <20021206112756.A2119@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <Pine.LNX.4.44.0212022307280.32685-100000@nakedeye.aparity.com> <Pine.LNX.4.44.0212032139020.3581-100000@nakedeye.aparity.com> <20021204133937.A2753@in.ibm.com> <1039049158.20387.86.camel@dell_ss3.pdx.osdl.net> <20021205191332.A3059@in.ibm.com> <1039115866.29641.28.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1039115866.29641.28.camel@dell_ss3.pdx.osdl.net>; from shemminger@osdl.org on Thu, Dec 05, 2002 at 11:17:46AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 11:17:46AM -0800, Stephen Hemminger wrote:
> On Thu Dec 05, 2002 ... Suparna Bhattacharya wrote:
>>On Wed, Dec 04, 2002 at 04:45:57PM -0800, Stephen Hemminger wrote:
>>> Here is an update to LKCD for 2.5 that tries to:
>>> * Use Linux style
>>> * Cleanup typo's, const handling stuff like that
>>> * Try and change as few base kernel files as possible
>>>   - Change to the SMP cpu handling (get out of sched.c) into dump_i386
>>>   - Only pluck as few symbols for a LKCD module as required.
>>>   - Make all dumps non-disruptive, kernel will reboot anyway on
>>> panic/nmi/...
>>>   - Use existing panic, sysrq integration hooks
>>> 
>>> * Integrate hooks necessary for netdump without touching dump_base
>>> 
>>> * Only re-enable interrupts if target requires it.
>>>    - enable APIC if it got disabled
>>>    - eventually want to have polling disk dump as well.
> > I have only looked at it briefly so far, and not the netdump bits
> > as yet, but I like the general direction of the changes. The less
> > intrusive this is and the simpler we can make the dependencies the 
> > better. Some of the reasons for the extra things that had been in for 
> > for handling quiescing were less of a problem in 2.5 together with
> > the more async oriented approach for i/o we have now, and it was
> > one of the goals to minimize those hooks, as also to integrate with
> > nmi handler callback infrastructure.
> 
> I am trying porting the x86_64 notify_die to i386, it looks easy.

OK.

> 
> > It is however worth recapping some of the reasons why things were as
> > they were to understand any caveats after your changes. BTW, its
> > OK to take an incremental path of having many of the 
> > changes checked into cvs first and then tackle any problems with
> > a fresh look. Most of the issues had to do with using the
> > standard block device drivers for i/o vs a polled/dedicated 
> > dump driver.  
> > 
> > - Forcing the other CPUs to spin inside the NMI ipi (rather than
> >   a more gentle ipi later or by causing a spin in schedule after 
> >   the return from interrupt) means that another cpu could be holding
> >   a spin lock irq at that moment, and in case this was a lock required
> >   in the dump i/o path, or any other code (e.g interrupts and softirqs),
> >   that could run on the dumping cpu, there could be a deadlock. The 
> >   chances of this are reduced with the global io_request_lock gone 
> >   for example, but there are some other possibilities (especially 
> >   with all interrupts and bottom halves been enabled on the dumping cpu)
> >   This could happen for non-disruptive dumps for example.
> >   (In 2.4 we had trouble with wait_on_irq but that's gone in 2.5)
> 
> Maybe just grabbing the scheduler run queue lock on the processors
> would do this easier.
> 
> > - The second reason for the hook in the scheduler was to avoid
> >   schedules in case of waits in the i/o path (in 2.4 dump used
> >   brw_kiovec). Now that we use an async low level i/o submission
> >   through submit_bio and poll for completion, its not a likely
> >   situation assuming we have slots in the request queue and no
> >   allocs / waits should typically happen. But would be good to
> >   be fully sure (that's something we may look at for aio as well).
> 
> Would grabbing the run queue lock work?

May be better if we can avoid it .. and look for a different way out.

> I am not opposed to a small spin in sched.c and probably will put it
> back, but this is one place people seem to have their performance
> microscope tuned at.
> 
> > Duplicating code outside of the kernel to avoid exporting routines 
> > is something I'm not so sure of is the best way to go eventually, 
> > so we should get some opinion on lkml on that. 
> 
> It was only for the small bit of code to look and see if page was
> really in ram.  Turning the routine from being static inline to exposed
> for LKCD seemed like it might cause offense to the performance bigots.

Static inline could also move to a header file, perhaps.

Tempted to think of a (possible?) alternative of a PG_Notram/PG_Ram 
type flag set by a mark_nonram_pages() routine early during bootup. This 
makes  checks arch indep, may perform better, and is a bit easier to 
extend in the future for things like Badmem. It is however relatively 
more intrusive and takes up a page-flag bit, so depends on general 
opinion.

> 
> > The panic notifier call happens after smp_send_stop() in panic.
> > I noticed that you have code to handle the apic, but how
> > do we get the register state on other CPUs if they are stopped
> > before we get to dump ?  
> 
> Could the two lines in panic.c be swapped?

We'd looked at that option earlier but just wasn't sure if any
panic notifiers rely on the assumption of smp_send_stop() having
been called. Apparently there seemed to be very little code in the 
tree using panic notifiers as you noticed too, but would be
good to get a confirmation.

If we could set things up so that the panic notifier calling
into dump is ahead of the other notifiers (except probably kdb,
which in any case can take care of its own serialization), then
another alternative would be to have the dump panic notifier invoke 
smp_send_stop() before returning. But do we have control over
the ordering ?

> 
> > Regarding nmi related general infrastructure, is there a value 
> > in having a send_nmi_ipi() sort of interface in the kernel, rather
> > than special branch for DUMP_VECTOR/KDB_VECTOR etc ?
> 
> Or perhaps a flag to smp_call_function() ?
> 

I'd personally feel more comfortable with a different 
interface. In general at dump time it may be safer to depend on 
things which are not used (much) during regular system operation 
if possible so that its more likely to work in problem scenarios.
And nmi ipis are likely to be used mostly under similar 
circumstances rather than during regular operation so seems 
preferable that it not share the same lock (and data structure) 
as smp_call_function.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

