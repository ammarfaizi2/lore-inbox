Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967881AbWLETIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967881AbWLETIK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968639AbWLETIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:08:10 -0500
Received: from piamox7.zanu.org.uk ([80.175.154.82]:52155 "EHLO
	mail.zanu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967881AbWLETII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:08:08 -0500
Date: Tue, 5 Dec 2006 19:08:03 +0000
From: Nicholas Piper <nick-lkml@nickpiper.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18 - ata1: command timeout - causing filesystem corruption with software RAID1 / ext3
Message-ID: <20061205190803.GA27389@zanu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,

I've been having trouble with my two SATA disks (ata{1,2}: command
timeout). I've replaced one of the disks, yet the problems persist. It
does not seem to be related to a kernel upgrade (acording to
dpkg.log.)

I posted this to the smartmontools mailing list first in case they
were more appropriate than the LKML, and it was suggested that I do
post the report here. It seems an interesting problem as the hardware
appears fine (replaced once; and vendor tools also validate OK.)

I'm using Debian (mostly testing) and Linux 2.6.18 (compiled
myself). That appears to contain libata 1.20.

Linux version 2.6.18.061031 (2.6.18.061031-10.00.Custom)
(root@piamox7) (gcc version 4.1.2 20061028 (prerelease) (Debian
4.1.1-19)) #4 Fri Nov 24 11:29:49 GMT 2006

The syslog says:

Dec  1 18:29:20 piamox7 kernel: ata1: command timeout
Dec  1 18:29:20 piamox7 kernel: ata1: no sense translation for status: 0x40
Dec  1 18:29:20 piamox7 kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  1 18:29:20 piamox7 kernel: ata1: status=0x40 { DriveReady }

My disks are currently:

Nov 30 15:52:38 piamox7 kernel: ata1: SATA max UDMA/133 cmd 0xF881A200 ctl 0xF881A238 bmdma 0x0 irq 16
Nov 30 15:52:38 piamox7 kernel: ata2: SATA max UDMA/133 cmd 0xF881A280 ctl 0xF881A2B8 bmdma 0x0 irq 16
Nov 30 15:52:38 piamox7 kernel: scsi0 : sata_promise
Nov 30 15:52:38 piamox7 kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Nov 30 15:52:38 piamox7 kernel: ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 
Nov 30 15:52:38 piamox7 kernel: ata1.00: ata1: dev 0 multi count 0
Nov 30 15:52:38 piamox7 kernel: ata1.00: configured for UDMA/133
Nov 30 15:52:38 piamox7 kernel: scsi1 : sata_promise
Nov 30 15:52:38 piamox7 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Nov 30 15:52:38 piamox7 kernel: ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 
Nov 30 15:52:38 piamox7 kernel: ata2.00: ata2: dev 0 multi count 0
Nov 30 15:52:38 piamox7 kernel: ata2.00: configured for UDMA/133
Nov 30 15:52:38 piamox7 kernel:   Vendor: ATA       Model: WDC WD2500KS-00M  Rev: 02.0
Nov 30 15:52:38 piamox7 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Nov 30 15:52:38 piamox7 kernel:   Vendor: ATA       Model: WDC WD2500KS-00M  Rev: 02.0
Nov 30 15:52:38 piamox7 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05

It's happened quite a few times:

Nov 14 11:26:50 piamox7 kernel: ata2: command timeout
Nov 17 02:15:35 piamox7 kernel: ata2: command timeout
Nov 17 05:16:30 piamox7 kernel: ata1: command timeout
Nov 18 05:07:45 piamox7 kernel: ata1: command timeout
Nov 21 22:09:40 piamox7 kernel: ata2: command timeout
Nov 22 21:02:50 piamox7 kernel: ata1: command timeout
Nov 22 22:16:30 piamox7 kernel: ata1: command timeout
Nov 23 06:13:10 piamox7 kernel: ata1: command timeout
Nov 24 10:39:25 piamox7 kernel: ata1: command timeout
Nov 30 04:37:15 piamox7 kernel: ata1: command timeout
Dec  1 18:29:20 piamox7 kernel: ata1: command timeout
Dec  3 04:29:40 piamox7 kernel: ata2: command timeout

And some of those times it's really damaged the filesystem, even
though I'm using a software RAID mirror:

