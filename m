Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266325AbUANOrf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 09:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266315AbUANOre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 09:47:34 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:60272 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S266325AbUANOrM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 09:47:12 -0500
Date: Wed, 14 Jan 2004 16:46:46 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org, Willy Tarreau <willy@w.ods.org>
Subject: Re: Something corrupts raid5 disks slightly during reboot
Message-ID: <20040114144646.GS11115091@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org, Willy Tarreau <willy@w.ods.org>
References: <20031031190829.GM4868@niksula.cs.hut.fi> <3FA30F4A.5030500@hundstad.net> <20031101082745.GF4640@niksula.cs.hut.fi> <20031101155604.GB530@alpha.home.local> <20031101182518.GL4640@niksula.cs.hut.fi> <20031101190114.GA936@alpha.home.local> <20040102194200.GA11115091@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102194200.GA11115091@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 09:42:00PM +0200, you [Ville Herva] wrote:
> Summary:                                                                   
> 
> I've been experiencing strange corruption on a raid5 volume for some time. 
> The kernel is 2.2.x + RAID-0.90 patch. Fs is ext2 (+e2compr). After        
> unmounting the filesystem, I can mount it again without problems. I can also
> raidstop the raid device in between and all is still fine:
> 
> > umount /dev/md4; mount /dev/md4
>     - no corruption              
> > umount /dev/md4; raidstop /dev/md4; raidstart /dev/md4; mount /dev/md4
>     - no corruption                                                     
> 
> But after a reboot, the filesystem is corrupted - few bytes differ in the
> beginning of /dev/md4 between 1k and and 5k.
> 
> See the threads
>   http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&threadm=MMYt.4B2.1%40gated-at.bofh.it&rnum=1&prev=/groups%3Fnum%3D50%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3Dutf-8%26q%3DSomething%2Bcorrupts%2Braid5%2Bdisks%2Bslightly%2Bduring%2Breboot%26sa%3DN%26tab%3Dwg
>   http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&threadm=MZsH.72R.5%40gated-at.bofh.it&rnum=4&prev=/groups%3Fnum%3D50%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3Dutf-8%26q%3DSomething%2Bcorrupts%2Braid5%2Bdisks%2Bslightly%2Bduring%2Breboot%26sa%3DN%26tab%3Dwg
> for details.
(...) 
> I found out that the difference (corruption) is usually on three bytes on
> /dev/hdg, but sometimes on /dev/hdc, too. (/dev/md4 = hdb+hdc+hdg; hdb&hdc
> are on i810, hdg is on hpt370).
> 
> First, I did
>    umount /dev/md4
>    raidstop /dev/md4
>    head -c 50k /dev/hdg > /save/hdg
>    reboot
> 
> To rule out kernel raid autodetect and raid code in general, I
> booted 2.2.25-1-secure with "single init=/bin/bash raid=noautodetect".
>  Did
>    head -c50k /dev/hdg | cmp -l /save/hdg
>  Three bytes differed:
>    4641   0      35
>    4642   0      205
>    4643   0      10
>    bytepos after before
>            boot  boot  
> 
>  wrote the original stuff back:
>    dd if=/save/hdg /dev/hdg
>    sync
>    hdparm -W0 /dev/hdg
>    sync
>    reboot
> 
> Booted 2.2.25-1-secure with "single init=/bin/bash raid=noautodetect"
> again.
>  Did
>    head -c50k /dev/hdg | cmp -l /save/hdg
>  Three same three bytes differed again.
>  Wrote the stuff back, sync'ed, did hdparm, and powered off. Still, the the
> bytes differed on next boot.
> 
> Then I booted 2.4.21-jam1 with "single init=/bin/bash raid=noautodetect" (I
> happened to have 2.4.21-jam1 compiled with suitable drivers at hand).
>  Wrote the same stuff back with dd, synced, turned ide cache off.
>  Booted 2.4.21-jam1 with "single init=/bin/bash raid=noautodetect" again.
>  Did the diff; the three bytes differed again.
> 
> Note that sometimes few bytes on hdc differed, too. Usually it was just the
> three hdg bytes.
> 
> So this is not a 2.2 kernel issue. I very much doubt it's a kernel issue at
> all. Unless it is a bug in kernel partition detection that is still present
> in 2.4.x.
>          
> I tried to turn off the ide write cache with hdparm -W0, so it shouldn't  
> be a write caching issue.
> 
> If it's a bios issue, it's really a strange one, since it affects both disks
> on i810 ide and on hpt370. The disks have no partition table, though, which
> _could_ confuse the bios.

Addition: 

  - I tried booting from 2.6.1 single user mode to 2.6.1 single user
    mode (booting with sysrq-b to avoid shutdown process):
       ->  The corruption on /dev/hdg happens like with 2.2 and 2.4

  - I booted from 2.6.1 single user mode to 2.6.1 single user
    mode with kexec patch to avoid entering BIOS in between
       ->  The corruption DOES NOT happen

I'm pretty much out of ideas.


-- v --

v@iki.fi
