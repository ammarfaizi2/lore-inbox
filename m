Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285277AbRLSNVc>; Wed, 19 Dec 2001 08:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285279AbRLSNVN>; Wed, 19 Dec 2001 08:21:13 -0500
Received: from camus.xss.co.at ([194.152.162.19]:24333 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S285277AbRLSNUy>;
	Wed, 19 Dec 2001 08:20:54 -0500
Message-ID: <3C209434.BCECA0BE@xss.co.at>
Date: Wed, 19 Dec 2001 14:20:52 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: monika@xss.co.at
Subject: Deadlock: Linux-2.2.18, sym53c8xx, Compaq ProLiant, HP Ultrium
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

We experience a problem with a HP Ultrium LTO drive connected
to a Compaq ProLiant ML380 server: in the last 6 months we had
two deadlocks of the machine which seem to be related to the
sym53c8xx driver.

What happens seems to be as follows:

*) From monday to friday, once a day an amanda backup process 
   starts and dumps about 70GB of data to the tape. 

*) this works quite fine, but twice in the last 6 months we
   got the following tape error at the start of the backup:

[...]
Dec 10 15:00:00 server kernel: sym53c1510D-0-<3,*>: FAST-20 WIDE SCSI
40.0 MB/s (50 ns, offset 15)
Dec 10 15:00:01 server kernel: st0: Error with sense data: Info
fld=0x8000, Current st09:00: sense key Hardware Error
Dec 10 15:00:01 server kernel: Additional sense indicates Internal
target failure
[...]

   After that, the amanda process hangs in state "D" and
   cannot be killed anymore. The machine itself is still
   working.
   This _seems_ to be the indication of an error of the
   HP Ultrium itself, though the drive works quite fine
   otherwise...

*) In order to unlock the hanging amanda process I tried to 
   remove the SCSI drive from the driver:

   echo "scsi remove-single-device" > /proc/scsi/scsi

   This did work well: the hanging amanda process terminated
   fine after that.

*) Next I tried to re-scan the SCSI bus to make the Ultrium 
   drive available again for a new backup:

   echo "scsi add-single-device 0 0 3 0" > /proc/scsi/scsi

   Result: the machine completely deadlocked. No log-message,
   no ping (the server currently runs without monitor and
   keyboard connected...)
   We had to power-switch the machine to get it back... :-(

I now have the following problems/questions:

a) Does anyone have any experience with such an HP Ultrium drive?
   (good/bad?)

b) Does the st0 error message indicate it should be replaced?

c) Is there a bug in the sym53c8xx driver which makes the
   amanda process hang uninterruptable when this error occurs?
   It is not nice to be forced to reboot the machine just because 
   the SCSI tape drive reported some error... :-((
   After all, this is not a windows server, and there are 40
   workstations which get fileservice from this server!

d) Is there a bug in the driver which deadlocks the server
   as soon as someone does a remove/add on the SCSI bus?
   We can live without this feature, but I don't think a
   documented function should deadlock the kernel...

The Ultrium hardware error is not reproducable at will. It
just happens every now and then.
Next thing I will try is to use a different SCSI controller
(Adaptec 29160 or the like) to see if the hanging process
occurs with a different SCSI driver, too.

Following is some information about the server:

Hardware: Compaq ProLiant ML370, Intel PIII/933, 512MB RAM, 
Compaq Smart Array 5302/32 RAID Controller with about 80GB 
of disk-capacity, 3Com 3c985 1000BaseSX NIC

Software: Linux-2.2.18 with newer acenic driver (for the 3Com NIC)

Some information from the running system:

root@server {533} # free
             total       used       free     shared    buffers    
cached
Mem:        517644     439092      78552      47404     166716    
178744
-/+ buffers/cache:      93632     424012
Swap:      1052592      18400    1034192

root@server {534} # lspci -v
00:00.0 Host bridge: Relience Computer CNB20HE (rev 05)
        Flags: bus master, medium devsel, latency 64

00:00.1 Host bridge: Relience Computer CNB20HE (rev 05)
        Flags: bus master, medium devsel, latency 64

00:01.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR):
Unknown device 000a (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device b143
        Flags: bus master, medium devsel, latency 255, IRQ 10
        I/O ports at 2000
        Memory at c6cffc00 (32-bit, non-prefetchable)
        Memory at c6cfe000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2

00:01.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR):
Unknown device 000a (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device b143
        Flags: bus master, medium devsel, latency 255, IRQ 11
        I/O ports at 2400
        Memory at c6cfdc00 (32-bit, non-prefetchable)
        Memory at c6cfc000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2

00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro
100] (rev 08)
        Subsystem: Compaq Computer Corporation: Unknown device b134
        Flags: bus master, medium devsel, latency 64, IRQ 15
        Memory at c6cfb000 (32-bit, non-prefetchable)
        I/O ports at 2800
        Memory at c6b00000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2

