Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135959AbREAB25>; Mon, 30 Apr 2001 21:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135960AbREAB2r>; Mon, 30 Apr 2001 21:28:47 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:10473 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S135959AbREAB2i>; Mon, 30 Apr 2001 21:28:38 -0400
Date: Mon, 30 Apr 2001 19:27:13 -0600
Message-Id: <200105010127.f411RDP03013@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
In-Reply-To: <p05100303b70eadd613b0@[207.213.214.37]>
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E286@ausxmrr501.us.dell.com>
	<200104242159.f3OLxoB07000@vindaloo.ras.ucalgary.ca>
	<p05100313b70bb73ce962@[207.213.214.37]>
	<200104270431.f3R4V4630593@vindaloo.ras.ucalgary.ca>
	<p05100303b70eadd613b0@[207.213.214.37]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell writes:
> On the subject of the Subject, Jeff Garzik recently (21 March) 
> suggested adding geographic information to the ethtool interface, 
> pci_dev->slot_name in the case of a PCI-based interface. There's 
> something to be said for having a uniform method of identifying the 
> location of devices, or at least a uniform parsable format. (A 
> potential shortcoming of Jeff's scheme, perhaps, is that it needs to 
> identify the slot_name as a PCI slot_name, though I could be missing 
> something there.)
> 
> Consider, instead of /dev/bus/pci0/dev1/fcn0/bus0/tgt1/lun2/part3 
> something like
> 
> /dev/bus/pci0d1f0/scsi0t1l2p3
> or
> /dev/bus/pci0:d1:f0/scsi0:t1:l2:p3

Nope. Linus hates the idea of "compressed" names. He wants them to be
obvious at first glance. My original devfs patch (before it went into
the kernel) had compressed names, and he made me change them (there
were other changes as well). I know it's a bit much to type in, but
he's probably right. If people need it, I can add compressed names to
devfsd, just like I did to preserve the names in the original devfs
patch.

> A related idea would be the ability to translate from a logical PCI 
> slot number, as above, and a physically meaningful description that 
> the user could use to identify an actual slot. Unfortunately the 
> proper place for such a translation function is in the 
> (hardware-specific) BIOS.

Nope. It's cleaner to do this in a vendor-specific "fixup" layer. Alan
asked me a similar question privately, so I've included my reponse to
his email (quoting bits of his email for context) below. In his reply,
Alan said "it makes sense". I take that as a good omen.
=========
> How do you intend to handle pci busses that are below other busses - eg gsc
> /dev/bus/gsc/bus/pci0/ .. ?
> Im just thinking it gets very cumbersome.

It could. And if you play with the upcoming SGI IA-64 boxes, where
they have a deep /dev/hw, it would appear even more so. However, I
came up with a scheme while I was visiting them after the workshop,
which I believe will handle an arbitrarily complex vendor tree. I'm
actually quite proud of this idea :-)

The basic idea is that /dev/bus contains a *logical* enumeration of
all busses in the system. This contains the generic Linux view of
busses. We already have this enumeration within struct pci_dev and
friends.

Then, vendors provide their own PCI fixups, which turn /dev/bus/pci0
into symlinks to something like /dev/hw/PBrick/00AA3415/bus1/pci3 (or
similar, I forget just how deep SGI's tree went).

This scheme is really just an extension of the approach Linus took in
the Great Name Change he forced upon me a year and a half ago. Back
then, he wanted /dev/discs to answer the question "what discs do I
have", and "/dev/scsi" to answer "what SCSI devices do I have, and
what's the layout". So now, I'm adding "/dev/bus" for "what logical
busses do I have" and "/dev/hw" for "what is the exact hardware
topology".

Where we have "generic" hardware (i.e. a vendor doesn't provide their
own PCI fixups), and there is a need to show the bus topology, we can
write generic fixups that parse the struct pci_dev and friends. For
example, most x86 machines would fall in this "generic" category.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
