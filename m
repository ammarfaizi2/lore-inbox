Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWAVWxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWAVWxD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 17:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWAVWxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 17:53:03 -0500
Received: from ns2.suse.de ([195.135.220.15]:60140 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932297AbWAVWxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 17:53:01 -0500
From: Neil Brown <neilb@suse.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Date: Mon, 23 Jan 2006 09:52:50 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17364.3266.29943.914861@cse.unsw.edu.au>
Cc: NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
In-Reply-To: message from Adam Kropelin on Saturday January 21
References: <20060117174531.27739.patches@notabene>
	<20060121234234.A32306@mail.kroptech.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday January 21, akropel1@rochester.rr.com wrote:
> NeilBrown <neilb@suse.de> wrote:
> > In line with the principle of "release early", following are 5 patches
> > against md in 2.6.latest which implement reshaping of a raid5 array.
> > By this I mean adding 1 or more drives to the array and then re-laying
> > out all of the data.
> 
> I've been looking forward to a feature like this, so I took the
> opportunity to set up a vmware session and give the patches a try. I
> encountered both success and failure, and here are the details of both.
> 
> On the first try I neglected to read the directions and increased the
> number of devices first (which worked) and then attempted to add the
> physical device (which didn't work; at least not the way I intended).
> The result was an array of size 4, operating in degraded mode, with 
> three active drives and one spare. I was unable to find a way to coax
> mdadm into adding the 4th drive as an active device instead of a 
> spare. I'm not an mdadm guru, so there may be a method I overlooked.
> Here's what I did, interspersed with trimmed /proc/mdstat output:

Thanks, this is exactly the sort of feedback I was hoping for - people
testing thing that I didn't think to...

> 
>   mdadm --create -l5 -n3 /dev/md0 /dev/sda /dev/sdb /dev/sdc
> 
>     md0 : active raid5 sda[0] sdc[2] sdb[1]
>           2097024 blocks level 5, 64k chunk, algorithm 2 [3/3] [UUU]
> 
>   mdadm --grow -n4 /dev/md0
> 
>     md0 : active raid5 sda[0] sdc[2] sdb[1]
>           3145536 blocks level 5, 64k chunk, algorithm 2 [4/3] [UUU_]

I assume that no "resync" started at this point?  It should have done.

> 
>   mdadm --manage --add /dev/md0 /dev/sdd
> 
>     md0 : active raid5 sdd[3](S) sda[0] sdc[2] sdb[1]
>           3145536 blocks level 5, 64k chunk, algorithm 2 [4/3] [UUU_]
> 
>   mdadm --misc --stop /dev/md0
>   mdadm --assemble /dev/md0 /dev/sda /dev/sdb /dev/sdc /dev/sdd
> 
>     md0 : active raid5 sdd[3](S) sda[0] sdc[2] sdb[1]
>           3145536 blocks level 5, 64k chunk, algorithm 2 [4/3] [UUU_]

This really should have started a recovery.... I'll look into that
too.


> 
> For my second try I actually read the directions and things went much
> better, aside from a possible /proc/mdstat glitch shown below.
> 
>   mdadm --create -l5 -n3 /dev/md0 /dev/sda /dev/sdb /dev/sdc
> 
>     md0 : active raid5 sda[0] sdc[2] sdb[1]
>           2097024 blocks level 5, 64k chunk, algorithm 2 [3/3] [UUU]
> 
>   mdadm --manage --add /dev/md0 /dev/sdd
> 
>     md0 : active raid5 sdd[3](S) sdc[2] sdb[1] sda[0]
>           2097024 blocks level 5, 64k chunk, algorithm 2 [3/3] [UUU]
> 
>   mdadm --grow -n4 /dev/md0
> 
>     md0 : active raid5 sdd[3] sdc[2] sdb[1] sda[0]
>           2097024 blocks level 5, 64k chunk, algorithm 2 [4/4] [UUUU]
>                                 ...should this be... --> [4/3] [UUU_] perhaps?

Well, part of the array is "4/4 UUUU" and part is "3/3 UUU".  How do
you represent that?  I think "4/4 UUUU" is best.


>           [>....................]  recovery =  0.4% (5636/1048512) finish=9.1min speed=1878K/sec
> 
>     [...time passes...]
> 
>     md0 : active raid5 sdd[3] sdc[2] sdb[1] sda[0]
>           3145536 blocks level 5, 64k chunk, algorithm 2 [4/4] [UUUU]
> 
> My final test was a repeat of #2, but with data actively being written
> to the array during the reshape (the previous tests were on an idle,
> unmounted array). This one failed pretty hard, with several processes
> ending up in the D state. I repeated it twice and sysrq-t dumps can be
> found at <http://www.kroptech.com/~adk0212/md-raid5-reshape-wedge.txt>.
> The writeout load was a kernel tree untar started shortly before the
> 'mdadm --grow' command was given. mdadm hung, as did tar. Any process
> which subsequently attmpted to access the array hung as well. A second
> attempt at the same thing hung similarly, although only pdflush shows up
> hung in that trace. mdadm and tar are missing for some reason.

Hmmm... I tried similar things but didn't get this deadlock.  Somehow
the fact that mdadm is holding the reconfig_sem semaphore means that
some IO cannot proceed and so mdadm cannot grab and resize all the
stripe heads... I'll have to look more deeply into this.

> 
> I'm happy to do more tests. It's easy to conjur up virtual disks and
> load them with irrelevant data (like kernel trees ;)

Great.  I'll probably be putting out a new patch set  late this week
or early next.  Hopefully it will fix the issues you can found and you
can try it again..


Thanks again,
NeilBrown
