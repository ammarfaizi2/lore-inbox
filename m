Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130468AbRACMDv>; Wed, 3 Jan 2001 07:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130812AbRACMDl>; Wed, 3 Jan 2001 07:03:41 -0500
Received: from p3EE00C31.dip.t-dialin.net ([62.224.12.49]:30848 "EHLO
	gate2.private.net") by vger.kernel.org with ESMTP
	id <S130468AbRACMDZ>; Wed, 3 Jan 2001 07:03:25 -0500
Message-Id: <200101031105.f03B5Nx00953@gate2.private.net>
From: "Otto Meier" <gf435@gmx.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 03 Jan 2001 12:05:37 +0100
Reply-To: "otto meier" <gf435@gmx.net>
X-Mailer: PMMail 2000 Professional (2.10.2010) For Windows 98 (4.10.2222)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: kernel freeze on 2.4.0.prerelease (smp,raid5)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jan 2001 18:19:41 +0100, Otto Meier wrote:

>>Dual Celeron (SMP,raid5)
>> As stated in my first mail I run actually my raid5 devices in degrated mode
>> and as I remenber there has been some raid5 stuff changed between 
>> test13p3 and newer kernels.

>So tell us, why do you run your raid5 devices in degraded mode?? I
>cannot be good for performance, and certainly isn't good for
>redundancy!!! But I'm not complaining as you found a bug...

I am actually in the middle of the conversion process to raid5 but it takes a while
I am to lazy :-) to get the next drive free to get raid5 into the fully running mode.  

>> Hope this gives someone an idea?

>Yep. This, combined with a related bug report from n0ymv@callsign.net
>strongly suggests the following patch.
>Writes to the failed drive are never completing, so you eventually
>run out of stripes in the stripe cache and you block waiting for a
>stripe to become free. 

>Please test this and confirm that it works.

It really did the trick you are great.
The system runs now for over a hour otherwise it would have crashed after some 
seconds (20 to 30).

btw what does this message in boot.msg mean?

<4>raid5: switching cache buffer size, 4096 --> 1024
<4>raid5: switching cache buffer size, 1024 --> 4096

the log of the raid init you find below.

Thanks again

Otto

--- ./drivers/md/raid5.c 2001/01/03 09:04:05 1.1
+++ ./drivers/md/raid5.c 2001/01/03 09:04:13
@@ -1096,8 +1096,10 @@
bh->b_rdev = bh->b_dev;
bh->b_rsector = bh->b_blocknr * (bh->b_size>>9);
generic_make_request(action[i]-1, bh);
- } else
+ } else {
PRINTK("skip op %d on disc %d for sector %ld\n", action[i]-1, i, sh->sector);
+ clear_bit(BH_Lock, &bh->b_state);
+ }
}
}

>Raid5 (3 drives actuall 2 drives degra. mode)
<6>raid5: device hdg7 operational as raid disk 1
<6>raid5: device hde7 operational as raid disk 0
<1>raid5: md1, not all disks are operational -- trying to recover array
<6>raid5: allocated 3264kB for md1
<1>raid5: raid level 5 set md1 active with 2 out of 3 devices, algorithm 2
<4>RAID5 conf printout:
<4> --- rd:3 wd:2 fd:1
<4> disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde7
<4> disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg7
<4> disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev 00:00]
<4>RAID5 conf printout:
<4> --- rd:3 wd:2 fd:1
<4> disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde7
<4> disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg7
<4> disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev 00:00]
<6>md: updating md1 RAID superblock on device
<4>hdg7 [events: 00000087](write) hdg7's sb offset: 24989696
<6>md: recovery thread got woken up ...
<3>md1: no spare disk to reconstruct array! -- continuing in degraded mode
<6>md: recovery thread finished ...
<4>hde7 [events: 00000087](write) hde7's sb offset: 24989696
<4>.
<4>... autorun DONE.





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
