Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266960AbRGTO0G>; Fri, 20 Jul 2001 10:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbRGTOZr>; Fri, 20 Jul 2001 10:25:47 -0400
Received: from tiku.hut.fi ([130.233.228.86]:19975 "EHLO tiku.hut.fi")
	by vger.kernel.org with ESMTP id <S266960AbRGTOZh>;
	Fri, 20 Jul 2001 10:25:37 -0400
Date: Fri, 20 Jul 2001 17:25:40 +0300 (EET DST)
From: =?ISO-8859-1?Q?Janne_P=E4nk=E4l=E4?= <epankala@cc.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: realiable crashing with AIC7xxxx driver and vanilla 2.4.6 kernel on
 KT133(A)
Message-ID: <Pine.OSF.4.10.10107201649210.22298-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

** Summary ** 
aic7xxx driver reliably crashes to(/in?) ahc_handle_seqint() function.

** Explanations **
I updated my motherboard from MVP3 chipset to KT133A (Asus KT7A) board and
now I'm getting Oopses like no tomorrow.

when ever I do something that uses scsi disk more than just a bit it will
crash.

lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:09.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871 (rev 03)

--- /proc/interrupts ---
           CPU0       
  0:     150666          XT-PIC  timer
  1:       4645          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:        224          XT-PIC  serial
  5:      12736          XT-PIC  usb-uhci, usb-uhci
  7:      33581          XT-PIC  aic7xxx
  9:          0          XT-PIC  acpi
 10:      20848          XT-PIC  eth0
 12:          0          XT-PIC  EMU10K1
 14:          6          XT-PIC  ide0
 15:         54          XT-PIC  ide1
NMI:          0 
ERR:         23
MIS:          0
---

what I always seem to get is following (I have kdb patch)

--- CRASH 1 ---
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
Unable to handle kernel NULL pointer dereference at virtual address 00000173
 printing eip:
c01cb819
*pde = 00000000

Entering kdb (current=0xc031c000, pid 0) Oops: Oops
due to oops @ 0xc01cb819
eax = 0xc1355c00 ebx = 0xc1254000 ecx = 0xc1254000 edx = 0x00000173
esi = 0xc1258210 edi = 0xc127de00 esp = 0xc031dee0 eip = 0xc01cb819
ebp = 0xc031df2c xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010006
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc031deac
kdb> bt
    EBP       EIP         Function(args)
0xc031df2c 0xc01cb819 ahc_handle_seqint+0x2c9 (0xc127de00, 0x71)
                               kernel .text 0xc0100000 0xc01cb550 0xc01cc4b0
0xc031df54 0xc01c835f ahc_linux_isr+0x17f (0xb, 0xc127de00, 0xc031dfa0, 0x2c0)
                               kernel .text 0xc0100000 0xc01c81e0 0xc01c8440
0xc031df74 0xc01084a0 handle_IRQ_event+0x30 (0xb, 0xc031dfa0, 0xc125d380, 0xc0105190, 0xc031c000)
                               kernel .text 0xc0100000 0xc0108470 0xc01084d0
0xc031df98 0xc0108632 do_IRQ+0x72
                               kernel .text 0xc0100000 0xc01085c0 0xc0108670
0xc031dfe8 0xc0105232 cpu_idle+0x42
                               kernel .text 0xc0100000 0xc01051f0 0xc0105250
kdb>

--- CRASH 2 ---
(scsi0:A:0:0): Unexpected busfree in Message-out phase
SEQADDR == 0x159
Unable to handle kernel NULL pointer dereference at virtual address 00000173
 printing eip:
c01cb819
*pde = 00000000

Entering kdb (current=0xc031c000, pid 0) Oops: Oops
due to oops @ 0xc01cb819
eax = 0xc125c000 ebx = 0xc1254000 ecx = 0xc1254000 edx = 0x00000173
esi = 0xc1258000 edi = 0xc127de00 esp = 0xc031dee0 eip = 0xc01cb819
ebp = 0xc031df2c xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010006
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc031deac
kdb> bt
    EBP       EIP         Function(args)
0xc031df2c 0xc01cb819 ahc_handle_seqint+0x2c9 (0xc127de00, 0x71)
                               kernel .text 0xc0100000 0xc01cb550 0xc01cc4b0
0xc031df54 0xc01c835f ahc_linux_isr+0x17f (0x7, 0xc127de00, 0xc031dfa0, 0x1c0)
                               kernel .text 0xc0100000 0xc01c81e0 0xc01c8440
0xc031df74 0xc01084a0 handle_IRQ_event+0x30 (0x7, 0xc031dfa0, 0xc125d380, 0xc0105190, 0xc031c000)
                               kernel .text 0xc0100000 0xc0108470 0xc01084d0
0xc031df98 0xc0108632 do_IRQ+0x72
                               kernel .text 0xc0100000 0xc01085c0 0xc0108670
0xc031dfe8 0xc0105232 cpu_idle+0x42
                               kernel .text 0xc0100000 0xc01051f0 0xc0105250
kdb>
-------------

--- /usr/src/linux/.config ---
CONFIG_MK7=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_SMP is not set
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_BUILD_FIRMWARE=y
---

>From linux-kernel mailing list I saw that ppl have had problems with
AIC7xxx on KT chipset. However seems that others have gotten it solved.

Any suggestions are more than welcome and I'll gladly provide any help I
can.

-- 
Janne
echo peufiuhu@tt.lac.nk | tr acefhiklnptu utpnlkihfeca

