Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267681AbTASR6T>; Sun, 19 Jan 2003 12:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267683AbTASR6T>; Sun, 19 Jan 2003 12:58:19 -0500
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:14088 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id <S267681AbTASR6Q> convert rfc822-to-8bit;
	Sun, 19 Jan 2003 12:58:16 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [alsa, pnp] more on opl3sa2
Date: Sun, 19 Jan 2003 19:07:12 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301191907.12450.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

more tests with snd-opl3sa2. i have to use the paramers to modprobe since pnp
doesn't work. the reason:
pnpc_register_driver sets driver.bus to its own static struct which doesn't
have a device list. driver_attach tries to scan this device list and compare
with the drivers device list. since there's no one for the bus it fails, the
driver can't see it's devices.

Call stack:
driver_attach
bus_add_driver
driver_register
pnpc_register_driver
alsa_card_opl3sa_init

ok, tried by hand with the config data from bios/lspnp:
# modprobe snd-opl3sa2 isapnp=0 port=0x538 wss_port=0x530 sb_port=0x220 fm_port=0x388 midi_port=0x330 irq=5 dma1=0 dma2=1
Segmentation fault

Unable to handle kernel NULL pointer dereference at virtual address 00000144
 printing eip:
d08aecfb
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<d08aecfb>]    Not tainted
EFLAGS: 00010246
EIP is at snd_opl3sa2_probe+0x3bb/0x3e4 [snd_opl3sa2]
eax: 00000000   ebx: cd9ace00   ecx: d089b734   edx: 00000000
esi: 00000000   edi: cd9ace6c   ebp: c7e11f84   esp: c7e11f58
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1816, threadinfo=c7e10000 task=ce0527e0)
Stack: 00000000 00000000 00000000 00000000 cd9ace24 00000000 00000001 00000000
       00000005 c82fec00 c9d5fcc4 c7e11fa8 d08b33c2 00000000 00000000 00000000
       00000000 d08b0fe0 c027e304 c027e304 c7e11fbc c01291a2 0804ea38 0804e008
Call Trace:
 [<d08b33c2>] alsa_card_opl3sa2_init+0x2a/0xffffe3cc [snd_opl3sa2]
 [<d08b0fe0>] +0x0/0x100 [snd_opl3sa2]
 [<c01291a2>] sys_init_module+0x116/0x1ac
 [<c010a75b>] syscall_call+0x7/0xb

Code: 89 9a 44 01 00 00 8b 45 e8 89 98 60 0c 8b d0 31 c0 eb 0a 89

100% reproducible.

machine is a toshiba tecra 8000 laptop (p3-500), kernel is 2.5.59 + vmlinux.lds.h patch + 
sound-firmware-load-fix + jaroslav's driver patch + adam's pnp.h id len patch.

kernel config: no acpi, _all_ pnp options enabled. soundcore compiled in, alsa as module.

# lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 03)
00:04.0 VGA compatible controller: Neomagic Corporation [MagicMedia 256AV] (rev 12)
00:05.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:05.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:05.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:05.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:09.0 Communication controller: Toshiba America Info Systems FIR Port (rev 23)
00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)

# lspnp
01 PNP0c01 memory controller: RAM
02 PNP0200 system peripheral: DMA controller
03 PNP0000 system peripheral: programmable interrupt controller
04 PNP0100 system peripheral: system timer
05 PNP0800 system peripheral: other
06 PNP0c04 reserved: other
07 PNP0303 input device: keyboard
08 PNP0f13 input device: mouse
09 PNP0b00 system peripheral: real time clock
0a PNP0c02 system peripheral: other
0b PNP0700 mass storage device: floppy
0e PNP0501 communications device: RS-232
10 PNP0401 communications device: AT parallel port
11 PNP0a03 bridge controller: PCI
14 PNP0e03 bridge controller: PCMCIA
15 YMH0021 multimedia controller: audio

