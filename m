Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261851AbTCTUFD>; Thu, 20 Mar 2003 15:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261871AbTCTUFD>; Thu, 20 Mar 2003 15:05:03 -0500
Received: from spc1.esa.lanl.gov ([128.165.67.191]:19841 "EHLO
	spc1.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S261851AbTCTUFA> convert rfc822-to-8bit; Thu, 20 Mar 2003 15:05:00 -0500
Subject: Re: 2.5.65-mm2
From: "Steven P. Cole" <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Mike Galbraith <efault@gmx.de>
Cc: Ed Tomlinson <tomlins@cam.org>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <5.2.0.9.2.20030320194530.01985440@pop.gmx.net>
References: <200303192327.45883.tomlins@cam.org>
	 <20030319012115.466970fd.akpm@digeo.com>
	 <20030319163337.602160d8.akpm@digeo.com>
	 <1048117516.1602.6.camel@spc1.esa.lanl.gov>
	 <200303192327.45883.tomlins@cam.org>
	 <5.2.0.9.2.20030320194530.01985440@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1048191154.1638.34.camel@spc1.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-1mdk 
Date: 20 Mar 2003 13:12:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-20 at 12:48, Mike Galbraith wrote:
> At 07:36 AM 3/20/2003 -0700, Steven Cole wrote:
> >On Wed, 2003-03-19 at 21:27, Ed Tomlinson wrote:
> > > On March 19, 2003 06:45 pm, Steven P. Cole wrote:
> > > > On Wed, 2003-03-19 at 17:33, Andrew Morton wrote:
> > > > > "Steven P. Cole" <elenstev@mesatop.com> wrote:
> > > > > > > Summary: using ext3, the simple window shake and scrollbar wiggle
> > > > > > > tests were much improved, but really using Evolution left much 
> > to be
> > > > > > > desired.
> > > > > >
> > > > > > Replying to myself for a followup,
> > > > > >
> > > > > > I repeated the tests with 2.5.65-mm2 elevator=deadline and the
> > > > > > situation was similar to elevator=as.  Running dbench on ext3, the
> > > > > > response to desktop switches and window wiggles was improved over
> > > > > > running dbench on reiserfs, but typing in Evolution was subject 
> > to long
> > > > > > delays with dbench clients greater than 16.
> > > > >
> > > > > OK, final question before I get off my butt and find a way to reproduce
> > > > > this:
> > > > >
> > > > > Does reverting
> > > > >
> > > > > 
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.65/2.5.65-mm2/broken-ou
> > > > >t/sched-2.5.64-D3.patch
> > > > >
> > > > > help?
> > > >
> > > > Sorry, didn't have much time for a lot of testing, but no miracles
> > > > occurred.  With 5 minutes of testing 2.5.65-mm2 and dbench 24 on ext3
> > > > and that patch reverted (first hunk had to be manually fixed), I don't
> > > > see any improvement.  Still the same long long delays in trying to use
> > > > Evolution.
> > >
> > > Steven,
> > >
> > > Do things improve with the patch below applied?  You have to backout the
> > > schedule-tuneables patch before appling it.
> > >
> > > Ed Tomlinson
> >
> >[patch snipped]
> >
> >I tried that patch, and the bad behavior with the Evolution "Compose a
> >Message" window remains.  With a load of dbench 12, I had stalls of many
> >seconds before I could type something.  Also, here is an additional
> >symptom.  If I move the Evolution "Compose" window around rapidly, it
> >leaves a smear of itself on the screen under itself.  With all -mm2
> >variants, this smear stays for an intolerably long time (tens of
> >seconds) while that window does not record keyboard strokes.  2.5.65-bk
> >on the other hand exhibits much more benign behavior.
> 
> This is a side effect of Ingo's (nice!) latency change methinks.  When you 
> have several cpu hogs running (dbench), and they are cleaning your cpu's 
> clock by using their full bandwidth to attain maximum throughput, and they 
> then break up their timeslice in order to provide you with more 
> responsiveness, and then their _cumulative_  sleep time between (round 
> robin!) cpu hard burns is added to their sleep_avg, (boy is this a long 
> sentence) you will (likely) find that they run at a highly elevated 
> priority and starve the devil out of everything else because they can not 
> possibly get enough cpu to eat the sleep_avg they have been given (only way 
> to reduce their priority without forking).  Virgin .65 is also subject to 
> the positive feedback loop (irman's process load is worst case methinks, 
> and rounding down only ~hides it).
> 
> I have a really horrid looking sched.c right now that works around some of 
> this problem in disgusting ways.  If you want to try it, give me a holler 
> before tomorrow morning (slice 'n dice resumes) and I'll rip it out and 
> send it to you.  Fair warning though, if you have good taste, don't look at 
> it at all before applying.  There are a few of spots I wouldn't even want 
> to _try_ to justify.  I don't think dbench will be able to dork it up, but 
> irman's process load (horrible thing) now can again.  (it's pure 
> research... that says a lot;)
> 
> Bottom line is that once cpu hogs are falsely determined to be sleepers, 
> positive feedback kills you.
> 
>          -Mike 
> 
> 
Sure, either post a patch against a known sync point, .65, .65-bk, or
65-mm2, or send me the sched.c file itself (2600 lines might be a little
too much for the entire list).

If you send it in the next 2 hours, I can test today, otherwise I'll do
it mañana.

Steven
