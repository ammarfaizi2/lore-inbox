Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288996AbSANUDC>; Mon, 14 Jan 2002 15:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288999AbSANUBt>; Mon, 14 Jan 2002 15:01:49 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:19702 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S288954AbSANUAT>; Mon, 14 Jan 2002 15:00:19 -0500
Message-ID: <3C433862.D1BF2D37@mvista.com>
Date: Mon, 14 Jan 2002 11:58:26 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Andrew Morton <akpm@zip.com.au>, alan@lxorguk.ukuu.org.uk,
        zippel@linux-m68k.org, rml@tech9.net, ken@canit.se,
        arjan@fenrus.demon.nl, landley@trommello.org,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PvKx-00005L-00@the-village.bc.nu>
		<200201140033.BAA04292@webserver.ithnet.com>
		<E16PvKx-00005L-00@the-village.bc.nu>
		<20020114104532.59950d86.skraw@ithnet.com>
		<3C42AD48.FCFD6056@zip.com.au> <20020114124755.3b2d6a4d.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> 
> On Mon, 14 Jan 2002 02:04:56 -0800
> Andrew Morton <akpm@zip.com.au> wrote:
> 
> > Stephan von Krawczynski wrote:
> > >
> > > ...
> > > Unfortunately me have neither of those. This would mean I cannot benefit
> from> > _these_ patches, but instead would need _others_
> [...]
> >
> > In 3c59x.c, probably the biggest problem will be the call to issue_and_wait()
> > in boomerang_start_xmit().  On a LAN which is experiencing heavy collision
> rates> this can take as long as 2,000 PCI cycles (it's quite rare, and possibly
> an> erratum).  It is called under at least two spinlocks.
> >
> > In via-rhine, wait_for_reset() can busywait for up to ten milliseconds.
> > via_rhine_tx_timeout() calls it from under a spinlock.
> >
> > In eepro100.c, wait_for_cmd_done() can busywait for one millisecond
> > and is called multiple times under spinlock.
> 
> Did I get that right, as long as spinlocked no sense in conditional_schedule()
> ?
> 
> > Preemption will help _some_ of this, but by no means all, or enough.
> 
> Maybe we should really try to shorten the lock-times _first_. You mentioned a
> way to find the bad guys?

Apply the preempt patch and then the preempt-stats patch.  Follow
instructions that come with the stats patch.  It will report on the
longest preempt disable times since the last report.  You need to
provide a load that will exercise the bad code, but it will tell you
which, where, and how bad.  Note: it measures preempt off time, NOT how
long it took to get to some task, i.e. it does not depend on requesting
preemption at the worst possible time.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
