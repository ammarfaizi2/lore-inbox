Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271279AbTGQASy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 20:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271283AbTGQASy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 20:18:54 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:19345
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271279AbTGQASs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 20:18:48 -0400
Message-ID: <1058402012.3f15eedcc06f2@kolivas.org>
Date: Thu, 17 Jul 2003 10:33:32 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] O6int for interactivity
References: <200307170030.25934.kernel@kolivas.org> <Pine.LNX.4.55.0307161241280.4787@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0307161241280.4787@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Davide Libenzi <davidel@xmailserver.org>:

> On Thu, 17 Jul 2003, Con Kolivas wrote:
> 
> > O*int patches trying to improve the interactivity of the 2.5/6 scheduler
> for
> > desktops. It appears possible to do this without moving to nanosecond
> > resolution.
> >
> > This one makes a massive difference... Please test this to death.
> >
> > Changes:
> > The big change is in the way sleep_avg is incremented. Any amount of sleep
> > will now raise you by at least one priority with each wakeup. This causes
> > massive differences to startup time, extremely rapid conversion to
> interactive
> > state, and recovery from non-interactive state rapidly as well (prevents X
> > stalling after thrashing around under high loads for many seconds).
> >
> > The sleep buffer was dropped to just 10ms. This has the effect of causing
> mild
> > round robinning of very interactive tasks if they run for more than 10ms.
> The
> > requeuing was changed from (unlikely()) to an ordinary if.. branch as this
> > will be hit much more now.
> 
> Con, I'll make a few notes on the code and a final comment.
> 
> 
> 
> > -#define MAX_BONUS		((MAX_USER_PRIO - MAX_RT_PRIO) * 
PRIO_BONUS_RATIO /
> 100)
> > +#define MAX_BONUS		(40 * PRIO_BONUS_RATIO / 100)
> 
> Why did you bolt in the 40 value ? It really comes from (MAX_USER_PRIO -
> MAX_RT_PRIO)
> and you will have another place to change if the number of slots will
> change. If you want to clarify better, stick a comment.

Granted. Will revert. If you don't understand it you shouldn't be fiddling with 
it I agree.

> 
> 
> 
> > +			p->sleep_avg = (p->sleep_avg * MAX_BONUS / runtime + 1) 
* runtime /
> MAX_BONUS;
> 
> I don't have the full code so I cannot see what "runtime" is, but if
> "runtime" is the time the task ran, this is :
> 
> p->sleep_avg ~= p->sleep_avg + runtime / MAX_BONUS;
> 
> (in any case a non-decreasing function of "runtime" )
> Are you sure you want to reward tasks that actually ran more ?


That was the bug. Runtime was supposed to be limited to MAX_SLEEP_AVG. Fix will 
be posted very soon.

> 
> 
> Con, you cannot follow the XMMS thingy otherwise you'll end up bolting in
> the XMMS sleep->burn pattern and you'll probably break the make-j+RealPlay
> for example. MultiMedia players are really tricky since they require strict
> timings and forces you to create a special super-interactive treatment
> inside the code. Interactivity in my box running moderate high loads is
> very good for my desktop use. Maybe audio will skip here (didn't try) but
> I believe that following the fix-XMMS thingy is really bad. I believe we
> should try to make the desktop to feel interactive with human tollerances
> and not with strict timings like MM apps. If the audio skips when dragging
> like crazy a X window using the filled mode on a slow CPU, we shouldn't be
> much worried about it for example. If audio skip when hitting the refresh
> button of Mozilla, then yes it should be fixed. And the more you add super
> interactive patterns, the more the scheduler will be exploitable. I
> recommend you after doing changes to get this :
> 
> http://www.xmailserver.org/linux-patches/irman2.c
> 
> and run it with different -n (number of tasks) and -b (CPU burn ms time).
> At the same time try to build a kernel for example. Then you will realize
> that interactivity is not the bigger problem that the scheduler has right
> now.

Please don't assume I'm writing an xmms scheduler. I've done a lot more testing 
than xmms.

Con
