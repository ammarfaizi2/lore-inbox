Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291254AbSBGUHz>; Thu, 7 Feb 2002 15:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291259AbSBGUHf>; Thu, 7 Feb 2002 15:07:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47630 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291254AbSBGUH0>;
	Thu, 7 Feb 2002 15:07:26 -0500
Message-ID: <3C62DE3E.DE15CAF2@zip.com.au>
Date: Thu, 07 Feb 2002 12:06:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Robert Love <rml@tech9.net>, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel@vger.kernel.org, mingo@elte.hu, nigel@nrg.org
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <3C629F91.2869CB1F@dlr.de>,		<3C629F91.2869CB1F@dlr.de> <1013107259.10430.29.camel@phantasy> <3C62D49A.4CBB6295@zip.com.au> <3C62DABA.3020906@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> Andrew Morton wrote:
> > Robert Love wrote:
> >>On Thu, 2002-02-07 at 10:38, Martin Wirth wrote:
> >>Some of the talk I've heard has been toward an adaptive lock.  These are
> >>locks like Solaris's that can spin or sleep, usually depending on the
> >>state of the lock's holder.  Another alternative, which I prefer since
> >>it is much less overhead, is a lock that spins-then-sleeps
> >>unconditionally.
> > I dunno.  The spin-a-bit-then-sleep lock has always struck me as
> > i_dont_know_what_the_fuck_im_doing_lock().  Martin's approach puts
> > the decision in the hands of the programmer, rather than saying
> > "Oh gee I goofed" at runtime.
> 
> The spin-then-sleep lock could be interesting as a replacement for the
> BKL in places where a semaphore causes performance degredation.  In
> quite a few places where we replaced the BKL with a more finely grained
> semapore (not a spinlock because we needed to sleep during the hold),
> instead of spinning for a bit, it would schedule instead.  This was bad
> :).  Spin-then-sleep would be great behaviour in this situation.

But surely you *knew*, from inspection, which code paths needed
a spinning lock, and which code paths needed a sleeping lock?

Assuming the answer is "yes" then a nice fix would be to use
two separate locks - one which spins and one which sleeps.

Now, if the resource which is being protected truly cannot
be split up into spin-protected and sleep-protected sections
then a lock which can be atomically converted from spinning to
sleeping at the programmer's discretion seems appropriate.

A dynamic lock which says "we've spun for too long, let's sleep"
seems to be a tradeoff between programmer effort and efficiency,
and a bad one at that.

Possibly the locks could become more adaptive, and could, at
each call site, "learn" the expected spintime.  But it all seems
too baroque to me.

-
