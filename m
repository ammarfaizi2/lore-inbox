Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWBPOLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWBPOLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 09:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWBPOLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 09:11:11 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:6547 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932259AbWBPOLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 09:11:10 -0500
Date: Thu, 16 Feb 2006 15:10:51 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] hrtimer: round up relative start time on low-res arches
In-Reply-To: <1140036234.27720.8.camel@leatherman>
Message-ID: <Pine.LNX.4.61.0602161244240.30994@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home> 
 <1139827927.4932.17.camel@localhost.localdomain>  <Pine.LNX.4.61.0602131208050.30994@scrub.home>
  <20060214074151.GA29426@elte.hu>  <Pine.LNX.4.61.0602141113060.30994@scrub.home>
  <20060214122031.GA30983@elte.hu>  <Pine.LNX.4.61.0602150033150.30994@scrub.home>
  <20060215091959.GB1376@elte.hu>  <Pine.LNX.4.61.0602151259270.30994@scrub.home>
 <1140036234.27720.8.camel@leatherman>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 15 Feb 2006, john stultz wrote:

> 	I just wanted to make sure you know I'm not ignoring your suggestions.
> I do appreciate the time you have spent, and I have been continuing to
> work on implementing your idea. Unfortunately the code is not trivial
> and very much hurts the readability. I expect thats a sacrifice that
> will be necessary, but hopefully after some review cycles we'll be able
> to come to something we both like.

The code could be cleaned up a little, but the main difference is that my 
code is much more compact, it lacks all the redundancy of your code, which 
makes it harder to read. My hope was here instead of putting back the 
code redundancy to add documentation instead, which would explain the 
subtleties.
I actually think that the basic principle of my code is quite simple, the 
problem is that it's a little buried inbetween how the incremental updates 
are done in my prototype, so after a little cleaning and separating the 
special cases, I think my code would be a lot more readable.

> I'm hoping to have a first pass patch I can mail this week.

I'm looking forward to it.
BTW What do you think how difficult it would be to rebase your patches on 
my NTP4 patches? In the end the simplification of my patches should also 
make your patches simpler, as it precalculates as much as possible and 
reduces the work done in the fast paths. It would avoid a lot of extra 
work, which you currently do.
The main problem that I see is that you need to drop the ppm calculations, 
the new code provides a scaled nsec value per tick (tick_nsec + time_adj) 
and you basically only need "(update - 10^9/HZ) / cycles" to calculate the 
new multiplier adjustment.
You also need to drop your ntp rework, the changes to the generic code 
should be quite simple now, basically just exporting second_overflow() 
and creating an alternative do_timer() entry point which doesn't call 
update_wall_time().

Besides some small cleanups I think my code is ready for some serious 
testing, but it conflicts with your NTP changes.

bye, Roman
