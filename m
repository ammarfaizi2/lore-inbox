Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTLDR0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 12:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTLDR0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 12:26:33 -0500
Received: from ahriman.bucharest.roedu.net ([141.85.128.71]:52353 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S263303AbTLDR0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 12:26:30 -0500
Date: Thu, 4 Dec 2003 19:26:38 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: Linus Torvalds <torvalds@osdl.org>
cc: Nathan Scott <nathans@sgi.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: kernel BUG at mm/filemap.c:332!
In-Reply-To: <Pine.LNX.4.58.0312040834480.2055@home.osdl.org>
Message-ID: <Pine.LNX.4.56L0.0312041849250.10045@ahriman.bucharest.roedu.net>
References: <Pine.LNX.4.56L0.0312041645560.7551@ahriman.bucharest.roedu.net>
 <Pine.LNX.4.58.0312040834480.2055@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus

First of all thanks for the answer!

On Thu, 4 Dec 2003, Linus Torvalds wrote:

> 
> Nathan,
>  you're not off the hook yet. This is a smoking gun on XFS, and this time
> with a big clue: large directories, and a low-memory situation.

Sorry to have misguided you guys in the first post. After rebooting the
machine I have some more information, the actual directory size its about
some hundred entries (~400) and not thousands as I previously speculated
(I didnt know the exact number until I could ls it and I couldnt do that
until I had to reboot the machine).

Beeing just several hundred entries I know that I have at least one more
2.6.0-test11 machine (SMP, no MD but hw DAC960 RAID) with more entries in
one directory and I didnt got any such message (yet), it has only 5 days
uptime, we will see if I get anything there too. It could be just that on
the other machine I dont have much action happening in the directories
with many entries. The machine which got the kernel error has a lot of
things going in that directory with many entries (mostly stats gathered
every 5 mins from cron with mrtg and written to binary image files).

However I have some more usefull (I hope) information about the subject.  
Before rebooting I wanted to first install a do_brk() patched 2.4.21-xfs
kernel with lilo. Unfortunetly lilo stuck in a fsync() call after writing
to screen that it did added all kernel images to MBR as configured in
lilo.conf. When I booted I had no problem to boot from the new do_brk()
fixed kernel so lilo seems it did the job, I dont know why it stuck
in fsync().

ctrl-alt-del didnt do the trick (I had online ssh session on the machine
which was working , I could do ps ax, vmstat etc, but probably init was
doing something which also stuck in D state) so I had to reboot it "hard".
After power on, one coleague complained that a file on which he worked a
couple of minutes before I took the machine down had NULL bytes instead of
actual content. I know that "dirty" data gets flushed to disk every 30
seconds so this seems a little bit strange (in general I know that XFS
leaves NULL bytes in files modified just before a unclean reboot but this
file was modified some 5 minutes before the "hard" reboot).

> Also, this time the config file doesn't have any MD/RAID support according
> to the attachment:
> 
> 	# Multi-device support (RAID and LVM)
> 	#
> 	# CONFIG_MD is not set
> 
> so it looks like the XFS and MD issues really are totally unrelated.

Yep, Im very conservative to the features I use in the kernel :)

> Mihai: the oops itself is in this case not very telling, since it's just a
> result of corruption of some fundamental data structures (probably
> somebody using a page cache page after having free'd it - and it probably
> only shows up when memory gets low and pages have to be cleaned). Can you
> tell Nathan more about the filesystem setup (block size, as much as
> possible about the affected directory, etc).

Ok.

$ xfs_info /var
meta-data=/var                   isize=256    agcount=18, agsize=262144 blks
data     =                       bsize=4096   blocks=4482127, imaxpct=25
         =                       sunit=0      swidth=0 blks, unwritten=0
naming   =version 2              bsize=4096  
log      =internal               bsize=4096   blocks=1200
realtime =none                   extsz=65536  blocks=0, rtextents=0

Mount options are "rw,noatime".

Please let me know if you need any other infos. Thanks!

> 		Linus

- -- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/z25QPZzOzrZY/1QRAnvLAKDmlFPQEYyzVmxgAgopuar3hhGZ5ACeOq6H
Zwty+roqa5JqjBZBJDF0xnc=
=gPtb
-----END PGP SIGNATURE-----
