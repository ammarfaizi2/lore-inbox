Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261612AbTCQNpF>; Mon, 17 Mar 2003 08:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbTCQNpF>; Mon, 17 Mar 2003 08:45:05 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:60300 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S261612AbTCQNpE>; Mon, 17 Mar 2003 08:45:04 -0500
Date: Mon, 17 Mar 2003 14:55:14 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Vitezslav Samel <samel@mail.cz>
cc: Matthew Wilcox <willy@debian.org>, Eric Piel <Eric.Piel@Bull.Net>,
       <davidm@hpl.hp.com>, <linux-ia64@linuxia64.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] nanosleep() granularity bumps up in 2.5.64
In-Reply-To: <20030317074526.GA21969@pc11.op.pod.cz>
Message-ID: <Pine.LNX.4.33.0303171445110.23224-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003, Vitezslav Samel wrote:

> On Fri, Mar 14, 2003 at 02:48:59PM +0000, Matthew Wilcox wrote:
> > On Fri, Mar 14, 2003 at 03:34:36PM +0100, Eric Piel wrote:
> > > I think lines like that from patch-2.5.64 are very suspicious to be
> > > related to the bug:
> > > +	base->timer_jiffies = INITIAL_JIFFIES;
> > > +	base->tv1.index = INITIAL_JIFFIES & TVR_MASK;
> > > +	base->tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
> > > +	base->tv3.index = (INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) & TVN_MASK;
> > > +	base->tv4.index = (INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) &
> > > TVN_MASK;
> > > +	base->tv5.index = (INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) &
> > > TVN_MASK;
> >
> > No, I don't think so.  Those lines are for starting `jiffies' at a very
> > high number so we spot jiffie-wrap bugs early on.
>
>   The nanosleep() bug narrowed down to 2.5.63-bk2. That's version, the "initial
> jiffies" patch went in. And yes, it's on i686 machine.

You can easily check whether it's connected with this change by setting
INITIAL_JIFFIES to zero. This should exactly recover the previous
situation.
I.e., something like the following (untested, hand-crafted) patch:

--- linux-2.5.64/include/linux/time.h
+++ linux-2.5.64/include/linux/time.h
@@ -28,7 +28,7 @@
  * Have the 32 bit jiffies value wrap 5 minutes after boot
  * so jiffies wrap bugs show up earlier.
  */
- #define INITIAL_JIFFIES ((unsigned int) (-300*HZ))
+ #define INITIAL_JIFFIES 0

 /*
  * Change timeval to jiffies, trying to avoid the


Tim

