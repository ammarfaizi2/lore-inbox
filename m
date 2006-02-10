Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWBJGa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWBJGa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 01:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWBJGa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 01:30:26 -0500
Received: from mail.gmx.de ([213.165.64.21]:17646 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751160AbWBJGaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 01:30:25 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Con Kolivas <kernel@kolivas.org>,
       gcoady@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <1139515605.30058.94.camel@mindpipe>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602081335.18256.kernel@kolivas.org>
	 <Pine.LNX.4.61.0602091806100.30108@yvahk01.tjqt.qr>
	 <1139515605.30058.94.camel@mindpipe>
Content-Type: text/plain
Date: Fri, 10 Feb 2006 07:35:19 +0100
Message-Id: <1139553319.8850.79.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 15:06 -0500, Lee Revell wrote:
> On Thu, 2006-02-09 at 18:06 +0100, Jan Engelhardt wrote:
> > >> grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log| cut
> > >> -c-95 ...
> > >
> > >What happens if you add "| cat" on the end of your command?
> > >
> > Do you think it's the new pipe buffering thing? (Introduced 2.6.10-.12, 
> > don't remember exactly)
> 
> If it's the same problem I've been seeing it goes back much farther than
> 2.6.10.
> 
> Lately I suspect the scheduler.

Hmm.  I ran into an oddity while testing a modified kernel, and see
something in schedule() that I don't think is right...

Down where it does requeue_task(next, array) if a freshly awakened task
is to possibly receive a priority boost for the time it sat on the
runqueue, I see a potential problem.  If the task didn't sit on the
queue long enough to be promoted, and isn't at the very top, it is going
to the back of the bus as soon it gets preempted by say xmms.  For a
task that possibly just sat through the full rotation of a busy queue
waiting for a shot at the cpu, that has got to hurt.  Speculating, that
requeue looks like it's there to increase the queue rotation rate, ie to
reduce latency, but it looks to me like it can also accomplish the
opposite if the context switch rate for your queue isn't very high.

... I ended up sharing a queue with a few rampaging irman2 threads, and
each keystroke took ages.  [btw, i wonder how the heck next->array could
not be rq->active there]  

	-Mike

