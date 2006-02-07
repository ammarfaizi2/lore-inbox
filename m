Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWBGJEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWBGJEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWBGJEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:04:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:64152 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750992AbWBGJEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:04:06 -0500
From: Neil Brown <neilb@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Tue, 7 Feb 2006 20:03:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17384.25214.810703.327286@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [klibc] Re: Exporting which partitions to md-configure
In-Reply-To: message from H. Peter Anvin on Monday February 6
References: <43DEB4B8.5040607@zytor.com>
	<17374.47368.715991.422607@cse.unsw.edu.au>
	<43DEC095.2090507@zytor.com>
	<17374.50399.1898.458649@cse.unsw.edu.au>
	<43DEC5DC.1030709@zytor.com>
	<17382.43646.567406.987585@cse.unsw.edu.au>
	<43E80A5A.5040002@zytor.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 6, hpa@zytor.com wrote:
> Neil Brown wrote:
> > 
> > Just as there is a direct unambiguous causal path from something
> > present at early boot to the root filesystem that is mounted (and the
> > root filesystem specifies all other filesystems through fstab)
> > similarly there should be an unambiguous causal path from something
> > present at early boot to the array which holds the root filesystem -
> > and the root filesystem should describe all other arrays via
> > mdadm.conf
> > 
> > Does that make sense?
> > 
> 
> It makes sense, but I disagree.  I believe you are correct in that the 
> current "preferred minor" bit causes an invalid assumption that, e.g. 
> /dev/md3 is always a certain thing, but since each array has a UUID, and 
> one should be able to mount by either filesystem UUID or array UUID, 
> there should be no need for such a conflict if one allows for dynamic md 
> numbers.
> 
> Requiring that mdadm.conf describes the actual state of all volumes 
> would be an enormous step in the wrong direction.  Right now, the Linux 
> md system can handle some very oddball hardware changes (such as on 
> hera.kernel.org, when the disks not just completely changed names due to 
> a controller change, but changed from hd* to sd*!)

mdadm.conf doesn't need to, and normally shouldn't, list the devices
that compose an array (though it can if you want it to).

A typical mdadm.conf should look something like:

   DEVICES /dev/hd* /dev/sd*
   ARRAY /dev/md0 UUID=some:long:uuid
   ARRAY /dev/md1 UUID=some:other:long:uuid

So I think we are actually in agreement.

> 
> Dynamicity is a good thing, although it needs to be harnessed.
> 
>  > kernel parameter md_root_uuid=xxyy:zzyy:aabb:ccdd...
>  >    This could be interpreted by an initramfs script to run mdadm
>  >    to find and assemble the array with that uuid.  The uuid of
>  >    each array is reasonably unique.
> 
> This, in fact is *EXACTLY* what we're talking about; it does require 
> autoassemble.  Why do we care about the partition types at all?  The 
> reason is that since the md superblock is at the end, it doesn't get 
> automatically wiped if the partition is used as a raw filesystem, and so 
> it's important that there is a qualifier for it.

Maybe I should be explicit about what I am against.
I am against the practice of choosing devices to assemble into arrays
based simply on a partition type - and assembling them into whatever
arrays they appear to comprise.

A device should not be able to say "pick me, pick me!".  Something
*outside* the array should say "pick all devices matching X", where X
is some arbitrary predicate, that could involve partition type
information if you like, but importantly should be precise enough not
to choose wrongly in any but very exceptional circumstances.

I am *not* against 'autoassemble' in the sense that some process hunts
through available devices trying to find the components for a give md
array: It was primarily to achieve this that I wrote mdadm.  I just
want the 'autoassemble' to be driven by some external description of
the array(s) - e.g. uuid.

I don't accept your argument that partition types are of interest
because array components could still have their superblock after being
retargeted.  This is because
  - running "mdadm --zero-superblock" is as easy as changing the
    partition type, and equally, both are easy to forget to do.
  - If you have retargeted devices in an array, you presumably don't
    put the UUID of that array anywhere that would encourage mdadm to
    assemble it.  So the fact that the UUID won't be recognised is
    just as good at stopping the array from being assembled as that
    fact that the partition type has been changed.

This doesn't mean I am violently against partition types (and for
legacy support, we need to use them).  I just don't see a lot of value
in using them.

NeilBrown
