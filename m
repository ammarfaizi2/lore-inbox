Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287574AbSALWCg>; Sat, 12 Jan 2002 17:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287582AbSALWC1>; Sat, 12 Jan 2002 17:02:27 -0500
Received: from camus.xss.co.at ([194.152.162.19]:41481 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S287574AbSALWCR>;
	Sat, 12 Jan 2002 17:02:17 -0500
Message-ID: <3C40B268.C2B87902@xss.co.at>
Date: Sat, 12 Jan 2002 23:02:16 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux-2.2.20 SMP & Asus CUR-DLS: "stuck on TLB IPI wait (CPU#3)"
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm seeing a problem with SMP Linux-2.2.20 on an ASUS CUR-DLS
motherboard. I noticed there were similar reports in the
past few months and I got the impression the problem should
already be fixed in 2.2.20, but seemingly it isn't.

We have a fileserver which was running Linux-2.2.18 without
a single problem for about 8 months or so. It has an Asus CUR-DLS
SMP motherboard with Server Works chipset and Asus Medallion
CUR-DLS ACPI BIOS revision 1009, dual Intel PIII CPU (866MHz) 
and 512MB registered PC133 SDRAM. 
There is also an Adaptec 29160 U160 SCSI controller and a 
3Com 3c905B NIC in this server.

Today I upgraded to Linux-2.2.20, and after reboot the
system became very slow, every now and then it halted for
3 or 4 seconds, and the kernel printed a lot of these
messages: "stuck on TLB IPI wait (CPU#3)"

I then rebooted, disabled BIOS MPS 1.4 support, but this 
didn't help. I had to boot with "noapic" option in order 
to get a system running in a sane way.

I have to say that this is not a pristine Linux-2.2.20
kernel, as we included the following patches:

devfs-v99.21
aic7xxx-6.2.4
sw-raid-2.2.20-A0

but the same kernel is running on an Asus CUV4X-D SMP
(dual PIII 1GHz CPU) system (VIA chipset) without any 
problem.

I found several mails on lkml reporting similar problems,
but no one reported them for this motherboard.

A few more infos from the system running with "noapic":

root@schiller:~ {194} $ lspci -v
00:00.0 Host bridge: Relience Computer CNB20HE (rev 05)
        Flags: bus master, medium devsel, latency 32

00:00.1 Host bridge: Relience Computer CNB20HE (rev 05)
        Flags: bus master, medium devsel, latency 48

00:05.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
[Cyclone] (rev 30)
        Subsystem: 3Com Corporation: Unknown device 9055
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d800
        Memory at fe000000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1

00:07.0 VGA compatible controller: ATI Technologies Inc: Unknown
device 4752 (rev 27) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 802b
        Flags: bus master, stepping, medium devsel, latency 32
        Memory at fd000000 (32-bit, non-prefetchable)
        I/O ports at f000
        Memory at fc800000 (32-bit, non-prefetchable)
        Expansion ROM at febc0000 [disabled]
        Capabilities: [5c] Power Management version 2

00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 50)
        Subsystem: Relience Computer: Unknown device 0200
        Flags: bus master, medium devsel, latency 0

00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if
8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at d000

01:03.0 SCSI storage controller: Adaptec 7892A (rev 02)
        Subsystem: Adaptec: Unknown device e2a0
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
        BIST result: 00
        I/O ports at b800 [disabled]
        Memory at fb800000 (64-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2

01:05.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR):
Unknown device 0020 (rev 01)
        Flags: bus master, medium devsel, latency 72, IRQ 15
        I/O ports at b400
        Memory at fb000000 (64-bit, non-prefetchable)
        Memory at fa800000 (64-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2

01:05.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR):
Unknown device 0020 (rev 01)
        Flags: bus master, medium devsel, latency 72, IRQ 5
        I/O ports at b000
        Memory at fa000000 (64-bit, non-prefetchable)
        Memory at f9800000 (64-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2

root@schiller:~ {195} $ cat /proc/interrupts
           CPU0       CPU1
  0:     177781          0          XT-PIC  timer
  1:       1153          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  4:         21          0          XT-PIC  serial
  8:          3          0          XT-PIC  rtc
 10:     740596          0          XT-PIC  aic7xxx
 11:     707791          0          XT-PIC  eth0
 13:          1          0          XT-PIC  fpu
NMI:          0
ERR:          0

root@schiller:~ {196} $ lsmod
Module                  Size  Used by
nfsd                  183840  16  (autoclean)
nfs                    72800   1  (autoclean)
lockd                  47248   1  (autoclean) [nfsd nfs]
sunrpc                 66192   1  (autoclean) [nfsd nfs lockd]
3c59x                  21744   1  (autoclean)
softdog                 1584   1  (autoclean)
eeprom                  3072   0  (unused)
w83781d                17184   0  (unused)
i2c-piix4               3616   0  (unused)
i2c-proc                5984   0  [eeprom w83781d]
i2c-core               12640   0  [eeprom w83781d i2c-piix4 i2c-proc]
raid5                  19024   1  (autoclean)
unix                   12400  18  (autoclean)
aic7xxx               111696  11
sd_mod                 17600  11
scsi_mod               63680   2  [aic7xxx sd_mod]
ext2                   42320   7

Any idea anyone?
I would be glad if I could help fixing this problem.

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
