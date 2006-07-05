Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWGETq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWGETq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWGETq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:46:56 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:35879 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964893AbWGETqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:46:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TH1Yha2geWxclWxrYGMI9boL7SfZw9Og5P1s6Cvw2LSA67xlvvfEu+OxR0KcLsDIignBihPp7KovSYoQ2+E3xfM547BYZL3l6gUAfriPaegMlzz48Da0oZ/tevpI/LpRLieqi+D3kTWMRZ67eI6RNpxvgVgFoc5iZddEoYXI/zo=
Message-ID: <e1e1d5f40607051246r4d583d9arab570b5a9e8cab0c@mail.gmail.com>
Date: Wed, 5 Jul 2006 15:46:54 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Daniel Drake" <dsd@gentoo.org>
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Cc: "Greg KH" <greg@kroah.com>, "Alon Bar-Lev" <alon.barlev@gmail.com>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <44AC0B2A.9080500@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
	 <20060703214509.GA5629@kroah.com>
	 <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>
	 <20060703222645.GA22855@kroah.com>
	 <e1e1d5f40607031624w245e5f70g2ae8f5d0e9d357c4@mail.gmail.com>
	 <20060703232927.GA19111@kroah.com>
	 <e1e1d5f40607031704kec2ff68w324d3d8ad111c46b@mail.gmail.com>
	 <44ABFDD3.6040500@gentoo.org>
	 <e1e1d5f40607051109r3e01a2eftce93314228425612@mail.gmail.com>
	 <44AC0B2A.9080500@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/06, Daniel Drake <dsd@gentoo.org> wrote:
> Daniel Bonekeeper wrote:
> > Yes and no... we can have that stuff in userspace, of course, but I
> > think that we are walking to a big salad here. Imagine this: some
> > fingerprint devices have userspace drivers while others have
> > kernel-mode drivers, while the majority of other USB devices (that
> > could also be implemented in userspace) are in kernel-space. Why care
> > to keep that stuff in userspace (except for security, since less
> > non-critical code in userspace == stability+security), while we still
> > have other devices being managed in kernel mode ?
>
> You kind of answered your own question before you asked it, but let me
> try and clarify my view. Two things:
>
> 1. We generally try and implement things in userspace where possible and
> where it makes sense at least to a certain degree. Or at least, you only
> get USB stuff included in the kernel when you have convinced Greg it
> belongs there (which you may have already done).
>

We actually didn't talk about where we should put fingerprint devices.
I understand that fingerprint devices can perfectly fit in userspace,
and maybe that's the best place to put them.

> 2. As you acknowledge, only a certain subset of all USB fingerprint
> reader drivers will be implemented in the kernel, therefore providing
> the abstraction at kernel level is inadequate (you leave the pure
> userspace drivers out of the loop, therefore getting people to actually
> use your interface will be difficult). You may argue that your proposal
> doesn't limit itself to fingerprint readers, but neither does my answer:
> many USB devices (of other types) are supported purely in userspace.
>

So in this case, instead of having an unique interface to retrieve and
use fingerprint readers on the kernel space, we should have it on
userspace ? Entirely ? This will then bind fingerprint applications to
always use some kind of userspace library or daemon. If we are to have
a centralized system to manage that (which we don't have right now),
and in both situations we're going to need to implement it (either at
kernel level or as some kind of userspace library set and/or a running
daemon that uses it), I think that it will be better to bind future
fingerprint applications to the kernel instead of userspace libraries.
What will happen then if we want to combine fingerprint matching in a
situation where the userspace isn't available ? Let's say, use a
fingerprint validation to mount / (I now that this implies having a
fingerprint match algorithm implemented in kernel, which is out of
scope).

If we are to have all the fingerprint readers interfaces in usermode,
how will this be done ?
Let's take in consideration the number of currently available usermode
drivers for fingerprint readers: if we are to have a centralized
interface to manage all the different types of fingerprint readers, we
need to keep this somewhere (a daemon or library providing an API to
access the devices in an uniform way). In both cases, an effort is
involved in porting the currently available SDKs to this API in order
to get it working. What about the closed-source SDKs ?

My point is: if we're going to implement a centralized interface for
this, and fingerprint applications are to be bound to an API, this API
should be at the kernel, where there are less chances of each vendor
having their own API (as it is now in userspace), and less libraries
or daemons competing between them to be "the default standard for
fingerprint devices" in linux.

> > Another thing is that this "device information layer" should also be
> > implemented not only for fingerprint devices, but for other USB
> > devices too... and possibly (very likely) to other devices that are
> > not USB. If such device-class-specific properties layer is to be
> > implemented, we should do it to all device classes (not bind to any
> > specific BUS type).
>
> Sounds like you are talking about reimplementing HAL at this point. I
> don't think this argument justifies including it at kernel level (but
> neither does it oppose it).
>

I'm currently talking about something much less ambitious... at least
started like that. Just having a way to tell the userspace the
capabilities of our fingerprint reader hardware (image resolution,
image format, etc). In a uniform way (so doesn't matter which reader
do you have, you can have this information). Them came the idea of
putting it on sysfs (since this is already done with sound system,
net, etc). Then came the idea of extending it to all devices and
BUSes, not just USB fingerprint (which got off-topic). If you see my
previous messages about this, the proposed system was just an extra
void structure pointer that would point to a device-class-based
structure holding the properties (even though this was fixed for USB
devices only).


> > I think that the kernel should be aware of the properties of the
> > devices that it handles,
>
> If the kernel doesn't *need* to know about the properties and doesn't
> act on them, why? And what about the devices that the kernel doesn't
> handle, where they are operated purely through userspace?
>

As I said before, the kernel _may_ need to access the device (used
together with cryptography, as an example). It's the only case that I
can actually think of, and may not be enough to move fingerprint
readers entirely to kernel mode...

> > otherwise we're walking to some kind of
> > microkernel architecture, where one day we'll have everything running
> > on userspace...
>
> That's not what I'm suggesting - many classes of drivers belong in
> kernel space and would incur major brain damage if moved to userspace.
>
> You might want to go back a year or two and read the discussions when
> the USB scanner driver was moved out of the kernel and reimplemented
> 100% inside libsane. There are other examples as well.
>

For scanners, I think that it's ok to be entirely in userspace, since
I don't see any use of scanners in kernel mode.

> > but this sounds to me more like a
> > decision made by fingerprint devices manufactures
>
> It's not their decision while they aren't the ones writing the drivers.
>

Actually they are, since I'm referring to the userspace SDK that they
provide, which access the /dev/usb* stuff directly to talk directly
with the fingerprint readers. Are there independent developers
developing userspace drivers for fingerprint readers on linux (i.e.,
aren't tied to any vendor) ?


Thanks
Daniel

-- 
What this world needs is a good five-dollar plasma weapon.
