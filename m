Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRIXKwI>; Mon, 24 Sep 2001 06:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273855AbRIXKv6>; Mon, 24 Sep 2001 06:51:58 -0400
Received: from ns.hobby.nl ([212.72.224.8]:49937 "EHLO hgatenl.hobby.nl")
	by vger.kernel.org with ESMTP id <S273854AbRIXKvk>;
	Mon, 24 Sep 2001 06:51:40 -0400
Date: Mon, 24 Sep 2001 12:41:31 +0200
From: toon@vdpas.hobby.nl
To: linux-kernel@vger.kernel.org
Subject: /proc/partitions hosed
Message-ID: <20010924124131.A4755@vdpas.hobby.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Last night I upgraded from linux-2.4.6pre3 to linux-2.4.10.
It didn't get trough the boot-sequence (RedHat-7.1).
After some investigation it turned out that it hang in
the kudzu script, and further on also in the netfs script.
The programs `/usr/sbin/updfstab', `/usr/sbin/kudzu' and
the command `mount -a' are all falling into a loop.

I used strace to find out that those programs loop while
reading /proc/partitions. It is very simple to reproduce
via the command `cat /proc/partitions', which gives the
following output (infinite):

major minor  #blocks  name

   8     0    8958120 sda
   8     1    4094960 sda1
   8     2    4862976 sda2
   8     0    8958120 sda
   8     1    4094960 sda1
   8     2    4862976 sda2
   8     0    8958120 sda
   8     1    4094960 sda1
   8     2    4862976 sda2
etc...

I know there was a thread about this problem in linux-kernel.
I checked the archive at http://marc.theaimsgroup.com, but
apparently nobody has come up with a solution or even a cause.

Apart from the /proc/partitions problem the kernel runs fine.
(Actually I'm writing this message while running 2.4.10...)

For convenience I'll give you the output of some relevant commands:

# ls -l /proc/scsi
dr-xr-xr-x    2 root     root            0 Sep 24 12:28 aha152x
-r--r--r--    1 root     root            0 Sep 24 12:28 scsi
dr-xr-xr-x    2 root     root            0 Sep 24 12:28 sym53c8xx

# cat /proc/scsi/sym53c8xx/0
  Chip sym53c875, device id 0xf, revision id 0x26
  On PCI bus 0, device 11, function 0, IRQ 15
  Synchronous period factor 12, max commands per lun 32

# lsmod
Module                  Size  Used by
emu10k1                49168   0  (autoclean)
ac97_codec              9248   0  (autoclean) [emu10k1]
soundcore               3536   4  (autoclean) [emu10k1]
ircomm-tty             31184   1  (autoclean)
ircomm                 13072   0  (autoclean) [ircomm-tty]
irtty                   7568   2  (autoclean)
irda                  146976   1  (autoclean) [ircomm-tty ircomm irtty]
3c509                   7184   1  (autoclean)
aha152x                30976   0 
nls_iso8859-1           2880   1  (autoclean)
nls_cp437               4384   1  (autoclean)
vfat                    8976   1  (autoclean)
fat                    31008   0  (autoclean) [vfat]
usbmouse                1792   0  (unused)
mousedev                4000   1 
hid                    12576   0  (unused)
input                   3296   0  [usbmouse mousedev hid]
usb-uhci               22320   0  (unused)
usbcore                50368   1  [usbmouse hid usb-uhci]
rtc                     6304   0  (autoclean)

# cat /proc/mounts
/dev/hda1 /dos vfat rw 0 0
/dev/hda7 /usr ext2 rw 0 0
/dev/sda2 /usr/local ext2 rw 0 0
/dev/hda6 /var ext2 rw 0 0
/dev/hda5 /var/spool/news ext2 rw 0 0
/dev/sda1 /rh60 ext2 rw 0 0
none /dev/pts devpts rw 0 0
nfs /mnt/psion nfs rw,v2,rsize=8192,wsize=8192,hard,intr,udp,nocto,lock,addr=localhost 0 0

# These are the boot messages that originate from the symbios controller:
Sep 24 09:42:15 vdpas kernel: SCSI subsystem driver Revision: 1.00
Sep 24 09:42:15 vdpas kernel: PCI: Found IRQ 15 for device 00:0b.0
Sep 24 09:42:15 vdpas kernel: sym53c8xx: at PCI bus 0, device 11, function 0
Sep 24 09:42:15 vdpas kernel: sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
Sep 24 09:42:15 vdpas kernel: sym53c8xx: 53c875 detected with Symbios NVRAM
Sep 24 09:42:15 vdpas kernel: sym53c875-0: rev 0x26 on pci bus 0 device 11 function 0 irq 15
Sep 24 09:42:15 vdpas keytable: 
Sep 24 09:42:15 vdpas kernel: sym53c875-0: Symbios format NVRAM, ID 7, Fast-20, Parity Checking
Sep 24 09:42:15 vdpas kernel: sym53c875-0: on-chip RAM at 0xe0000000
Sep 24 09:42:15 vdpas kernel: sym53c875-0: restart (scsi reset).
Sep 24 09:42:15 vdpas kernel: sym53c875-0: Downloading SCSI SCRIPTS.
Sep 24 09:42:15 vdpas rc: Starting keytable:  succeeded
Sep 24 09:42:15 vdpas kernel: scsi0 : sym53c8xx-1.7.3c-20010512
Sep 24 09:42:15 vdpas kernel:   Vendor: IBM       Model: DNES-309170W      Rev: S80K
Sep 24 09:42:15 vdpas kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Sep 24 09:42:15 vdpas kernel: sym53c875-0-<0,0>: tagged command queue depth set to 8
Sep 24 09:42:15 vdpas kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Sep 24 09:42:15 vdpas kernel: sym53c875-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 16)
Sep 24 09:42:15 vdpas kernel: SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Sep 24 09:42:15 vdpas kernel:  sda: sda1 sda2

# Here is the same for that piece of crap that's called a ADP1505 SCSI host controller:
Sep 24 09:42:15 vdpas kernel: aha152x: BIOS test: passed, detected 1 controller(s)
Sep 24 09:42:15 vdpas kernel: aha152x: resetting bus...
Sep 24 09:42:15 vdpas kernel: aha152x1: vital data: rev=3, io=0x140 (0x140/0x140), irq=10, scsiid=7, reconnect=enabled, parity=enabled, synchronous=disabled, delay=1000, extended translation=disabled
Sep 24 09:42:15 vdpas kernel: aha152x1: trying software interrupt, ok.
Sep 24 09:42:15 vdpas kernel: scsi1 : Adaptec 152x SCSI driver; $Revision: 2.4 $

The only device that is attached to the Adaptec SCSI host controller is a scanner,
which was turned off at the time of booting. That's the reason you don't see any
devices connected to that controller.

Did somebody find the cause of this problem yet?
Regards,
Toon.
-- 
 /"\                             |   Windows XP:
 \ /     ASCII RIBBON CAMPAIGN   |        "I'm sorry Dave...
  X        AGAINST HTML MAIL     |         I'm afraid I can't do that."
 / \
