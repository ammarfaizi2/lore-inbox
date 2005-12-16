Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVLPVIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVLPVIy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVLPVIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:08:54 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:13709 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932414AbVLPVIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:08:41 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Christian Trefzer <ctrefzer@gmx.de>
Subject: Re: [RFC/RFT] swsusp: image size tunable (was: Re: [PATCH][mm] swsusp: limit image size)
Date: Fri, 16 Dec 2005 22:09:52 +0100
User-Agent: KMail/1.9
Cc: Stefan Seyfried <seife@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
References: <200512072246.06222.rjw@sisk.pl> <200512161908.56635.rjw@sisk.pl> <20051216192952.GA7212@zeus.uziel.local>
In-Reply-To: <20051216192952.GA7212@zeus.uziel.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512162209.53128.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 16 December 2005 20:29, Christian Trefzer wrote:
> On Fri, Dec 16, 2005 at 07:08:56PM +0100, Rafael J. Wysocki wrote:
> > On Friday, 16 December 2005 15:26, Christian Trefzer wrote:
> > > The problem is the free swap space is not constant as long as you are
> > > trying to free more RAM, because some pages can get swapped out in the
> > > process at any time.
> > 
> > To handle this properly we would have to count the amount of free swap in
> > every iteration of the loop in swsusp_shrink_memory(), but I wouldn't like
> > to make this function swap-dependent.
> 
> Well, I did not quite see that. Renders the problem a lot less trivial.
> More on that later.
> 
> 
> > We are going to move the image-writing and reading functionality of swsusp
> > to the user space anyway and the userspace process controlling the suspend
> > will solve this problem.  For now, please use workarounds like the Stefan's
> > one.
> 
> In the long term, if I am correctly informed, everything should be
> controlled by userspace, so it seems to me that some current problems
> will be solved along the way. I am not looking for a workaround, though.
> Instead I wanted to ask if there was no simple way to keep swsusp from
> failing in a self-contained manner, i.e. without sneaky workarounds.
> What occured to me while writing my first mail was that maybe it is not
> trivial at all to determine the remaining swap space, as you already
> confirmed.
> 
> My point is, that the generic algorithm to determine the maximum image
> size desired by the user will, as a whole, remain the same, whether
> implemented in kernel or user space. Unfortunately, I am very unfamiliar
> with swsusp code and all of its implications wrt. drivers etc. - this
> still holds true after looking at swsusp_shrink_memory().
> 
> But generally speaking: at some point, memory is freed for the image
> creation process. Recent efforts towards tunable max_image_size make it
> seem to me that we likely know beforehand, how much we are going to
> free. Now say we have max_image_size of 500MB, but we know that active
> swaps will hold 400MB at max. So we start out freeing enough memory for
> a 400MB image, and once we're done, we notice we can only save 350MB.
> Does anything keep us from reducing the image size to 350MB right now?

Basically nothing and it could be implemented, but IMO it would be a step
in a wrong direction.

Namely, we want the image-writing code to go to the user space in the long
run. Then, the whole suspend will be handled by a userspace process and the
kernel will not know what kind of storage this process is using (it may or
may not be a swap partition).  Consequently, the kernel will not know how
much space there is for the image, _unless_ the user space process tells it.

The user space process can do this _once_, using /sys/power/image_size
before it asks the kernel to create the image.  Next, the kernel creates
the image and swsusp_shrink_memory() is called in the process.  Of course
at this point the amount of available storage can change, but to know it
the kernel would have to ask the userspace process if that happened.
Generally speaking it can't do this, so it "returns" the image to the
userspace process which should verify if the image is small enough
and if not, repeat from writing /sys/power/image_size with a smaller
number or just fail (if so configured).

> Apologies for wasting your time, I am trying to get rid of my ignorance.

It's not a waste of time at all. :-)  IMO the issue is definitely worth
discussing.

Greetings,
Rafael
 

-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
