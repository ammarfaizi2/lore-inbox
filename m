Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVAADSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVAADSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 22:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVAADSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 22:18:50 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57746 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262183AbVAADSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 22:18:46 -0500
Subject: Re: Latency results with 2.6.10 - looks good
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Paul Davis <paul@linuxaudiosystems.com>
In-Reply-To: <1104348820.5218.42.camel@krustophenia.net>
References: <1104348820.5218.42.camel@krustophenia.net>
Content-Type: text/plain
Date: Fri, 31 Dec 2004 22:18:44 -0500
Message-Id: <1104549524.3803.28.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-29 at 14:33 -0500, Lee Revell wrote:
> After testing JACK with vanilla 2.6.10, it appears that the scheduling
> latency of 2.6.10 is a vast improvement over previous kernel releases.
> JACK seems to be usable with a period of 32 and 64 frames, I cannot
> produce xruns by moving the mouse or any amount of display or disk
> activity.  Previous kernel releases were somewhat worse than Windows XP
> in this area, 2.6.10 is definitely better, maybe as good as OSX.

Followup: other audio users have confirmed that 2.6.10 is the best
release yet latency-wise.  It works most of the time at 64 frames
(~1.33ms latency).

Now, the bad news: there are still enough xruns to make it not quite
good enough for, say, a recording studio; as we all know with realtime
constraints the worst case scenario is important.  As expected the RT
kernel beats it by a wide margin.  I have attached some numbers,
excerpted from a post by Rui on the JACK list.  The JACK test used was
described previously on this list.

Ingo, what are your plans for pushing more of the RT patch set upstream?
It seems that the soft/hardirq threading and voluntary preemption
(turning the might_sleep checks into preemption points) are required to
further improve the latency of the standard kernel.  These are well
tested at this point and also zero cost for users who don't enable them.
I think if these features go upstream before 2.6.11 then we can say all
of the issues Paul raised, in that post months ago that led to the VP
patches, will be put to rest.

We are finally within sight of Linux being the best multimedia OS
available, out of the box - a position we had briefly in the 2.4 days,
albeit with the low latency patches, and subsequently lost to OSX
(IMHO).  This is a milestone, everyone should be proud of this release.

Anyway, happy new year to everyone.

Lee

--

Rui:

Now, let's get to the point. With the default workload (20 clients * 4 *
4 ports) I've ran it against a Con Kolivas' 2.6.10-cko1 patched kernel
and the real jewel as is latest 2.6.10-rc3-mm1-RT-V0.7.33-04, which is
Ingo Molnar's full PREEMPT_RT patched kernel. The tests were conducted
on my P4@2.5G laptop, against the on-board alsa driver (snd-ali5451).

The jackd command line is therefore:

  jackd -v -R -P60 -dalsa -dhw:0 -r44100 -p64 -n2 -S -P

The results speak for themselves :)


                                  2.6.10-cko1  RT-V0.7.33-04
                                  ------------- -------------
  Timeout Rate  . . . . . . . . :    (    0.0)    (    0.0)   /hour
  XRUN Rate . . . . . . . . . . :       216.8          2.2    /hour
  Delay Rate (>spare time)  . . :       395.2          0.0    /hour
  Delay Rate (>1000 usecs)  . . :       375.8          0.0    /hour
  Delay Maximum . . . . . . . . :      4320          308      usecs
  Cycle Maximum . . . . . . . . :       845         1051      usecs
  Average DSP Load. . . . . . . :        44.0         50.2    %
  Average CPU System Load . . . :        14.4         31.7    %
  Average CPU User Load . . . . :        19.8         21.4    %
  Average CPU Nice Load . . . . :         0.0          0.0    %
  Average CPU I/O Wait Load . . :         0.1          0.1    %
  Average CPU IRQ Load  . . . . :         0.0          0.0    %
  Average CPU Soft-IRQ Load . . :         0.0          0.0    %
  Average Interrupt Rate  . . . :      1691.7       1692.6    /sec
  Average Context-Switch Rate . :     13368.8      18213.9    /sec

--

