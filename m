Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292934AbSCIVMz>; Sat, 9 Mar 2002 16:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292902AbSCIVMj>; Sat, 9 Mar 2002 16:12:39 -0500
Received: from smtp-server1.cfl.rr.com ([65.32.2.68]:40440 "EHLO
	smtp-server1.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S292934AbSCIVMS>; Sat, 9 Mar 2002 16:12:18 -0500
Message-ID: <000701c1c7af$18333d60$ac542341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>
Subject: SCSI Problem 2.4.19-pre2-ac3
Date: Sat, 9 Mar 2002 16:12:17 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using Linux 2.4.19-pre2-ac3 #1 SMP Sat Mar 9 06:44:19 EST 2002 i686 unknown

Dual 1GHz PIII
Adaptec 39160 on 64-bit PCI -- one chassis on one channel -- 2nd chassis on
2nd channel
2nd Adaptec 39160 has seperate 3-disk RAID set on one channel and tape drive
on 2nd channel (still running fine).

11 Seagate 180GB disks in software RAID5 config  (note that "Array Size"
below looks suspicious -- overflowing?.  also -- why 13 disks when only 12
requested?)
Partitions are:
/dev/sdp1             1     22072 177293308+  fd  Linux raid autodetect

Sample /proc/scsi/aic7xxx entry:
Channel A Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 1 Lun 0 Settings
                Commands Queued 403390
                Commands Active 0
                Command Openings 8
                Max Tagged Openings 8
                Device Queue Frozen Count 0


Build with: mdadm --create
/dev/md6 --chunk=128 --level=5 --raid-disks=12 --spare-disks=0 /dev/sd[d-o]1
/dev/md6:
        Version : 00.90.00
  Creation Time : Sat Mar  9 14:34:17 2002
     Raid Level : raid5
     Array Size : -197258624
    Device Size : 177293184 (169 GiB)
     Raid Disks : 12
    Total Disks : 13
Preferred Minor : 6
    Persistance : Superblock is persistant

    Update Time : Sat Mar  9 14:34:17 2002
          State : dirty, no-errors
  Active Drives : 11
 Working Drives : 12
  Failed Drives : 1
   Spare Drives : 1

         Layout : left-symmetric
     Chunk Size : 128K
(note -- remainder of this not available as it's locked up at this point
trying to access the devices while SCSI reset is still happening)

Was getting oopses when RAID chassis were on seperate 39160's (already
emailed to this list) -- now that both chassis are on one controller am
getting SCSI error when I put both RAID chassis on one controller (still
seperate channels though).

Here's the beginning of the messages from messages (note that md3 finishes
syncing -- since I'm getting constant lockups everybody has to resync -- and
what's with the 0xff messages??):
Mar  9 15:46:09 yeti kernel: md: md3: sync done.
Mar  9 15:46:16 yeti kernel: 0xff) 31(c 0x60, s 0x57, l 0, t 0xff)
Mar  9 15:46:46 yeti last message repeated 7 times
Mar  9 15:46:56 yeti kernel: 0xff) 31(c 0x60, s 0x57, l 0, t 0xff)
Mar  9 15:47:36 yeti last message repeated 4 times
Mar  9 15:47:46 yeti kernel: 0xff) 31(c 0x60, s 0x57, l 0, t 0xff)
Mar  9 15:47:56 yeti kernel: 0xff) 31(c 0x60, s 0x57, l 0, t 0xff)
Mar  9 15:48:06 yeti kernel: 0xff) 31(c 0x60, s 0x57, l 0, t 0xff)
Mar  9 15:48:21 yeti kernel: xff) 31(c 0x60, s 0x57, l 0, t 0xff)
Mar  9 15:48:21 yeti kernel: scsi: device set offline - not ready or command
retry failed after bus reset: host 2 channel 0 id 1 lun
 0
Mar  9 15:48:31 yeti kernel: 0xff) 31(c 0x60, s 0x57, l 0, t 0xff)
Mar  9 15:48:31 yeti kernel: scsi: device set offline - not ready or command
retry failed after bus reset: host 2 channel 0 id 1 lun
 0
