Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131573AbRCNVmJ>; Wed, 14 Mar 2001 16:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131574AbRCNVmB>; Wed, 14 Mar 2001 16:42:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30930 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131573AbRCNVlr>;
	Wed, 14 Mar 2001 16:41:47 -0500
Date: Wed, 14 Mar 2001 16:41:05 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] open_namei() braindamage Re: NODEV filesystem, multiple
 mounts and umount...
In-Reply-To: <210D2876A88@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0103141624290.4468-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Mar 2001, Petr Vandrovec wrote:

> Hey, it is reproducible:
> 
> mount -t vfat /dev/hda1 /dos/c
> mount --bind / /xxx
> echo "a" > /xxx/dos/c
> 
> and it stops here... ^C does not work. umount /dos/c fixes it
> (creat() returns EISDIR)

Very interesting. <thinks>
OK, so path_walk() gives us (vfsmnt of /xxx, dentry of /dos).
Then we do down() on ->i_sem of inode of /dos. OK.
We find dentry of /dos/c (mountpoint)
It's positive, so we drop ->i_sem of parent.
Dentry is a mountpoint.
We call __follow_down(). Since nothing is mounted under xxx we get
unchanged... What the fuck?

OK, I'm an idiot. Linus, please apply the following:

--- fs/namei.c.old    Wed Mar 14 16:37:45 2001
+++ fs/namei.c        Wed Mar 14 16:38:23 2001
@@ -1013,7 +1013,7 @@
                error = -ELOOP;
                if (flag & O_NOFOLLOW)
                        goto exit_dput;
-               do __follow_down(&nd->mnt,&dentry); while(d_mountpoint(dentry));
+               while (__follow_down(&nd->mnt,&dentry) && d_mountpoint(dentry));
        }
        error = -ENOENT;
        if (!dentry->d_inode)

							Cheers,
								Al

