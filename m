Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSKBU6i>; Sat, 2 Nov 2002 15:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbSKBU6i>; Sat, 2 Nov 2002 15:58:38 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:3952 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261398AbSKBU6g>;
	Sat, 2 Nov 2002 15:58:36 -0500
Message-ID: <3DC43D86.5070608@gmx.net>
Date: Sat, 02 Nov 2002 22:03:02 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: de, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-rc1
References: <Pine.LNX.4.44L.0210291358010.16425-100000@freak.distro.conectiva>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Hi,
> 
> Finally, rc1.
> [snipped]
> 
> Please stress test it.
> 

My system comes up with a blank console after hardware suspend and resume. 
The cursor is still visible, but no text is there. Switching to another 
console and back fixes it. Vesafb is enabled with vga=791.
Hardware is a Toshiba Satellite 4100XCDT notebook with Trident Cyber9525DVD 
graphics chipset, but this also can be reproduced with Dell notebooks.

I just verified the problem exists still with 2.4.20-rc1.
A binary search turned up 2.4.18-pre7 as the kernel which broke, 
specifically the changes made to apm.c back then.

Relevant part of .config:
CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_APM_ALLOW_INTS=y
# CONFIG_APM_REAL_MODE_POWER_OFF is not set
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_CYBER2000=m
CONFIG_FB_VESA=y
CONFIG_FB_VGA16=m
CONFIG_VIDEO_SELECT=y
CONFIG_FB_TRIDENT=m
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_VGA_PLANES=m
CONFIG_FBCON_VGA=m
CONFIG_FBCON_HGA=m
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

/sbin/lsmod
Module                  Size  Used by    Not tainted
tulip                  38016   1
ds                      6368   2
yenta_socket            8704   2
pcmcia_core            31872   0 [ds yenta_socket]
nls_iso8859-1           2880   1 (autoclean)
nls_cp437               4384   1 (autoclean)
vfat                    9244   1 (autoclean)
fat                    28888   0 (autoclean) [vfat]

relevant part of dmesg:
apm: BIOS version 1.2 Flags 0x02 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
vesafb: framebuffer at 0xff800000, mapped to 0xcc80d000, size 2560k
vesafb: mode is 1024x768x16, linelength=2048, pages=0
vesafb: protected mode interface info at c000:6d44
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device

lspci -v
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(AGP disabled) (rev 03)
         Subsystem: Toshiba America Info Systems: Unknown device 0001
         Flags: bus master, medium devsel, latency 64
         Memory at e0000000 (32-bit, prefetchable) [size=256M]

00:02.0 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
         Subsystem: Toshiba America Info Systems: Unknown device 0001
         Flags: bus master, slow devsel, latency 0, IRQ 11
         Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
         Bus: primary=00, secondary=14, subordinate=14, sec-latency=0
         Memory window 0: 10400000-107ff000 (prefetchable)
         Memory window 1: 10800000-10bff000
         I/O window 0: 00004000-000040ff
         I/O window 1: 00004400-000044ff
         16-bit legacy interface ports at 0001

00:02.1 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
         Subsystem: Toshiba America Info Systems: Unknown device 0001
         Flags: bus master, slow devsel, latency 0, IRQ 11
         Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
         Bus: primary=00, secondary=15, subordinate=15, sec-latency=0
         Memory window 0: 10c00000-10fff000 (prefetchable)
         Memory window 1: 11000000-113ff000
         I/O window 0: 00004800-000048ff
         I/O window 1: 00004c00-00004cff
         16-bit legacy interface ports at 0001

00:04.0 VGA compatible controller: Trident Microsystems Cyber 9525 (rev 49) 
(prog-if 00 [VGA])
         Subsystem: Toshiba America Info Systems: Unknown device 0001
         Flags: bus master, 66Mhz, medium devsel, latency 8, IRQ 11
         Memory at ff800000 (32-bit, non-prefetchable) [size=4M]
         Memory at ff7e0000 (32-bit, non-prefetchable) [size=128K]
         Memory at ff000000 (32-bit, non-prefetchable) [size=4M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [80] AGP version 1.0
         Capabilities: [90] Power Management version 1

00:05.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
         Flags: bus master, medium devsel, latency 0

00:05.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 
80 [Master])
         Flags: bus master, medium devsel, latency 64
         I/O ports at 1000 [size=16]

00:05.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
         Flags: bus master, medium devsel, latency 64, IRQ 11
         I/O ports at ffe0 [size=32]

00:05.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
         Flags: medium devsel, IRQ 9

00:07.0 Communication controller: Lucent Microelectronics 56k WinModem (rev 01)
         Subsystem: Toshiba America Info Systems Internal V.90 Modem
         Flags: bus master, medium devsel, latency 0, IRQ 3
         Memory at ffefff00 (32-bit, non-prefetchable) [size=256]
         I/O ports at 02f8 [size=8]
         I/O ports at 1c00 [size=256]
         Capabilities: [f8] Power Management version 2

00:0a.0 Communication controller: Toshiba America Info Systems FIR Port (rev 23)
         Subsystem: Toshiba America Info Systems: Unknown device 0001
         Flags: bus master, slow devsel, latency 64, IRQ 11
         I/O ports at ff80 [size=32]

00:0c.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
         Subsystem: Toshiba America Info Systems ES1978 Maestro-2E Audiodrive
         Flags: bus master, medium devsel, latency 64, IRQ 11
         I/O ports at fc00 [size=256]
         Capabilities: [c0] Power Management version 2

15:00.0 Ethernet controller: Abocom Systems Inc: Unknown device ab02 (rev 11)
         Subsystem: Abocom Systems Inc: Unknown device ab02
         Flags: bus master, medium devsel, latency 64, IRQ 11
         I/O ports at 4800 [size=256]
         Memory at 11000000 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at 10c00000 [size=128K]
         Capabilities: [c0] Power Management version 2

If you need any other info, please tell me.
Thanks for your help

