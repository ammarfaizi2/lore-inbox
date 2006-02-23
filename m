Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWBWERs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWBWERs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 23:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWBWERs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 23:17:48 -0500
Received: from thunk.org ([69.25.196.29]:61386 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750783AbWBWERr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 23:17:47 -0500
Date: Wed, 22 Feb 2006 23:17:08 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Martin Bligh <mbligh@mbligh.org>
Cc: David Zeuthen <david@fubar.dk>, Linus Torvalds <torvalds@osdl.org>,
       Kay Sievers <kay.sievers@suse.de>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060223041707.GA9645@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Martin Bligh <mbligh@mbligh.org>, David Zeuthen <david@fubar.dk>,
	Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@suse.de>,
	Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
	Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	John Stultz <johnstul@us.ibm.com>
References: <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI> <20060222152743.GA22281@vrfy.org> <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org> <1140625103.21517.18.camel@daxter.boston.redhat.com> <43FC9C13.7040109@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FC9C13.7040109@mbligh.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 09:14:59AM -0800, Martin Bligh wrote:
> >But I realize these changes are important because it's progress and back
> >in 2.6.0 things were horribly broken for at least desktop workloads [1].
> >It also makes me release note that newer HAL releases require newer
> >kernel and udev releases and that's alright. In fact it's perfectly
> >fine. We get users to upgrade to the latest and greatest and we keep
> >making good progress. That's open source at it's finest I think.
> 
> If it's all that fragile, surely it just means that someone picked the
> wrong point at which to try to form the API abstraction?
> 
> Frankly, that seems to be the issue behind a lot of these problems -
> people decide to shove stuff into userspace for some religions reason, 
> without thinking about the API implications at all.

Martin has hit the nail on the head.

There is currently a religion going on in some circles (we see it in
the uswsusp vs suspend2 debate) which states that moving functionality
to userspace is always better because it makes the kernel "simpler".
Well, maybe.  To the extent that we move policy to userspace, that is
(usually) goodness, but we have to weigh the resulting _interface_
complexity.  When you take a piece of work and split it up between the
kernel and userspace, by definition there will have to be some kind of
interface between the kernel and the userspace code.  

Some people assume the only thing that makes up the interface is
syscalls, ioctl's, and fnctls, but that's not true; /proc and /sys are
interfaces too.  And as Linus has stated, once we introduce an
interface, that's it; we have to maintain it forever.  No gratuitous
changes.  If that is too hard, because we can imagine potential
changes that might require us to change the interface, or painful
backwards compatibility kludges to maintain the old interface for at
least 12 months --- then maybe it was a bad idea to move certain
pieces of functionality into userspace in the first place.

> We don't have a sane way to package all the userspace crud together
> with the microkernel that people are turning Linux into. Either people
> quit pretending that divesting things to userspace is a solution to all
> hard problems, or we create a packaging / bundling mechanism for all
> this shite. Frankly, I prefer the former, but whichever ... it's
> getting insane.

Precisely.  These days, using initrd is an exercise in pain, and
wasted time; anything goes wrong, and there is no recovery whatsoever,
except a reboot back to a working setup, and if you have multiple SCSI
drivers, a 5-10 minute wait for the boot to cycle.  So I don't use it.
And if there is functionality that requires initrd's, as a general
rule I don't use it, and I don't test it.  And if it's just me being
stupid, then everyone can ignore me.  But if it's many people then
maybe folks should start considering that we either need to make
initrd more robust, and probably start bundling initrd setup's into
the kernel, or we should start reconsidering the whole plan of moving
more and more into initrd in the first place.

'						- Ted
