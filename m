Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318363AbSGRUlU>; Thu, 18 Jul 2002 16:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318364AbSGRUlT>; Thu, 18 Jul 2002 16:41:19 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:43538 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S318363AbSGRUlR>; Thu, 18 Jul 2002 16:41:17 -0400
Date: Thu, 18 Jul 2002 13:44:13 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
Message-ID: <20020718204413.GB26536@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20020702173636.A13790@pegasys.ws> <8ff9ed84695e27db@mayday.cix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff9ed84695e27db@mayday.cix.co.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Jul 18, 2002 at 08:15:05PM +0100, Robert de Bath wrote:
> On Tue, 2 Jul 2002, jw schultz wrote:
[something causing printk every n emulation hits]
> 
> > wouldn't add too much more overhead than
> >
> > 	if (!emulation_notice)
> > 	{
> > 		emulation_notice = 1;
> > 		printk(...);
> > 	}
> >
> > after all this is only supposed to happen under rescue
> > situations.  That way it will be sure to be in the logs and
> > maybe even on the console and we won't have to hunt for it.
> >
> > Also, the message should say you are doing instruction
> > emulation.  "wrong model cpu, emulating instruction XXX" I
> > doubt indicating the program is helpful unless the tracking
> > is done per task or the printk every time you emulate.
> 
> I'd suggest this message could be so frequent that you want to
> link it's display to real time. Check the jiffy counter each
> time and if it's been less that X seconds since the last message
> just up a counter. Plus in the message say how many instructions
> have been emulated since the last one ... eg if it's only five
> I don't care, but five million would be a problem!

If a jiffies check (need only be low order word) isn't too
expensive, fine.  My concern hear is that while i don't want
the printk overhead of emulation to swamp the system i do want
it to pepper the log so if someone is foolish enough to be
miscompiled with this in they will know it.

Emulating advanced instructions via traps is slow, very slow
i would be willing to put up with an extra 5% time overhead
to tell the user he shouldn't be doing it.  This emulation
should only be done long enough to rescue and/or recompile.
period. It occurs to me now that if it comes from user-mode
(can we tell?) we should always printk with ARGV[0], not
PID, to identify the faulty executable.

As such i'm more concerned with codesize than speed.  If it
is too big i wouldn't enable it in *config.

> 
> One other thing ... should the FPU emulator also display messages
> like these if it's used?
Absolutely not.  The kernel never uses FPU instructions and
there are legitimate situations for running on systems
without an FPU where user-level floating point will be used.

The distinction between these two emulations is clear.
FPU emulation allows user-mode code to do floating point
without coding around the (now corner) case of not having a
FPU.  CMOV et al emulation allows you to move a HD from a
dead MB to another with a different CPU type or at least
boot a kernel that was configured for the wrong CPU type
without crashing on an "illegal instruction".  One is
long-term normal operation, the other is short-term crash
avoidance.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
