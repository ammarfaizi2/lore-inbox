Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270479AbRHNHeV>; Tue, 14 Aug 2001 03:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270480AbRHNHeM>; Tue, 14 Aug 2001 03:34:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18035 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S270479AbRHNHd6>; Tue, 14 Aug 2001 03:33:58 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
In-Reply-To: <Pine.LNX.4.33.0108060228220.10664-100000@hp.masroudeau.com>
	<9kuid8$q57$1@cesium.transmeta.com>
	<m1n157rrpk.fsf@frodo.biederman.org>
	<9l2p9e$89h$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Aug 2001 01:27:07 -0600
In-Reply-To: <9l2p9e$89h$1@cesium.transmeta.com>
Message-ID: <m166brqeyc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> This is indeed a good structure, but this wide interface is a pain to
> keep stable, and having bootloaders call it directly is a genuinely
> bad idea.  It will lock us into an interface, or cause major breakage,
> when we have to do necessary revving of this interface.
> 
> Instead, the proper time to deal with this is at kernel link time.
> The PC-BIOS stuff should go in, say arch/i386/pcbios, and you then can
> have other platforms (say, for example, arch/i386/linuxbios) which has
> its own setup code.  You then link a kernel image which has the
> appropriate code for the platform you're running on, and you're set.

Probably.  My hope is that with linuxbios I can come up with a format
that is sufficient to be an internal interface.  There is also another
major reason for looking at this.  We don't have the same kind of
interface on any port.  For example rdev only exists on x86.  Making
the whole bootloader process a major pain everytime you swich a linux
hardware platform. 

> You're now
> encoding a ton of assumptions about what the kernel needs in each and
> every bootloader, which is bound to cause a major headache not too
> long down the road.  For example, the stuff you describe above may
> very well be obsolete in 2 years with HyperTransport, Infiniband and
> 3GIO on the very near horizon.  Now you have to suffer dealing with
> lots and lots of compatibility logic to make things work, which may
> not be possible, or we're going to have frequent breakage.
> 
> I do not believe this is a good idea.  This kind of information
> belongs in the kernel image, although it should be abstracted out
> within the kernel tree.

>From your reaction I'm not explaining myself well.  And since I'm
working with a work in progress that isn't too much of a suprise.

The basic rule is that nothing that can be queried from the hardware
directly should be passed to the kernel.  However we do need to have
an interface to describe the hardware that we can't do a
PCI/ISAPNP/USB/etc bus scan to get.  To a certain extent the
information is optional because sometimes we cannot get it.  But if we
can it is good to have.  

That is all I intend to pass to the linux kernel besides a command
line the unprobeable hardware details.  If something becomes probeable
in the future that wasn't in the past, I'd spec it as optional to pass
that information.  

For the kernel loaders I'd definentily have a standard probe routine
that would query the traditional BIOS, and then package the results in
the format I'm suggesting.  Because of working around BUGS sometimes
you need extra information that gets lost in translation, so I'm not
100% certain that is the best way to go.  However it is possible to
turn things on their heads and share the same code between multiple
operating systems at which point it makes real sense to move that code
into a bootloader.  This is one of those questions worth looking very
closely at.

For the unprobeable hardware what I want to do is pass in what amounts
to a struct pci_device tree.  But with struct pci_device generalized
to struct device as has been proposed for 2.5.  A preseeded tree
shouldn't be to hard to check up on, to see if it is accurate.
Verifing that I can handle resources like interrupts, and structures
that are not trees is my current challenge, with this.  Things like
interrupts tend to at least be DAGs.  I think the interfaces will need
some small extensions to handle 3GIO, Hypertransport, and Infiniband,
and other bus technologies to come.  Sort of like you need another RFC
when you encode another protocol on top of IP.  Just something to
specify exactly how the encoding will work.

I'll fight this in a month or two when I start integrating this into
2.5 and have had a chance to start integrating this in.  I'll see if I
can have this as a seperate of startup files in early 2.5 so that this
code can be tested seperately.  But there is real virtue in putting
all of your software eggs in one basket so long as it is a very good
basket.

Eric

