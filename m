Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbWCMGVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWCMGVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 01:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWCMGVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 01:21:14 -0500
Received: from soundwarez.org ([217.160.171.123]:31450 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751643AbWCMGVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 01:21:13 -0500
Date: Mon, 13 Mar 2006 07:21:12 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>,
       drzeus-list@drzeus.cx, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060313062112.GA15720@vrfy.org>
References: <4406AF27.9040700@drzeus.cx> <20060302165816.GA13127@vrfy.org> <44082E14.5010201@drzeus.cx> <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org> <4414033F.2000205@drzeus.cx> <20060312172332.GA10278@vrfy.org> <20060312145543.194f4dc7.akpm@osdl.org> <20060313041458.GA13605@vrfy.org> <20060313060221.GA20178@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313060221.GA20178@neo.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 01:02:21AM -0500, Adam Belay wrote:
> On Mon, Mar 13, 2006 at 05:14:58AM +0100, Kay Sievers wrote:
> > 
> > Macio solved the problem by adding all devices to a single string and
> > let the device table match one of these id's in that single string:
> >   http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;hb=HEAD;f=drivers/macintosh/macio_sysfs.c#l42
> > 
> > We should first check if that is possible for PnP too, or solve that
> > problem in general at that level before we introduce such a hack.
> 
> I do have some concerns about merging every ID into a single string.  The
> orginal design goal of having multiple IDs was to allow vendors to specify
> a single high priority ID that a driver that supports the device's complete
> feature set could match against.  If that driver is unavailable, it is
> acceptable to search for other drivers that might match against a
> compatibility ID and support a partial feature set.  Now if we just search
> for the first driver that matches anything in a single ID string without
> regard to the order IDs are presented, then we're not supporting the
> specification.
> 
> More generally speaking, it seems to me there are four main options:
> 
> 1.) We remove the modalias strings from all buses, and generate them in
> userspace exclusively.  We may loose the ability to support new buses
> without specialized userspace software, but we gain a great deal of
> flexibility and can eventually implement more advanced hardware detection
> schemes without depreciating existing kernel interfaces or parsing strings
> that are limiting when compared to bus-specific data.  Also, at least we
> have a uniform sysfs interface.

This is what we are coming from. Just look at the input.agent in any older
installation and you may think twice about this. :) I'm all for having
that created by the kernel.

> 2.) We selectively export modalias strings on buses where this sort of
> thing works and use hacks for other buses.

This is what we have today, right? PnP does not have modalias at all for the
reason, we couldn't figure out how to do this. We can use the "id" file
just fine, even when it's kind of ugly.

> 3.) We export multiline sysfs modalias attributes and tell userspace
> hotplug developers that they're wrong and must change their assumptions.

I'm pretty sure, we don't want multiline values. How do you stick them
in the environment?

> 4.) We export a single line modalias with each ID appended to the previous ID.
> Userspace must pay careful attention to the order, but because the format is
> bus-specific, it will have to be handled in a very specialized way. (e.g. PCI
> has class codes, PnP has compatibility IDs, etc)

What's the problem you see? It's all about loading modules if a piece of
hardware appears, It's even completely uncritical to load a module that
does not do anything in the end, cause it decides not to bind to that
hardware.
If you want fine grained policy in userspace, just implement it matching
on the other values in sysfs (or whatever policy) before you run the
"default" brute-force "modprobe $MODALIAS". I don't see any problem with
that approach and having it work without any specific userspace setup is
very nice. You still have full control what you can do, cause the device event
still travels through udev/hotplug and you can do whatever a system decides
what's needed - it's not that a modalias values would make the kernel load
a module on its own.

> In the long run, I think option 1 is the best choice.  I'm more concerned with
> flexibility than having a simplistic but limited hardware detection mechanism.
> Also, I prefer to keep code out of the kernel when there isn't a clear
> functionality advantage.  "file2alias" is not a kernel-level interface, but
> rather implementation specific to modutils and various module scripts included
> with the kernel source.  Therefore, I don't think that sysfs is obligated to be
> specially tailored toward modprobe, even if it is convenient for some buses.

It's about making it "just work", even for currently unknown buses, which
is very nice.

> But I'm also interested in a practical short-term solution.  What are your
> thoughts?  Would method #2 be acceptable?

What do you have in mind? #2 is what we have today, right?

Thanks,
Kay
