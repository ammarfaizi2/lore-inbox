Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261378AbSJFQC0>; Sun, 6 Oct 2002 12:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbSJFQC0>; Sun, 6 Oct 2002 12:02:26 -0400
Received: from synapse.t30.physik.tu-muenchen.de ([129.187.186.221]:19333 "EHLO
	synapse.t30.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S261378AbSJFQCY>; Sun, 6 Oct 2002 12:02:24 -0400
To: linux-kernel@vger.kernel.org
Subject: partly solved IO performance problems in 2.5.40 when writing to DVD-RAM/ZIP
CC: andrea@suse.de
Content-Type: text/plain; charset=US-ASCII
From: Moritz Franosch <jfranosc@physik.tu-muenchen.de>
Date: 06 Oct 2002 18:08:00 +0200
Message-ID: <rxx8z1bim8v.fsf@synapse.t30.physik.tu-muenchen.de>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

In
http://groups.google.de/groups?selm=20020416165358.E29747%40dualathlon.random&output=gplain
Andrea Arcangeli forwarded my previous mail to the Linux kernel
mailing list. I have reported a serious IO problem of 2.4.18 and
2.4.19-pre5 where writing to DVD-RAM blocked reading from HDD almost
totally.

Here is the update of the benchmark for 2.5.40. It has _much_ improved
but is not yet where it could be. The column "factor 2.5.40" contains
the factor 2.5.40 is slower than it could theoretically be (so 1 would
be ideal and, in my opinion, achievable). The factor for 2.4.19-pre5
is given for comparison.


nr bench read      write     time   expected factor factor      same IDE
                             2.5.40 2.5.40   2.5.40 2.4.19-pre5 channel

1  dd    30GB HDD  DVD-RAM   187    86       2.2    8.2         *
2  dd    120GB HDD DVD-RAM    57    31       1.8    14 
3  dd    30GB HDD  ZIP        87    86       1.0    4.0
4  dd    120GB HDD ZIP        75    31       2.4    7.8         * 
5  dd    30GB HDD  120GB HDD 121    86       1.4    1.5
6  dd    120GB HDD 30GB HDD   65    31       2.1    2.2
7  cp    30GB HDD  120GB HDD  94    86       1.1    1.3
8  cp    120GB HDD 30GB HDD   69    62       1.1    1.3


The column "time 2.4.40" contains the execution time for the
benchmark, and "expected 2.4.40" contains the execution time I would
have expected for an ideal kernel.

The "dd" benchmark reads (with dd) a 1 GB file from the device in
column "read" while writing (also with dd) to the device in column
"write". 

I have four IDE devices installed in that system:
hda: 30 GB IDE HDD 5400 rpm
hdb: 9.4 GB ATAPI DVD-RAM
hdc: 120 GB IDE HDD 7200 rpm
hdd: 100 MB ATAPI ZIP

The column "same IDE channel" indicates whether the device written to
an read from are on the same IDE controller.

Theoretically, the two devices (e.g. the 120 GB HDD and the DVD-RAM in
nr. 2) are independent (at least when they are on a different IDE
controller), so the read should perform as good as without the
additional writing activity (31 seconds, as given in the column
"expected"). But in reality the read takes 1.8 times as long. With
2.4.50, there could be performance gains up to a factor of 2.4 (test
nr. 4). But that's _much_ better than 2.4.19-pre5 where performance
gains of up to a factor of 14 (test nr. 2) were possible.

The "cp" benchmark simply copies a 1 GB file from "read" to "write"
and performs almost as good (factor 1.1) as it could (factor 1) with
2.4.50. Good work!

Here are the numbers for 2.4.18 and 2.4.19-pre5 for comparison.


nr bench read       write      time    time        expected    factor
                               2.4.18  2.4.19-pre5 2.4.19-pre5 2.4.19-pre5
1  dd    30GB HDD   DVD-RAM    278     490         60          8.2
2  dd    120GB HDD  DVD-RAM    197     438         32          14
3  dd    30GB HDD   ZIP        158     239         60          4.0
4  dd    120GB HDD  ZIP        142     249         32          7.8
5  dd    30GB HDD   120GB HDD   87      89         60          1.5
6  dd    120GB HDD  30GB HDD    66      69         32          2.2
7  cp    30GB HDD   120GB HDD   97      77         60          1.3
8  cp    120GB HDD  30GB HDD    78      65         50          1.3


I don't know why the 30 GB HDD takes 86 seconds for reading a 1 GB
file on 2.5.40 whereas it only took 60 seconds on 2.4.19-pre5. The 120
GB HDD has almost the same reading speed on 2.5.40 (31 seconds) as on
2.4.19-pre5 (32 seconds).

I ran the benchmarks for 2.5.40 just after booting into runlevel 1
(single user mode) on a Suse 8.0 system. The system is a Athlon 700
MHz, KT133 chipset, 256 MB RAM, 256 MB swap.


The "dd" benchmark is:

#!/bin/bash

dd if=/dev/zero of=$1/tmp bs=1000000 &
# a sleep is sometimes necessary for bad performance (to fill cache?)
sleep 30
time dd if=$2 of=/dev/null bs=1000000


Filesystems are:
jfranosc@nomad:~ > mount
/dev/hda3 on / type reiserfs (rw,noatime)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/hda1 on /boot type ext2 (rw,noatime)
/dev/hda6 on /home type ext2 (rw,noatime)
/dev/hda7 on /lscratch type reiserfs (rw,noatime)
/dev/hdc2 on /lscratch2 type reiserfs (rw,noatime)
shmfs on /dev/shm type shm (rw)
automount(pid341) on /net type autofs (rw,fd=5,pgrp=341,minproto=2,maxproto=4)
automount(pid334) on /misc type autofs (rw,fd=5,pgrp=334,minproto=2,maxproto=4)
/dev/hdd4 on /mzip type vfat (rw,noexec,nosuid,nodev,user=jfranosc)
/dev/sr0 on /dvd type ext2 (rw,noexec,nosuid,nodev,user=jfranosc)


Boot parameters in /etc/lilo.conf:
append = "hdb=ide-scsi hdd=ide-floppy"
 

So, kernel 2.5.40 has improved much over 2.4.18 and 2.4.19-pre5, but
there is still room for improvements in this benchmark for up to a
factor of more than 2.

If you have patches that you think should be tested, I'd like to try
them.


Thank you for your attention,

Moritz


-- 
Dipl.-Phys. Moritz Franosch
http://Franosch.org
