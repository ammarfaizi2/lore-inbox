Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVGPIqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVGPIqw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 04:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVGPIqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 04:46:51 -0400
Received: from hastings.mumak.ee ([194.204.22.4]:54187 "EHLO hastings.mumak.ee")
	by vger.kernel.org with ESMTP id S262157AbVGPIqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 04:46:17 -0400
Subject: Re: reiserfs+acl makes processes hang?
From: Tarmo =?ISO-8859-1?Q?T=E4nav?= <tarmo@itech.ee>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0507161018020.32709@yvahk01.tjqt.qr>
References: <1121469596.17539.9.camel@localhost>
	 <Pine.LNX.4.61.0507161018020.32709@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 16 Jul 2005 11:46:12 +0300
Message-Id: <1121503573.9150.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You made one mistake, the last echo "1" >blah should not be
to the file you created earlier.. the echo is meant to
create another file which is supposed to fail because there
is no free space but for some reason instead of failing it
will cause the process to enter D state.

Here is how I just reproced it:
#mkdir testdir
#cd testdir/
#dd if=/dev/zero of=blk count=64 bs=1M
64+0 records in
64+0 records out
#mkreiserfs -f blk >/dev/null
mkreiserfs 3.6.19 (2003 www.namesys.com)

blk is not a block special device
Continue (y/n):y
#mkdir mpoint
#mount blk mpoint/ -o loop,acl
#cd mpoint
#mkdir dir
#setfacl -f -m u:sn4ip3r:rwX dir
setfacl: invalid option -- f
Usage: setfacl [-bkndRLP] { -m|-M|-x|-X ... } file ...
Try `setfacl --help' for more information.
#setfacl -d -m u:sn4ip3r:rwX dir
#cd dir
#cat /dev/zero >blah
cat: write error: No space left on device
#df .
Filesystem           1K-blocks      Used Available Use% Mounted on
/home/sn4ip3r/testdir/blk
                         65528     65528         0
100% /home/sn4ip3r/testdir/mpoint
#echo 1 > blah2              <<< and this is the line that never returns

--
Tarmo Tänav
tarmo@itech.ee

On L, 2005-07-16 at 10:24 +0200, Jan Engelhardt wrote:
> >Hi,
> >
> >Here's how to reproduce:
> >1. mount a reiserfs volume (loopmount will do) with "-o acl".
> >2. create a directory "dir"
> >3. set some default acl: setfacl -d -m u:username:rwX dir
> >4. cd dir
> >5. dd if=/dev/zero of=somefile1 bs=4k count=100000
> >(the idea is to run out of space)
> >6. now df should show 0 free space, if not then repeat 5.
> >7. echo "1" > somefile2 # this should hang infinitely
> 
> Can't reproduce. My versions are:
> mkreiserfs 3.6.18
> Kernel 2.6.13-rc1
> 
> 
> ---Step 1---
> 10:25 shanghai:/mnt > dd if=/dev/zero of=blk count=64 bs=1M
> 64+0 records in
> 64+0 records out
> 67108864 bytes (67 MB) copied, 0.552862 seconds, 121 MB/s
> 10:26 shanghai:/mnt > mkreiserfs -f blk
> mkreiserfs 3.6.18 (2003 www.namesys.com)
> 
> A pair of credits:
> ...
> blk is not a block special device
> Continue (y/n):y
> Guessing about desired format.. Kernel 2.6.13-rc1 is running.
> Format 3.6 with standard journal
> Count of blocks on the device: 16384
> Number of blocks consumed by mkreiserfs formatting process: 8212
> Blocksize: 4096
> Hash function used to sort names: "r5"
> Journal Size 8193 blocks (first block 18)
> Journal Max transaction length 1024
> inode generation number: 0
> UUID: aa3bd664-fde0-4552-9484-49bac0fb698f
> Initializing journal - 0%....20%....40%....60%....80%....100%
> Syncing..ok
> ReiserFS is successfully created on blk.
> 10:26 shanghai:/mnt > mount blk loop -o loop,acl
> 
> ---Step 2-7---
> 10:26 shanghai:/mnt > cd loop/
> 10:27 shanghai:/mnt/loop > md dir
> 10:27 shanghai:/mnt/loop > setfacl -d -m u:daemon:rwX dir
> 10:27 shanghai:/mnt/loop > cd dir
> 10:27 shanghai:/mnt/loop/dir > cat /dev/zero >blah
> cat: write error: No space left on device
> 10:27 shanghai:/mnt/loop/dir > df .
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /mnt/blk                 65528     65528         0 100% /mnt/loop
> 10:27 shanghai:/mnt/loop/dir > l
> total 32684
> drwxr-xr-x+ 2 root root       72 Jul 16 10:27 .
> drwxr-xr-x  5 root root      104 Jul 16 10:27 ..
> -rw-rw-r--+ 1 root root 33435648 Jul 16 10:27 blah
> (That's ok, the other 32MB are for the journal)
> 10:27 shanghai:/mnt/loop/dir > echo "1" >blah
> 10:28 shanghai:/mnt/loop/dir > l blah
> -rw-rw-r--+ 1 root root 2 Jul 16 10:28 blah
> 
> 
> 
> Jan Engelhardt

