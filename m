Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272329AbTHEKQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 06:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272535AbTHEKQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 06:16:55 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:3230
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272329AbTHEKQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 06:16:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 20:22:01 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200308050207.18096.kernel@kolivas.org> <1060060568.3f2f3d989683f@kolivas.org> <3F2F4076.1030009@cyberone.com.au>
In-Reply-To: <3F2F4076.1030009@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308052022.01377.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 15:28, Nick Piggin wrote:
> Con Kolivas wrote:
> >Quoting Nick Piggin <piggin@cyberone.com.au>:
> Yes yes, but we come to the same conclusion no matter why you have decided
> to make the change ;) namely that you're only papering over a flaw in the
> scheduler!

This would take a redesign in the interactivity estimator. I worked on one for 
a while but decided it best to stick to one infrastructure and tune it as 
much as possible; especially in this stage of 2.6 blah blah...

> What happens in the same sort of workload that is using interruptible
> sleeps?
> Say the same make -j NFS mounted interrruptible (I think?).

Dunno. Can't say. I've only ever seen NFS D but I don't have enough test 
material...

> I didn't really understand your answer a few emails ago... please just
> reiterate: if the problem is that processes sleeping too long on IO get
> too high a priority, then give all processes the same boost after they
> have slept for half a second?
>
> Also, why is this a problem exactly? Is there a difference between a
> process that would be a CPU hog but for its limited disk bandwidth, and
> a process that isn't a CPU hog? Disk IO aside, they are exactly the same
> thing to the CPU scheduler, aren't they?
>
> _wants_ to be a CPU hog, but can't due to disk

You're on the right track; I'll try and explain differently. 

A truly interactive task has periods of sleeping irrespective of disk 
activity. It is the time spent sleeping that the estimator uses to decide 
"this task is interactive, improve it's dynamic priority by 5". A true cpu 
hog (eg cc1) never sleeps intentionally and the estimator sees this as "I'm a 
hog; drop my priority by 5". Now if the cpu hog sleeps while waiting on disk 
i/o the estimator suddenly decides to elevate it's priority. If it gets to 
maximum boost and then stops doing I/O and goes back to being a hog it now 
starts starving other processes till it's dynamic priority drops enough 
again. As I said it's a design quirk (bug?) and _limiting_ how high the 
priority goes if the sleep is due to I/O would be ideal but I don't have a 
simple way to tell that apart from knowing that the sleep was 
UNINTERRUPTIBLE. This is not as bad as it sounds as for the most part it 
still is counted as sleep except that it can't ever get maximum priority 
boost to be a sustained starver.

However, since you're a disk I/O kind of guy you may have a better solution to 
this problem and give me some data I can feedback into the estimator ;-)

Con

