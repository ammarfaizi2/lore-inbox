Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWBFBqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWBFBqv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 20:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWBFBqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 20:46:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:11953 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750763AbWBFBqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 20:46:50 -0500
From: Neil Brown <neilb@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 6 Feb 2006 12:46:38 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17382.43646.567406.987585@cse.unsw.edu.au>
Cc: klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: Exporting which partitions to md-configure
In-Reply-To: message from H. Peter Anvin on Monday January 30
References: <43DEB4B8.5040607@zytor.com>
	<17374.47368.715991.422607@cse.unsw.edu.au>
	<43DEC095.2090507@zytor.com>
	<17374.50399.1898.458649@cse.unsw.edu.au>
	<43DEC5DC.1030709@zytor.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday January 30, hpa@zytor.com wrote:
> Neil Brown wrote:
> > 
> > Well, grepping through fs/partitions/*.c, the 'flags' thing is set by
> >  efi.c, msdos.c sgi.c sun.c
> > 
> > Of these, efi compares something against PARTITION_LINUX_RAID_GUID,
> > and msdos.c, sgi.c and sun. compare something against
> > LINUX_RAID_PARTITION.
> > 
> > The former would look like
> >   e6d6d379-f507-44c2-a23c-238f2a3df928
> > in sysfs (I think);
> > The latter would look like
> >   fd
> > (I suspect).
> > 
> > These are both easily recognisable with no real room for confusion.
> 
> Well, if we're going to have a generic facility it should make sense 
> across the board.  If all we're doing is supporting legacy usage we 
> might as well export a flag.
> 
> I guess we could have a single entry with a string of the form 
> "efi:e6d6d379-f507-44c2-a23c-238f2a3df928" or "msdos:fd" etc -- it 
> really doesn't make any difference to me, but it seems cleaner to have 
> two pieces of data in two different sysfs entries.

What constitutes 'a piece of data'?  A bit? a byte?

I would say that 
   msdos:fd
is one piece of data.  The 'fd' is useless without the 'msdos'.
The 'msdos' is, I guess, not completely useless with the fd.

I would lean towards the composite, but I wouldn't fight a separation.


> 
> > 
> > And if other partition styles wanted to add support for raid auto
> > detect, tell them "no". It is perfectly possible and even preferable
> > to live without autodetect.   We should support legacy usage (those
> > above) but should discourage any new usage.
> > 
> 
> Why is that, keeping in mind this will all be done in userspace?
> 

partition-type based autodetect is easily fooled.
If you take a pair of drives from a failed computer, plug them into a
similar computer for data recovery, and boot:  you might have two
different pairs of drives that both want to be 'md0'.  Which wins?

I believe there needs to be a clear, non ambigous, causality path from
the kernel paramters, initramfs, or machine hardware that leads to the
arrays to be assembled and hence the filesystem to be mounted.  These
should identify the array by some reasonably unique identifier.  The
'minor number' stored in the raid superblock and used by
partition-based autodetect is not 'reasonably unique'.

There are many many possibilites.  Some are:

 kernel parameter  md=0,/dev/hda,/dev/hdc

    'hda' and 'hdc' on 'this' machine are (I think) still unique
    identifiers of hardware, and so this can identify drives to assemble
    into an array.  Note that this would *not* be reliable with
          md=0,/dev/sda,/dev/sdb

 kernel parameter md_root_uuid=xxyy:zzyy:aabb:ccdd...
    This could be interpreted by an initramfs script to run mdadm 
    to find and assemble the array with that uuid.  The uuid of 
    each array is reasonably unique.

 initramfs containing preconfigured /etc/mdadm.conf
    This mdadm.conf would contain the uuid's of the arrays to
    assemble.

 kernel hardware MAC address
    This could be mapped through DHCP to a host name.  The host name
    is then given to mdadm such that it finds and assemble the array
    with 'name' (only supported in version-1 superblocks) of
         $HOST-root
    or whatever.


Just as there is a direct unambiguous causal path from something
present at early boot to the root filesystem that is mounted (and the
root filesystem specifies all other filesystems through fstab)
similarly there should be an unambiguous causal path from something
present at early boot to the array which holds the root filesystem -
and the root filesystem should describe all other arrays via
mdadm.conf

Does that make sense?

NeilBrown

