Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWGEXSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWGEXSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWGEXSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:18:42 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:38704 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964820AbWGEXSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:18:41 -0400
Message-ID: <44AC49EE.1070104@gentoo.org>
Date: Thu, 06 Jul 2006 00:23:26 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Daniel Bonekeeper <thehazard@gmail.com>
CC: Greg KH <greg@kroah.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>	 <20060703214509.GA5629@kroah.com>	 <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com>	 <20060703222645.GA22855@kroah.com>	 <e1e1d5f40607031624w245e5f70g2ae8f5d0e9d357c4@mail.gmail.com>	 <20060703232927.GA19111@kroah.com>	 <e1e1d5f40607031704kec2ff68w324d3d8ad111c46b@mail.gmail.com>	 <44ABFDD3.6040500@gentoo.org>	 <e1e1d5f40607051109r3e01a2eftce93314228425612@mail.gmail.com>	 <44AC0B2A.9080500@gentoo.org> <e1e1d5f40607051246r4d583d9arab570b5a9e8cab0c@mail.gmail.com>
In-Reply-To: <e1e1d5f40607051246r4d583d9arab570b5a9e8cab0c@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Bonekeeper wrote:
> So in this case, instead of having an unique interface to retrieve and
> use fingerprint readers on the kernel space, we should have it on
> userspace ?

Yep - why not (we can do it that way, and it is much easier than doing 
it in kernel space).

 > Entirely ?

I guess there may be situations where, if there is a kernel-based 
fingerprint scanning driver, userspace cannot realistically know about 
some of the advanced details that we plan to 'export' for this 
interface. In this case, we'd have to modify the kernel drivers to add 
an interface for this extra information, or just make it add a file to 
sysfs or something like that.

> This will then bind fingerprint applications to
> always use some kind of userspace library or daemon.

Yep. Just like all applications that use scanners use libsane, and there 
are many other examples where the kernel does not provide the full 
solution to a problem.

Not to forget that userspace code is needed to complement any potential 
kernel-side driver anyway - the functionality provided by the 
DigitalPersona and AES4000 scanners (just 2 examples which I know about) 
is so rich that you need an actual userspace library to form the basic 
operations ("scan a finger", etc). Even more so when we figure out how 
to decrypt the images and can enable the image encryption bit. Whether 
in userspace or in kernel, I don't want the driver portion to limit what 
can be done with the devices, since there are so many possibilities.

> If we are to have
> a centralized system to manage that (which we don't have right now),
> and in both situations we're going to need to implement it 

Yep.

> (either at
> kernel level or as some kind of userspace library set and/or a running
> daemon that uses it), I think that it will be better to bind future
> fingerprint applications to the kernel instead of userspace libraries.

While there are viable and workable userspace solutions available, I 
disagree.

> What will happen then if we want to combine fingerprint matching in a
> situation where the userspace isn't available ? Let's say, use a
> fingerprint validation to mount / (I now that this implies having a
> fingerprint match algorithm implemented in kernel, which is out of
> scope).

Do it in an initramfs, just like you would for any other complex 
mounting procedure. I think klibc makes this kind of thing even easier. 
Even if it is out of scope of this discussion, software-based 
fingerprint matching is not practical in kernel space, and I think I can 
safely say that this kind of thing will never be added to the Linux kernel.

> If we are to have all the fingerprint readers interfaces in usermode,
> how will this be done ?

Good question. I haven't thought a great deal about it, as I mentioned 
before my TODO list is:
1. Get dpfp/libdpfp stable
2. Find or write some code which can reliably compare fingerprint 
images, hook dpfp up to that as a prototype
3. Solve the larger problem of finding a way to abstract fingerprint 
reading devices (and fingerprint comparison) into a common API for mass 
adoption.

I'm still on (1), but I'm really glad that people are showing interest 
in (2) and (3).

Anyway, here's a really rough plan for (3): compare a number of 
fingerprint readers, looking at the functionality they offer. Find a way 
to abstract the common functionality into an API which would be used by 
a higher level. Add some API and code to compare fingerprint images, and 
maybe to glue the two together (scanning and matching). Design a modular 
system so that (to a certain extent) support for fingerprint scanning 
devices can be 'plugged in' to provide some of the functionality behind 
the scanning API that has been previously defined.

> Let's take in consideration the number of currently available usermode
> drivers for fingerprint readers: if we are to have a centralized
> interface to manage all the different types of fingerprint readers, we
> need to keep this somewhere (a daemon or library providing an API to
> access the devices in an uniform way).

Yep.

> In both cases, an effort is
> involved in porting the currently available SDKs to this API in order
> to get it working.

Yep, except there aren't really any current SDKs/APIs. As I said before, 
the only driver I know about is idmouse and that doesn't offer any 
recognition capabilities, infact it doesn't even offer finger detection 
(you ask it for an image, and it will take a photo of thin air if there 
is no finger there). I don't know much about the driver or hardware, but 
I think idmouse will need to be reworked before it becomes useful.

So basically we're starting from scratch.

 > What about the closed-source SDKs ?

We (as in kernel development community) don't care about them. They can 
do what they want. They can even adapt our GPL code to better suit their 
needs, but we might not accept their changes into the official codebase.

> My point is: if we're going to implement a centralized interface for
> this, and fingerprint applications are to be bound to an API, this API
> should be at the kernel, where there are less chances of each vendor
> having their own API (as it is now in userspace), and less libraries
> or daemons competing between them to be "the default standard for
> fingerprint devices" in linux.

I'm not clear whether you refer to vendors as Linux vendors (e.g. Red 
Hat, Novell, ...) or fingerprint hardware manufacturers (e.g. Digital 
Persona, Authentec).

