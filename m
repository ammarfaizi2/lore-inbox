Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRBXS6I>; Sat, 24 Feb 2001 13:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbRBXS5s>; Sat, 24 Feb 2001 13:57:48 -0500
Received: from [216.151.155.116] ([216.151.155.116]:15110 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S129562AbRBXS5j>; Sat, 24 Feb 2001 13:57:39 -0500
To: Mark Swanson <swansma@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 242-ac3 loop bug
In-Reply-To: <20010224181136.18532.qmail@web1301.mail.yahoo.com>
From: Doug McNaught <doug@wireboard.com>
Date: 24 Feb 2001 13:57:36 -0500
In-Reply-To: Mark Swanson's message of "Sat, 24 Feb 2001 10:11:36 -0800 (PST)"
Message-ID: <m3u25jzz6n.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Swanson <swansma@yahoo.com> writes:

> --- Doug McNaught <doug@wireboard.com> wrote:
> > It's just an artifact of the fact that processes in state D
> > (uninterruptible sleep) are included in the load average calculation.
> > Since the loop thread apparently sits in state D waiting for events
> > on its device, you get a load average of 1 for each mounted loop
> > device. 
> 
> My thought was that the calculation seems to be misleading. The loop
> process isn't taking up any CPU time. My applications are running
> faster than ever. I'm guessing that ps (and /proc/loadavg) need to make
> the distinction between:
> 1. uninterruptable sleep - where the process is blocking but taking
> 0CPU
> 2. uninterruptable sleep - I/O is happening using CPU
> 
> But I may not understand what uninterruptable sleep is supposed to
> mean.

Well, "sleep" means we're not using CPU at all; we're waiting for
something.  Remember, "load average" isn't purely a CPU measure.

Historically, state D has meant "fast" i/o--reading from disk or tape,
where the result is supposed to be available very soon and it's not
worth doing the extra housekeeping to sleep interruptibly.  Processes
aren't supposed to sit in state D for more than a fraction of a
second.  This being the case, Unix has always factored state D
processes into the load average.  For your distinction to work, there
would have to be an extra flag somewhere saying "I'm in state D, but
don't factor me into the load average", with corresponding code in the
load average calculation routine to honor the flag.  Doable, but not
useful up to now, and only (possibly) worth doing if we get more
threads like the loop driver that sit in D state for a long time. 

This is the first example I've seen in Linux of something sitting in
state D for a long time on purpose.  I agree that IMHO it's not ideal
(for the reason you outline below, mainly).

> Take sendmail for example. Its default configuration for Linux won't
> send attachments if the machine's load is too high. If I have 8 loop
> devices in use and the load is at least 8, this may affect how sendmail
> operates.

Yup. 

The whole Sendmail/load average thing needs careful thought anyway
when setting up a production system--a load average of 8 on an 8-way
system, for example, is a much lighter load than a load of 8 on a
single-CPU machine.

-Doug
