Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263007AbVD2V3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbVD2V3M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbVD2V1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:27:04 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:36201 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263007AbVD2VZj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:25:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oIRDuaWQa5apXbTvreAt2jXS3NukvKevLDNGEho+IyXUSq30PHDZHLdLOphnJZZjwDy9RhW5qpOGlzFMe3J+YaYRObovavdqrSwq1bxLqLLLpZRGp2iVndK2d7kPsqu6sy2QYThLW9KI3w34CEErMhMwp4CnhYNMp0wf0VJl5bw=
Message-ID: <29495f1d050429142515f7e2c4@mail.gmail.com>
Date: Fri, 29 Apr 2005 14:25:32 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Paulo Marques <pmarques@grupopie.com>
Subject: Re: setitimer timer expires too early
Cc: Olivier Croquette <ocroquette@free.fr>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <427285CC.9090300@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42726DDD.1010204@free.fr> <427285CC.9090300@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/05, Paulo Marques <pmarques@grupopie.com> wrote:
> Olivier Croquette wrote:
> > Hello
> >
> > I wrote a program which uses setitimer to implement a usleep() equivalent.
> > [...]
> > Anyone have an idea?
> > Can you reproduce that?
> 
> I can reproduce that.
> 
> It seems that the code responsible for this is in kernel/itimer.c:126:
> 
>         p->signal->real_timer.expires = jiffies + interval;
>         add_timer(&p->signal->real_timer);
> 
> If you request an interval of, lets say 900 usecs, the interval given by
> timeval_to_jiffies will be 1.

<snip>

> The complex (and more computationally expensive) solution would be to
> check the gettimeofday time, and compute the correct number of jiffies.
> This way, if we request a 300 usecs timer 200 usecs inside the timer
> tick, we can wait just one tick, but not if we are 800 usecs inside the
> tick. This would also mean that we would have to lock preemption during
> these computations to avoid races, etc.

I am working on soft-timer subsystem rework that will do exactly this,
based upon John Stultz's timeofday-rework. Expect to see an RFC soon
:)

> I've searched the archives but couldn't find this particular issue being
> discussed before.

Perhaps not discussed before, but definitely a known issue. Check out
sys_nanosleep(), which adds an extra jiffy to the delay if there is
going to be one. My patch, which uses human-time (or at least more so
than currently), should not have issues like this.
 
> Attached is a patch to do the simple solution, in case anybody thinks
> that it should be used.

Your patch is the only way to guarantee no early timeouts, as far as I know.

Really, what you want is:

on adding timers, take the ceiling of the interval into which it could be added
on expiring timers, take the floor

This combination guarantees no timers go off early (and takes away
many of these corner cases). I do exactly this in my patch, btw.

> Signed-Off-By: Paulo Marques <pmarques@grupopie.com>

Acked-By: Nishanth Aravamudan <nacc@us.ibm.com>

Thanks,
Nish
