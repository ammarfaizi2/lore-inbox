Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265908AbTGLPNn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 11:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265911AbTGLPNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 11:13:43 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:38534 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265908AbTGLPNl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:13:41 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 12 Jul 2003 08:20:57 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Miguel Freitas <miguel@cetuc.puc-rio.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
In-Reply-To: <1058017391.1197.24.camel@mf>
Message-ID: <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
References: <1058017391.1197.24.camel@mf>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003, Miguel Freitas wrote:

> Hi Davide,
>
> I've found your SCHED_SOFTRR patch pretty interesting, the idea sounds
> amazingly simple and effective :)
>
> Some months ago i did experiments with multimedia performance on linux
> kernel and ideas on what could be improved.
>
> http://cambuca.ldhs.cetuc.puc-rio.br/~miguel/multimedia_sim/
>
> I think it should be a general consensus that joe user must not need to
> patch his kernel or run the multimedia player as root just to be able to
> watch videos with good quality.

While I love the new scheduler, it is also true that interactivity comes
at a price. And this is fairness and predictable latency. It is also true
that many multimedia application do use very small buffers, that make them
to require short timings. I have to say that on my machine (P4 2.4GHz),
audio hardly skip during the typical load that my desktop sees, that in
turn is not so high. Like you can see in the couple of graphs that I
quickly dropped inside the SOFTRR page, typical latencies of 150ms are
very easy to obtain. Also, during the load used to measure those
latencies, my machines was perfectly interactive. And this clearly means
that high latencies are not interactivity enemies. I am also very much
sure that way higher latencies will be observable with other loads. It is
sufficent that one interactive task will start eating CPU slices that,
with the current timeslices and decay law, can generate a blackout of
hundreds of milliseconds. There are sufficent to make everyone expecting
bounded latencies to miss them. The patch is trivially simple, like you
can see from the code, and it basically introduces an expiration policy
for realtime tasks (SOFTRR ones). Polite SCHEDRR tasks can benefit of a
really predictable latency (see graph), while if they start to be greedy
they will be expired like other SCHED_OTHER tasks. Since RT processes ends
up getting a pretty decent timeslice, this should be sufficent for them
to perform their timing critical tasks w/out ever being expired. The other
test I did was indeed a task 'for (;;);' running on my machine with
SCHED_SOFTRR policy, and I could not even feel it. Patch acceptance is
tricky and definitely would need more discussion and test. The POSIX
standard clearly does not leave any space for std-user quasi-realtime
policies. The SCHED_RR and SCHED_FIFO are definitely not suitable to be
used from non-root because of the potential starvation they might inflict
to other processes on the system. On the other side, a modification of the
SCHED_RR and SCHED_FIFO behaviour inside the kernel is not good for both
POSIX compliancy and existing real realtime tasks compatibility. Bah, I
don't know. If they're roses they'll bloom ... ;)



> As a xine developer i'm very interested in help improving that
> situation. Please let me know if you think this patch has chance of
> being accepted into main tree, we can add support in xine for it.

With the current patch you do not need any special support if you are
already asking for SCHED_RR policy. If you are not root you will be
automatically downgraded to SCHED_SOFTRR ;)



PS: I just realized that the SOFTRR name is Copyright by Daniel Phillips.
Sorry Daniel, pls do not sue me :)



- Davide

