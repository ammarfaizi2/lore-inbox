Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTFJTDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTFJTDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:03:20 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:43399
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261757AbTFJTCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 15:02:24 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: "Sean Hunter" <sean@uncarved.com>, Shawn <core@enodev.com>
Subject: Re: cachefs on linux
Date: Tue, 10 Jun 2003 15:15:53 -0400
User-Agent: KMail/1.5
Cc: Matthias Schniedermeyer <ms@citd.de>,
       "Leonardo H. Machado" <leoh@dcc.ufmg.br>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306091624370.14854-100000@volga.dcc.ufmg.br> <1055191776.13435.6.camel@localhost> <20030610082930.GA26777@uncarved.com>
In-Reply-To: <20030610082930.GA26777@uncarved.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306101515.53464.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 June 2003 04:29, Sean Hunter wrote:
> On Mon, Jun 09, 2003 at 03:49:36PM -0500, Shawn wrote:
> > Well, it's a nice way to simulate writing on r/o filesystems IIRC. Like
> > mounting a cdrom then writing to it, but you're not.
> >
> > Was that was this was? Anyway, linux also does not have unionFS. If it
> > was that big of a deal, someone would write it. As it is, it's a
> > whizbang no one cares about enough.
>
> Its particularly handy for fast read-only NFS stuff.  We have thousands
> of linux hosts and distributing software to all of them is a pain.  With
> cachefs with NFS as the "back" filesystem, you push to the masters and
> the clients get the changes over NFS and then store them in their local
> cache so your software distribution nightmare becomes no problem at all.
> Clients read off the local disk if they can, but fetch over NFS as
> required.  You can tune the cache size on all of the client machines so
> they can cache more or less of the most recently used NFS junk on its
> local disk.
>
> Sean

Technically cachefs is just a union mount with tmpfs or ramfs as the overlay 
on the underlying filesystem.  Doing a seperate cachefs is kind of pointless 
in Linux.

I believe the reason we're using "union mount" is that was the term Al Viro 
used when mentioning the concept in his to-do list months and months ago.  
that was before he dropped off the face of the planet for a while, and the 
Second Coming of Al Viro has yet to express an opinion on the matter, that I 
am aware of.

I myself want union mounts to seperate the current procfs into a "procfs" that 
does a subdirectory for each PID, and a "crapfs" that does all the legacy 
stuff that got shoehorned into procfs back when it was the main virtual 
filesystem for exporting system state.  (For legacy systems, union mount 
them.  For new systems, use just /proc and /sys with no need for crapfs.  
Easy migration path to something sane, that way...)

A lot of the VFS stuff has gotten cleaned up in 2.5 already.  You can detach a 
filesystem ala unlink (it goes out of the namespace now, but actually gets 
unmounted when the last open filehandle in it gets closed.)  I'm told there 
is also now a umount equivalent of "kill -9".  There was also talk of 
per-process namespaces (so your mount doesn't have to show up in another 
process's filesystem tree).  As soon as I get brave enough to put 2.5 on main 
work laptop, I intend to start playing with this sort of thing...

In 2.4 you could already remount the same filesystem in two or three places, 
and there's --bind to graft a subdirectory into the three as if it were a 
root directory.  And mounting one filesystem over another doesn't cause 
problems (although the underlying filesystem is completely hidden).  What you 
CAN'T do in 2.4 is move an existing mountpoint so you can free up what it was 
mounted under without unmounting it.

Yes, I cared about this.  Example: during initfs: mount /var, losetup 
/dev/loop0 /var/firmware.img, then exit so root device becomes /dev/loop0, 
and have init-first script "mount --move /initrd/var /var" (so init-first 
doesn't have to actually know where /var is partition-wise, since it's _IN_ 
the read-only firmware we loopback mounted earlier, and we can't umount 
/initrd/var anyway since it's got an open file in it for the loopback mount).  
I ended up doing mount --bind instead and just living with the duplicate 
mount under /initrd/var (and never being able to umount /initrd and free up 
the three megabytes of ram).  In 2.5, I can do a lot better...

As to the current status of union mounts, I have no idea.  It was more or less 
lumped in with the initramfs type work back around the halloween freeze, 
which fell through the cracks for a while, and seems to have been resurrected 
by other people (klib, etc) recently.  Let's see...

The most recent 2.5 status thing says union mounts are post 2.6:

http://kernelnewbies.org/status/Status-27-May-2003.html

Whether that's accurate, or means 2.6.x or 2.7, I couldn't tell you...

Rob
