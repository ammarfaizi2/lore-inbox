Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270847AbTGNVav (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270845AbTGNV3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:29:54 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:14297 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S270843AbTGNV2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:28:40 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Guillaume Chazarain <gfc@altern.org>
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Date: Tue, 15 Jul 2003 07:45:32 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, phillips@arcor.de, smiler@lanil.mine.nu
References: <WRGA0805JD97A7A6YTZT94KB0B0JI65.3f12ced4@monpc>
In-Reply-To: <WRGA0805JD97A7A6YTZT94KB0B0JI65.3f12ced4@monpc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307150745.33036.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 01:40, Guillaume Chazarain wrote:
> 14/07/03 02:07:34, Con Kolivas <kernel@kolivas.org> wrote:
> >On Mon, 14 Jul 2003 00:54, Guillaume Chazarain wrote:
> >> Good, with ISO_PENALTY == 2, I can smoothly move big windows (with
> >> ISO_PENALTY == 5 it was smooth only with very small windows), but it
> >> lets me move them smoothly during less time than stock :(
> >
> >Less time than stock? I don't understand you. You can only move them
> > smoothly for a small time or they move faster or... ?
>
> With the previous SCHED_ISO, moving big windows was smooth for a short
> time, but then it became jerky.  Unlike with stock where it was smooth all
> the time.
>
> >Indeed it is artificial, and probably never a real world condition unless
> > it was specifically an attack, but it would never bring the system to a
> > halt, just some minor audio hiccups while it adjusted.
>
> This is also true for stock.
>
> >> >The logical conclusion of this idea where there is a dynamic policy
> >> > assigned to interactive tasks is a dynamic policy assigned to non
> >> > interactive tasks that get treated in the opposite way. I'll code
> >> > something for that soon, now that I've had more feedback on the first
> >> > part.
> >>
> >> Interesting, let's see :)
> >> But as the interactive bonus can already be negative I wonder what use
> >> will have another variable.
> >
> >As it is, the penalty will be no different to what it currently gets to
> > (in the same way sched_iso get the same bonus they normally would). The
> > difference is once they are moved to the different policy it is much
> > harder for them to change from that state, always getting the maximum
> > penalty, and being expired each time they run out of timeslice instead of
> > getting a chance to be put onto the active array. Neither of these new
> > states is very different to what normal policy tasks get except for the
> > fact they dont change interactive state without a lot more effort.
>
> OK, the latest SCHED_ISO fixed my problem, but now I am afraid of the
> scheduler trying to be too intelligent, because if it makes the wrong
> choice the bad result will be much more noticeable.
> I like the simplicity of stock, the interactivity bonus is given in a
> simple and understandable way, and if it's not given to the process you
> want, you can always renice it or make it RT.

Yes I think I may be chasing my own tail with this work and should probably 
concentrate on what has been working...

>
> I have to admit that
> p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 1) /
> MAX_BONUS; and
> if ((runtime - MIN_SLEEP_AVG < MAX_SLEEP_AVG) && (runtime *
> JUST_INTERACTIVE > p->sleep_avg)) p->sleep_avg += (runtime *
> JUST_INTERACTIVE - p->sleep_avg) *
> 	                (MAX_SLEEP_AVG + MIN_SLEEP_AVG - runtime) / MAX_SLEEP_AVG;
>
> are quite obscure to me.

If the patch ever stabilises I'll post an RFC explaining as much as possible.

>
> Also, I don't understand your MAX_BONUS definition:
> ((MAX_USER_PRIO - MAX_RT_PRIO) * PRIO_BONUS_RATIO / 100) it evaluates to
> -15
>
> I would use ((MAX_PRIO - MAX_RT_PRIO) * PRIO_BONUS_RATIO / 100 / 2) since
> it gives 5.

I was trying to preserve Ingo's code style where it still existed...

I'll concentrate on the O*int patches because they are less invasive. This 
approach has the problem you described:
> scheduler trying to be too intelligent, because if it makes the wrong
> choice the bad result will be much more noticeable.
and it will never be smart enough...

Con