Mar  9 15:48:41 yeti kernel: 0xff) 31(c 0x60, s 0x57, l 0, t 0xff)
This continues for all devices on this SCSI channel (all 11 disks)

Here's the beginning of the messages from syslog:
Mar  9 15:37:36 yeti kernel: scsi2:0:1:0: Attempting to queue an ABORT
message
Mar  9 15:37:36 yeti kernel: scsi2: Dumping Card State while idle, at
SEQADDR 0x8
Mar  9 15:37:36 yeti kernel: ACCUM = 0x0, SINDEX = 0xc, DINDEX = 0xe4, ARG_2
= 0x0
Mar  9 15:37:36 yeti kernel: HCNT = 0x0 SCBPTR = 0xe
Mar  9 15:37:36 yeti kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar  9 15:37:36 yeti kernel:  DFCNTRL = 0x0, DFSTATUS = 0x89
Mar  9 15:37:36 yeti kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 =
0x80
Mar  9 15:37:36 yeti kernel: SSTAT0 = 0x0, SSTAT1 = 0x8
Mar  9 15:37:36 yeti kernel: SCSIPHASE = 0x0
Mar  9 15:37:36 yeti kernel: STACK == 0x3, 0x108, 0x160, 0x0
Mar  9 15:37:36 yeti kernel: SCB count = 60
Mar  9 15:37:36 yeti kernel: Kernel NEXTQSCB = 27
Mar  9 15:37:36 yeti kernel: Card NEXTQSCB = 27
Mar  9 15:37:36 yeti kernel: QINFIFO entries:
Mar  9 15:37:36 yeti kernel: Waiting Queue entries:
Mar  9 15:37:36 yeti kernel: Disconnected Queue entries:
Mar  9 15:37:36 yeti kernel: QOUTFIFO entries:
Mar  9 15:37:36 yeti kernel: Sequencer Free SCB List: 14 12 9 13 5 19 7 24
10 4 8 18 0 21 3 20 29 23 11 22 15 30 25 26 28 31 1 17 2
6 16 27
Mar  9 15:37:36 yeti kernel: Sequencer SCB Info: 0(c 0x60, s 0x67, l 0, t
0xff) 1(c 0x60, s 0x27, l 0, t 0xff) 2(c 0x60, s 0x57, l 0
, t 0xff) 3(c 0x60, s 0x47, l 0, t 0xff) 4(c 0x60, s 0x67, l 0, t 0xff) 5(c
0x60, s 0xa7, l 0, t 0xff) 6(c 0x60, s 0x27, l 0, t 0xff
) 7(c 0x60, s 0x67, l 0, t 0xff) 8(c 0x60, s 0x47, l 0, t 0xff) 9(c 0x60, s
0xa7, l 0, t 0xff) 10(c 0x60, s 0x17, l 0, t 0xff) 11(c
0x60, s 0x47, l 0, t 0xff) 12(c 0x60, s 0xa7, l 0, t 0xff) 13(c 0x60, s
0x17, l 0, t 0xff) 14(c 0x60, s 0x27, l 0, t 0xff) 15(c 0x60
, s 0x67, l 0, t 0xff) 16(c 0x60, s 0x57, l 0, t 0xff) 17(c 0x60, s 0x57, l
0, t 0xff) 18(c 0x60, s 0x57, l 0, t 0xff) 19(c 0x60, s
0x47, l 0, t 0xff) 20(c 0x60, s 0x27, l 0, t 0xff) 21(c 0x60, s 0xa7, l 0, t
0xff) 22(c 0x60, s 0xa7, l 0, t 0xff) 23(c 0x60, s 0x67
, l 0, t 0xff) 24(c 0x60, s 0xa7, l 0, t 0xff) 25(c 0x60, s 0x27, l 0, t
0xff) 26(c 0x60, s 0x37, l 0, t 0xff) 27(c 0x60, s 0x27, l
0, t 0xff) 28(c 0x60, s 0x47, l 0, t 0xff) 29(c 0x60, s 0x57, l 0, t 0xff)
30(c 0x60, s 0xa7, l 0, t
Mar  9 15:37:36 yeti kernel: Pending list: 12(c 0x60, s 0x27, l 0), 15(c
0x60, s 0x37, l 0), 24(c 0x60, s 0x47, l 0), 5(c 0x60, s 0x
57, l 0), 11(c 0x60, s 0x67, l 0), 37(c 0x60, s 0x17, l 0), 16(c 0x60, s
0x27, l 0), 6(c 0x60, s 0x37, l 0), 32(c 0x60, s 0x47, l 0)
, 20(c 0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 41(c 0x60, s 0xa7, l 0),
46(c 0x60, s 0xa7, l 0), 1(c 0x60, s 0x17, l 0), 38(c 0
x60, s 0x27, l 0), 51(c 0x60, s 0x37, l 0), 30(c 0x60, s 0x47, l 0), 29(c
0x60, s 0x57, l 0), 52(c 0x60, s 0x67, l 0), 53(c 0x60, s
0xa7, l 0), 25(c 0x60, s 0x17, l 0), 54(c 0x60, s 0x27, l 0), 33(c 0x60, s
0x37, l 0), 45(c 0x60, s 0x47, l 0), 22(c 0x60, s 0x57, l
 0), 39(c 0x60, s 0x67, l 0), 44(c 0x60, s 0xa7, l 0), 26(c 0x60, s 0x17, l
0), 14(c 0x60, s 0x27, l 0), 47(c 0x60, s 0x37, l 0), 18
(c 0x60, s 0x47, l 0), 21(c 0x60, s 0x57, l 0), 0(c 0x60, s 0x67, l 0), 8(c
0x60, s 0xa7, l 0), 28(c 0x60, s 0x17, l 0), 59(c 0x60,
s 0x27, l 0), 55(c 0x60, s 0x37, l 0), 34(c 0x60, s 0x47, l 0), 7(c 0x60, s
0x57, l 0), 48(c 0x60, s
Mar  9 15:37:36 yeti kernel: Kernel Free SCB list: 58 57 56
Mar  9 15:37:36 yeti kernel: DevQ(0:1:0): 0 waiting
Mar  9 15:37:36 yeti kernel: DevQ(0:2:0): 0 waiting
Mar  9 15:37:36 yeti kernel: DevQ(0:3:0): 0 waiting
Mar  9 15:37:36 yeti kernel: DevQ(0:4:0): 0 waiting
Mar  9 15:37:36 yeti kernel: DevQ(0:5:0): 0 waiting
Mar  9 15:37:36 yeti kernel: DevQ(0:6:0): 0 waiting
Mar  9 15:37:36 yeti kernel: DevQ(0:10:0): 0 waiting
Mar  9 15:37:36 yeti kernel: (scsi2:A:1:0): Queuing a recovery SCB
Mar  9 15:37:36 yeti kernel: scsi2:0:1:0: Device is disconnected, re-queuing
SCB
Mar  9 15:37:36 yeti kernel: (scsi2:A:1:0): Abort Tag Message Sent
Mar  9 15:37:36 yeti kernel: Recovery code sleeping
Mar  9 15:37:36 yeti kernel: (scsi2:A:1:0): SCB 49 - Abort Tag Completed.
Mar  9 15:37:36 yeti kernel: Recovery SCB completes
Mar  9 15:37:36 yeti kernel: Recovery code awake
Mar  9 15:37:36 yeti kernel: aic7xxx_abort returns 0x2002
Mar  9 15:37:46 yeti kernel: scsi2:0:1:0: Attempting to queue an ABORT
message
Mar  9 15:37:46 yeti kernel: scsi2: Dumping Card State while idle, at
SEQADDR 0x8
Mar  9 15:37:46 yeti kernel: ACCUM = 0x0, SINDEX = 0x1b, DINDEX = 0xe4,
ARG_2 = 0x0
Mar  9 15:37:46 yeti kernel: HCNT = 0x0 SCBPTR = 0xe
Mar  9 15:37:46 yeti kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar  9 15:37:46 yeti kernel:  DFCNTRL = 0x0, DFSTATUS = 0x89
Mar  9 15:37:46 yeti kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 =
0x80
Mar  9 15:37:46 yeti kernel: SSTAT0 = 0x0, SSTAT1 = 0x8
Mar  9 15:37:46 yeti kernel: SCSIPHASE = 0x0
Mar  9 15:37:46 yeti kernel: STACK == 0x3, 0x108, 0x160, 0xe7
Mar  9 15:37:46 yeti kernel: SCB count = 60
Mar  9 15:37:46 yeti kernel: Kernel NEXTQSCB = 49
Mar  9 15:37:46 yeti kernel: Card NEXTQSCB = 49
Mar  9 15:37:46 yeti kernel: QINFIFO entries:
Mar  9 15:37:46 yeti kernel: Waiting Queue entries:
Mar  9 15:37:46 yeti kernel: Disconnected Queue entries:
Mar  9 15:37:46 yeti kernel: QOUTFIFO entries:
Mar  9 15:37:46 yeti kernel: Sequencer Free SCB List: 14 12 9 13 5 19 7 24
10 4 8 18 0 21 3 20 29 23 11 22 15 30 25 26 28 31 1 17 2
6 16 27
Mar  9 15:37:46 yeti kernel: Sequencer SCB Info: 0(c 0x60, s 0x67, l 0, t
0xff) 1(c 0x60, s 0x27, l 0, t 0xff) 2(c 0x60, s 0x57, l 0
, t 0xff) 3(c 0x60, s 0x47, l 0, t 0xff) 4(c 0x60, s 0x67, l 0, t 0xff) 5(c
0x60, s 0xa7, l 0, t 0xff) 6(c 0x60, s 0x27, l 0, t 0xff
) 7(c 0x60, s 0x67, l 0, t 0xff) 8(c 0x60, s 0x47, l 0, t 0xff) 9(c 0x60, s
0xa7, l 0, t 0xff) 10(c 0x60, s 0x17, l 0, t 0xff) 11(c
0x60, s 0x47, l 0, t 0xff) 12(c 0x60, s 0xa7, l 0, t 0xff) 13(c 0x60, s
0x17, l 0, t 0xff) 14(c 0x60, s 0x17, l 0, t 0xff) 15(c 0x60
, s 0x67, l 0, t 0xff) 16(c 0x60, s 0x57, l 0, t 0xff) 17(c 0x60, s 0x57, l
0, t 0xff) 18(c 0x60, s 0x57, l 0, t 0xff) 19(c 0x60, s
0x47, l 0, t 0xff) 20(c 0x60, s 0x27, l 0, t 0xff) 21(c 0x60, s 0xa7, l 0, t
0xff) 22(c 0x60, s 0xa7, l 0, t 0xff) 23(c 0x60, s 0x67
, l 0, t 0xff) 24(c 0x60, s 0xa7, l 0, t 0xff) 25(c 0x60, s 0x27, l 0, t
0xff) 26(c 0x60, s 0x37, l 0, t 0xff) 27(c 0x60, s 0x27, l
0, t 0xff) 28(c 0x60, s 0x47, l 0, t 0xff) 29(c 0x60, s 0x57, l 0, t 0xff)
30(c 0x60, s 0xa7, l 0, t

This continues thru all 11 disks 16 times for each disk and then finally
disables some disks:
md6 : active raid5 sdo1[12] sdn1[10] sdm1[9] sdl1[8] sdk1[7] sdj1[6](F)
sdi1[5](F) sdh1[4](F) sdg1[3](F) sdf1[2](F) sde1[1](F) sdd1[
0](F)
      1950225024 blocks level 5, 128k chunk, algorithm 2 [12/4]
[_______UUUU_]
      [========>............]  recovery = 40.0% (70949824/177293184)
finish=17.1min speed=103333K/sec

I'm thinking the next thing I'll do is drop the bus speed to 80MB instead of
160MB and see if it behaves better.  Since nothing happened until one of the
other resyncs finished and the raid5 daemon started using 100% CPU on this
raid setup (and the I/O speed increased).  Could be we're just banging the
data bus too hard?


