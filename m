Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUAEDd3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 22:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265867AbUAEDd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 22:33:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:27114 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265681AbUAEDd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 22:33:27 -0500
Date: Sun, 4 Jan 2004 19:33:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040105030737.GA29964@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0401041918260.2162@home.osdl.org>
References: <20040103141029.B3393@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Daniel Jacobowitz wrote:
> 
> I think you two are talking straight past each other.  Andries is
> talking about the fsid, which is determined by the NFS server, based on
> its idea of the device number of the filesystem underlying the exported
> directory.  Right now, I can reboot my host system, and when it comes
> up then the NFS directories it exports to clients will have the same
> fsid.  With random device numbers it won't work; after rebooting the
> NFS server all clients will be forced to explicitly unmount and
> remount.

Ahh. I'll buy into that, and yes, this is an example of something that 
needs to be fixed. 

It shouldn't be fixed by saying "device numbers have to be stable across 
reboots", because the fact is, we're most likely going to have storage 
that is really really hard to enumerate in a repeatable fashion.

So the _proper_ thing to do is to have the NFS server not use the device 
number as part of fsid. It should use the _stable_ UUID of the filesystem 
or some similar label.

And it should do that exactly because the device number isn't as stable as 
NFS exporting would like it to be. Exactly because things like network- 
attached disks etc.  How would you otherwise export a disk that perhaps 
gets its address from DHCP? 

[ I incredulously asked a NetApp person why you'd ever want to expose the
  _disk_ over ethenet, rather than just have the NAS device export a
  filesystem of its own. It turns out that some people really want to just
  see a block device, either because Windows sucks at network filesystems
  or because they want to do things like databases onto them. The point
  being that once you do that, you'll likely want to export the thing as
  an SMB share from the thing that "owns" the disk. 

  So you would literally have a _disk_ whose IP address changed depending 
  on what other machines were booted on the same network. ]

Issues like this is also why Linux vendors have already started doing
things like "mount by label" - because disks have a nasty tendency to move
around, and specifying the fstab contents (or "root=xxx" on the kernel
command line) with physical location or similar just doesn't work all
that well. It happens today with things like USB2 or firewire disks. They 
get moved around, and they get a new device number.

It's still not _common_, but it's slowly getting there.

> Now, it seems to me that this isn't much of an argument against random
> device numbers.  Have userspace set a UUID for the device if you want,
> and use that in the fsid instead.  But that's the argument; it has
> nothing to do with the NFS server exporting its /dev.

I buy into that, and I agree 100% with you that this is just a case where 
you should use a UUID.

		Linus
