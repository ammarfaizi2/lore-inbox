Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTELCAS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 22:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTELCAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 22:00:17 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:51408 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S261860AbTELCAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 22:00:12 -0400
Date: Sun, 11 May 2003 22:10:07 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Two RAID1 mirrors are faster than three
To: linux-raid <linux-raid@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305112212_MC3-1-386B-32BF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  All these tests were run on 2.4.21-rc2-ac1...

  We start out with a three disk raid1 array in failure mode:
        md21 : active raid1 hdi9[1] hdg9[2]
              3145856 blocks [3/2] [_UU]
        
  There are three 500 MiB contiguous files in the volume root:
        -rw-r--r--    1 root     root     524288000 May 11 13:53 file1
        -rw-r--r--    1 root     root     524288000 May 11 13:54 file2
        -rw-r--r--    1 root     root     524288000 May 11 13:55 file3

  First test is a single sequential stream:
        # umount /mnt/md21; mount /mnt/md21
        # time dd if=/mnt/md21/file1 of=/dev/null bs=64k &
        real    0m18.230s   <==== 27.5 MiB/s 
        user    0m0.020s
        sys     0m3.760s

  Now two streams:
        # umount /mnt/md21; mount /mnt/md21
        # time dd if=/mnt/md21/file1 of=/dev/null bs=64k &
        # time dd if=/mnt/md21/file2 of=/dev/null bs=64k &
        real    0m18.065s   <==== 27.6 MiB/s
        user    0m0.040s
        sys     0m4.280s
        real    0m23.197s   <==== 21.6 MiB/s
        user    0m0.020s
        sys     0m4.250s

  Add the third disk back into the array:
        # raidhotadd /dev/md21 /dev/hde9
        [rebuilt 3000MiB in 313s == (3000+3000)/313 == 19MiB/s throughput]
        
  Now rerun the two streams test:
        # umount /mnt/md21; mount /mnt/md21
        # time dd if=/mnt/md21/file1 of=/dev/null bs=64k &
        # time dd if=/mnt/md21/file2 of=/dev/null bs=64k &
        real    0m50.336s   <==== 9.94 MiB/s (!)
        user    0m0.030s
        sys     0m4.350s
        real    0m50.431s   <==== 9.91 MiB/s (!)
        user    0m0.030s
        sys     0m4.200s

  So 50% more hardware (disks, channels) gives a 60% performance drop
  when using raid1 with sequential reads... and raid1.c:read_balance()
  is the culprit.


Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
  
HPT370: IDE controller at PCI slot 00:0d.0  
HPT370: chipset revision 3

PDC20262: IDE controller at PCI slot 00:10.0
PDC20262: chipset revision 1

hde: MAXTOR 4K060H3, ATA DISK drive
hdg: MAXTOR 4K060H3, ATA DISK drive
hdi: MAXTOR 4K060H3, ATA DISK drive

 hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 hde9 hde10 >
 hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 hdg6 hdg7 hdg8 hdg9 hdg10 >
 hdi: hdi1 hdi2 hdi3 hdi4 < hdi5 hdi6 hdi7 hdi8 hdi9 hdi10 >
 
