Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280448AbRK1Tj7>; Wed, 28 Nov 2001 14:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280456AbRK1Tjt>; Wed, 28 Nov 2001 14:39:49 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:48646 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280448AbRK1Tjs>; Wed, 28 Nov 2001 14:39:48 -0500
Message-ID: <3C053D4F.2AA643B@zip.com.au>
Date: Wed, 28 Nov 2001 11:38:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Torrey Hoffman <torrey.hoffman@myrio.com>,
        "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <3C043468.D50998E@zip.com.au> <Pine.LNX.4.21.0111281609270.15571-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> On Tue, 27 Nov 2001, Andrew Morton wrote:
> 
> > Torrey Hoffman wrote:
> > >
> > > I've running 2.4.16 with this VM patch combined with your
> > > 2.4.15-pre7-low-latency patch from www.zip.com.au.  (it applied with a
> > > little fuzz, no rejects). Is this a combination that you would feel
> > > comfortable with?
> >
> > Should be OK.  There is a possibility of livelock when you have
> > a lot of dirty buffers against multiple devices.
> 
> Could you please describe this one ?

It's a recurring problem with the low-latency patch.  Basically:

restart:
	spin_lock(some_lock);
	for (lots of data) {
		if (current->need_resched) {
			spin_unlock(some_lock);
			schedule();
			goto restart;
		}
		if (something_which_is_often_true)
			continue();
		other_stuff();
	}

If there is a realtime task which wants to be scheduled at,
say, one kilohertz, and the execution of that loop takes
more than one millisecond before it actually hits other_stuff()
and does any actual work, we make no progress at all, and we lock
up until the 1 kHz scheduling pressure is stopped.

In the 2.4.15-pre low-latency patch this can happen if we're
running fsync_dev(devA) and there are heaps of buffers for
devB on a list.

It's not a problem in your kernel ;)

-