00:03.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC
215IIC [Mach64 GT IIC] (rev 7a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 4756
        Flags: bus master, stepping, medium devsel, latency 64
        Memory at c5000000 (32-bit, prefetchable)
        I/O ports at 2c00
        Memory at c6aff000 (32-bit, non-prefetchable)
        Capabilities: [5c] Power Management version 1

00:04.0 System peripheral: Compaq Computer Corporation: Unknown device
a0f0
        Subsystem: Compaq Computer Corporation: Unknown device b0f3
        Flags: medium devsel
        I/O ports at 1800
        Memory at c6afef00 (32-bit, non-prefetchable)

00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 51)
        Subsystem: Relience Computer: Unknown device 0200
        Flags: bus master, medium devsel, latency 0

00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if
8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 3000

03:03.0 RAID bus controller: Compaq Computer Corporation: Unknown
device b060 (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 4070
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 5
        Memory at c6fc0000 (32-bit, non-prefetchable)
        Memory at c6e00000 (32-bit, non-prefetchable)
        I/O ports at 4000
        Capabilities: [f0] Power Management version 2
        Capabilities: [f8] Vital Product Data

03:06.0 Ethernet controller: 3Com Corporation 3c985 1000BaseSX (rev
01)
        Subsystem: Unknown device 9850:0001
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 15
        Memory at c6dfc000 (32-bit, non-prefetchable)


root@server {535} # cat /proc/cciss/cciss0
cciss0:  Compaq Smart Array 5300 Controller
       Board ID: 40700e11
       Firmware Version: 1.62
       Memory Address: e0812000
       IRQ: 0x5
       Logical drives: 2
       Current Q depth: 0
       Current # commands on controller 0
       Max Q depth since init: 1
       Max # commands on controller since init: 128
       Max SG entries since init: 22

cciss/c0d0: blksz=512 nr_blocks=17764320
cciss/c0d1: blksz=512 nr_blocks=142261440
nr_allocs = 11831533
nr_frees = 11831533

root@server {536} # cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: HP       Model: Ultrium 1-SCSI   Rev: N11D
  Type:   Sequential-Access                ANSI SCSI revision: 03

root@server {537} # cat /proc/scsi/sym53c8xx/0
General information:
  Chip sym53c1510D, device id 0xa, revision id 0x2
  On PCI bus 0, device 1, function 0, IRQ 10
  Synchronous period factor 10, max commands per lun 32

root@server {538} # cat /proc/scsi/sym53c8xx/1
General information:
  Chip sym53c1510D, device id 0xa, revision id 0x2
  On PCI bus 0, device 1, function 1, IRQ 11
  Synchronous period factor 10, max commands per lun 32

root@server {539} # cat /proc/interrupts
           CPU0
  0:   76904808          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:    5231002          XT-PIC  serial
  5:   11578119          XT-PIC  cciss0
  8:          2          XT-PIC  rtc
 10:   13412657          XT-PIC  sym53c8xx
 11:        450          XT-PIC  sym53c8xx
 13:          1          XT-PIC  fpu
 15:   36100885          XT-PIC  eth0
NMI:          0
ERR:          0

root@server {540} # uname -a
Linux server 2.2.18 #1 SMP Sun May 27 23:14:43 CEST 2001 i686 unknown

root@server {541} # lsmod
Module                  Size  Used by
sym53c8xx              56592   0
af_packet               6528   1  (autoclean)
nfsd                  184416  16  (autoclean)
nfs                    75872   1  (autoclean)
lockd                  47344   1  (autoclean) [nfsd nfs]
sunrpc                 63376   1  (autoclean) [nfsd nfs lockd]
acenic                125744   1  (autoclean)
softdog                 1584   1  (autoclean)
st                     25424   0
scsi_mod               55504   2  [sym53c8xx st]
cciss                  17552   9
ext2                   42032   7


These are the sym53c8xx driver's boot-messages:
[...]
sym53c8xx: at PCI bus 0, device 1, function 0
sym53c8xx: 53c1510D detected
sym53c8xx: at PCI bus 0, device 1, function 1
sym53c8xx: 53c1510D detected
sym53c1510D-0: rev 0x2 on pci bus 0 device 1 function 0 irq 10
sym53c1510D-0: ID 7, Fast-40, Parity Checking
sym53c1510D-1: rev 0x2 on pci bus 0 device 1 function 1 irq 11
sym53c1510D-1: ID 7, Fast-40, Parity Checking
scsi0 : sym53c8xx-1.7.1-20000726
scsi1 : sym53c8xx-1.7.1-20000726
scsi : 2 hosts.
  Vendor: HP        Model: Ultrium 1-SCSI    Rev: N11D
  Type:   Sequential-Access                  ANSI SCSI revision: 03
Detected scsi tape st0 at scsi0, channel 0, id 3, lun 0
[...]

Any help is appreciated!
Many thanks in advance!

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
