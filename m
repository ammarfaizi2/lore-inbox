Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUJLBYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUJLBYu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 21:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUJLBYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 21:24:50 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:33711 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S268246AbUJLBYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 21:24:40 -0400
Subject: Re: Totally broken PCI PM calls
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: David Brownell <david-b@pacbell.net>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200410111437.17898.david-b@pacbell.net>
References: <1097455528.25489.9.camel@gaston>
	 <200410110936.37268.david-b@pacbell.net>
	 <1097529469.4523.3.camel@desktop.cunninghams>
	 <200410111437.17898.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1097544283.3301.20.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Oct 2004 11:24:43 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-10-12 at 07:37, David Brownell wrote:
> On Monday 11 October 2004 2:17 pm, Nigel Cunningham wrote:
> > On Tue, 2004-10-12 at 02:36, David Brownell wrote:
> > > I've made that point too.  STD is logically a few steps:  quiesce system,
> > > write image to swap, change power state.
> 
> I'm hoping you agree with that abbreviated summary of
> what's involved!  Pavel seemed to.  Of course the devil is
> in the details, which I hope to leave mostly to others ... ;)

It certainly fits for Pavel, but, I do have things slightly different,
so that don't have the maximum-image-size-is-half-of-RAM problem. At the
moment I do:

quiesce system & prepare metadata
suspend devices not used for writing the image or user I/O (this is just
seeking to remove any chance of them allocating memory, which might
strangle writing the image)
write LRU pages ('pageset 2')
suspend used devices
save CPU context & make atomic copy of remaining pages
resume used devices
save image
power down used devices
power down system/enter S4.

This is why I made that 'device tree' patch - so I could separate the
devices used for writing the image from those unused and treat them
separately. I'm pretty sure that I could get away with leaving the
unused ones alone until snapshot time, but it seems more ideal to me to
get them to save state and power down at the start, especially if you're
trying to suspend when the battery is low!

At the very least, I'd like to see that 'snapshot' state implemented
separately to the 'powerdown' state.

> Of course the ACPI spec muddies the water by talking about two
> different states called "S4":  "S4 Sleeping", which is what I was
> talking about as G1/S4; and "S4 Non-Volatile Sleep" that's more
> what I've seen with swusp:  more like a G2 or G3 poweroff.

Okay. I've only looked at the ACPI spec occasionally, and have generally
just followed the lead of Patrick and Pavel in implementing ACPI support
in s-t-d.

> I'm willing to believe that there are systems on which swsusp
> tells drivers a less confusing story ... but I don't seem to have
> tested with those!

:> I'm confused by all these changes; no wonder drivers are!

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

