Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268835AbRG0MY0>; Fri, 27 Jul 2001 08:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268838AbRG0MYR>; Fri, 27 Jul 2001 08:24:17 -0400
Received: from [195.157.147.30] ([195.157.147.30]:18182 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S268835AbRG0MYH>; Fri, 27 Jul 2001 08:24:07 -0400
Date: Fri, 27 Jul 2001 13:15:37 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange remount behaviour with ext3-2.4-0.9.4
Message-ID: <20010727131537.I18669@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>, <3B5FC7FB.D5AF0932@zip.com.au>; <20010727103221.F18669@dev.sportingbet.com> <3B61414E.72F39AFF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B61414E.72F39AFF@zip.com.au>; from akpm@zip.com.au on Fri, Jul 27, 2001 at 08:24:14PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 08:24:14PM +1000, Andrew Morton wrote:
> Sean Hunter wrote:
> > 
> > Following the announcement on lkml, I have started using ext3 on one of my
> > servers.  Since the server in question is a farily security-sensitive box, my
> > /usr partition is mounted read only except when I remount rw to install
> > packages.
> > 
> > I converted this partition to run ext3 with the mount options
> > "nodev,ro,data=writeback,defaults" figuring that when I need to install new
> > packages etc, that I could just mount rw as before and that metadata-only
> > journalling would be ok for this partition as it really sees very little write
> > activity.
> > 
> > When I try to remount it r/w I get a log message saying:
> > Jul 27 09:54:29 henry kernel: EXT3-fs: cannot change data mode on remount
> > 
> > ...even if I give the full mount option list with the remount instruction.
> 
> hmm..  The mount option handling there is a bit bogus.
> 
> What we *should* do on remount is check that the requested
> journalling mode is equal to the current mode.  ext3 won't
> allow you to change the journalling mode on-the-fly.

Indeed.

> 
> So...  you will have to omit the `data=xxx' portion of the
> mount options when remounting.  It's being invisibly added
> by /bin/mount.

Thought so.  I tried both ways just to be sure.

> /bin/mount tries to be smart.  If, for example you have
> 
> 	/dev/hdf12 /mnt/hdf12 ext3 noauto,ro,data=writeback 1
> 
> in /etc/fstab and then type
> 
> 	mount /dev/hdf12 -o remount,rw
> 
> then /bin/mount runs off and looks up the fstab entry and
> inserts the mount options.  However if you instead type
> 
> 	mount /dev/hdf12 /mnt/hdf12 -o remount,rw          (1)
> 
> then /bin/mount does *not* look up the fstab entry, and
> the remount succeeds.

Interesting, and (almost) 100% true

sean@henry:~$  sudo mount /dev/sda8 /usr -oro,nodev,data=writeback,remount
mount: you must specify the filesystem type
sean@henry:~$ sudo mount /dev/sda8 /usr -oro,nodev,data=writeback,remount -text3
mount: /usr not mounted already, or bad option
sean@henry:~$ sudo mount /dev/sda8 /usr -oro,nodev,remount -text3
sean@henry:~$ mount
/dev/sdb6 on / type ext3 (rw)
none on /proc type proc (rw)
/dev/sda1 on /boot type ext2 (ro,nosuid,nodev)
/dev/sdc6 on /home type ext3 (rw,nosuid,nodev,data=ordered)
/dev/sda8 on /usr type ext3 (ro,nodev)
/dev/sda5 on /var type ext3 (rw,nosuid,nodev,sync,data=journal)
none on /dev/pts type devpts (rw,gid=5,mode=620)

It succeeds as long as I don't specify the journal type.

> 
> ho-hum.  For the while you'll have to fiddle with the mount
> usage to get things working right.   Equation (1) above will
> work fine.  Or apply the appended patch.
> 
> > I can, however, remount it as ext2 read-write, but when I try to remount as
> > ext3 (even read only) I get the same problem.
> 
> You can't switch between ext2 and ext3 with a remount - unmount
> is needed.

Wierd.  This certainly looked to all the world as though it worked for me.  Thus:

sean@henry:~$ sudo mount /dev/sda8 /usr -oro,nodev,remount -text2

...doesn't give me an error, but:

sean@henry:~$ mount 
/dev/sdb6 on / type ext3 (rw)
none on /proc type proc (rw)
/dev/sda1 on /boot type ext2 (ro,nosuid,nodev)
/dev/sdc6 on /home type ext3 (rw,nosuid,nodev,data=ordered)
/dev/sda8 on /usr type ext3 (ro,nodev)
                       ^^^^
/dev/sda5 on /var type ext3 (rw,nosuid,nodev,sync,data=journal)
none on /dev/pts type devpts (rw,gid=5,mode=620)


> > Wierdly, "mount" lists it as being still an ext3 partition even though it has
> > been remounted as ext2.  I can't umount /usr because kjournald is currently
> > listed as using the partition.
> 
> That sounds very weird.  Could you please describe the steps
> you took to create this state?

See above.

> Sometimes /etc/mtab gets out of sync - especially for the
> root fs.  It's more reliable to look in /proc/mounts

sean@henry:~$ cat /proc/mounts
/dev/root / ext3 rw 0 0
/proc /proc proc rw 0 0
/dev/sda1 /boot ext2 ro,nosuid,nodev 0 0
/dev/sdc6 /home ext3 rw,nosuid,nodev 0 0
/dev/sda8 /usr ext3 ro,nodev 0 0
/dev/sda5 /var ext3 rw,nosuid,nodev,sync 0 0
none /dev/pts devpts rw 0 0

sean@henry:~$ cat /etc/mtab   
/dev/sdb6 / ext3 rw 0 0
none /proc proc rw 0 0
/dev/sda1 /boot ext2 ro,nosuid,nodev 0 0
/dev/sdc6 /home ext3 rw,nosuid,nodev,data=ordered 0 0
/dev/sda8 /usr ext3 ro,nodev 0 0
/dev/sda5 /var ext3 rw,nosuid,nodev,sync,data=journal 0 0
none /dev/pts devpts rw,gid=5,mode=620 0 0

Its almost as if mount is just silently ignoring the "-t" option when I specify
ext2.

> 
> 
> Here's the fix for the data= handling on remount:

I'll try this when its safe to reboot the box.

Thanks very much for your help.

Sean 
