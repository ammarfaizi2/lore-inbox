Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274298AbRJAA2y>; Sun, 30 Sep 2001 20:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274299AbRJAA2p>; Sun, 30 Sep 2001 20:28:45 -0400
Received: from cs666814-197.austin.rr.com ([66.68.14.197]:19441 "EHLO
	kinison.puremagic.com") by vger.kernel.org with ESMTP
	id <S274298AbRJAA2i>; Sun, 30 Sep 2001 20:28:38 -0400
Date: Sun, 30 Sep 2001 19:29:06 -0500 (CDT)
From: Evan Harris <eharris@puremagic.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RAID5: mkraid --force /dev/md0 doesn't work properly
Message-ID: <Pine.LNX.4.33.0109301841220.2459-100000@kinison.puremagic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And yes, I'm using the real --force option.  :)

I have a 6 disk RAID5 scsi array that had one disk go offline through a
dying power supply, taking the array into degraded mode, and then another
went offline a couple of hours later from what I think was a loose cable.

The first drive to go offline was /dev/sde1.
The second to go offline was /dev/sdd1.

Both drives are actually fine after fixing the connection problems and a
reboot, but since the superblocks are out of sync, it won't init.

Here's the output from a raidstart /dev/md0:

(read) sdd1's sb offset: 35840896 [events: 00000009]
(read) sde1's sb offset: 35840896 [events: 00000008]
(read) sdf1's sb offset: 35840896 [events: 0000000b]
(read) sdg1's sb offset: 35840896 [events: 0000000b]
(read) sdh1's sb offset: 35840896 [events: 0000000b]
(read) sdi1's sb offset: 35840896 [events: 0000000b]
autorun ...
considering sdi1 ...
  adding sdi1 ...
  adding sdh1 ...
  adding sdg1 ...
  adding sdf1 ...
  adding sde1 ...
  adding sdd1 ...
created md0
bind<sdd1,1>
bind<sde1,2>
bind<sdf1,3>
bind<sdg1,4>
bind<sdh1,5>
bind<sdi1,6>
running: <sdi1><sdh1><sdg1><sdf1><sde1><sdd1>
now!
sdi1's event counter: 0000000b
sdh1's event counter: 0000000b
sdg1's event counter: 0000000b
sdf1's event counter: 0000000b
sde1's event counter: 00000008
sdd1's event counter: 00000009
md: superblock update time inconsistency -- using the most recent one
freshest: sdi1
md: kicking non-fresh sde1 from array!
unbind<sde1,5>
export_rdev(sde1)
md: kicking non-fresh sdd1 from array!
unbind<sdd1,4>
export_rdev(sdd1)
md0: removing former faulty sdd1!
md0: removing former faulty sde1!
md0: max total readahead window set to 5120k
md0: 5 data-disks, max readahead per data-disk: 1024k
raid5: device sdi1 operational as raid disk 5
raid5: device sdh1 operational as raid disk 4
raid5: device sdg1 operational as raid disk 3
raid5: device sdf1 operational as raid disk 2
raid5: not enough operational devices for md0 (2/6 failed)
RAID5 conf printout:
 --- rd:6 wd:4 fd:2
 disk 0, s:0, o:0, n:0 rd:0 us:1 dev:[dev 00:00]
 disk 1, s:0, o:0, n:1 rd:1 us:1 dev:[dev 00:00]
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:sdf1
 disk 3, s:0, o:1, n:3 rd:3 us:1 dev:sdg1
 disk 4, s:0, o:1, n:4 rd:4 us:1 dev:sdh1
 disk 5, s:0, o:1, n:5 rd:5 us:1 dev:sdi1
raid5: failed to run raid set md0
pers->run() failed ...
do_md_run() returned -22
md0 stopped.
unbind<sdi1,3>
export_rdev(sdi1)
unbind<sdh1,2>
export_rdev(sdh1)
unbind<sdg1,1>
export_rdev(sdg1)
unbind<sdf1,0>
export_rdev(sdf1)
... autorun DONE.

I set the first disk that went offline out with a failed-disk directive, and
tried to recover with a:

mkraid --force /dev/md0

I'm _positive_ that the /etc/raidtab is correct, but it fails to force the
update with:

DESTROYING the contents of /dev/md0 in 5 seconds, Ctrl-C if unsure!
handling MD device /dev/md0
analyzing super-block
raid_disk conflict on /dev/sde1 and /dev/sdi1 (1)
mkraid: aborted, see the syslog and /proc/mdstat for potential clues.

Nothing is in syslog, and
mdstat only has:

Personalities : [raid5]
read_ahead not set
unused devices: <none>

Why won't --force go ahead and force the reset of the superblocks?  Even
though I'm sure there will be some filesystem inconsistencies, they should
be minor, and nearly all of the data should be recoverable if only mkraid
would go ahead and force it, so that it could be raidstart'ed.

Is there any lower level tool that will do what mkraid --force should but
isn't?  The data on this raid represents a large chunk of time invested.

Any help would be much appreciated.  Web searches have not turned up any
useful info, and I can't seem to find a more recent version of raidtools
than 0.90.0 from 990824.

For info, here is my raidtab:

raiddev /dev/md0
        raid-level              5
        nr-raid-disks           6
        nr-spare-disks          0
        chunk-size              256
        persistent-superblock   1
        device                  /dev/sdd1
        raid-disk               0
        device                  /dev/sde1
        raid-disk               1
        device                  /dev/sdf1
        raid-disk               2
        device                  /dev/sdg1
        raid-disk               3
        device                  /dev/sdh1
        raid-disk               4
        device                  /dev/sdi1
        raid-disk               5
        failed-disk     1

Thanks in advance.

Evan

-- 
| Evan Harris - eharris@puremagic.com - All flames to /dev/nul
|
| RIP Bill Hicks - "I don't mean to sound cold or cruel or vicious... but I
|                   am, so that's the way it comes out."