# lspnp -vv 15
15 YMH0021 multimedia controller: audio
    flags: [dynamic]
    allocated resources:
        io 0x0220-0x0233 [16-bit decode]
        io 0x0530-0x0537 [16-bit decode]
        io 0x0388-0x038f [16-bit decode]
        io 0x0330-0x0333 [16-bit decode]
        io 0x0538-0x0539 [16-bit decode]
        irq 5 [high edge]
        dma 0 [8 bit] [count byte] [compat]
        dma 1 [8 bit] [count byte] [compat]
    possible resources:
        [start dep fn]
        io base 0x0220-0x0280 align 0x20 len 0x14 [16-bit decode]
        io 0x0530-0x0537 [16-bit decode]
        io base 0x0388-0x03b8 align 0x10 len 0x08 [16-bit decode]
        io base 0x0300-0x0330 align 0x10 len 0x04 [16-bit decode]
        io 0x0538-0x0539 [16-bit decode]
        irq mask 0x0ca0 [high edge]
        dma mask 0x000b [8 bit] [count byte] [compat]
        dma mask 0x000b [8 bit] [count byte] [compat]
        [start dep fn]
        io base 0x0220-0x0280 align 0x20 len 0x14 [16-bit decode]
        io 0x0530-0x0537 [16-bit decode]
        io base 0x0388-0x03b8 align 0x10 len 0x08 [16-bit decode]
        io base 0x0300-0x0330 align 0x10 len 0x04 [16-bit decode]
        io 0x0538-0x0539 [16-bit decode]
        irq mask 0x0ca0 [high edge]
        dma mask 0x000b [8 bit] [count byte] [compat]
        dma disabled [8 bit] [count byte] [compat]
        [start dep fn]
        io base 0x0220-0x0280 align 0x20 len 0x14 [16-bit decode]
        io 0x0540-0x0547 [16-bit decode]
        io base 0x0388-0x03b8 align 0x10 len 0x08 [16-bit decode]
        io base 0x0300-0x0330 align 0x10 len 0x04 [16-bit decode]
        io 0x0548-0x0549 [16-bit decode]
        irq mask 0x0ca0 [high edge]
        dma mask 0x000b [8 bit] [count byte] [compat]
        dma mask 0x000b [8 bit] [count byte] [compat]
        [start dep fn]
        io base 0x0220-0x0280 align 0x20 len 0x14 [16-bit decode]
        io 0x0540-0x0547 [16-bit decode]
        io base 0x0388-0x03b8 align 0x10 len 0x08 [16-bit decode]
        io base 0x0300-0x0330 align 0x10 len 0x04 [16-bit decode]
        io 0x0548-0x0549 [16-bit decode]
        irq mask 0x0ca0 [high edge]
        dma mask 0x000b [8 bit] [count byte] [compat]
        dma disabled [8 bit] [count byte] [compat]
        [start dep fn]
        io base 0x0220-0x0280 align 0x20 len 0x14 [16-bit decode]
        io 0x0550-0x0557 [16-bit decode]
        io base 0x0388-0x03b8 align 0x10 len 0x08 [16-bit decode]
        io base 0x0300-0x0330 align 0x10 len 0x04 [16-bit decode]
        io 0x0558-0x0559 [16-bit decode]
        irq mask 0x0ca0 [high edge]
        dma mask 0x000b [8 bit] [count byte] [compat]
        dma mask 0x000b [8 bit] [count byte] [compat]
        [start dep fn]
        io base 0x0220-0x0280 align 0x20 len 0x14 [16-bit decode]
        io 0x0550-0x0557 [16-bit decode]
        io base 0x0388-0x03b8 align 0x10 len 0x08 [16-bit decode]
        io base 0x0300-0x0330 align 0x10 len 0x04 [16-bit decode]
        io 0x0558-0x0559 [16-bit decode]
        irq mask 0x0ca0 [high edge]
        dma mask 0x000b [8 bit] [count byte] [compat]
        dma disabled [8 bit] [count byte] [compat]
        [start dep fn]
        io base 0x0220-0x0280 align 0x20 len 0x14 [16-bit decode]
        io 0x0560-0x0567 [16-bit decode]
        io base 0x0388-0x03b8 align 0x10 len 0x08 [16-bit decode]
        io base 0x0300-0x0330 align 0x10 len 0x04 [16-bit decode]
        io 0x0568-0x0569 [16-bit decode]
        irq mask 0x0ca0 [high edge]
        dma mask 0x000b [8 bit] [count byte] [compat]
        dma mask 0x000b [8 bit] [count byte] [compat]
        [start dep fn]
        io base 0x0220-0x0280 align 0x20 len 0x14 [16-bit decode]
        io 0x0560-0x0567 [16-bit decode]
        io base 0x0388-0x03b8 align 0x10 len 0x08 [16-bit decode]
        io base 0x0300-0x0330 align 0x10 len 0x04 [16-bit decode]
        io 0x0568-0x0569 [16-bit decode]
        irq mask 0x0ca0 [high edge]
        dma mask 0x000b [8 bit] [count byte] [compat]
        dma disabled [8 bit] [count byte] [compat]
        [end dep fn]
    compatible devices:
        identifier 'OPL3-SA3 Sound System'


if you need more info or if you want me to test patches...just ask

rgds,
-daniel
