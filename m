Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130519AbRCIS3A>; Fri, 9 Mar 2001 13:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130537AbRCIS2u>; Fri, 9 Mar 2001 13:28:50 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11904 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130519AbRCIS2k>; Fri, 9 Mar 2001 13:28:40 -0500
Date: Fri, 9 Mar 2001 13:26:46 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alexander Viro <viro@math.psu.edu>
cc: Mike Galbraith <mikeg@wen-online.de>, Andries Brouwer <aeb@veritas.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk (and other) problems with 2.4.2
In-Reply-To: <Pine.GSO.4.21.0103091232150.14558-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.3.95.1010309132040.2688A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, Alexander Viro wrote:

> 
> 
> On Fri, 9 Mar 2001, Mike Galbraith wrote:
> 
> > I think I've figured it out.. at least I've found a way to reproduce
> > the exact errors to the last detail and some pretty nasty corruption
> > to go with it.  The operator must help though.. a lot ;-)
> > 
> > If you do mount -o remount /dev/somedisk / thinking that that will get
> > rid of your /dev/ram0 root, that isn't the case, and you will corrupt
> > the device you remounted (I did it to a scratch monkey) very badly when
> > you write to the still mounted ramdisk.
> 

Mount was not executed.


> Ugh. mount -o remount ignores dev_name argument. It will change the
> flags of fs mounted from /dev/ram0 and will not even touch a /dev/somedisk.
> If you write to device you have mounted... Well, don't expect it to be pretty.
[Snipped wonderful explaination of how to change flags using `mount`]

> 							Cheers,
> 								Al
> (fully expecting a long rant from Richard declaring that -o remount had
> _always_ been used to mount a different fs and both ANSI C standard and
> X-files fan guide mention it somewhere ;-)
> 

Nope. I didn't have anything to do with the way an
initial ramdisk is implemented either. However, here
is the point at which the root file system gets changed
from the initrd file-system to the real root.

This is `dmesg` stripped down:

 sda: sda1 sda2 < sda5 >
SCSI device sdb: 4406960 512-byte hdwr sectors (2256 MB)
 sdb: sdb1 sdb2
SCSI device sdc: 17783240 512-byte hdwr sectors (9105 MB)
 sdc: sdc1 sdc2 sdc3
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=3  < ============= Note the count!
Freeing unused kernel memory: 80k freed

At one time d_count meant something. Then there were changes.
Then more changes. This might have something to do with the
dangling references that can kill.

The `mount` command, nor its internal mount(2) doesn't enter into
this at all. There were no command-scripts that executed the
change_root. This is all part of the built-in initial RAM Disk
capabilites.

The problem is, simply, once you have booted a system using the
RAM Disk, don't expect to ever use the RAM disk again. Writes
to this, even though not currently mounted, can (will) make a mess
of your file-systems, even those which are not mounted.
This is simply a bug that should be fixed. It's not somebody
trying to do something for which the system was not designed.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


