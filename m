Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280114AbRKIVEX>; Fri, 9 Nov 2001 16:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280120AbRKIVEO>; Fri, 9 Nov 2001 16:04:14 -0500
Received: from jericho.gospelcom.net ([204.253.132.2]:15378 "HELO
	gospelcom.net") by vger.kernel.org with SMTP id <S280114AbRKIVD6>;
	Fri, 9 Nov 2001 16:03:58 -0500
Date: Fri, 9 Nov 2001 16:04:11 -0500 (EST)
From: Brian DeFeyter <bdf@gospelcom.net>
X-X-Sender: <bdf@agabus.gf.gospelcom.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RAID5 reconstruction problem
In-Reply-To: <Pine.LNX.4.33.0111091403320.8002-100000@agabus.gf.gospelcom.net>
Message-ID: <Pine.LNX.4.33.0111091556440.8339-100000@agabus.gf.gospelcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More information. Here's the point at which it breaks:

kernel: RAID5 conf printout: 
kernel: --- rd:6 wd:5 fd:1 
kernel: disk 0, s:0, o:1, n:0 rd:0 us:1 dev:sdc1 
kernel: disk 1, s:0, o:0, n:1 rd:1 us:1 dev:[dev 00:00] 
kernel: disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sde1 
kernel: disk 3, s:0, o:1, n:3 rd:3 us:1 dev:sdf1 
kernel: disk 4, s:0, o:1, n:4 rd:4 us:1 dev:sdg1 
kernel: disk 5, s:0, o:1, n:5 rd:5 us:1 dev:sdh1 
kernel: md: syncing RAID array md7 
kernel: md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc. 
kernel: md: using maximum available idle IO 
bandwith (but not more than 100000 KB/sec) for reconstruction. 
kernel: md: using 124k window, over a total of 35840896 blocks. 
kernel: md: updating md7 RAID superblock on device 
kernel: sdd1 [events: 00000016](write) sdd1's sb offset: 35840896 
kernel: sdh1 [events: 00000016](write) sdh1's sb offset: 35840896 
kernel: sdg1 [events: 00000016](write) sdg1's sb offset: 35840896 
kernel: sdf1 [events: 00000016](write) sdf1's sb offset: 35840896 
kernel: sde1 [events: 00000016](write) sde1's sb offset: 35840896 
kernel: sdc1 [events: 00000016](write) sdc1's sb offset: 35856960 
kernel: . 
kernel: SCSI disk error : host 1 channel 0 id 3 lun 0 return code = 8000002 
kernel: [valid=0] Info fld=0x0, Current sd08:31: sense key Aborted Command 
kernel: Additional sense indicates Scsi parity error 
kernel: I/O error: dev 08:31, sector 2264 
kernel: interrupting MD-thread pid 10 
kernel: raid5: Disk failure on spare sdd1 
kernel: md_do_sync() got signal ... exiting 

Again, I do know that sdd1 is fine, as I pounded it quite heavily a few 
times now in a standard ext2 mount. The array's data also doesn't have any 
errors while running in degraded mode.

 - bdf


On Fri, 9 Nov 2001, Brian DeFeyter wrote:

> 
> Last night I had 2 drives in a 6 drive array instantly fail and cause my 
> array to crash. I suspect that the channel these 2 drives were on was the 
> cause as these were the only 2 drives on that channel.
> 
> Here's my current /etc/raidtab for the failed /dev/md7:
> 
> raiddev             /dev/md7
> raid-level                  5
> nr-raid-disks               6
> nr-spare-disks              0
> persistent-superblock       1
> parity-algorithm            left-symmetric
> chunk-size                  32
> device              /dev/sdc1
> raid-disk           0
> device              /dev/sdd1
> raid-disk           1
> device              /dev/sde1
> raid-disk           2
> device              /dev/sdf1
> raid-disk           3
> device              /dev/sdg1
> raid-disk           4
> device              /dev/sdh1
> raid-disk           5
> 
> sdc1 and sdd1 where the failed drives. I used the 'fail one drive in 
> /etc/raidtab' trick on sdd1 to bring the array back which worked fine. 
> Then remarked sdd1 as a 'raid-disk' instead of 'failed-disk' and then did 
> a 'raidhotadd /dev/md7 /dev/sdd1' which started the recontruction.
> 
> About 1/2 way through, /dev/sdd1 died with the failure diagnostic led 
> blinking. I swapped it out with a new drive, paritioned it (Linux, not 
> auto-detect), formatted it, and then attempted a 'raidhotadd /dev/md7 
> /dev/sdd1'
> 
> Unfortunately, the raidhotadd appears to fail right away. I get a couple 
> hundred lines of kernel messages with 'DISK' and raidconf printouts. A gut 
> feeling tells me it doesn't like the superblock on the new drive. However,
> I do know that the drive itself is fine since I manually mounted it and
> ran a few tests on it before re-formatting it and putting it into the
> array. If anyone wants all the kernel messages, I'll send them along.
> 
> 
> Thanks,
> 
>  - bdf
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

