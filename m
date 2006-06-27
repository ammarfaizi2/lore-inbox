Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWF0NCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWF0NCh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWF0NCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:02:36 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:3553 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932223AbWF0NCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:02:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Incorrect CPU process accounting using CONFIG_HZ=100
Date: Tue, 27 Jun 2006 23:02:16 +1000
User-Agent: KMail/1.9.3
Cc: Al Boldi <a1426z@gawab.com>, Pavel Machek <pavel@ucw.cz>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
References: <200606211716.01472.a1426z@gawab.com> <20060626160239.GA3257@elf.ucw.cz> <200606271532.33368.a1426z@gawab.com>
In-Reply-To: <200606271532.33368.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606272302.16950.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 June 2006 22:32, Al Boldi wrote:
> Pavel Machek wrote:
> > On Thu 2006-06-22 20:36:39, Al Boldi wrote:
> > > Jan Engelhardt wrote:
> > > > >Setting CONFIG_HZ=100 results in incorrect CPU process accounting.
> > > > >
> > > > >This can be seen running top d.1, that shows top, itself, consuming
> > > > > 0ms CPUtime.
> > > > >
> > > > >Will this bug have consequences for sched.c?
> > > >
> > > > Works for me, somewhat.
> > > > TIME+ says 0:00.02 after 70 secs. (Ergo: top is not expensive on this
> > > > CPU.)
> > >
> > > That's what I thought for a long time.  But at closer inspection, top
> > > d.1 slows down other apps by about the same amount of time at 1000Hz
> > > and 100Hz, only at 1000Hz it is accounted for whereas at 100Hz it is
> > > not.
> >
> > It is not a bug... it is design decision. If you eat "too little" cpu
> > time, you'll be accouted 0 msec. That's what happens at 100Hz...
>
> Bummer!
>
> Meanwhile, can't "too little" cpu time be made relative to CONFIG_HZ?

It is and that's what you're perceiving as the problem. We only charge tasks 
in ticks and it's the tick size they get charged with. So at 100HZ if a task 
is running when a tick fires it gets charged 1% cpu. If it runs for 100 ticks 
it gets charged with 100% cpu. At 1000HZ it gets charged .1% cpu per tick and 
so on. The actual problem is that tasks only get charged if they happen to be 
running at the precise moment the tick fires. Now you could increase the 
accuracy of this timekeeping but it is expensive and this is exactly the sort 
of thing that we're saving cpu resources on by running at 100HZ (one of 
many).

-- 
-ck
