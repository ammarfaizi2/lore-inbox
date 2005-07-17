Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVGQSA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVGQSA6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 14:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVGQSA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 14:00:58 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:43139 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261344AbVGQSA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 14:00:56 -0400
Date: Sun, 17 Jul 2005 20:00:48 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [RFC - 0/12] NTP cleanup work (v. B4)
In-Reply-To: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0507171706490.3728@scrub.home>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Jul 2005, john stultz wrote:

> 	In my attempts to rework the timeofday subsystem, it was suggested I
> try to avoid mixing cleanups with functional changes. In response to the
> suggestion I've tried to break out the majority of the NTP cleanups I've
> been working out of my larger patch and try to feed it in piece meal. 
> 
> The goal of this patch set is to isolate the in kernel NTP state machine
> in the hope of simplifying the current timeofday code.

I don't really like, where you taken it with ntp_advance(). With these 
patches you put half the ntp state machine in there and execute it at 
every single tick.
>From the previous patches I can guess where you want to go with this, but 
I think it's the wrong direction. The code is currently as is for a 
reason, it's optimized for tick based system and I don't see a reason to 
change this for tick based system.
If you want to change this for cycle based system, you have to give more 
control to the arch/timer source, which simply call a different set of 
functions and the ntp core system basically just acts as a library to the 
timer source.
Tick based timer sources continue to update xtime and cycle based system 
will modify the cycle multiplier (e.g. what ppc64 does). Don't force 
everything to use the same set of functions, you'll make it only more 
complex. Larger ntp state updates don't have to be done more than once a 
second and leave the details of how the clock is updated to the clock 
source (just provide some library functions it can use).

bye, Roman
