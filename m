Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264112AbUKZU3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264112AbUKZU3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbUKZU0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:26:10 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:60581 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264069AbUKZUMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:12:48 -0500
Subject: Re: Suspend2 merge: 1/51: Device trees
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125185304.GA1260@elf.ucw.cz>
References: <20041125165413.GB476@openzaurus.ucw.cz>
	 <20041125185304.GA1260@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101421336.27250.80.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 09:22:16 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 05:53, Pavel Machek wrote:
> Hi!
> 
> > This patch allows the device tree to be split up into multiple trees. I
> > don't really expect it to be merged, but it is an important part of
> > suspend at the moment, and I certainly want to see something like it
> > that will allow us to suspend some parts of the device tree and not
> > others. Suspend2 uses it to keep alive the hard drive (or equivalent)
> > that we're writing the image to while suspending other devices, thus
> > improving the consistency of the image written.
> > 
> > I remember from last time this was posted that someone commented on
> > exporting the default device tree; I haven't changed that yet.
> 
> Q: I do not understand why you have such strong objections to idea of
> selective suspend.
> 
> A: Do selective suspend during runtime power managment, that's
> okay. But
> its useless for suspend-to-disk. (And I do not see how you could use
> it for suspend-to-ram, I hope you do not want that).
> 
> Lets see, so you suggest to
> 
> * SUSPEND all but swap device and parents
> * Snapshot
> * Write image to disk
> * SUSPEND swap device and parents
> * Powerdown
> 
> Oh no, that does not work, if swap device or its parents uses DMA,
> you've corrupted data. You'd have to do
> 
> * SUSPEND all but swap device and parents
> * FREEZE swap device and parents
> * Snapshot
> * UNFREEZE swap device and parents
> * Write
> * SUSPEND swap device and parents
> 
> Which means that you still need that FREEZE state, and you get more
> complicated code. (And I have not yet introduce details like system
> devices).

There's obviously a misunderstanding here. What I do is:

SUSPEND all but swap device and parents
WRITE LRU pages
SUSPEND swap device and parents (+sysdev)
Snapshot
RESUME swap device and parents (+sysdev)
WRITE snapshot
SUSPEND swap device and parents
POWERDOWN everything

I thought I wrote - perhaps I'm wrong here - that I understand that your
new work in this area might make this unnecessary. I really only want to
do it this way because I don't know what other drivers might be doing
while we're writing the LRU pages. I'm not worried about them touching
LRU. What I am worried about is them allocating memory and starving
suspend so that we get hangs due to being oom. If they're suspended, we
have more certainty as to how memory is being used. I don't remember
what prompted me to do this in the first place, but I'm pretty sure it
would have been a real observed issue.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

