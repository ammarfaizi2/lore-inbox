Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263351AbUKZW4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbUKZW4B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbUKZTt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:49:29 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262383AbUKZT3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:29:21 -0500
Date: Thu, 25 Nov 2004 23:41:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge: 1/51: Device trees
Message-ID: <20041125224124.GE2711@elf.ucw.cz>
References: <20041125165413.GB476@openzaurus.ucw.cz> <20041125185304.GA1260@elf.ucw.cz> <1101421336.27250.80.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101421336.27250.80.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This patch allows the device tree to be split up into multiple trees. I
> > > don't really expect it to be merged, but it is an important part of
> > > suspend at the moment, and I certainly want to see something like it
> > > that will allow us to suspend some parts of the device tree and not
> > > others. Suspend2 uses it to keep alive the hard drive (or equivalent)
> > > that we're writing the image to while suspending other devices, thus
> > > improving the consistency of the image written.
> > > 
> > > I remember from last time this was posted that someone commented on
> > > exporting the default device tree; I haven't changed that yet.
> > 
> > Q: I do not understand why you have such strong objections to idea of
> > selective suspend.
> > 
> > A: Do selective suspend during runtime power managment, that's
> > okay. But
> > its useless for suspend-to-disk. (And I do not see how you could use
> > it for suspend-to-ram, I hope you do not want that).
> > 
> > Lets see, so you suggest to
> > 
> > * SUSPEND all but swap device and parents
> > * Snapshot
> > * Write image to disk
> > * SUSPEND swap device and parents
> > * Powerdown
> > 
> > Oh no, that does not work, if swap device or its parents uses DMA,
> > you've corrupted data. You'd have to do
> > 
> > * SUSPEND all but swap device and parents
> > * FREEZE swap device and parents
> > * Snapshot
> > * UNFREEZE swap device and parents
> > * Write
> > * SUSPEND swap device and parents
> > 
> > Which means that you still need that FREEZE state, and you get more
> > complicated code. (And I have not yet introduce details like system
> > devices).
> 
> There's obviously a misunderstanding here. What I do is:

Ok, sorry, this was from another flamewar ;).

> SUSPEND all but swap device and parents
> WRITE LRU pages
> SUSPEND swap device and parents (+sysdev)
> Snapshot
> RESUME swap device and parents (+sysdev)
> WRITE snapshot
> SUSPEND swap device and parents
> POWERDOWN everything
> 
> I thought I wrote - perhaps I'm wrong here - that I understand that your
> new work in this area might make this unnecessary. I really only want to
> do it this way because I don't know what other drivers might be doing
> while we're writing the LRU pages. I'm not worried about them touching
> LRU. What I am worried about is them allocating memory and starving
> suspend so that we get hangs due to being oom. If they're suspended, we
> have more certainty as to how memory is being used. I don't remember
> what prompted me to do this in the first place, but I'm pretty sure it
> would have been a real observed issue.

Uh... It seems like quite a lot of work. Would not reserving few more
pages help here? Or perhaps right solution is to fix "broken" drivers
that need too much memory...

...because you loose anyway if that "broken" driver is between swap
device and root.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
