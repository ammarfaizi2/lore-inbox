Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313167AbSDJOXr>; Wed, 10 Apr 2002 10:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313172AbSDJOXq>; Wed, 10 Apr 2002 10:23:46 -0400
Received: from [216.196.223.237] ([216.196.223.237]:47500 "HELO sin.sloth.org")
	by vger.kernel.org with SMTP id <S313167AbSDJOXo>;
	Wed, 10 Apr 2002 10:23:44 -0400
Date: Wed, 10 Apr 2002 10:23:43 -0400
From: Geoffrey Gallaway <geoffeg@sin.sloth.org>
To: linux-kernel@vger.kernel.org
Subject: Update - Ramdisks and tmpfs problems
Message-ID: <20020410102343.A31552@sin.sloth.org>
In-Reply-To: <20020409144639.A14678@sin.sloth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally found the problem, which appears to be a combination of things:

Multiple tmpfs mounts and SMP.

I am using a Dual Intel PIII 1Ghz box. When I use a SMP kernel AND do
multiple tmpfs mounts (mount --bind /dev/shm/etc /etc; mount --bind
/dev/shm/var /var) the machine goes into a reset loop. HOWEVER, when I use a
non-SMP kernel and still do multiple tmpfs mounts OR when I use a SMP kernel
and do only one tmpfs mount, the machine boots fine. Every once in a while
(1 out of 20 times?) the machine would boot fine with a SMP kernel and
multiple tmpfs mounts. Is this a timing issue?

If I can help to nail down this (apparent) bug more, please let me know.

Thanks,
Geoffeg

This one time, at band camp, Geoffrey Gallaway wrote:
> Hello,
> 
> I am attempting to create a central NFS server with a single slackware 8
> installation that many boxes can use as their root disks. I got bootp kernel
> level autoconfiguration working and the test box sucessfully mounts the root
> (/) NFS share. I'm using floppy disks with kernels on diskless machines.
> 
> The problem occurs for /var, /tmp and /etc. Because each machine will need
> it's own /var, /tmp and /etc I've been trying to create a ramdisk or tmpfs
> filesystem for those partitions on each box. I've been using the system
> initialization scripts to setup these directories and dynamically rewrite
> important files (HOSTNAME, etc) in /etc.
> 
> Originally I started playing with ram disks but when I try to create a new
> ramdisk with "mke2fs /dev/ram0 16384" mke2fs says:
> mke2fs: Filesystem larger then apparent filesystem size.
> Proceed anyway? (y,n) y
> Warning: could not erase sector 2: Invalid arguement
> Warning: could not erase sector 0: Attempt to write block from filesystem
> resulted in short write
> mke2fs: Invalid arguement zeroing block 16320 at end of filesystem
> 
> So no go with ram disks (this is kernel 2.4.18 on a 3 gig RAM dual PIII
> 1gig, BTW). So now to try tmpfs. Since I need to copy the existing files in
> /etc off to tmpfs I have to create a "temporary" tmpfs, copy /etc off to it
> then create another tmpfs on top of the existing /etc and copy from the
> "temporary" tempfs back to the new /etc. I came up with the following 
> commands:
> mount -w -n -t tmpfs -o defaults tmpfs /mnt
> cp -axf /etc /mnt
> mount -w -t tmpfs -o defaults tmpfs /etc
> cp -axf /mnt/etc/* /etc/
> umount /mnt
> # -- Reapeat for /var and /tmp --
> 
> Again, I put these commands in slackware's init scripts and it looks like
> everything is working fine until the login prompt appears, at which time the
> machine immediatly uncleanly reboots, eveytime without fail.
> 
> Anyone know what could be going on? I'm out of options as far as RAM-based
> filesystems. :)
> 
> Thanks,
> Geoffeg
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
