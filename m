Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbSJ0UDB>; Sun, 27 Oct 2002 15:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262523AbSJ0UDB>; Sun, 27 Oct 2002 15:03:01 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:19104 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262512AbSJ0UC6> convert rfc822-to-8bit; Sun, 27 Oct 2002 15:02:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Jeff Garzik <jgarzik@pobox.com>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] [RFC] Advanced TCA SCSI Disk Hotswap
Date: Sun, 27 Oct 2002 10:08:59 -0500
User-Agent: KMail/1.4.3
Cc: Steven Dake <sdake@mvista.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200210242342.g9ONgGT04819@localhost.localdomain> <3DB887D5.5080500@pobox.com>
In-Reply-To: <3DB887D5.5080500@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210270908.59805.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 October 2002 18:52, Jeff Garzik wrote:
> James Bottomley wrote:
> >>n Advanced TCA (what spawned this work) a button is pressed to
> >>indicate  hotswap removal which makes for easy detection of hotswap
> >>events.  This is why there are  kernel interfaces for removal and
> >>insertion (so a kernel driver can be written to detect  the button
> >>press and remove the devices from the os data structures and then
> >>light a blue  led indicating safe for removal).
> >
> >OK, I understand what's going on now.  It's no different from those
> > hotplug PCI busses where you press the button and a second or so later
> > the LED goes out and you can remove the card.  10ms sounds rather a short
> > maximum time for a technician to wait for a light to go out....I suppose
> > Telco technicians are rather impatient.
> >
> >I really think you need to lengthen this interval.  The kernel is moving
> >towards this type of hotplug infrastructure which you can easily leverage
> > (or even help build), but it's definitely going to be mainly in user
> > space.
>
> Caveat coder -- you also have to handle the case where the device is
> already gone, by the time you are notified of the hot-unplug event.
>  Some ejections are less friendly than others...  though from a SCSI
> standpoint, hopefully that case is easier -- error out all I/Os in
> flight, and unregister the host and device structures associated with
> the recently-removed host.  The devil, of course, is in the details ;-)

Hmmm...  Not being familiar with the SCSI layer but sticking my nose in anyway 
on general block device/mount point hotplug issues:

How hard would it be to write a simple debugging function to lobotomize a 
block device?  (So that all further I/O to that sucker immediately returns an 
error.)  Not just simulating an a hot extraction (or catastrophic failure) of 
a block device, but also something you could use to see how gracefully 
filesystems react.

The reason I ask is there was a discussion a while back about the new lazy 
unmount (umount -l /blah/foo) not always being quite enough, and that 
sometimes what what you want is basically "umount -9 /blah/foo" (ala kill 
-9).  Close all files, reparent all process home directories and chroot mount 
points to a dummy inode, flush all I/O, drive a stake through the 
superblock's heart, and scatter the ashes at sea.  Somebody posted a patch to 
actually do this.  (Against 2.4, i think.)  I could probably dig it up if you 
were curious.  Let's see...

http://marc.theaimsgroup.com/?l=linux-kernel&m=103443466225915&q=raw

The eject command should certainly have an "umount with shotgun" option, so 
zombie processes can't pin your CD in the drive.  (Your average end-user is 
NOT going to be able to grovel through /proc to figure out which processes 
have an open filehandle or home directory under the cdrom mount point so it 
can kill them and get the disk out.  They're going to power cycle the machine 
and eject it while the bios is in charge.  I've done this myself a couple of 
times when I'm in a hurry.)

Anyway, if the block device under the filesystem honestly does go away for 
hotplug eject reasons, the obvious thing to do is umount -9 the sucker 
immediately so userspace can collapse gracefully (or even conceivably 
recover).  The main difference here is that the flushing would all error out 
and get discarded, and this wouldn't always get reported to the user, but 
thanks to write cacheing that's the case anyway.  (Use some variant of 
O_DIRECT or fsync if you care.)  The errors userspace does see switch from 
"all my I/O failed with a media error" to "all my filehandles closed out from 
under me" (and the directory I'm in has been deleted), but that's still 
relatively logical behavior.

Does this sound like it's off in left field?

>     Jeff

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
