Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130515AbRCDUTZ>; Sun, 4 Mar 2001 15:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130512AbRCDUTG>; Sun, 4 Mar 2001 15:19:06 -0500
Received: from gear.torque.net ([204.138.244.1]:10258 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S130510AbRCDUTB>;
	Sun, 4 Mar 2001 15:19:01 -0500
Message-ID: <3AA2A120.49509A11@torque.net>
Date: Sun, 04 Mar 2001 15:10:08 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Black <mblack@csihq.com>
CC: Jeremy Hansen <jeremy@xxedgexx.com>, linux-scsi@vger.kernel.org,
        mysql@lists.mysql.com, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <Pine.LNX.4.33L2.0103021033190.6176-200000@srv2.ecropolis.com> <054201c0a33d$55ee5870$e1de11cc@csihq.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is definitely something strange going on here.
As the bonnie test below shows, the SCSI disk used
for my tests should vastly outperform the old IDE one:

              -------Sequential Output-------- ---Sequential Input-- --Random--
Seagate       -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
ST318451LW MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
SCSI      200 21544 96.8 51367 51.4 11141 16.3 17729 58.2 40968 40.4 602.9  5.4

Quantum       -------Sequential Output-------- ---Sequential Input-- --Random--
Fireball      -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
ST3.2A     MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
IDE       200  3884 72.8  4513 86.0  1781 36.4  3144 89.9  4052 95.3 131.5  0.9

I used a program based on Mike Black's "Blah Blah" test
(shown below) in which 200 write()+fdatasync()s are 
performed. Each write() outputs either 20 or 4096 bytes.

On my Celeron 533 Mhz 128 MB ram hardware with an ext2 fs,
the "block" size that is seen by the sd driver for each 
fdatasync() is 4096 bytes. lk 2.4.2 is being used. The 
fs/buffer.c __wait_on_buffer() routine waits for IO 
completion in response to fdatasync(). Timings have been 
done with Andrew Morton's timepegs (units are microseconds). 
Here are the IDE results:

IDE 20*200     Destination  Count       Min       Max   Average       Total
enter __wait_on_buffer:0 ->
  leave __wait_on_buffer:0  200    1,037.23  6,487.72  1,252.19  250,439.80
leave __wait_on_buffer:0 ->
  enter __wait_on_buffer:0  199        7.32     21.05      7.82    1,557.05

IDE 4096*200   Destination  Count       Min       Max   Average       Total
enter __wait_on_buffer:0 ->
  leave __wait_on_buffer:0  200    1,037.06  7,354.21  1,243.78  248,756.64
leave __wait_on_buffer:0 ->
  enter __wait_on_buffer:0  199       23.01     67.32     37.03    7,370.51


So the size of each transfer doesn't matter to this IDE
disk. Now the same test for the SCSI disk:

SCSI(20*200)   Destination  Count     Min       Max   Average       Total
enter __wait_on_buffer:0 ->
   enter sd_init_command:0  200      1.86     13.27      2.05      411.48
enter sd_init_command:0 ->
           enter rw_intr:0  200    320.87  5,398.56  3,417.30  683,461.25
enter rw_intr:0 ->
  leave __wait_on_buffer:0  200      4.04     15.81      4.42      885.73
leave __wait_on_buffer:0 ->
  enter __wait_on_buffer:0  199      8.78     14.39      9.26    1,844.23

SCSI(4096*200) Destination  Count     Min        Max   Average       Total
enter __wait_on_buffer:0 ->
   enter sd_init_command:0  200      1.97      13.20      2.21      443.52
enter sd_init_command:0 ->
           enter rw_intr:0  200    109.53  13,997.50  1,327.47  265,495.87
enter rw_intr:0 ->
  leave __wait_on_buffer:0  200      4.37      22.50      4.75      951.44
leave __wait_on_buffer:0 ->
  enter __wait_on_buffer:0  199     22.40      42.20     24.27    4,831.34

The extra timepegs inside the SCSI subsystem show that 
the IO transaction to that disk really did take that 
long. [Initially I suspected a "plugging" type
elevator bug, but that isn't supported by the above
and various other timepegs not shown.]
Since there is a wait on completion for every write,
tagged queuing should not be involved.

So writing more data to the SCSI disk speeds it up!
I suspect the critical point in the "20*200" test is
that the same sequence of 8 512 byte sectors are being 
written to disk 200 times. BTW That disk spins at
15K rpm so one rotation takes 4 ms and it has a
4 MB cache.

Even though the SCSI disk's "cache" mode page indicates
that the write cache is on, it would seem that writing 
the same sectors continually causes flushes to the medium 
(and hence the associated delay). Here is scu's output 
of the "cache" mode page:

$ scu -f /dev/sda show page cache
Cache Control Parameters (Page 0x8 - Current Values):

Mode Parameter Header:

                      Mode Data Length: 31
                           Medium Type: 0 (Default Medium Type)
             Device Specific Parameter: 0x10 (Supports DPO & FUA bits)
               Block Descriptor Length: 8

Mode Parameter Block Descriptor:

                          Density Code: 0x2
              Number of Logical Blocks: 2289239 (1117.792 megabytes)
                  Logical Block Length: 512

Page Header / Data:
                             Page Code: 0x8
                    Parameters Savable: Yes
                           Page Length: 18
              Read Cache Disable (RCD): No
            Multiplication Factor (MF): Off
              Write Cache Enable (WCE): Yes
      Cache Segment Size Enable (SIZE): Off
                  Discontinuity (DISC): On
      Caching Analysis Permitted (CAP): Disabled
                Abort Pre-Fetch (ABPF): Off
         Initiator Control Enable (IC): Off
              Write Retention Priority: 0 (Not distiguished)
        Demand Read Retention Priority: 0 (Not distiguished)
      Disable Prefetch Transfer Length: 65535 blocks
                      Minimum Prefetch: 0 blocks
                      Maximum Prefetch: 65535 blocks
              Maximum Prefetch Ceiling: 65535 blocks
       Vendor Specific Cache Bits (VS): 0
              Disable Read-Ahead (DRA): No
      Logical Block Cache Segment Size: Off (Cache size interpreted as bytes)
          Force Sequential Write (FSW): Yes (Blocks written in sequential order)
              Number of Cache Segments: 20
                    Cache Segment Size: 0 bytes
                Non-Cache Segment Size: 0 bytes

Perhaps someone has an idea of which of the above settings
can be tweaked to make the write caching work better in
this case.

Doug Gilbert

----------------------------------------------------------
Test program:

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define NUM_BLKS 200
#define BLK_SIZE 4096   /* use either 20 or 4096 */

char buff[BLK_SIZE * NUM_BLKS];

int main(int argc, char * argv[])
{
    int fd, k;

    fd = open("tst.txt", O_WRONLY | O_CREAT, 0644);
    for (k = 0; k < NUM_BLKS; ++k) {
        write(fd, buff + (k * BLK_SIZE), BLK_SIZE);
        fdatasync(fd);
    }
    close(fd);
    return 0;
}


Mike Black wrote:
> 
> Here's a strace -r on IDE:
>      0.001488 write(3, "\214\1\0\0Blah Blah Blah Blah Blah Bla"..., 56) = 56
>      0.000516 fdatasync(0x3)            = 0
>      0.001530 write(3, "\215\1\0\0Blah Blah Blah Blah Blah Bla"..., 56) = 56
>      0.000513 fdatasync(0x3)            = 0
>      0.001555 write(3, "\216\1\0\0Blah Blah Blah Blah Blah Bla"..., 56) = 56
>      0.000517 fdatasync(0x3)            = 0
>      0.001494 write(3, "\217\1\0\0Blah Blah Blah Blah Blah Bla"..., 56) = 56
>      0.000515 fdatasync(0x3)            = 0
>      0.001495 write(3, "\220\1\0\0Blah Blah Blah Blah Blah Bla"..., 56) = 56
>      0.000522 fdatasync(0x3)            = 0
> 
> Here it is on SCSI:
>      0.049285 write(3, "\3\0\0\0Blah Blah Blah Blah Blah Bla"..., 56) = 56
>      0.000689 fdatasync(0x3)            = 0
>      0.049148 write(3, "\4\0\0\0Blah Blah Blah Blah Blah Bla"..., 56) = 56
>      0.000516 fdatasync(0x3)            = 0
>      0.049318 write(3, "\5\0\0\0Blah Blah Blah Blah Blah Bla"..., 56) = 56
>      0.000516 fdatasync(0x3)            = 0
>      0.049343 write(3, "\6\0\0\0Blah Blah Blah Blah Blah Bla"..., 56) = 56
> 
> Looks like a constant 50ms delay on each fdatasync() on SCSI vs .5ms for
> IDE.  Maybe IDE isn't really doing a sync??  I find .5ms to be a little too
> good.
> 
> I did this on 4 different machines with different SCSI cards (include RAID5
> and non-RAID), disks, and IDE drives with the same behavior.
> 
> ________________________________________
> Michael D. Black   Principal Engineer
> mblack@csihq.com  321-676-2923,x203
> http://www.csihq.com  Computer Science Innovations
> http://www.csihq.com/~mike  My home page
> FAX 321-676-2355
> ----- Original Message -----
> From: "Jeremy Hansen" <jeremy@xxedgexx.com>
> To: <linux-scsi@vger.kernel.org>
> Cc: <mysql@lists.mysql.com>; <internals@lists.mysql.com>
> Sent: Friday, March 02, 2001 11:27 AM
> Subject: scsi vs ide performance on fsync's
> 
> We're doing some mysql benchmarking.  For some reason it seems that ide
> drives are currently beating a scsi raid array and it seems to be related
> to fsync's.  Bonnie stats show the scsi array to blow away ide as
> expected, but mysql tests still have the idea beating on plain insert
> speeds.  Can anyone explain how this is possible, or perhaps explain how
> our testing may be flawed?
> 
> Here's the bonnie stats:
> 
> IDE Drive:
> 
> Version 1.00g       ------Sequential Output------ --Sequential
> Input- --Random-
>                     -Per Chr- --Block-- -Rewrite- -Per
> Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec
> %CP
> jeremy         300M  9026  94 17524  12  8173   9  7269  83 23678   7 102.9
> 0
>                     ------Sequential Create------ --------Random
> Create--------
>                     -Create-- --Read--- -Delete-- -Create-- --Read--- -Delet
> e--
>               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec
> %CP
>                  16   469  98  1476  98 16855  89   459  98  7132  99   688
> 25
> 
> SCSI Array:
> 
> Version 1.00g       ------Sequential Output------ --Sequential
> Input- --Random-
>                     -Per Chr- --Block-- -Rewrite- -Per
> Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec
> %CP
> orville        300M  8433 100 134143  99 127982  99  8016 100 374457  99
> 1583.4   6
>                     ------Sequential Create------ --------Random
> Create--------
>                     -Create-- --Read--- -Delete-- -Create-- --Read--- -Delet
> e--
>               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec
> %CP
>                  16   503  13 +++++ +++   538  13   490  13 +++++ +++   428
> 11
> 
> So...obviously from bonnie stats, the scsi array blows away the ide...but
> using the attached c program, here's what we get for fsync stats using the
> little c program I've attached:
> 
> IDE Drive:
> 
> jeremy:~# time ./xlog file.out fsync
> 
> real    0m1.850s
> user    0m0.000s
> sys     0m0.220s
> 
> SCSI Array:
> 
> [root@orville mysql_data]# time /root/xlog file.out fsync
> 
> real    0m23.586s
> user    0m0.010s
> sys     0m0.110s
> 
> I would appreciate any help understand what I'm seeing here and any
> suggestions on how to improve the performance.
> 
> The SCSI adapter on the raid array is an Adaptec 39160, the raid
> controller is a CMD-7040.  Kernel 2.4.0 using XFS for the filesystem on
> the raid array, kernel 2.2.18 on ext2 on the IDE drive.  The filesystem is
> not the problem, as I get almost the exact same results running this on
> ext2 on the raid array.
> 
> Thanks
> -jeremy
> 
> --
> this is my sig.

