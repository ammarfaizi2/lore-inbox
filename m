Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265576AbUABTmP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265610AbUABTmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:42:15 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:53584 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S265576AbUABTmL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:42:11 -0500
Date: Fri, 2 Jan 2004 21:42:00 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Cc: Willy Tarreau <willy@w.ods.org>
Subject: Re: Something corrupts raid5 disks slightly during reboot
Message-ID: <20040102194200.GA11115091@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org, Willy Tarreau <willy@w.ods.org>
References: <20031031190829.GM4868@niksula.cs.hut.fi> <3FA30F4A.5030500@hundstad.net> <20031101082745.GF4640@niksula.cs.hut.fi> <20031101155604.GB530@alpha.home.local> <20031101182518.GL4640@niksula.cs.hut.fi> <20031101190114.GA936@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031101190114.GA936@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:                                                                   

I've been experiencing strange corruption on a raid5 volume for some time. 
The kernel is 2.2.x + RAID-0.90 patch. Fs is ext2 (+e2compr). After        
unmounting the filesystem, I can mount it again without problems. I can also
raidstop the raid device in between and all is still fine:

> umount /dev/md4; mount /dev/md4
    - no corruption              
> umount /dev/md4; raidstop /dev/md4; raidstart /dev/md4; mount /dev/md4
    - no corruption                                                     

But after a reboot, the filesystem is corrupted - few bytes differ in the
beginning of /dev/md4 between 1k and and 5k.

See the threads
  http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&threadm=MMYt.4B2.1%40gated-at.bofh.it&rnum=1&prev=/groups%3Fnum%3D50%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3Dutf-8%26q%3DSomething%2Bcorrupts%2Braid5%2Bdisks%2Bslightly%2Bduring%2Breboot%26sa%3DN%26tab%3Dwg
  http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&threadm=MZsH.72R.5%40gated-at.bofh.it&rnum=4&prev=/groups%3Fnum%3D50%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3Dutf-8%26q%3DSomething%2Bcorrupts%2Braid5%2Bdisks%2Bslightly%2Bduring%2Breboot%26sa%3DN%26tab%3Dwg
for details.

I did some futher research.

First I thought this was an artifact of using "non-normal" blocksize on the
fs, 4096 bytes. The other raid partitions I have on the system are 1024 and
do not get corrupted.). Also the corrupting fs is on raid5 on bare disks
(hdb+hdc+hdg), while the others are on partitions (hda1+hdd1+hdf1 and so
on.)

I tried to reproduce this under vmware with 3-disk raid5 (hda+hdb+hdd) using
4096-byte ext2 and the exact same kernel. Initially, I thought I was able to
trigger it by mounting the fs while raid rebuild was on progress. The kernel
spitted this:

  set_blocksize: b_count 1, dev md(9,4), block 15642112, from c014c3fb
  set_blocksize: b_count 1, dev md(9,4), block 15642113, from c014c3fb
  set_blocksize: b_count 1, dev md(9,4), block 15642114, from c014c3fb
  ...
  set_blocksize: b_count 2, dev md(9,4), block 15642367, from c014c3fb
  md4: blocksize changed during read
  nr_blocks changed to 64 (blocksize 4096, j 3910528, max_blocks 39091968)

and fsck reported problems, but only once (the set_blocksize stuff appeared
each time). It seems the "set_blocksize" outpouring is a known issue, and
not severe:

  http://www.ussg.iu.edu/hypermail/linux/kernel/0110.1/0493.html

The fsck errors were probably just a side-effect of unclean shutdown I used
to force raid rebuild.


After the failed vmware experiment, I tried to isolate when exactly the
corruption happens, shutdown or boot. Also, in the mentioned threads, people
had suggested turning off the write cache of the IDE disk.

I found out that the difference (corruption) is usually on three bytes on
/dev/hdg, but sometimes on /dev/hdc, too. (/dev/md4 = hdb+hdc+hdg; hdb&hdc
are on i810, hdg is on hpt370).

First, I did
   umount /dev/md4
   raidstop /dev/md4
   head -c 50k /dev/hdg > /save/hdg
   reboot

To rule out kernel raid autodetect and raid code in general, I
booted 2.2.25-1-secure with "single init=/bin/bash raid=noautodetect".
 Did
   head -c50k /dev/hdg | cmp -l /save/hdg
 Three bytes differed:
   4641   0      35
   4642   0      205
   4643   0      10
   bytepos after before
           boot  boot  

 wrote the original stuff back:
   dd if=/save/hdg /dev/hdg
   sync
   hdparm -W0 /dev/hdg
   sync
   reboot

Booted 2.2.25-1-secure with "single init=/bin/bash raid=noautodetect"
again.
 Did
   head -c50k /dev/hdg | cmp -l /save/hdg
 Three same three bytes differed again.
 Wrote the stuff back, sync'ed, did hdparm, and powered off. Still, the the
bytes differed on next boot.

Then I booted 2.4.21-jam1 with "single init=/bin/bash raid=noautodetect" (I
happened to have 2.4.21-jam1 compiled with suitable drivers at hand).
 Wrote the same stuff back with dd, synced, turned ide cache off.
 Booted 2.4.21-jam1 with "single init=/bin/bash raid=noautodetect" again.
 Did the diff; the three bytes differed again.

Note that sometimes few bytes on hdc differed, too. Usually it was just the
three hdg bytes.

So this is not a 2.2 kernel issue. I very much doubt it's a kernel issue at
all. Unless it is a bug in kernel partition detection that is still present
in 2.4.x.
         
I tried to turn off the ide write cache with hdparm -W0, so it shouldn't  
be a write caching issue.

If it's a bios issue, it's really a strange one, since it affects both disks
on i810 ide and on hpt370. The disks have no partition table, though, which
_could_ confuse the bios.

Any ideas? Who the heck could write to those three bytes, and why?


-- v --

v@iki.fi