(note the 'sync done'; shouldn't that take much longer?)

Dec  1 18:29:20 piamox7 kernel: ata1: command timeout
Dec  1 18:29:20 piamox7 kernel: ata1: no sense translation for status: 0x40
Dec  1 18:29:20 piamox7 kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  1 18:29:20 piamox7 kernel: ata1: status=0x40 { DriveReady }
Dec  1 18:29:20 piamox7 kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Dec  1 18:29:20 piamox7 kernel: sda: Current: sense key: Aborted Command
Dec  1 18:29:20 piamox7 kernel:     Additional sense: No additional sense information
Dec  1 18:29:20 piamox7 kernel: end_request: I/O error, dev sda, sector 173202207
Dec  1 18:29:20 piamox7 kernel: raid1: Disk failure on sda3, disabling device. 
Dec  1 18:29:20 piamox7 kernel: ^IOperation continuing on 1 devices
Dec  1 18:29:20 piamox7 kernel: RAID1 conf printout:
Dec  1 18:29:20 piamox7 kernel:  --- wd:1 rd:2
Dec  1 18:29:20 piamox7 kernel:  disk 0, wo:1, o:0, dev:sda3
Dec  1 18:29:20 piamox7 kernel:  disk 1, wo:0, o:1, dev:hda3
Dec  1 18:29:20 piamox7 kernel: RAID1 conf printout:
Dec  1 18:29:20 piamox7 kernel:  --- wd:1 rd:2
Dec  1 18:29:20 piamox7 kernel:  disk 0, wo:1, o:0, dev:sda3
Dec  1 18:29:20 piamox7 kernel:  disk 1, wo:0, o:1, dev:hda3
Dec  1 18:29:20 piamox7 kernel: RAID1 conf printout:
Dec  1 18:29:20 piamox7 kernel:  --- wd:1 rd:2
Dec  1 18:29:20 piamox7 kernel:  disk 1, wo:0, o:1, dev:hda3
Dec  1 18:29:20 piamox7 kernel: RAID1 conf printout:
Dec  1 18:29:20 piamox7 kernel:  --- wd:1 rd:2
Dec  1 18:29:20 piamox7 kernel:  disk 0, wo:1, o:1, dev:sdb3
Dec  1 18:29:20 piamox7 kernel:  disk 1, wo:0, o:1, dev:hda3
Dec  1 18:29:23 piamox7 kernel: md: syncing RAID array md2
Dec  1 18:29:23 piamox7 kernel: md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
Dec  1 18:29:23 piamox7 kernel: md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for reconstruction.
Dec  1 18:29:23 piamox7 kernel: md: using 128k window, over a total of 117186048 blocks.
Dec  1 18:29:23 piamox7 kernel: md: md2: sync done.
Dec  1 18:29:23 piamox7 kernel: RAID1 conf printout:
Dec  1 18:29:23 piamox7 kernel:  --- wd:2 rd:2
Dec  1 18:29:23 piamox7 kernel:  disk 0, wo:0, o:1, dev:sdb3
Dec  1 18:29:23 piamox7 kernel:  disk 1, wo:0, o:1, dev:hda3
Dec  1 18:29:25 piamox7 kernel: EXT3-fs error (device md2): ext3_new_block: Allocating block in system zone - blocks from 6029312, length 2
Dec  1 18:29:25 piamox7 kernel: Remounting filesystem read-only

In that case, I had to recreate the array after a reboot by mouting
the apparently 'failed' disk and making a new filesytem on /dev/md2.

I'm using smartmontools 5.36-8 from the Debian package.

I get this each time I try to start smartd:

Dec  3 13:06:08 piamox7 smartd[6772]: Device: /dev/sda, opened 
Dec  3 13:06:08 piamox7 smartd[6772]: Device: /dev/sda, not found in smartd database. 
Dec  3 13:06:08 piamox7 kernel: ata1: no sense translation for status: 0x50
Dec  3 13:06:08 piamox7 kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  3 13:06:08 piamox7 kernel: ata1: status=0x50 { DriveReady SeekComplete }
Dec  3 13:06:08 piamox7 kernel: ata1: no sense translation for status: 0x50
Dec  3 13:06:08 piamox7 kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  3 13:06:08 piamox7 kernel: ata1: status=0x50 { DriveReady SeekComplete }
Dec  3 13:06:08 piamox7 kernel: ata1: no sense translation for status: 0x50
Dec  3 13:06:08 piamox7 kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  3 13:06:08 piamox7 kernel: ata1: status=0x50 { DriveReady SeekComplete }
Dec  3 13:06:08 piamox7 kernel: ata1: no sense translation for status: 0x50
Dec  3 13:06:08 piamox7 kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  3 13:06:08 piamox7 kernel: ata1: status=0x50 { DriveReady SeekComplete }
Dec  3 13:06:08 piamox7 kernel: ata1: no sense translation for status: 0x50
Dec  3 13:06:08 piamox7 kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  3 13:06:08 piamox7 kernel: ata1: status=0x50 { DriveReady SeekComplete }
Dec  3 13:06:08 piamox7 kernel: ata1: no sense translation for status: 0x50
Dec  3 13:06:08 piamox7 kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  3 13:06:08 piamox7 kernel: ata1: status=0x50 { DriveReady SeekComplete }
Dec  3 13:06:08 piamox7 smartd[6772]: Device: /dev/sda, could not enable SMART Attribute Autosave. 
Dec  3 13:06:08 piamox7 kernel: ata1: no sense translation for status: 0x50
Dec  3 13:06:08 piamox7 kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  3 13:06:08 piamox7 kernel: ata1: status=0x50 { DriveReady SeekComplete }
Dec  3 13:06:08 piamox7 kernel: ata1: no sense translation for status: 0x50
Dec  3 13:06:08 piamox7 kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  3 13:06:08 piamox7 kernel: ata1: status=0x50 { DriveReady SeekComplete }
Dec  3 13:06:08 piamox7 kernel: ata1: no sense translation for status: 0x50
Dec  3 13:06:08 piamox7 kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  3 13:06:08 piamox7 kernel: ata1: status=0x50 { DriveReady SeekComplete }
Dec  3 13:06:08 piamox7 kernel: ata1: no sense translation for status: 0x50
Dec  3 13:06:08 piamox7 kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  3 13:06:08 piamox7 kernel: ata1: status=0x50 { DriveReady SeekComplete }
Dec  3 13:06:08 piamox7 kernel: ata1: no sense translation for status: 0x50
Dec  3 13:06:08 piamox7 kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  3 13:06:08 piamox7 kernel: ata1: status=0x50 { DriveReady SeekComplete }
Dec  3 13:06:08 piamox7 kernel: ata1: no sense translation for status: 0x50
Dec  3 13:06:08 piamox7 kernel: ata1: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Dec  3 13:06:08 piamox7 kernel: ata1: status=0x50 { DriveReady SeekComplete }
Dec  3 13:06:08 piamox7 smartd[6772]: Device: /dev/sda, enable SMART Automatic Offline Testing failed. 
Dec  3 13:06:08 piamox7 smartd[6772]: Device: /dev/sda, is SMART capable. Adding to "monitor" list. 

and have this line in /etc/smartd.conf:

/dev/sda -a -d ata -o on -S on -s (S/../.././02|L/../../6/03)  -m root -M exec /usr/share/smartmontools/smartd-runner

I've just now realised I can improve that to remove -o on -S on, which
caused those errors (which I expect to be not causing my further
trouble.)

/dev/sda -a -d ata -s (S/../.././02|L/../../6/03)  -m root -M exec /usr/share/smartmontools/smartd-runner

smartctl -d ata -a /dev/sda says:

--------------------------
smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD2500KS-00MJB0
Serial Number:    WD-WCANK3521747
Firmware Version: 02.01C03
User Capacity:    250,059,350,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Mon Dec  4 23:02:00 2006 GMT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED
See vendor-specific Attribute list for marginal Attributes.

General SMART Values:
Offline data collection status:  (0x84)	Offline data collection activity
					was suspended by an interrupting command from host.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 (7080) seconds.
Offline data collection
capabilities: 			 (0x7b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					General Purpose Logging supported.
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (  83) minutes.
Conveyance self-test routine
recommended polling time: 	 (   6) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   200   200   051    Pre-fail  Always       -       0
  3 Spin_Up_Time            0x0003   199   192   021    Pre-fail  Always       -       5033
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       25
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   200   200   051    Pre-fail  Always       -       0
  9 Power_On_Hours          0x0032   096   096   000    Old_age   Always       -       3617
 10 Spin_Retry_Count        0x0013   100   253   051    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x0012   100   253   051    Old_age   Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       19
190 Unknown_Attribute       0x0022   048   029   045    Old_age   Always   In_the_past 52
194 Temperature_Celsius     0x0022   098   079   000    Old_age   Always       -       52
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   200   200   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0009   200   200   051    Pre-fail  Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%      3596         -
# 2  Short offline       Completed without error       00%      3572         -
# 3  Extended offline    Completed without error       00%      3551         -
# 4  Short offline       Completed without error       00%      3548         -
# 5  Short offline       Completed without error       00%      3525         -
# 6  Short offline       Completed without error       00%      3500         -
# 7  Short offline       Completed without error       00%      3476         -
# 8  Conveyance offline  Completed without error       00%      3463         -
# 9  Short offline       Completed without error       00%      3453         -
#10  Short offline       Completed without error       00%      3429         -
#11  Short offline       Completed without error       00%      3405         -
#12  Extended offline    Completed without error       00%      3383         -
#13  Short offline       Completed without error       00%      3381         -
#14  Short offline       Completed without error       00%      3357         -
#15  Short offline       Completed without error       00%      3333         -
#16  Short offline       Completed without error       00%      3309         -
#17  Short offline       Completed without error       00%      3285         -
#18  Short offline       Completed without error       00%      3261         -
#19  Short offline       Completed without error       00%      3237         -
#20  Extended offline    Completed without error       00%      3216         -
#21  Short offline       Completed without error       00%      3213         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.
--------------------------

I've read at http://linux-ata.org/software-status.html#smart that
"There are also some lingering reports that using SMART commands while
the disk is in heavy usage leads to timeouts and other failures. This
needs to be investigated. Haven't seen any of these reports recently."
and I wonder if this is related to my trouble.

For now, I've reduced my RAID array to a single IDE disk as the SATA
failures were causing me great trouble.

I've used the Western Digital software (
http://support.wdc.com/download/index.asp?swid=1 ) to validate the
disks. I used an extended test (1.5 hours) and the software says the
disks are fine. I assume this also validates the SATA controller to
some extent?

I'd be grateful for any advice on what I can do from here?

AMD Athlon(TM) XP 1700+
Motherboard: Asus A7V8X
VIA KT400 Northbridge + VT8235 Southbridge
2GB RAM

Much thanks,

 Nick
