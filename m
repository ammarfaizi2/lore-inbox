Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbVLETlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVLETlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVLETlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:41:47 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:35984 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932520AbVLETlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:41:46 -0500
Date: Mon, 5 Dec 2005 20:40:41 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
cc: Steven Rostedt <rostedt@goodmis.org>, johnstul@us.ibm.com,
       george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, ray-gmail@madrabbit.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <200512032028.59472.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Message-ID: <Pine.LNX.4.61.0512051136060.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0512011828150.1609@scrub.home> <1133464097.7130.15.camel@localhost.localdomain>
 <200512032028.59472.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 3 Dec 2005, Andrew James Wade wrote:

>      But does it make sense to use it in any other circumstances? It sounds
> like the rb-tree based ktimer system is suitable for the general case. So
> you can have a simple rule: use ktimeout for timing out when an expected
> event doesn't occur, and ktimer for everything else. Are there any
> situations where you want a timer optimized for the removal case that is not
> also monotonic and low-res? And are there any situations in practice other
> than the "timeout" one where you'd want to use a timer wheel instead of a
> rb-tree?
> 
>     It sounds to me that the ktimer should be the general case, leaving
> ktimeout to be optimized for one particular case (by e.g. decreasing the
> resolution to reduce cascades).

By reducing the resolution you only reduce the frequency of the cascading, 
but the amount of timer in the timer wheel at any time is still the same.
So in general you will have less number of cascades, but not generally 
smaller cascades. The latter depends on the actual timeout value and its
distribution over the wheel. This means you can tune the resolution to 
avoid most cascading for a specific situation, but that would be a rather 
bad general solution.

rbtree based timer are also not necessarily the better general case. The 
timer wheel still scales better with O(n) compared to the rbtree with
O(n*log(n)).

It's really better to keep the focus of the new timer at high resolution 
timer, that's what it's really better at and we shouldn't try to use it 
for everything only because it has such a kool name.

bye, Roman
