Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbSJ0UWs>; Sun, 27 Oct 2002 15:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSJ0UWs>; Sun, 27 Oct 2002 15:22:48 -0500
Received: from air-2.osdl.org ([65.172.181.6]:46816 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262536AbSJ0UWq>;
	Sun, 27 Oct 2002 15:22:46 -0500
Date: Sun, 27 Oct 2002 12:25:18 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Rob Landley <landley@trommello.org>
cc: Jeff Garzik <jgarzik@pobox.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Steven Dake <sdake@mvista.com>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] Advanced TCA SCSI Disk Hotswap
In-Reply-To: <200210270908.59805.landley@trommello.org>
Message-ID: <Pine.LNX.4.33L2.0210271220010.8140-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Oct 2002, Rob Landley wrote:

(maybe wrap lines around column 70 ? :)

...

Stephen Tweedie did something like this already (for 2.4.19-pre10),
called "testdrive".  It uses loopback over a block device.
He says that it will need modifications to use bio in 2.5.

See here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102457399020069&w=2

-- 
~Randy

| Hmmm...  Not being familiar with the SCSI layer but sticking my nose in anyway
| on general block device/mount point hotplug issues:
|
| How hard would it be to write a simple debugging function to lobotomize a
| block device?  (So that all further I/O to that sucker immediately returns an
| error.)  Not just simulating an a hot extraction (or catastrophic failure) of
| a block device, but also something you could use to see how gracefully
| filesystems react.
|
| The reason I ask is there was a discussion a while back about the new lazy
| unmount (umount -l /blah/foo) not always being quite enough, and that
| sometimes what what you want is basically "umount -9 /blah/foo" (ala kill
| -9).  Close all files, reparent all process home directories and chroot mount
| points to a dummy inode, flush all I/O, drive a stake through the
| superblock's heart, and scatter the ashes at sea.  Somebody posted a patch to
| actually do this.  (Against 2.4, i think.)  I could probably dig it up if you
| were curious.  Let's see...
|
| http://marc.theaimsgroup.com/?l=linux-kernel&m=103443466225915&q=raw
|
| The eject command should certainly have an "umount with shotgun" option, so
| zombie processes can't pin your CD in the drive.  (Your average end-user is
| NOT going to be able to grovel through /proc to figure out which processes
| have an open filehandle or home directory under the cdrom mount point so it
| can kill them and get the disk out.  They're going to power cycle the machine
| and eject it while the bios is in charge.  I've done this myself a couple of
| times when I'm in a hurry.)
|
| Anyway, if the block device under the filesystem honestly does go away for
| hotplug eject reasons, the obvious thing to do is umount -9 the sucker
| immediately so userspace can collapse gracefully (or even conceivably
| recover).  The main difference here is that the flushing would all error out
| and get discarded, and this wouldn't always get reported to the user, but
| thanks to write cacheing that's the case anyway.  (Use some variant of
| O_DIRECT or fsync if you care.)  The errors userspace does see switch from
| "all my I/O failed with a media error" to "all my filehandles closed out from
| under me" (and the directory I'm in has been deleted), but that's still
| relatively logical behavior.
|
| Does this sound like it's off in left field?
|
| Rob

