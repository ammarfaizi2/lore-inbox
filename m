Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289138AbSAOJTN>; Tue, 15 Jan 2002 04:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289422AbSAOJTE>; Tue, 15 Jan 2002 04:19:04 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:21259 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S289138AbSAOJSx>; Tue, 15 Jan 2002 04:18:53 -0500
Message-ID: <3C43F3F1.50F30779@aitel.hist.no>
Date: Tue, 15 Jan 2002 10:18:41 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> <20020111220051.A2333@hq.fsmlabs.com> <3C4023A2.8B89C278@linux-m68k.org> <20020112052802.A3734@hq.fsmlabs.com> <3C40392F.C4E1EFF3@linux-m68k.org> <20020112075638.A5098@hq.fsmlabs.com> <3C4367EA.A52D6360@mvista.com> <20020114175931.A27147@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com wrote:
> 
> On Mon, Jan 14, 2002 at 03:21:14PM -0800, george anzinger wrote:
> > > > How is that changed? AFAIK inserting more schedule points does not
> > > > change the behaviour of the scheduler. The niced app will still get its
> > > > time.
> > >
> > > How many times can an app be preempted? In a non preempt kernel
> > > is can be preempted during user mode at timer frequency and no more
> >
> > Uh, it can be and is preempted in user mode by ANY interrupt, be it
> > keyboard, serial, lan, disc, etc.  The kernel looks for need_resched at
> > the end of ALL interrupts, not just the timer interrupt.
> 
> Ouch.

Ouch?  It is supposed to be that way.  Consider:

A high-priority task issues a disk read - and blocks.  Some
lower-priority process gets the cpu.  But then the disk io finishes
way before the low-priority process used up its timeslice.
The kernel gets an interrupt from the disk controller because
of that.  Perhaps the block device issues some more requests,
then time comes to return to user space.  The higher priority task
is now ready to run because its IO completed.  So of course
it is preferred over that low-priority thing.  In other words,
the low-priority task got preempted, this time by a disk
interrupt.

The same thing happens whan high-priority tasks waits for
other kinds of io, such as network, serial, and so on.
I am sure you wouldn't want it any other way.  Not
using the opportunity to switch task immediately after an io
completion interrupt would kill latency completely.

Helge Hafting
