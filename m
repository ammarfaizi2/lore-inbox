Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWFJKXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWFJKXg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 06:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWFJKXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 06:23:35 -0400
Received: from lucidpixels.com ([66.45.37.187]:49627 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751476AbWFJKXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 06:23:35 -0400
Date: Sat, 10 Jun 2006 06:23:32 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: smartmontools-support@lists.sourceforge.net
cc: Remy Card <Remy.Card@linux.org>, "Theodore Ts'o" <tytso@alum.mit.edu>,
       David Beattie <dbeattie@softhome.net>, linux-kernel@vger.kernel.org,
       apiszcz@solarrain.com
Subject: The Death and Diagnosis of a Dying Hard Drive - Is S.M.A.R.T. useful?
Message-ID: <Pine.LNX.4.64.0606100615500.15475@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SUMMARY:
I pose the following question in the subject, as over the years running 
smartd and having failed disks, I have always first been alerted of bad 
sectors and such through dmesg or logcheck.  Even with a bad disk I 
currently have, smartd does not pickup any errors, except those with the 
kernel writes to syslog.

LKML INFO:
I've cc'd the LKML to show that, when a disk is failing I had received 
similar stat errors, but those were due to buffer / or other disk issues.

[4485617.826000] ata2: status=0x51 { DriveReady SeekComplete Error }
[4485619.292000] ata2: translated ATA stat/err 0x51/40 to SCSI SK/ASC/ASCQ 
0x3/11/04
[4485619.292000] ata2: status=0x51 { DriveReady SeekComplete Error }
[4485620.749000] ata2: translated ATA stat/err 0x51/40 to SCSI SK/ASC/ASCQ 
0x3/11/04
[4485620.749000] ata2: status=0x51 { DriveReady SeekComplete Error }
[4494582.951000] ata2: command 0x25 timeout, stat 0x50 host_stat 0x22
[4494831.267000] ata2: command 0x25 timeout, stat 0x50 host_stat 0x22

--------------

Now for the problem and analysis:

The Death and Diagnosis of a Dying Hard Drive - Is S.M.A.R.T. useful?

1] SMARTMONTOOLS: I pose the following question: Is running the smartd daemon
with short and long S.M.A.R.T. tests enough?

2] FAILED HARD DRIVE: A Maxtor of course! (1.38 years old)
------------------------- snip -------------------------------------------------
Model Family:     Maxtor DiamondMax 10 family
Device Model:     Maxtor 6B250S0
Serial Number:    ******** (out of warranty on 02/19/2006)
Firmware Version: BANC1B70
User Capacity:    251,000,193,024 bytes
------------------------- snip -------------------------------------------------

3] DMESG DATA DUMP: Occured while [reading] a file from the HDD.
------------------------- snip -------------------------------------------------
ATA: abnormal status 0x80 on port 0xC807
ATA: abnormal status 0x80 on port 0xC807
ATA: abnormal status 0x80 on port 0xC807
ata2: command 0x25 timeout, stat 0x80 host_stat 0x21
ata2: translated ATA stat/err 0x80/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata2: status=0x80 { Busy }
sd 2:0:0:0: SCSI error: return code = 0x8000002
sdc: Current: sense key=0xb
     ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sdc, sector 130483823
ATA: abnormal status 0x80 on port 0xC807
ATA: abnormal status 0x80 on port 0xC807
ATA: abnormal status 0x80 on port 0xC807
ata2: command 0x25 timeout, stat 0x50 host_stat 0x21
------------------------- snip -------------------------------------------------

4] SMARTCTL-SHORT TEST: The short shows nothing wrong with the drive.
------------------------- snip -------------------------------------------------
# smartctl -d ata -t short /dev/sdc
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA
_of_first_error
# 1  Short offline       Completed without error       00%     12097         -
------------------------- snip -------------------------------------------------

