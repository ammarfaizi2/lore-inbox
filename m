Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271314AbTGQA6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 20:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271313AbTGQA6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 20:58:06 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:33169
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271314AbTGQA54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 20:57:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Wade <neroz@ii.net>
Subject: Re: [PATCH] O6int for interactivity
Date: Thu, 17 Jul 2003 11:15:33 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307170030.25934.kernel@kolivas.org> <1058402012.3f15eedcc06f2@kolivas.org> <3F15F279.7060909@ii.net>
In-Reply-To: <3F15F279.7060909@ii.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307171115.33063.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003 10:48, Wade wrote:
> Con Kolivas wrote:
> > Quoting Davide Libenzi <davidel@xmailserver.org>:
> >>On Thu, 17 Jul 2003, Con Kolivas wrote:
> >>>O*int patches trying to improve the interactivity of the 2.5/6 scheduler
> >>
> >>for
> >>
> >>>desktops. It appears possible to do this without moving to nanosecond
> >>>resolution.
> >>>
> >>>This one makes a massive difference... Please test this to death.
> >>>
> >>>Changes:
> >>>The big change is in the way sleep_avg is incremented. Any amount of
> >>> sleep will now raise you by at least one priority with each wakeup.
> >>> This causes massive differences to startup time, extremely rapid
> >>> conversion to
> >>
> >>interactive
> >>
> >>>state, and recovery from non-interactive state rapidly as well (prevents
> >>> X stalling after thrashing around under high loads for many seconds).
> >>>
> >>>The sleep buffer was dropped to just 10ms. This has the effect of
> >>> causing
> >>
> >>mild
> >>
> >>>round robinning of very interactive tasks if they run for more than
> >>> 10ms.
> >>
> >>The
> >>
> >>>requeuing was changed from (unlikely()) to an ordinary if.. branch as
> >>> this will be hit much more now.
> >>
> >>Con, I'll make a few notes on the code and a final comment.
> >>
> >>>-#define MAX_BONUS		((MAX_USER_PRIO - MAX_RT_PRIO) *
> >
> > PRIO_BONUS_RATIO /
> >
> >>100)
> >>
> >>>+#define MAX_BONUS		(40 * PRIO_BONUS_RATIO / 100)
> >>
> >>Why did you bolt in the 40 value ? It really comes from (MAX_USER_PRIO -
> >>MAX_RT_PRIO)
> >>and you will have another place to change if the number of slots will
> >>change. If you want to clarify better, stick a comment.
> >
> > Granted. Will revert. If you don't understand it you shouldn't be
> > fiddling with it I agree.
> >
> >>>+			p->sleep_avg = (p->sleep_avg * MAX_BONUS / runtime + 1)
> >
> > * runtime /
> >
> >>MAX_BONUS;
> >>
> >>I don't have the full code so I cannot see what "runtime" is, but if
> >>"runtime" is the time the task ran, this is :
> >>
> >>p->sleep_avg ~= p->sleep_avg + runtime / MAX_BONUS;
> >>
> >>(in any case a non-decreasing function of "runtime" )
> >>Are you sure you want to reward tasks that actually ran more ?
> >
> > That was the bug. Runtime was supposed to be limited to MAX_SLEEP_AVG.
> > Fix will be posted very soon.
>
> Should any harm come from running 06int without the phantom patch
> mentioned?

No harm, but applications that have been running for a while (?hours) will 
eventually not run quite as smoothly. I promise it is only one 10 minute 
kernel compile away :)

Con

