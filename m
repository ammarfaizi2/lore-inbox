Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315708AbSHAQul>; Thu, 1 Aug 2002 12:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSHAQul>; Thu, 1 Aug 2002 12:50:41 -0400
Received: from lucidpixels.com ([66.45.37.187]:33230 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S315708AbSHAQuj>;
	Thu, 1 Aug 2002 12:50:39 -0400
Date: Thu, 1 Aug 2002 12:54:06 -0400 (EDT)
From: jpiszcz@lucidpixels.com
To: linux-kernel@vger.kernel.org
cc: lftp@uniyar.ac.ru, <lftp-devel@uniyar.ac.ru>, <apiszcz@mitre.org>
Subject: Nasty ext2fs bug!
Message-ID: <Pine.LNX.4.44.0208011150310.17729-100000@lucidpixels.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Topic: Nasty ext2fs bug.
 Summary: When using lftp with the pget -n option for large files, once the
          file is complete the problem begins.  If you try to copy, ftp, or
          pretty much anything that involves reading the file, it is "stuck"
          at a rate of 800KB/s to 1600KB/s.
 Problem: The pget -n feature of lftp is very nice if you want to maximize
          your download bandwidth, however, if getting a large file, such
          as the one I am getting in the example, once the file is successfully
          retrived, transferring it to another HDD or FTPing it to another
          computer is very slow (800KB-1600KB/s).
Solution: Haven't quite found one yet, other than the obvious, copying the
          file to another place, and then using it, or moving it to another
          partition and then moving it back.
 Example: An example is provided below.
  System: Information is provided at the bottom.
Question: What could be causing this, could lftp be fragmenting the file
          all over the place causing horrible transfer rates?

-----------------------------------------------------
Step 1: Create large file on remote shell.
-----------------------------------------------------
[war@iceberg war]$ dd if=/dev/zero of=1GB bs=1M count=1024
1024+0 records in
1024+0 records out

[war@iceberg war]$ ls -lh 1GB
-rw-r--r--    1 war      users        1.0G Aug  1 07:19 1GB
-----------------------------------------------------
Step 2: Download via lftp using: pget -n 20.
-----------------------------------------------------
        This opens 20 simultaneous connections and grabs ranges of the
file
        per each connection.

        Wait for the download to complete.
        [0] pget -n 20 1GB
        `1GB', got 17998728 of 1073741824 (1%) 351.5K/s eta:68m
-----------------------------------------------------
Step 3: I'll run two tests, a) copy file to other HDD (IBM 5400RPM)
                            b) ftp file to other machine (100MBIT)
-----------------------------------------------------
a) [war@p300 x]$ /usr/bin/time cp 1GB /x2
0.61user 29.44system 14:40.52elapsed 3%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (97major+14minor)pagefaults 0swaps

a) Using a script to calculate the speed during the cp shows:
97.63GB/d    4165.80MB/h      69.43MB/m    1185.06KB/s
96.66GB/d    4124.40MB/h      68.74MB/m    1173.26KB/s
97.98GB/d    4180.80MB/h      69.68MB/m    1189.33KB/s
97.38GB/d    4155.00MB/h      69.25MB/m    1182.00KB/s

b) ftp> get 1GB
1073741824 bytes received in 869 secs (1.2e+03 Kbytes/sec)

-----------------------------------------------------
Step 4: Download a file via lftp using: a) pget -n 1
                                        -or-
                                        b) get
-----------------------------------------------------
    [0] get 1GB &
            `1GB' at 446120 (0%) 12.1K/s eta:26h [Receiving data]
     Now you see why I like pget :)
-----------------------------------------------------
Step 5: I'll run the same two tests for this file as well.

a) [war@p300 x]$ /usr/bin/time cp 1GB /x2
0.41user 29.79system 1:33.19elapsed 32%CPU (0avgtext+0avgdata
0maxresident)k
0inputs+0outputs (97major+14minor)pagefaults 0swaps

b) ftp> get 1GB
1073741824 bytes received in 98.4 secs (1.1e+04 Kbytes/sec)
-----------------------------------------------------

System Information:

1] Disk:

# dumpe2fs -h /dev/hde1
dumpe2fs 1.27 (8-Mar-2002)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          2dfb45aa-f335-11d5-9b02-ecd3131a6d2b
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      sparse_super
Filesystem state:         not clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              15007744
Block count:              15006718
Reserved block count:     0
Free blocks:              14514839
Free inodes:              15007728
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         32768
Inode blocks per group:   1024
Last mount time:          Wed Jul 24 05:15:52 2002
Last write time:          Thu Aug  1 11:14:16 2002
Mount count:              3
Maximum mount count:      36
Last checked:             Mon Jul 22 14:27:30 2002
Check interval:           15552000 (6 months)
Next check after:         Sat Jan 18 13:27:30 2003
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128

# Maxtor 96147U8 61.4GB HDD
name                    value           min             max             mode
----                    -----           ---             ---             ----
bios_cyl                119108          0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw
breada_readahead        4               0               127             rw
bswap                   0               0               1               r
current_speed           68              0               69              rw
failures                0               0               65535           rw
file_readahead          124             0               16384           rw
ide_scsi                0               0               1               rw
init_speed              68              0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      127             1               127             rw
multcount               8               0               8               rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw

# I did not use elvtune, these are the defaults.
# elvtune /dev/hde
/dev/hde elevator ID            2
        read_latency:           8192
        write_latency:          16384
        max_bomb_segments:      0

# Controller
I have tried two controllers.
a) The onboard motherboard controller (PIIX)
b) A promise ATA/100 board which the drives are on now.

# Further information:
System Hardware:
    CPU Type: Pentium II
   CPU Speed: 298.003 MHz
        Disk: Maxtor
         Ram: 124 MB
        Swap: 125 MB

Filesystem            Size  Used Avail Use% Mounted on
/dev/hda2             3.8G  1.4G  2.1G  40% /
/dev/hda1              21M  4.6M   14M  24% /boot
/dev/hde1              55G  347M   55G   1% /disk1 (5400RPM MAXTOR)
/dev/hdg1              38G   32G  6.3G  84% /disk2 (5400RPM IBM)

# hdparm -t /dev/hde
 Timing buffered disk reads:  64 MB in  3.27 seconds = 19.57 MB/sec
# hdparm -t /dev/hdg
 Timing buffered disk reads:  64 MB in  4.19 seconds = 15.27 MB/sec

2] Software:
    binutils: 2.12.90.0.9
   e2fsprogs: 1.27
         gcc: 2.95.3
      kernel: 2.4.18-lowlatency-preempt
  util-linux: 2.11r

As shown, I am running lowlatency-preempt right now, however this problem
occured on vanilla 2.4.16, 2.4.17, and 2.4.18 as well.


