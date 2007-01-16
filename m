Return-Path: <linux-kernel-owner+w=401wt.eu-S1751331AbXAPCkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbXAPCkr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXAPCkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:40:47 -0500
Received: from marisil.org ([72.9.228.73]:34890 "EHLO smtp.marisil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbXAPCkq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:40:46 -0500
From: Peter Antoniac <theSeinfeld@users.sourceforge.net>
Reply-To: theSeinfeld@users.sourceforge.net
Organization: University of Oulu
To: "Kristian =?utf-8?q?H=C3=B8gsberg?=" <krh@bitplanet.net>
Subject: Re: allocation failed: out of vmalloc space error treating and VIDEO1394 IOC LISTEN CHANNEL ioctl failed problem
Date: Tue, 16 Jan 2007 11:40:18 +0900
User-Agent: KMail/1.9.5
Cc: "Arjan van de Ven" <arjan@infradead.org>, "David Moore" <dcm@mit.edu>,
       linux1394-devel@lists.sourceforge.net,
       theSeinfeld@users.sourceforge.net, "Bill Davidsen" <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org, libdc1394-devel@lists.sourceforge.net
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net> <1168896257.3122.577.camel@laptopd505.fenrus.org> <59ad55d30701151343r6f964475tae799185f05aa579@mail.gmail.com>
In-Reply-To: <59ad55d30701151343r6f964475tae799185f05aa579@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701161140.19084.theSeinfeld@users.sf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 January 2007 06:43, Kristian Høgsberg wrote:
> On 1/15/07, Arjan van de Ven <arjan@infradead.org> wrote:
> > there is a lot of pain involved with doing things this way, it is a TON
> > better if YOU provide the memory via a custom mmap handler for a device
> > driver.
> > (there are a lot of security nightmares involved with the opposite
> > model, like the user can put any kind of memory there, even pci mmio
> > space)
>
> OK, point taken.  I don't have a strong preference for the opposite
> model, it just seems elegant that you can let user space handle
> allocation and pin and map the pages as needed.  But you're right, it
> certainly is easier to give safe memory to user space in the first
> place rather than try to make sure user space isn't trying to trick
> us.

I am glad that the discussion is heading to the right place thanks to David.

Yes. Probably that is the best solution. In the case of the ring buffers, 
based on my discussion with Damien, 4 buffers are probably optimal. If the 
user is allocating them, in case of normal cameras, this is somewhere around 
4 MiB, lets say maxim 16 MiB. So, everything should be ok for normal people, 
at least for now. The problem is when the cameras require bigger images (we 
are thinking about the future, right) and maybe also more buffers in the DMA 
ring buffer. If you leave that to the user, it will require some hacking 
skills if we are using the current model from libdc1394 and video1394. Why? 
Because if you use 10 buffers with some big images it is likely you are going 
out of the 64 MiB. In that case, we were thinking to give a nice error (that 
is why we needed to know the amount available for mmap/vmalloc) and instruct 
the user to change the kernel boot time allocation of memory in a way that 
will fit the range (the vmalloc=xxx at startup - the "hacking"). So, in a 
way, it will be nice to have the solution close to the one proposed by David. 
Do you think that if the user allocates small buffers (instead of the big 
ring buffer) and sends the list to the driver, this will help in breaking the 
64 limit? I have doubts about it, but I am not good at this level of VMA. 
Anyway, I hope that something can be done to allow bigger DMA ring buffers 
without the user needing to reboot the system with some parameter.

> > >   Then is does an ioctl() on the firewire control device
> >
> > ioctls are evil ;) esp an "mmap me" ioctl
>
> Ah, I'm not mmap'ing it from the ioctl, I do implement the mma file
> operation for this.  However, you have to do an ioctl before mapping
> the device to configure the dma context.
>
> Other than that what is the problem with ioctls, and more interesting,
> what is the alternative?  I don't expect (or want) a bunch of syscalls
> to be added for this, so I don't really see what other mechanism I
> should use for this.
>
> > > It's not too difficult from what I'm doing now, I'd just like to give
> > > user space more control over the buffers it uses for streaming (i.e.
> > > letting user space allocate them).  What I'm missing here is: how do I
> > > actually pin a page in memory?  I'm sure it's not too difficult, but I
> > > haven't yet figured it out and I'm sure somebody knows it off the top
> > > of his head.
> >
> > again the best way is for you to provide an mmap method... you can then
> > fill in the pages and keep that in some sort of array; this is for
> > example also what the DRI/DRM layer does for textures etc...
>
> That sounds a lot like what I have now (mmap method, array of pages)
> so I'll just stick with that.
>
> thanks,
> Kristian
