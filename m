Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWDMPal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWDMPal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 11:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWDMPak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 11:30:40 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:18359 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750946AbWDMPak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 11:30:40 -0400
Date: Thu, 13 Apr 2006 17:30:28 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: select takes too much time
Message-ID: <20060413153028.GA26480@rhlx01.fht-esslingen.de>
References: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 13, 2006 at 10:01:04AM -0500, Ram Gupta wrote:
> I am using select with a timeout value of 90 ms. But for some reason
> occasionally  it comes out of select after more than one second . I
> checked the man page but it does not help in concluding if this is ok
> or not. Is this expected  or it is a bug. Most of this time is
> consumed in   schedule_timeout . I am using 2.5.45 kernel but I
> believe the same would  be the true for the latest kernel too. Any
> thoughts or suggestion are welcome.

AFAIK (I'm not an absolute expert on this, but it should be about correct):
Any user of select() competes with all other processes on the system
for the attention of the scheduler. If there are always runnable tasks
available with a higher priority than the select() user, then it's easily
imaginable that those tasks get woken up and/or will be kept running first.
The timeout value given to select() thus states the *minimum* time that
the process will continue after if the timeout has been fully taken (i.e.
no event occurred).
The man page of select() is a bit inaccurate in saying that "it will return
immediately". Well, it will *try to* return ASAP once it has decided to
return. BUT the scheduler will *always* have ultimate authority upon when
*exactly* this process will be allowed to continue.

Now if you have issues with select() taking too long, then I'd say tough
luck, that's life, other processes seem more important than your select()
user, but OTOH it could mean that our scheduler design is not assigning
enough importance to processes waiting on a select() and becoming runnable
again (however I strongly doubt that, since there has gone a LOT of work into
proper scheduler design in Linux).

Or, to put it differently, select() doesn't have realtime guarantees, i.e.
there's no way for you to boldly assume that once select() times out
your process will continue to run instantly within microseconds.

Finally, *any* scheduling timeout on a system should be taken for granted
as a *minimum* guarantee only. This is also why looped msleep()s in
Linux drivers should very often be coupled with a jiffies timeout condition
just in case the system is so extremely busy that each msleep(1) takes up
3 seconds, thus letting a 300 times 1ms loop end up as 900 seconds instead...

Whoa, way too many words for answering such a basic issue...
(but this problem being so basic it probably cannot be explained too often)

Oh, and another related word of advice: when doing thread programming,
always synchronize parallel threads by letting them *block* on each others
status instead of letting the peer thread busy-loop for the other thread to
finish its work. Good schedulers *will* punish busy-looping and honour
proper blocking on a condition, so your software will suffer a lot when
doing too much busy-looping or semi-busy-looping (too many useless wakeups).

Andreas Mohr

-- 
Please consider not buying any HDTV hardware! (extremely anti-consumer)
Bitte kaufen Sie besser keinerlei HDTV-Geräte! (extrem verbraucherfeindlich)
Infos:
http://www.hdboycott.com   http://www.eff.org/IP/DRM/   http://bluraysucks.com
