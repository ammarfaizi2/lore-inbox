Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132850AbRDXHfD>; Tue, 24 Apr 2001 03:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132852AbRDXHey>; Tue, 24 Apr 2001 03:34:54 -0400
Received: from MAIL1.ANDREW.CMU.EDU ([128.2.10.131]:5572 "EHLO
	mail1.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S132850AbRDXHej>; Tue, 24 Apr 2001 03:34:39 -0400
Date: Tue, 24 Apr 2001 03:33:55 -0400 (EDT)
From: Paul Komarek <komarek@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
cc: komarek@andrew.cmu.edu, ross@willow.seitz.com
Subject: FA311 fails on set_power_state()
Message-ID: <Pine.LNX.4.21L.0104240323440.27602-100000@unix49.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

SUMMARY:
Netgear FA311TX with natsemi.o driver fails when set_power_state(0x100,
APM_STATE_READY) is called.

DESCRIPTION:
I have been trying to figure out why my Netgear FA311TX would stop seeing
packets on the lan when an X server quit.  I have traced the problem
through the VT code and into the APM code.  Specifically, when the
ioctl(fd, KDSETMODE, KD_TEXT) is called, the following sequence of calls
occur:

  vt.c:unblank_screen()
  console.c:console_blank_hook(0)  ==  (i386)apm.c:apm_console_blank(0)
  set_power_state(0x100, state), state == linux/apm_bios.h:APM_STATE_READY

At this point, tcpdump stops showing any packets on the FA311's network.
Simply ifup'ing the FA311 makes it work properly again.  I've played
around with reordering PCI cards, etc, thinking it might be an interrupt
problem, but this didn't remove the problem.  I also disabled all
nonessential drivers, leaving basically SCSI, IDE, IDE/RAID, and ethernet,
but the problem remained.  However, if someone thinks it would be useful,
I'll compile as "bare" of kernel as I can and try again since I wasn't
particularly careful about really removing *all* nonessential drivers.

HARDWARE and KERNEL:
I'm running an MSI K7T Turbo RAID motherboard with the VIA KT133A chipset.
There are more details below from lspci, etc.  I have found one person
with an EPoX 8KTA3 motherboard (also VIA KT133A-based) and FA311TX NIC
that has the same problem.  I have found one person with a Tyan Tiger 133A
with the Via Apollo Pro 133A chipset and another with an ASUS A7V with VIA
KT133 chipset that don't have this problem.  All of us are using a 2.4.x
kernel (I'm currently using 2.4.4pre-3, and have used several other 2.4.x
kernels with the same result) with the forward-ported natsemi.o driver.

It is probably worth noting, though probably implied by the above stuff,
that I have APM stuff compiled in the kernel including console blanking:

  CONFIG_APM=y
  # CONFIG_APM_IGNORE_USER_SUSPEND is not set
  CONFIG_APM_DO_ENABLE=y
  CONFIG_APM_CPU_IDLE=y
  CONFIG_APM_DISPLAY_BLANK=y
  CONFIG_APM_RTC_IS_GMT=y
  # CONFIG_APM_ALLOW_INTS is not set
  # CONFIG_APM_REAL_MODE_POWER_OFF is not set

My system has a strange interrupt-related behavior that may be relevant.
In particular, when the via82cxxx_audio.o module is loaded, I receive the
messages:

  kernel: PCI: Found IRQ 10 for device 00:07.5
  kernel: IRQ routing conflict in pirq table for device 00:07.5
  kernel: PCI: The same IRQ used for device 00:09.0
  kernel: PCI: The same IRQ used for device 00:0f.0

07.5 is the audio controller, 09.0 is a Netgear FA310TX (*not* the
FA311TX), and 0f.0 is a Promise 20265 IDE RAID controller.  According to
/proc/interrupts, the audio controller is on IRQ 5, not IRQ 10 as the
above messages state.  The BIOS also shows the audio controller on IRQ 5
during boot.  What I think makes this relevent to the FA311TX is that the
FA311 shares IRQ 5 with the audio controller, according to the BIOS and
/proc/interrupts.

Thanks in advance for any help, and belated thanks for the linux kernel
and this mailing list.  Please 'cc' me on any email
(komarek@andrew.cmu.edu), as I don't think I can afford to subscribe to
the LKML.  Also, Ross Vandergrift would like to be 'cc'd
(ross@willow.seitz.com).  Ross is the owner of the Asus A7V that isn't
having any problems with his FA311TX. More detailed hardware information
follows.

-Paul Komarek

**************** uname -a ***************
Linux elmo.rem.cmu.edu 2.4.4-pre3 #21 Tue Apr 24 02:01:21 EDT 2001 i686
unknown

**************** /sbin/lspci *****************
 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 03)
 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
 00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
 00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40)
 00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 50)
 00:08.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c895
(rev 01)
 00:09.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 21)
 00:0a.0 Ethernet controller: National Semiconductor Corporation: Unknown
device 0020
 00:0c.0 Multimedia video controller: Brooktree Corporation Bt848 TV with
DMA push (rev 12)
 00:0f.0 RAID bus controller: Promise Technology, Inc. 20265 (rev 02)
 01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
01)

**************** /proc/interrupts *****************
  0:     421614          XT-PIC  timer
  1:      25432          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:         87          XT-PIC  serial
  5:       8926          XT-PIC  via82cxxx, eth1
  7:          1          XT-PIC  parport0
  9:         28          XT-PIC  usb-uhci, usb-uhci
 10:      12873          XT-PIC  eth0
 11:      23354          XT-PIC  sym53c8xx
 12:      86247          XT-PIC  PS/2 Mouse
 14:         59          XT-PIC  ide0
 15:        111          XT-PIC  ide1

*************** /proc/ioports **********************
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
a000-afff : PCI Bus #01
  a000-a0ff : 3Dfx Interactive, Inc. Voodoo 3
b000-b00f : VIA Technologies, Inc. Bus Master IDE
  b000-b007 : ide0
  b008-b00f : ide1
b400-b41f : VIA Technologies, Inc. UHCI USB
  b400-b41f : usb-uhci
b800-b81f : VIA Technologies, Inc. UHCI USB (#2)
  b800-b81f : usb-uhci
bc00-bcff : VIA Technologies, Inc. AC97 Audio Controller
  bc00-bcff : via82cxxx
c000-c003 : VIA Technologies, Inc. AC97 Audio Controller
c400-c403 : VIA Technologies, Inc. AC97 Audio Controller
c800-c8ff : Symbios Logic Inc. (formerly NCR) 53c895
  c800-c87f : sym53c8xx
cc00-ccff : Lite-On Communications Inc LNE100TX
  cc00-ccff : eth0
d000-d0ff : PCI device 100b:0020 (National Semiconductor Corporation)
  d000-d0ff : eth1
d400-d407 : Promise Technology, Inc. 20265
d800-d803 : Promise Technology, Inc. 20265
dc00-dc07 : Promise Technology, Inc. 20265
e000-e003 : Promise Technology, Inc. 20265
e400-e43f : Promise Technology, Inc. 20265
  e400-e407 : ide2
  e410-e43f : PDC20265


