Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTH0Fwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 01:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTH0Fwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 01:52:38 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:170 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263152AbTH0FwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 01:52:23 -0400
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: Oleg Drokin <green@namesys.com>
Date: Wed, 27 Aug 2003 15:52:04 +1000
Cc: reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4 snapshot for August 26th.
Message-ID: <20030827055204.GA18114@cse.unsw.EDU.AU>
References: <20030826102233.GA14647@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826102233.GA14647@namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 02:22:33PM +0400, Oleg Drokin wrote:
> Fixed some bugs. And finally reiser4 should compile on 64bit boxes
> (hm. somebody try it, as I am unable to build any 2.6 kernel for
> ia64).

I built this with IA64 2.6.0-test4, it works but there were lots of
warnings (I can put up a log if you want it).  This was on a dual
processor Itanium 2 box.

First up, I tried a little test to make a few files, but once I had
unmounted the disk I couldn't re-mount it.

--- example testing below ---
bash-2.05b# mkfs.reiser4 /dev/sda5
mkfs.reiser4 0.4.12
Copyright (C) 2001, 2002, 2003 by Hans Reiser, licensing governed by reiser4progs/COPYING.
 
Information: Reiser4 is going to be created on /dev/sda5.
(Yes/No): Yes
Creating reiser4 on /dev/sda5...
mkfs.reiser4(5676): unaligned access to 0x60000000000242f2, ip=0x20000000000f7661
mkfs.reiser4(5676): unaligned access to 0x60000000000242fa, ip=0x20000000000f77a1
mkfs.reiser4(5676): unaligned access to 0x6000000000024302, ip=0x20000000000f78e1
mkfs.reiser4(5676): unaligned access to 0x60000000000242f2, ip=0x20000000000f2671
done
Synchronizing /dev/sda5...done
bash-2.05b# mount -t reiser4 /dev/sda5 /mnt
bash-2.05b# cd /mnt
bash-2.05b# time for i in `seq 1 10000` ; do touch $i ; done
 
real    0m18.577s
user    0m5.910s
sys     0m12.657s

[do ls, all looks ok]

bash-2.05b# umount /mnt
bash-2.05b# mount -t reiser4 /dev/sda5 /mnt
mount: wrong fs type, bad option, bad superblock on /dev/sda5,
       or too many mounted file systems

--- end example testing ---
The console popped up with :

reiser4[mount(15688)]: reiser4_fill_super (fs/reiser4/vfs_ops.c:1229)[nikita-2608]:
WARNING: Wrong magic: 10000 != 62533452

when I tried to mount it.

I repeated this, but this time thought I'd try 'sync' before
unmounting the disk; the sync command just hung and from that point
nothing could seem to access disk, even on different partitions (so
each program became unresponsive as soon as it tried to open a file).

Then I tried the mongo.pl script just for something else, I used the
parameters given in the sample config, i.e.

FSTYPE=reiser4
BYTES=250000000
FILE_SIZE=4096

It just seemed to hang in "PHASE Create" and after, say a minute or
two, made the machine unresponsive in the same way as 'sync' above --
as soon as anything tried to access disk it just hung.

So I retried this, and did a ls in the mounted directory just after I
started mongo to try and poke at what it was up to; ls hung in the
same way but this time I got messages :

 reiser4[ls(30795)]: traverse_tree (fs/reiser4/search.c:488)[nikita-1481]:
WARNING: Too many iterations: 128
 reiser4[ls(30795)]: traverse_tree (fs/reiser4/search.c:488)[nikita-1481]:
WARNING: Too many iterations: 256
 reiser4[ls(30795)]: traverse_tree (fs/reiser4/search.c:488)[nikita-1481]:
WARNING: Too many iterations: 512
 reiser4[ls(30795)]: traverse_tree (fs/reiser4/search.c:488)[nikita-1481]:
WARNING: Too many iterations: 1024
 reiser4[ls(30795)]: traverse_tree (fs/reiser4/search.c:488)[nikita-1481]:
WARNING: Too many iterations: 2048

that just kept climbing ...

I'm happy to help more, but I think a little more targetting debugging
is required.  Could you suggest what would be helpful for me to try?

-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au
