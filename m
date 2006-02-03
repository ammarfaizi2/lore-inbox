Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWBCI7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWBCI7D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 03:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWBCI7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 03:59:03 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:1176 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750950AbWBCI7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 03:59:01 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Fri, 3 Feb 2006 09:57:48 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022310.40783.rjw@sisk.pl> <200602031020.46641.nigel@suspend2.net>
In-Reply-To: <200602031020.46641.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602030957.48626.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 03 February 2006 01:20, Nigel Cunningham wrote:
> On Friday 03 February 2006 08:10, Rafael J. Wysocki wrote:
> > I was referring to the (not so far) future situation when we have
> > compression in the userland suspend/resume utilities.  The times of
> > writing/reading the image will be similar to yours and IMHO it's usually
> > possible to free 1/2 of RAM in a box with 512+ MB of RAM at a little cost
> > as far as the responsiveness after resume is concerned.  Thus on machines
> > with 512+ MB of RAM
> > both solutions will give similar results performance-wise, but the
> > userland-driven suspend gives you much more flexibility wrt what you can
> > do with the image (eg. you can even send it over the network if need be).
> >
> > On machines with less RAM suspend2 will probably be better
> > preformance-wise, and that may be more important than the flexibility.
> 
> Ok. So I bit the bullet and downloaded -mm4 to take a look at this interface 
> you're making, and I have a few questions:
> 
> - It seems to be hardwired to use swap, but you talk about writing to a 
> network image above. In Suspend2, I just bmap whatever the storage is, and 
> then submit bios to read and write the data. Is anything like that possible 
> with this interface? (Could it be extended if not?)

The swap partition was easy. :-)  However, there is the bmap() call that
userspace processes can use, so it seems to be possible.  [BTW, the network
is easy too, because it desn't require us to tamper with disks while
suspended.]

> - Is there any way you could support doing a full image of memory with this 
> approach?

I'm not sure, but I think that's possible.  For now I don't see major
obstacles, but honestly I'll have to read your code (and understand it)
to answer this question responsibly.

> Would you take patches? 

Well, the code in question is already in the kernel (in -mm, but this doesn't
matter here) and I'm not the maintainer of it, so I can't answer this
question directly.  However, if you asked me whether I would _support_ any
patches, I would say I had never opposed or supported a patch whithout trying
to understand it.

When I think I understand the patch, I try to value it, and I have two rules
here:
1) The released code should always be functional.  [So I never submit
untested patches without saying explicitly that they are untested and if I
replace some code A with alternative code B, I do my best to ensure it
won't break any existing setups.]
2) The software with this patch applied must be such that I would like to run
it on my computer. [If I wouldn't, there's no chance I'll support it.]

> - Does the data have to be transferred to userspace? Security and efficiency  
> wise, it would seem to make a lot more sense just to be telling the kernel 
> where to write things and let it do bio calls like I'm doing at the moment.

First, there's a difference between efficiency and performance.

For example, the kernel already contains the code for writing data to the disk
or partition you are using for suspend.  By using bio directly to write to it
you're duplicating the functionality of that code which is _inefficient_,
although this need not be related to performance.  Worse yet, if some
optimizations go to this code, you won't have them unless you notice
and implement them once again.

Similar observation applies to enryption and compression: There are libraries
for encryption and compression that contain lots of different algorithms,
so why should we try to duplicate that code?  It is more efficient to _use_
it, which can be done easily in the user space.

This may hurt performance a bit, but usually not so far that anyone will
notice.  [Actually on my box the suspending and resuming userland
utilities I use for testing perform the I/O-related operations _faster_
than the built-in swsusp code, although they seemingly do the same
things.]

Second, as far as the security is concerned, the only problem I see is that a
malicious attacker may be able to read unencrypted suspend image from the
system or submit his own specially crafted image which would require
root-equivalent access anyway.  However to prevent this you can set whatever
paranoid permissions you desire on /dev/snapshot and implement your
suspending utility as a daemon running in a privileged security ring (the
resume is run from and initrd anyway).

The biggest advantage of the userland-based approach I see is that there
may be _many_ implementations of the suspending and resuming tools
and they will not conflict.  For example, if Distributor X needs an exotic feature
Y wrt suspend (various vendor-specific eye-candies come to mind or
transferring the image over a network), he can implement it in his userland
tools without modifying the kernel.  Similarly, if Vendor V wants to use paranoid
encryption algorithm Z to encrypt the image, she can do that _herself_ in the
user space.

We only need to provide reference tools and we won't be asked to implement
every feature that people may want in the kernel.

> - In your Documentation file, you say say opening /dev/snapshot for reading is 
> done when suspending. Shouldn't that be open read for resume and write for 
> suspend?

No.  During suspend the image is read from the kernel and saved by a userland
tool and analogously during resume.

> I'm not saying I'm going to get carried away trying to port Suspend2 to 
> userspace. Just tentatively exploring. But if I did decide to port it, my 
> default position would be to seek not to drop a single feature. I hope that's 
> not too unreasonable!

That's fine.  I think we have the same goal which is a reasonable set of
features available to the users.

[Heh, that looks like a good starter for the userland suspend FAQ.  Perhaps
I should save this message. ;-)]

Greetings,
Rafael
