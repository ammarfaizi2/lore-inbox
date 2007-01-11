Return-Path: <linux-kernel-owner+w=401wt.eu-S1750863AbXAKSUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbXAKSUu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 13:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbXAKSUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 13:20:50 -0500
Received: from khepri.openbios.org ([80.190.231.112]:56231 "EHLO
	khepri.openbios.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbXAKSUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 13:20:49 -0500
Date: Thu, 11 Jan 2007 19:20:41 +0100
From: Stefan Reinauer <stepan@coresystems.de>
To: ron minnich <rminnich@gmail.com>
Cc: "OLPC Developer's List" <devel@laptop.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Mitch Bradley <wmb@firmworks.com>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Message-ID: <20070111182041.GA6243@coresystems.de>
References: <13426df10701110939k21f7bb1dy38d2b34ca37a5a36@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13426df10701110939k21f7bb1dy38d2b34ca37a5a36@mail.gmail.com>
X-Operating-System: Linux 2.6.18.2-4-default on an x86_64
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Duff: Orig. Duff, Duff Lite, Duff Dry, Duff Dark,
	Raspberry Duff, Lady Duff, Red Duff, Tartar Control Duff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* ron minnich <rminnich@gmail.com> [070111 18:39]:
> I'd like to put in my $.02 in favor of having a way to pass the OF
> device tree to the kernel, in much the same way we pass stuff like
> ACPI and PIRQ and MP tables now.
 
This works fine for just passing the device tree, but it will fail for
the next step of being able to use the firmware in the OS, and returning
sanely to the firmware.

> But any mechanism that depends on a callback to OFW is way too
> limiting. As soon as you put that callback in, you lock out
> - uBoot

People in the uBoot project have been discussing adding OFW
functionality because it is so useful.

> - LinuxBIOS

With some of the payloads, especially those you list below anyways.


> - Bochs BIOS as used in Xen and other hypervisors and emulators

You dont need it there. Think compatible. We are not going to get _rid_
of legacy bios traces for another 10 years anyways.

> - any path that uses kexec (since the first kernel probably shut down
>   OF)

No, that path works fine. The first kernel uses OFW, so it wont shut it
down. Only thing is you need to pass the callback to the loaded kernel.

1 line of code.

> - etherboot

ok, well. 

> - GNUFI

Reading UEFI.

There you have a large number of callbacks anyways which will be
supported anyways unless large parts of the industry stop their 
"Cuius regio, eius religio" behavior and do sane solutions rather than 
(U)EFI.

This is a completely different path, and out of reach for us anyways.

With GNUFI we support EFI callbacks, the same way as we support 16bit
legacy callbacks with ADLO, and OFW callbacks with OFW.

> So, while the idea of the OF tree is very general, and IMHO very
> desirable, the idea of the callback is very specific to one firmware
> implementation on one CPU architecture on one platform -- the OLPC --
> and is hence not desirable at all.

SUN, IBM, APPLE, ... lots of vendors have been using OFW for their
machines. It is by no means a local phenomenon. This way of doing things
has been working since about two decades now with nearly no changes. 
And it covers at least Sparc, Sparc64, PPC, PPC64, Mips, Arm, X86,
X86-64. That's 8 CPU architectures. Far more successful than any other 
approach.

> An idea that is potentially applicable and usable on all BIOSes
> becomes usable on only one.

The idea is to only have one in the end, and that is flexible enough to
customize it. That's why it is open and we can look at the source.

Some PowerPC systems use a flat tree without callback interface. Sure,
if the machine is too slow to do the real thing, why not. But why throw
away flexibility otherwise? It is not like we have to rely on some evil
patented closed source crap that vendors hail and court as IP.

> OFW is open source now. I think it's time to reexamine the basic
> assumptions about the need for a callback, and see if something better
> can't be done. 

I fully agree. And I believe there are very good things that can be done
with callbacks. The reasons callbacks are evil is that you dont know
what you call into. This is not at all the case here. It's a mere
function call that calls some highly board specific code, not unlike all
the calls we do in LinuxBIOS already today. Since we're 100% open
source, we don't "cross a border" anymore.

> Also, as others mentioned, callback into any sort of
> firmware on SMP can and does get messy. I've seen this in practice on
> EFI-based machines.

Yes, executing closed source half undocumented binary blobs from your
software might have undocumented harmful side effects. But that is a
different story, no?

> Otherwise, this is just too limited to be of any use to those of us
> doing more than just OFW.

Yes, the patch was specific to Open Firmware. It is just another
interface next to

- 16bit legacy callbacks
- (u)efi legacy callbacks
- existing openfirmware support code for non-x86 platforms.

But: It is a first step that, as a mid-term goal, allows us to unify OFW
support on all platforms to some extent. Of course. There will always be
quirks. We have quirks in about every subsystem of Linux today, so that
is not more scary. 

So what we need is one in-kernel interface that allows us to plug-in
support code for each of the supported firmware interfaces. The attempt
to use the same firmware interface on more than one platform helps that
path.  

> Mitch, is there some way to get OF device tree to the kernel without
> involving a callback? That would be quite nice.

That is a nice idea, but unless there is any LinuxBIOS version that
creates such a device tree and exports it as a data structure to the OS,
why would we want to add such support to the Linux kernel?

Stefan


-- 
coresystems GmbH • Brahmsstr. 16 • D-79104 Freiburg i. Br.
      Tel.: +49 761 7668825 • Fax: +49 761 7664613
Email: info@coresystems.de  • http://www.coresystems.de/
