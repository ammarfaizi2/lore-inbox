Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272227AbTHNHkz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 03:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272236AbTHNHkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 03:40:55 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:38830
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272227AbTHNHky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 03:40:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] O12.2int for interactivity
Date: Thu, 14 Aug 2003 17:46:53 +1000
User-Agent: KMail/1.5.3
Cc: Timothy Miller <miller@techsource.com>, rob@landley.net,
       Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
       linux-kernel@vger.kernel.org
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <200308141659.33447.kernel@kolivas.org> <20030814070119.GN32488@holomorphy.com>
In-Reply-To: <20030814070119.GN32488@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308141746.53346.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003 17:01, William Lee Irwin III wrote:
> On Thu, 14 Aug 2003 16:09, William Lee Irwin III wrote:
> >> "scale" on which scheduling events should happen, and as tasks become
> >> more cpu-bound, they have longer timeslices, so that two cpu-bound
> >> tasks of identical priority will RR very slowly and have reduced
> >> context switch overhead, but are near infinitely preemptible by more
> >> interactive or short-running tasks.
>
> On Thu, Aug 14, 2003 at 04:59:33PM +1000, Con Kolivas wrote:
> > Actually the timeslice handed out is purely dependent on the static
> > priority, not the priority it is elevated or demoted to by the
> > interactivity estimator. However lower priority tasks (cpu bound ones if
> > the estimator has worked correctly) will always be preempted by higher
> > priority tasks (interactive ones) whenever they wake up.
>
> So it is; the above commentary was rather meant to suggest that the
> lengthening of timeslices in conventional arrangements did not penalize
> interactive tasks, not to imply that priority preemption was not done
> at all in the current scheduler.

While you're on the subject can I just clarify some details about the arrays. 
If a task doesn't use up it's full timeslice and goes back to sleep, it 
starts gaining bonus points which elevate it's interactivity in the eyes of 
the scheduler. When it wakes up again, it will always go onto the active 
array. While running, it's bonus points are being burnt off on a time basis. 
If it then uses up it's timeslice, depending on whether it is above or below 
a cuttoff (the delta) based on the level of interactivity of the task, the 
scheduler will decide to put it on the end of the active array again, or 
expire it. Thus tasks that never sleep are always below the interactive delta 
so each time they use up their timeslice they go onto the expired array. 
Tasks with enough bonus points can go back onto the active array if they 
haven't used up those bonus points.

As wli said, most of my tweaks just change what I do with the data given to me 
by the scheduler, and looks for patterns in the way processes run to choose 
what bonus to give each process. The rest is the same as the vanilla tree.

Lots more to say but that should make it clear enough for understanding. 

Con

