Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbREOWD6>; Tue, 15 May 2001 18:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbREOWDl>; Tue, 15 May 2001 18:03:41 -0400
Received: from mcp.csh.rit.edu ([129.21.60.9]:60168 "HELO mcp.csh.rit.edu")
	by vger.kernel.org with SMTP id <S261624AbREOWDH>;
	Tue, 15 May 2001 18:03:07 -0400
Date: Tue, 15 May 2001 18:03:05 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515180305.A6019@fury.csh.rit.edu>
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com> <344250272.989965778@[169.254.198.40]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <344250272.989965778@[169.254.198.40]>; from linux-kernel@alex.org.uk on Tue, May 15, 2001 at 10:29:38PM +0100
X-Operating-System: SunOS 5.8 (sun4u)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 10:29:38PM +0100, Alex Bligh - linux-kernel wrote:
> > The argument that "if you use numbering based on where in the SCSI chain
> > the disk is, disks don't pop in and out" is absolute crap. It's not true
> > even for SCSI any more (there are devices that will aquire their location
> > dynamically), and it has never been true anywhere else. Give it up.
> 
> Q: Let us assume you have dynamic numbering disk0..N as you suggest,
>    and you have some s/w RAID of SCSI disks. A disk fails, and is (hot)
>    removed. Life continues. You reboot the machine. Disks are now numbered
>    disk0..(N-1). If the RAID config specifies using disk0..N thusly, it
>    is going to be very confused, as stripes will appear in the wrong place.
>    Doesn't that mean the file specifying the RAID config is going to have
>    to enumerate SCSI IDs (or something configuration invariant) as
>    opposed to use the disk0..N numbering anyway? Sure it can interrogate
>    each disk0..N to see which has the ID that it actually wanted, but
>    doesn't this rather subvert the purpose?
> 
> IE, given one could create /dev/disk/?.+, isn't the important
> argument that they share common major device numbers etc., not whether
> they linearly reorder precisely to 0..N as opposed to have some form
> of identifier guaranteed to be static across reboot & config change.

    I was think about something along these lines earlier, and I guess this is
    the perfect time to bring it up..

    Before I started working with Linux full time, I did a lot of work as an
    admin with Digital UNIX/Tru64. Tru64 v5 has a feature that at first glance
    I wasn't too sure about, but it's sort of grown on me.

    /dev/disk/* is populated with entries of the style dsk0a, dsk0b, etc.. The
    numbering of the disk is bus independant, ID independent, even transport
    independant. The disks are kept track of by disk serial number, and so for
    example, if you have three disks with serials "456", "123", "789", they
    would be recognized as dsk0, dsk1, dsk2, in the order of discovery. Once
    discovered, the disk with a certain serial number will _always_ be at a
    certain "dsk#" location, stored in /etc/disk-mappings or some such file in
    the root filesystem.

    Under the current system, if dsk1 fails, and the system reboots, all the
    disk numbers slide down. Linus mentioned "of course your disk numbers will
    change" earlier, but there's no real reason they have to, but there's also
    no reason you have to access them in the sys-v'ish c0d0p0.. style either.

    What I liked about the way Tru64 did it is that the disk numbering stays
    the same. You could've just taken the disk out for a day to put in another
    system, and you're planning on putting it back in. Re-attach the disk w/
    serial number "123", and it gets assigned "dsk1" again. Add another disk to
    the system, it gets dsk3, regardless of whether dsk1 was re-attached or
    not.

    This approach has the advantage of abstracting the device type from the
    user, as well as offering reproducable ordering.  The clear and immediate
    exception to all of this is replacing a failed disk, RAID or not. Since the
    mapping is done via user space, a simple utility, or even a text editor
    could remap a "new" disk to an "old" location, thus making the disk
    replaced. The "moving" of the disk to a different location shouldn't be
    much different than a device disappearing and reappearing.

    Of course, this is all a high level view of the whole process, but I
    thought I'd throw it out there for comment.

    -Jeff

-- 
Jeff Mahoney
jeffm@suse.com
jeffm@csh.rit.edu
