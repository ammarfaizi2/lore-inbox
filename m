Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266168AbTGLQM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266988AbTGLQM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:12:57 -0400
Received: from RJ161046.user.veloxzone.com.br ([200.149.161.46]:54003 "EHLO
	mf.dnsalias.org") by vger.kernel.org with ESMTP id S266168AbTGLQMg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:12:36 -0400
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
From: Miguel Freitas <miguel@cetuc.puc-rio.br>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
References: <1058017391.1197.24.camel@mf> 
	<Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jul 2003 13:34:32 -0300
Message-Id: <1058027672.1196.105.camel@mf>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davide,

On Sat, 2003-07-12 at 12:20, Davide Libenzi wrote:
> While I love the new scheduler, it is also true that interactivity comes
> at a price. And this is fairness and predictable latency. It is also true
> that many multimedia application do use very small buffers, that make them
> to require short timings.


I guess you are talking about mostly audio applications here. For video
playback these timings are even tighter and there is very little the
application itself can do to improve it (it's not a matter of increasing
the buffer size).

It is also true that most people won't be running heavy applications
while watching a video. It's not like the xmms that we leave running on
background while working.


> I have to say that on my machine (P4 2.4GHz),
> audio hardly skip during the typical load that my desktop sees, that in
> turn is not so high. Like you can see in the couple of graphs that I
> quickly dropped inside the SOFTRR page, typical latencies of 150ms are
> very easy to obtain.


150ms latency would kill any video application.

There is no equivalent of sound card's or kernel audio buffers for
frames, the application just _have_ to be scheduled in time to display
the frame (basicaly tell X to display a frame from shared memory, for
example).

In xine, we have separated decoder and output threads with a queue of
about 15 frames between them. So just the output thread needs
predictable latency, and that thread does use very little CPU.

Also the problem may get a little worse as people start trying to get
better quality from their systems. I recently added a plugin in xine
(tvtime) that deinterlaces frames to full tv field rate (60Hz). While
playing a DVD @ 30Hz under a 2.4 kernel (HZ=100) is usually acceptable,
60Hz pushes the requirements a little further: the output thread must be
scheduled every 16ms.


> The patch is trivially simple, like you
> can see from the code, and it basically introduces an expiration policy
> for realtime tasks (SOFTRR ones).

yes, i saw that, pretty nice!
i have yet to try it (i don't have any recent 2.5 on my machine)


> Patch acceptance is
> tricky and definitely would need more discussion and test.


Sure. But let me add a voice of support here: I would be great if kernel
provided a way to multimedia or interactive applications to request a
better latency predictability (or hint the scheduler somehow) without
need of being root. If that comes in a form of a new scheduler policy,
or just allowing small negative nice values for non-root i don't mind...


> With the current patch you do not need any special support if you are
> already asking for SCHED_RR policy. If you are not root you will be
> automatically downgraded to SCHED_SOFTRR ;)


We don't currently request SCHED_RR in xine. At least Ingo once adviced
me he didn't thought it was right for a multimedia application to use
that. The problem is that currently we have an all (root can set -nice,
scheduler policy, etc) or nothing situation.
 
regards,

Miguel

