Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317786AbSHCVMt>; Sat, 3 Aug 2002 17:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317815AbSHCVMt>; Sat, 3 Aug 2002 17:12:49 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:31750 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S317786AbSHCVMs>; Sat, 3 Aug 2002 17:12:48 -0400
Date: Sat, 3 Aug 2002 23:16:19 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Cc: Lars Schmitt <lschmitt@e18.physik.tu-muenchen.de>
Subject: large file IO starving ls -l
Message-ID: <Pine.LNX.4.44.0208032253260.23040-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel hackers!

While investigating some issues with our computing farm (*) I came across
this issue: when writing a 2GB file with 'dd if=/dev/zero of=bigfile
bs=1024k count=2048' onto a 3ware RAID (5*Maxtor 160GB, RAID-5), ls -l in
that directory sometimes takes some minutes to complete, thereby
presenting obviously the file sizes corresponding to the starting time of
the command. The directory has less than ten entries, the filesystem is 
reiserfs, kernel 2.4.18-3 from RedHat. Nothing else going on during the 
test.

I modified the 3ware driver to provide information on how long each 
command takes from posting to the controller to receiving the answer via 
an interrupt:

scsi0: 3ware Storage Controller
Driver version: 1.02.00.025
Current commands posted:         0
Max commands posted:           255
Current pending commands:        0
Max pending commands:            0
Last sgl length:                 7
Max sgl length:                 32
Last sector count:              56
Max sector count:              256
Resets:                          0
Aborts:                          0
AEN's:                           0
      time    read   write   query  capcty   ioctl
        10     843      14       1       1      17
        20      86      23       0       0       0
        40      17      16       0       0       0
        80      23      54       0       0       0
       160      59      41       0       0       0
       320     124     269       0       0       0
       640     771    2794       0       0       0
      1280    1386   10917       0       0       2
      2560    1598    3410       0       0       0
      5120       0      35       0       0       0
     10240       0       0       0       0       0
     20480       0       0       0       0       0
     40960       0       0       0       0       0
     81920       0       0       0       0       0
gliding avg   2036    2124       0       0      11

The time is given in ms (actually jiffies differences, rounded down
towards the next power of two, then multiplied by ten), the gliding 
average gives an exponentially weighted average with a lifetime of 200. 
This sample is from a mount (the reads) and the aforementioned 2GB write. 
During the writing, 255 commands are posted, nearly all with 256 sectors 
each, so that the data rate is about 16MB/s which also fits the 
measurement with the wall clock.

Now the question is: who keeps ls from returning? The command never hits 
the disk (reads in above histogram do not increase), but stays for many 
seconds (up to one minute) in state D.

Ciao,
					Roland

(*) It's not actually a CPU intensive task: we call these machines 
eventbuilders as they gather data from our experiment and write it to disk 
with an average rate of about 5-10MB/s. The relevance of the ls problem is 
that sometimes also these eventbuilding jobs get stuck for several 
seconds and are afterwards unable to catch up again.

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