If you are talking about Linux vendors, I think they would have no 
problem adopting and contributing to an open-source centralized 
fingerprint handling userspace library, and I don't think there would be 
any problems with multiple libraries doing the same thing in the wild, 
unless ours really sucks.

If you are talking about hardware manufacturers, I'd gladly take any 
input they have if they are interested in helping the open source 
development community. I'm sure they have more experience than most of 
we do. I have yet to even get a word of response from Digital Persona 
about my work.

Also, in some ways, competition is good. And doing something at kernel 
level to simply ensure everyone is using the same code and to prevent 
competition is not a strategy that is usually employed.

> I'm currently talking about something much less ambitious... at least
> started like that. Just having a way to tell the userspace the
> capabilities of our fingerprint reader hardware (image resolution,
> image format, etc). In a uniform way (so doesn't matter which reader
> do you have, you can have this information).

Ok. This makes a certain degree of sense, but is making the assumption 
that the kernel actually knows about the fingerprint reader it is 
working with. There aren't enough devices supported to make judgment 
yet, but it appears this will be at least partially false: open-source 
drivers for at least some widely marketed fingerprint readers will be 
implemented purely in userspace.

Either way, I agree with the aim, which is basically to provide a 
generic way for userspace programs to get information about the 
fingerprint reading hardware which they are dealing with.

> Them came the idea of
> putting it on sysfs (since this is already done with sound system,
> net, etc).

Sounds sensible, but only if we are talking about kernel drivers. 
Putting information into syfs about devices which the kernel knows 
almost nothing about is not very realistic, unless you have a masterplan.

> Then came the idea of extending it to all devices and
> BUSes, not just USB fingerprint (which got off-topic).

This is ambitious (just by sheer scope) but is an admirable effort: it 
would rock if more device-specific information is available in sysfs, 
but again, it only makes sense where the kernel itself is powering the 
hardware.

>> > but this sounds to me more like a
>> > decision made by fingerprint devices manufactures
>>
>> It's not their decision while they aren't the ones writing the drivers.
>>
> 
> Actually they are, since I'm referring to the userspace SDK that they
> provide, which access the /dev/usb* stuff directly to talk directly
> with the fingerprint readers.

Are you referring to open source SDKs? If you are, I'd love to hear 
about them. If you aren't, its not something that we really care about. 
They are free to work without the support of the community if they choose.

> Are there independent developers
> developing userspace drivers for fingerprint readers on linux (i.e.,
> aren't tied to any vendor) ?

I don't know.

Anyway, let me make a statement in response to your mails which I'm sure 
will be corrected by Greg or someone else if I'm talking rubbish:

Various USB devices are *not* handled by the kernel. However, these 
devices are usable on Linux/FreeBSD/Windows via userspace libusb-based 
driver code. These drivers will *not* be moved into the Linux kernel 
unless there is a strong reason to do so. This also applies to the 
in-development USB fingerprint reader drivers in userspace: they won't 
be moved into the kernel unless there is a real need to. The ideas you 
have presented so far do not justify that move.

So, if you are designing some kind of information abstraction for all 
USB fingerprint readers, or even all USB devices, or even the spectrum 
of all devices which includes USB, you *cannot* realistically do this at 
kernel level because the kernel has no clue about some of the devices it 
is operating. This is a significant problem with your otherwise 
convincing ideas up to this point, and is something you need to think 
about in other ways than moving things into the kernel.

I hope this makes some sense!

Daniel

