Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136469AbREDRhb>; Fri, 4 May 2001 13:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136470AbREDRhL>; Fri, 4 May 2001 13:37:11 -0400
Received: from smtp.alacritech.com ([209.10.208.82]:28947 "EHLO
	smtp.alacritech.com") by vger.kernel.org with ESMTP
	id <S136469AbREDRhE>; Fri, 4 May 2001 13:37:04 -0400
Message-ID: <3AF2E717.AF7936BD@alacritech.com>
Date: Fri, 04 May 2001 10:29:59 -0700
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: smp_send_stop() and disable_local_APIC()
In-Reply-To: <3AF19A17.19C2741F@alacritech.com> <m1d79pnm2b.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> "Matt D. Robinson" <yakker@alacritech.com> writes:
> 
> > It looks like around 2.3.30 or so, someone added the call
> > disable_local_APIC() to smp_send_stop().  I'm not sure what the
> > intention was, but I'm getting some strange behavior as a result
> > based on some code I'm writing.
> >
> > Basically, I'm doing the following ...
> >
> >     panic()
> >     {
> >         /* do whatever you want, notifier list, etc. */
> >         smp_send_stop();
> >         write_system_memory();
> >         /* then do whatever */
> >     }
> >
> > write_system_memory() does a write of all system memory pages to some
> > block device.  It uses kiobufs as the way to get the pages to disk,
> > doing brw_kiovec() on those pages (using either the IDE or SCSI
> > driver to write the data).
> 
> IDE being less likely to hang than SCSI as it tends to use legacy isa
> interrupt lines.

Actually, we see the problem more with IDE than SCSI, but that's
neither here nor there.

> > The wierd behavior I see is that sometimes, smp_send_stop()
> > being called causes the system to hang up (not every time).
> 
> Doing event driver i/o after disabling the interrupt controller
> hmm, I wonder why...

It's an SMP (and only when your system crashes on a CPU other
than 0) problem.  I did some more checking of this to verify the
specifics of the behavior.  Thanks for the sarcasm, though. :)

> > If we don't call smp_send_stop() on those systems, everything works fine.
> > This looks to be directly caused by the disabling of the APIC, which
> > we may need to dump pages to local disk.  This only applies to some
> > people's systems -- not everyone displays the same behavior.
> >
> > I'm sure it's good to disable the APIC, but there's no clean way to
> > wait on disabling the APIC until after I'm done writing pages out.
> >
> > My questions are:
> >
> > 1) Why was disable_local_APIC() added to stop_this_cpu()
> >    and smp_send_stop()?  Completeness?
> >
> > 2) Is there a better way around this to disable all the
> >    other CPUs without disabling the APIC?
> >
> 
> I don't know what a good way is, since there is a kernel panic it
> should only be something truly fatal.  Given that reusing anything
> that hasn't been designed to run in that situation is playing with
> fire.

Someone's sent me a suggestion as to how to get around this issue.
It goes back to turning off the disable_local_APIC() behavior for
one (if I'm writing pages out), but secondly to avoid doing any
TLB flushing of CPUs that are stopped.

The problem is, on SMP configurations where one CPU's
task causes a panic() condition to another CPU's task (let's say
they are playing with the same list of structures in the kernel),
I need to stop all CPUs except the one panic()ing, and let him
be responsible for dumping system memory, so I can at least try
to figure out what the other CPU's task did to cause the problem.

A hack way around this is to stop job scheduling, but it doesn't
help if you want to catch the state of the task that caused the
problem on another CPU just after it happens.  Secondly, because there
is no disk driver to dump raw to disk (I've written one, but
not for SCSI -- only for IDE), you require interrupts and must
use the current block driver.  Sure, brw_kiovec() is nice, but it
isn't raw I/O without kernel interrupts.

All I wanted was clarification as to why it was added in the first
place, and whether there was a better way around the scenario.
I think Ingo added the code, but I never heard back from him.
Thanks for the response.

> Eric

--Matt
