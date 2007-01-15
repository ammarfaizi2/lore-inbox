Return-Path: <linux-kernel-owner+w=401wt.eu-S932071AbXAOVnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbXAOVnJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 16:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbXAOVnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 16:43:09 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:6703 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbXAOVnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 16:43:07 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ZA8IFXvqVWbbOTUgqfybOAr3bFqqR+NPmrWxczJODIYgoN3/KFyBbJHrHBoSul10THu9DyKmOt9j+q8KsScBaEWw8O5ARL53u+0Jvybioud7JSo4ycYYnlI1nzuhqjw2+z9ekKVaZsRDPw6m+nhNwaVCeZ91IItKCItfyS0OJJo=
Message-ID: <59ad55d30701151343r6f964475tae799185f05aa579@mail.gmail.com>
Date: Mon, 15 Jan 2007 16:43:03 -0500
From: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@bitplanet.net>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: allocation failed: out of vmalloc space error treating and VIDEO1394 IOC LISTEN CHANNEL ioctl failed problem
Cc: "David Moore" <dcm@mit.edu>, linux1394-devel@lists.sourceforge.net,
       theSeinfeld@users.sourceforge.net, "Bill Davidsen" <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org, libdc1394-devel@lists.sourceforge.net
In-Reply-To: <1168896257.3122.577.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net>
	 <200701100023.39964.theSeinfeld@users.sf.net>
	 <tkrat.c0a43c7c901c438c@s5r6.in-berlin.de>
	 <1168802934.3123.1062.camel@laptopd505.fenrus.org>
	 <45ABC1A2.90109@tmr.com>
	 <1168885223.3122.304.camel@laptopd505.fenrus.org>
	 <1168890881.10136.29.camel@pisces.mit.edu>
	 <59ad55d30701151306q492e07aep9c640afd7b6c442f@mail.gmail.com>
	 <1168896257.3122.577.camel@laptopd505.fenrus.org>
X-Google-Sender-Auth: 150d796dc4007c23
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/07, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > However, what I'd really like to do is to leave it to user space to
> > allocate the memory as David describes.  In the transmit case, user
> > space allocates memory (malloc or mmap) and loads the payload into
> > that buffer.
>
> there is a lot of pain involved with doing things this way, it is a TON
> better if YOU provide the memory via a custom mmap handler for a device
> driver.
> (there are a lot of security nightmares involved with the opposite
> model, like the user can put any kind of memory there, even pci mmio
> space)

OK, point taken.  I don't have a strong preference for the opposite
model, it just seems elegant that you can let user space handle
allocation and pin and map the pages as needed.  But you're right, it
certainly is easier to give safe memory to user space in the first
place rather than try to make sure user space isn't trying to trick
us.

> >   Then is does an ioctl() on the firewire control device
>
> ioctls are evil ;) esp an "mmap me" ioctl

Ah, I'm not mmap'ing it from the ioctl, I do implement the mma file
operation for this.  However, you have to do an ioctl before mapping
the device to configure the dma context.

Other than that what is the problem with ioctls, and more interesting,
what is the alternative?  I don't expect (or want) a bunch of syscalls
to be added for this, so I don't really see what other mechanism I
should use for this.

> > It's not too difficult from what I'm doing now, I'd just like to give
> > user space more control over the buffers it uses for streaming (i.e.
> > letting user space allocate them).  What I'm missing here is: how do I
> > actually pin a page in memory?  I'm sure it's not too difficult, but I
> > haven't yet figured it out and I'm sure somebody knows it off the top
> > of his head.
>
> again the best way is for you to provide an mmap method... you can then
> fill in the pages and keep that in some sort of array; this is for
> example also what the DRI/DRM layer does for textures etc...

That sounds a lot like what I have now (mmap method, array of pages)
so I'll just stick with that.

thanks,
Kristian
