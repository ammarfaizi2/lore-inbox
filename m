Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132249AbQKBQdC>; Thu, 2 Nov 2000 11:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132229AbQKBQcx>; Thu, 2 Nov 2000 11:32:53 -0500
Received: from london.rubylane.com ([208.184.113.40]:39598 "HELO
	london.rubylane.com") by vger.kernel.org with SMTP
	id <S132216AbQKBQcg>; Thu, 2 Nov 2000 11:32:36 -0500
Message-ID: <20001102163235.3530.qmail@london.rubylane.com>
From: jim@rubylane.com
Subject: IDE tape problem in 2.2.17 on Intel SMP
To: gadio@netvision.net.il
Date: Thu, 2 Nov 2000 08:32:34 -0800 (PST)
Cc: Alan.Cox@linux.org, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gadi - On Oct 27th we upgraded from 2.2.16 to the 2.2.17 Intel
Linux kernel on our production web server (450MHz dual SMP, Tyan
1532(?)  motherboard, 1GB ram).  We have a Seagate 20GB IDE tape
backup on this machine and do backups every day.  The backups had been
working fine, and the backup just before the upgrade worked fine.

Since the upgrade, our backups have been failing in the tar verify
pass with around 10 read errors:

backuplog
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Too many errors, quitting
tar: Error is not recoverable: exiting now
Command exited with non-zero status 2
48.14user 332.02system 4:47:22elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1919159major+3434minor)pagefaults 0swaps

Here is our tar command line:

time tar -cvWf /dev/tape -X /root/exclude />/tmp/backup.log 2>&1


Here are the messages from our system log:

Nov  2 07:00:16 london kernel: ide-tape: ht0: DSC timeout
Nov  2 07:02:16 london kernel: ide-tape: ht0: DSC timeout
Nov  2 07:02:16 london kernel: hdd: ATAPI reset complete
Nov  2 07:02:16 london kernel: ide-tape: ht0: I/O error, pc = 11, key =  2, asc =  4, ascq =  1
Nov  2 07:02:16 london kernel: ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
Nov  2 07:02:17 london last message repeated 11 times
Nov  2 07:02:17 london kernel: ide-tape: ht0: I/O error, pc =  1, key =  2, asc =  4, ascq =  1

The backup seems to fail the same time every day, around 10AM Pacific Time,
which is when our web server traffic starts to pick up.

I also notice that our backups are taking much longer under 2.2.17.  Our
backups were taking about 3 hours, as below (the day before upgrade):

# tail tape.2000-10-27_01:00
var/qmail/.bash_logout
var/qmail/.bashrc
var/qmail/rc
var/qmail/rc.~1~
var/qmail/rc.~2~
.bash_history
d1
backuplog
45.82user 316.83system 3:05:30elapsed 3%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1753209major+3322minor)pagefaults 0swaps

Now our backups are taking nearly 5 hours:

# tail tape.2000-10-28_01:00
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Read error on /dev/tape: Input/output error
tar: Too many errors, quitting
tar: Error is not recoverable: exiting now
Command exited with non-zero status 2
33.15user 313.25system 4:23:03elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1764183major+3346minor)pagefaults 0swaps

I don't really care how long the backup takes, but maybe this is a
clue about the problem.  The number of I/O's has not changed
significantly, only the time.  Also, BIG NOTE HERE: we run our web
server at a high priority (-10) and run our backup process at a low
priority (20).  I am going to change this to run our backup program at
normal user priority and see if this affects the problem.  I'll let
you know the results, but still, it does not seem right to have a
device not work if a process is run at a lower priority.

We have two IDE channels on this machine.  The primary channel has 2
Maxtor 27GB IDE drives, the secondary channel has the tape drive and a
CDROM.  (The CDROM is not being used).  I'm sorry, but I can't
remember if the tape drive or CDROM is the master.


Here is the output of dmesg since our reboot with the new kernel:

pcwd: PC Watchdog (REV.C) detected at port 0x350 (Firmware version: 1.42a)
pcwd: Cold boot sense.
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K size
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 92732U8, ATA DISK drive
hdb: Maxtor 92739U6, ATA DISK drive
hdc: BCD-24X 1997-06-27, ATAPI CDROM drive
hdd: Seagate STT20000A, ATAPI TAPE drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: Maxtor 92732U8, 26059MB w/2048kB Cache, CHS=3322/255/63, UDMA
hdb: Maxtor 92739U6, 26127MB w/2048kB Cache, CHS=3330/255/63, UDMA
hdc: ATAPI 10X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11
ide-tape: hdd <-> ht0, 1000KBps, 6*54kB buffer, 5400kB pipeline, 160ms tDSC, DMA
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Partition check:
 hda: hda1 hda2 hda3
 hdb: hdb1 hdb2 hdb3
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 56k freed
tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
eth0: Digital DS21140 Tulip rev 34 at 0xec00, 00:C0:F0:30:E5:B7, IRQ 17.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
Adding Swap: 136544k swap-space (priority 0)
Adding Swap: 136544k swap-space (priority 0)
eth0: Setting full-duplex based on MII#1 link partner capability of 41e1.
ide-tape: ht0: DSC timeout
ide-tape: ht0: DSC timeout
hdd: DMA disabled
hdd: ATAPI reset complete
ide-tape: ht0: I/O error, pc = 11, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  1, key =  2, asc =  4, ascq =  1
ide-tape: ht0: DSC timeout
ide-tape: ht0: DSC timeout
hdd: ATAPI reset complete
ide-tape: ht0: I/O error, pc = 11, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  1, key =  2, asc =  4, ascq =  1
ide-tape: ht0: DSC timeout
ide-tape: ht0: DSC timeout
hdd: ATAPI reset complete
ide-tape: ht0: I/O error, pc = 11, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  1, key =  2, asc =  4, ascq =  1
ide-tape: ht0: DSC timeout
ide-tape: ht0: DSC timeout
hdd: ATAPI reset complete
ide-tape: ht0: I/O error, pc = 11, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  1, key =  2, asc =  4, ascq =  1
Suspect short first fragment.
eth0 PROTO=6 209.141.75.196:0 208.184.113.40:0 L=20 S=0x00 I=36119 F=0x6000 T=115 (#0)
ide-tape: ht0: DSC timeout
ide-tape: ht0: DSC timeout
hdd: ATAPI reset complete
ide-tape: ht0: I/O error, pc = 11, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  1, key =  2, asc =  4, ascq =  1
ide-tape: ht0: DSC timeout
ide-tape: ht0: DSC timeout
hdd: ATAPI reset complete
ide-tape: ht0: I/O error, pc = 11, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  8, key =  2, asc =  4, ascq =  1
ide-tape: ht0: I/O error, pc =  1, key =  2, asc =  4, ascq =  1



We have this exact same configuration running on another server
that sees much less web usage (and has less data), and the tape
drive is still working there under 2.2.17.

I will let you know whether running the backup at normal priority
changes the problem.  We also may reboot 2.2.16 again to see if the
drive still works under that, although I would rather not since this
is a production server.

If you have any suggestions or need more information, please let
me know.  I'm really glad the IDE tape stuff got fixed in 2.2.16,
because in prior releases it crashed our SMP machine.

Thanks in advance,
Jim Wilcoxson
Owner, www.rubylane.com

(I'm not on the Linux kernel mailing list)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