5] SMARTCTL-LONG TEST:
------------------------- snip -------------------------------------------------
# smartctl -d ata -t short /dev/sdc
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA
# 1  Extended offline    Completed without error       00%     12099         -
------------------------- snip -------------------------------------------------

6] TRY OTHER METHOD USE DD.
------------------------- snip -------------------------------------------------
# /usr/bin/time dd if=/dev/sdc bs=4096 | pipebench > /x6/failed_hdd.img
# This also checked out but some interesting messages in dmesg:
ata3: no sense translation for status: 0x51
ata3: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
ata3: status=0x51 { DriveReady SeekComplete Error }
------------------------- snip -------------------------------------------------

7] CHECK WITH BADBLOCKS(READ-ONLY)...?
------------------------- snip -------------------------------------------------
# /usr/bin/time badblocks -b 512 -s -v /dev/sdc
  -b 512 -s -v /dev/sdhecking blocks 0 to 490234752
Checking for bad blocks (read-only test): done 
Pass completed, 0 bad blocks found.
5.56user 439.85system 1:31:29elapsed 8%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+230minor)pagefaults 0swaps
# mount -a
------------------------- snip -------------------------------------------------


8] CHECK WITH BADBLOCKS(READ+WRITE)...?
------------------------- snip -------------------------------------------------
# /usr/bin/time badblocks -b 512 -s -v -w /dev/sdc 
Checking for bad blocks in read-write mode
>From block 0 to 490234752
Testing with pattern 0xaa:       369800128/      490234752
------------------------- snip -------------------------------------------------
After 12 hours of testing, FINALLY, it says I have a bad disk, see below.
233537658
233537659
233537660
233537661
233537662
233537663
done
Testing with pattern 0x00: done
Reading and comparing: done
Pass completed, 26368 bad blocks found.
1496.54user 3582.18system 12:14:45elapsed 11%CPU (0avgtext+0avgdata 0maxresident)k0inputs+0outputs (2major+282minor)pagefaults 0swaps

-- Also in dmesg:

System Events
=-=-=-=-=-=-=
Jun  9 23:14:51 p34 smartd[32213]: Device: /dev/sdc, 1 Currently unreadable
(pending) sectors
Jun  9 23:44:52 p34 smartd[32213]: Device: /dev/sdc, 1 Currently unreadable
(pending) sectors

------------------------- snip -------------------------------------------------

9] Now review the SMART log again!
------------------------- snip -------------------------------------------------
Error 252 occurred at disk power-on lifetime: 11354 hours (473 days + 2 hours)
   When the command that caused the error occurred, the device was in an unknown 
state.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   78 00 08 b0 19 eb e0

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   00 00 08 b0 19 eb e0 00      01:39:12.107  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:10.649  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:09.191  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:07.716  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:06.258  NOP [Abort queued commands]

Error 251 occurred at disk power-on lifetime: 11354 hours (473 days + 2 hours)
   When the command that caused the error occurred, the device was in an unknown 
state.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   78 00 08 b0 19 eb e0

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   00 00 08 b0 19 eb e0 00      01:39:10.649  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:09.191  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:07.716  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:06.258  NOP [Abort queued commands]
   00 00 08 b0 19 eb e0 00      01:39:04.791  NOP [Abort queued commands]
------------------------- snip -------------------------------------------------

10] What about those self-tests, do they find anything now? Nope.
------------------------- snip -------------------------------------------------
# smartctl -d ata -t short /dev/sdc
Nope.

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA
_of_first_error
# 1  Short offline       Completed without error       00%     12116         -
------------------------- snip -------------------------------------------------

11] What about the long test? Does not find anything.
------------------------- snip -------------------------------------------------
# smartctl -d ata -t long /dev/sdc
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA
_of_first_error
# 1  Extended offline    Completed without error       00%     12117         -
------------------------- snip -------------------------------------------------

After all of this testing, I must pose the question to all of those who run
smartd, is it worth running with scheduled short/long tests if they do 
not find the errors that badblocks did?

Please advise.

Thanks,

Justin.


