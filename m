Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261291AbSIQBdJ>; Mon, 16 Sep 2002 21:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263456AbSIQBdJ>; Mon, 16 Sep 2002 21:33:09 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:29852 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261291AbSIQBdI>; Mon, 16 Sep 2002 21:33:08 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Leif Sawyer <lsawyer@gci.com>
Date: Tue, 17 Sep 2002 09:41:10 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15750.27670.301037.349309@notabene.cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Raid 1 Issues
In-Reply-To: message from Leif Sawyer on Friday September 13
References: <BF9651D8732ED311A61D00105A9CA31509E4C934@berkeley.gci.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday September 13, lsawyer@gci.com wrote:
> I'm running 2.4.18, and trying to use Raid-1.
> 
> I created /etc/raidtab according to the instructions.
>     raiddev /dev/md0
>         raid-level      1
>         nr-raid-disks   2
>         nr-spare-disks  0
>         device  /dev/hdc2
>         raid-disk       0
>         device /dev/hdb2
>         raid-disk       1
> 
SNIP
> "cat /proc/mdstat"  shows the the devices connected, but not attached:
> 
> 	Personalities : [raid1] 
> 	read_ahead 1024 sectors
> 	md0 : active raid1 ide/host0/bus0/target1/lun0/part2[1]
> ide/host0/bus1/target0/lun0/part2[0]
> 	      77914752 blocks [1/1] [U]
>       unused devices: <none>
> 

There is an inconsistancy here.  Your raidtab says "nr-raid-disks 2",
but mdstat shows there is only 1 raid-disk in the array.

You will need to recreate the array using "mkraid -R /dev/md0"
 with a raidtab of
>     raiddev /dev/md0
>         raid-level      1
>         nr-raid-disks   2
>         device  /dev/hdc2
>         raid-disk       0
>         device /dev/hdb2
>         failed-disk       1

or with
     mdadm -C /dev/md0 --level=1 -n 2 /dev/hdc2 missing

Then "raidhotadd /dev/md0 /dev/hdb2"  or "mdadm /dev/md0 -a /dev/hdb2"
should add the other drive in.
Ofcourse  you will need to unmount /usr and "raidstop -a" or "mdadm -Ss"
first.


mdadm is available at
   http://www.cse.unsw.edu.au/~neilb/source/mdadm/

NeilBrown
