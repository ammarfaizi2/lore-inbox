Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267434AbSLFAHt>; Thu, 5 Dec 2002 19:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267455AbSLFAHt>; Thu, 5 Dec 2002 19:07:49 -0500
Received: from mailhub2.une.edu.au ([129.180.4.202]:44552 "HELO
	mailhub2.une.edu.au") by vger.kernel.org with SMTP
	id <S267434AbSLFAFz>; Thu, 5 Dec 2002 19:05:55 -0500
Date: Fri, 6 Dec 2002 11:13:26 +1100
From: Norman Gaywood <norm@turing.une.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206111326.B7232@turing.une.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I have a trigger for a VM bug in the RH kernel-bigmem-2.4.18-18

The system is a 4 processor, 16GB memory Dell PE6600 running RH8.0 +
errata. More details at the end of this message.

By doing a large copy I can trigger this problem in about 30-40 minutes. At
the end of that time, kswapd will start to get a larger % of CPU and
the system load will be around 2-3. The system will feel sluggish at an
interactive shell and it will take several seconds before a command like
top would start to display. If I let it go for another 30 minutes the
system is unusable were it could take 10 minutes or more to do simple
commands. If I let it go for several hours after that, the following
messages can appear on the console depending on the type of copy:

ENOMEM in journal_get_undo_access_Rsmp_df5dec49, retrying.

or

EMOMEM in do_get_write_access, retrying.

The problem can be triggered by almost any type of copy command. In
particular, this command can trigger it:

   tar cf /dev/tape .

for . large enough. Unfortunately this was how I was intending to backup
the system.

"Large enough" is several gigabytes. It also seems to depend on how much
memory is used. In particular, how much memory is used by cache. Also in
the equation is the number of files. Copying one big file does not seem
to trigger the problem. I initially discovered the problem when doing an
rsync copy over a network of the user home directories.

Can it be stopped? Yes. On the linux-poweredge@dell.com mailing list,
Stephan Wonczak suggested that I should put the system under some memory
pressure while doing the copy. The program he supplied used about 750
megabytes just to use some memory. I tried running this at 10 second
intervals while doing a copy but it did not help. Since the system has
16 Gig of memory, I tried to give it some real memory pressure and ran
7 processes that used 1.8G each like this:

#!/bin/sh
SLEEP=600
COUNT=20

while [ `expr $COUNT - 1` != 0 ]
do
   date
   # 2000 by 1_000_000 seems to be a 1.8G process
   perl -e '$i=2000;while ($i--){ $a[$i]="x"x1_000_000; }' &
   perl -e '$i=2000;while ($i--){ $a[$i]="x"x1_000_000; }' &
   perl -e '$i=2000;while ($i--){ $a[$i]="x"x1_000_000; }' &
   perl -e '$i=2000;while ($i--){ $a[$i]="x"x1_000_000; }' &
   perl -e '$i=2000;while ($i--){ $a[$i]="x"x1_000_000; }' &
   perl -e '$i=2000;while ($i--){ $a[$i]="x"x1_000_000; }' &
   perl -e '$i=2000;while ($i--){ $a[$i]="x"x1_000_000; }'
   sleep $SLEEP
done

This bought the cache down to about 3-4 Gig used after it ran. With this
running the system performed the copy with no problems! No doubt there
is a happy medium between these two extremes.

There is a suggestion that I may not see this problem when the system is
under real load. Since I am only setting up the system at the moment there
are no users giving the system something to do. The copy is the only real
work during these tests. I find it difficult to say "she'll be right",
(as we do in Aus) and throw the system into production hoping that it
will just work.

So what do I do now? I have a what I believe a trigger for a VM problem
in a widely used version of linux. Anyone have some patches for me to
try that won't take me too far from the RH 8.0 base system.

Here are the system details:

PE6600 running RH 8.0 with latest errata. Note that I have upgraded to
kernel 2.4.18-19.7.tg3.120bigmem which I understand to be the latest
RH8 errata kernel + patches to stop the tg3 hanging problem. This came
from http://people.redhat.com/jgarzik/tg3/. I have also tried the latest
RH errata kernel using the bcm5700 driver and it has the same problem.

HW includes:
Adaptec AIC-7892 SCSI BIOS v25704
3 Adaptex SCSI Card 39160 BIOS v2.57.2S2
8 HITACHI DK32DJ-72MC 160 drives
2 Quantum ATLAS10K3-73-SCA 160 drives

uname -a
Linux alan.une.edu.au 2.4.18-19.7.tg3.120bigmem #1 SMP Mon Nov 25 15:15:29 EST 2002 i686 i686 i386 GNU/Linux

cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  16671522816 444915712 16226607104        0 136830976 56520704
Swap: 34365202432        0 34365202432
MemTotal:     16280784 kB
MemFree:      15846296 kB
MemShared:           0 kB
Buffers:        133624 kB
Cached:          55196 kB
SwapCached:          0 kB
Active:         249984 kB
Inact_dirty:     18088 kB
Inact_clean:       480 kB
Inact_target:    53708 kB
HighTotal:    15597504 kB
HighFree:     15434932 kB
LowTotal:       683280 kB
LowFree:        411364 kB
SwapTotal:    33559768 kB
SwapFree:     33559768 kB
Committed_AS:   177044 kB

df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/md2               8254136   2825112   5009736  37% /
/dev/md0                101018     25627     70175  27% /boot
/dev/md6             211671024  88323536 112595200  44% /home
/dev/md1              16515968   1785024  13891956  12% /opt
none                   8140392         0   8140392   0% /dev/shm
/dev/md4               4126976    149944   3767392   4% /tmp
/dev/md3              16515968    168172  15508808   2% /var
/dev/md5               8522932   1596520   6493468  20% /var/spool/mail
/dev/sdh1             70557052     32832  66940124   1% /.automount/alan/disks/alan/h1
/dev/sdi1             70557052  22856784  44116172  35% /.automount/alan/disks/alan/i1
/dev/sdj1             70557052  13619440  53353516  21% /.automount/alan/disks/alan/j1

df -i
Filesystem            Inodes   IUsed   IFree IUse% Mounted on
/dev/md2             1048576  167838  880738   17% /
/dev/md0               26104      59   26045    1% /boot
/dev/md6             26886144 1941926 24944218    8% /home
/dev/md1             2101152   49285 2051867    3% /opt
none                 2035098       1 2035097    1% /dev/shm
/dev/md4              524288      26  524262    1% /tmp
/dev/md3             2101152    4877 2096275    1% /var
/dev/md5             1082720    2535 1080185    1% /var/spool/mail
/dev/sdh1            8962048      12 8962036    1% /.automount/alan/disks/alan/h1
/dev/sdi1            8962048  712400 8249648    8% /.automount/alan/disks/alan/i1
/dev/sdj1            8962048   10497 8951551    1% /.automount/alan/disks/alan/j1

-- 
Norman Gaywood -- School of Mathematical and Computer Sciences
University of New England, Armidale, NSW 2351, Australia
norm@turing.une.edu.au     http://turing.une.edu.au/~norm
Phone: +61 2 6773 2412     Fax: +61 2 6773 3312
