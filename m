Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135520AbREAOih>; Tue, 1 May 2001 10:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135844AbREAOi1>; Tue, 1 May 2001 10:38:27 -0400
Received: from geos.coastside.net ([207.213.212.4]:43664 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S135813AbREAOiK>; Tue, 1 May 2001 10:38:10 -0400
Mime-Version: 1.0
Message-Id: <p05100301b71475c6091e@[207.213.214.37]>
In-Reply-To: <200105010127.f411RDP03013@vindaloo.ras.ucalgary.ca>
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E286@ausxmrr501.us.dell.com>
 <200104242159.f3OLxoB07000@vindaloo.ras.ucalgary.ca>
 <p05100313b70bb73ce962@[207.213.214.37]>
 <200104270431.f3R4V4630593@vindaloo.ras.ucalgary.ca>
 <p05100303b70eadd613b0@[207.213.214.37]>
 <200105010127.f411RDP03013@vindaloo.ras.ucalgary.ca>
Date: Tue, 1 May 2001 07:38:02 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:27 PM -0600 2001-04-30, Richard Gooch wrote:
>Jonathan Lundell writes:
>  > ...
>  > Consider, instead of /dev/bus/pci0/dev1/fcn0/bus0/tgt1/lun2/part3
>>  something like
>>
>>  /dev/bus/pci0d1f0/scsi0t1l2p3
>>  or
>>  /dev/bus/pci0:d1:f0/scsi0:t1:l2:p3
>
>Nope. Linus hates the idea of "compressed" names. He wants them to be
>obvious at first glance. My original devfs patch (before it went into
>the kernel) had compressed names, and he made me change them (there
>were other changes as well). I know it's a bit much to type in, but
>he's probably right. If people need it, I can add compressed names to
>devfsd, just like I did to preserve the names in the original devfs
>patch.

OK. Not a big deal, really.

/dev/bus/pci0/dev1/fcn0/bus0/tgt1/lun2/part3

becomes

/device/bus/peripheralcomponentinterconnect0/device1/function0/bus0/target1/logicalunitnumber2/partition3 
:-)

>  > A related idea would be the ability to translate from a logical PCI
>>  slot number, as above, and a physically meaningful description that
>>  the user could use to identify an actual slot. Unfortunately the
>>  proper place for such a translation function is in the
>>  (hardware-specific) BIOS.
>
>Nope. It's cleaner to do this in a vendor-specific "fixup" layer.

I agree, actually. If there *were* BIOS support for such geographic 
information (and while there should be there isn't), the 
vendor-specific fixup could take advantage of it. The point about 
BIOS is that it's connected to the specific hardware, and is the 
appropriate (ultimate) repository for that kind of information. In a 
related vein (for example) Sun's OBP (BIOS-equivalent) provides a 
lookup function that converts a physical memory address (generally 
after an ECC error) to a physical DIMM U-number, for human reporting 
purposes. But it's a moot point, so never mind....

>Alan
>asked me a similar question privately, so I've included my reponse to
>his email (quoting bits of his email for context) below. In his reply,
>Alan said "it makes sense". I take that as a good omen.
>=========
>>  How do you intend to handle pci busses that are below other busses - eg gsc
>>  /dev/bus/gsc/bus/pci0/ .. ?
>  > Im just thinking it gets very cumbersome.

It *does* address my concern about multiple PCI subsystems.

>It could. And if you play with the upcoming SGI IA-64 boxes, where
>they have a deep /dev/hw, it would appear even more so. However, I
>came up with a scheme while I was visiting them after the workshop,
>which I believe will handle an arbitrarily complex vendor tree. I'm
>actually quite proud of this idea :-)
>
>The basic idea is that /dev/bus contains a *logical* enumeration of
>all busses in the system. This contains the generic Linux view of
>busses. We already have this enumeration within struct pci_dev and
>friends.
>
>Then, vendors provide their own PCI fixups, which turn /dev/bus/pci0
>into symlinks to something like /dev/hw/PBrick/00AA3415/bus1/pci3 (or
>similar, I forget just how deep SGI's tree went).
>
>This scheme is really just an extension of the approach Linus took in
>the Great Name Change he forced upon me a year and a half ago. Back
>then, he wanted /dev/discs to answer the question "what discs do I
>have", and "/dev/scsi" to answer "what SCSI devices do I have, and
>what's the layout". So now, I'm adding "/dev/bus" for "what logical
>busses do I have" and "/dev/hw" for "what is the exact hardware
>topology".
>
>Where we have "generic" hardware (i.e. a vendor doesn't provide their
>own PCI fixups), and there is a need to show the bus topology, we can
>write generic fixups that parse the struct pci_dev and friends. For
>example, most x86 machines would fall in this "generic" category.

Reasonable, especially if a fixup map could be created by a user in 
the absence of a vendor-supplied map. (When/where does /dev/hw/ get 
created?)

On a related note, how does the current pci_dev tree deal with 
multiple PCI subsystems? For example, in pci.c we have

struct pci_dev *
pci_find_slot(unsigned int bus, unsigned int devfn)
{
	struct pci_dev *dev;

	pci_for_each_dev(dev) {
		if (dev->bus->number == bus && dev->devfn == devfn)
			return dev;
	}
	return NULL;
}

...which appears on the face of it (assuming a single tree) to ignore 
the possibility of bus-number aliasing across PCI subsystems.
-- 
/Jonathan Lundell.
