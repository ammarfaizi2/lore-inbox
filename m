Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261738AbSJMWgw>; Sun, 13 Oct 2002 18:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261739AbSJMWgv>; Sun, 13 Oct 2002 18:36:51 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:24488 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261738AbSJMWgt>; Sun, 13 Oct 2002 18:36:49 -0400
Message-Id: <200210132242.g9DMgVnf334662@pimout3-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Nick LeRoy <nleroy@cs.wisc.edu>, Hans Reiser <reiser@namesys.com>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Sun, 13 Oct 2002 13:27:10 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <20021012012807.1BB5B635@merlin.webofficenow.com> <200210120414.g9C4E1X10038@schroeder.cs.wisc.edu>
In-Reply-To: <200210120414.g9C4E1X10038@schroeder.cs.wisc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 October 2002 12:14 am, Nick LeRoy wrote:
> On Friday 11 October 2002 03:26 pm, Rob Landley wrote:
> > On Friday 11 October 2002 07:53 pm, Hans Reiser wrote:
>
> <snip>
>
> > A little side project I'm working on now (in my copious free time) is
> > mount point relocation support.  (You can mount the same filesystem a
> > second time in another location (mount --bind makes this easy), and they
> > share a superblock so open files should be happy, but you still can't
> > detach the first mount point.  Not with a hacksaw, or explosives...) 
> > It's more an excuse to learn the new VFS layer than anything else, but
> > it's
> > functionality I would in fact have a use for, strange enough...
>
> Not quite sure that I'm following the _why_ of this one, but maybe I'm just
> slow.

I posted it earlier:

Root filesystem is a loopback mounted zisofs image.  The file to be loopback 
mounted lives in the partition that will become /var.

An initial ramdisk mounts the partition on /initrd/var, calls losetup to 
associate /dev/loop0 with the correct file, and exits to let the boot process 
continue.  The boot process remounts /var in the appropriate place.

/var is now mounted twice.  The initrd can't be released because it's got an 
active mount point under it.  That mount point can't be released because the 
root filesystem is loopback mounted from within it, so it has to stay open.

Logically, the second /var mount should be "mount --move /initrd/var /var", 
followed by "umount /initrd" to free up the initrd memory.  Right now it's 
doing "mount -n --bind /initrd/var /var", because /etc is a symlink into /var 
(has to remain editable, you see), and this way the information about which 
partition var actually is can be kept in one place.  (This is an 
implementation detail: I could have used volume labels instead.)

The point is, right now I can't free the initial ramdisk because it has an 
active mount point under it..

> > I'm also looking for an "unmount --force" option that works on something
> > other than NFS.  Close all active filehandles (the programs using it can
> > just deal with EBADF or whatever), flush the buffers to disk, and
> > unmount. None of this "oh I can't do that, you have a zombie process with
> > an open file...", I want  "guillotine this filesystem pronto, capice?"
> > behavior.
>
> Now _this_ I *like*.  I've wanted this for _a long time_.  Not that I have
> that much spare time, but I'd like to help if I can!

I have no spare time at the moment either (hopefully next week), and I 
started out studying the 2.4 vfs layer which seems a bit different in 2.5 
(can't tell how much yet), but I'll get there...

> > Of course loopback mounts would be kind of upset about this, but to be
> > honest: tough.  The loopback block device gives them an I/O error, and
> > the filesystem should just cope.  Floppies do this all the time with dust
> > and cat hair and stuff...
>
> Yup.  This is required sometimes.  Ever have a CD mounted that the (#$)#
> kernel won't let you umount even though lsof and /proc insist that's
> there's nothing open, but all you can do is an fscking reboot?!!!

Yes.  And some scratched CDs can give REALLY interesting results...

Rob
