Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVEaXCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVEaXCJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 19:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVEaXCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 19:02:09 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:57693 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261205AbVEaXB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 19:01:59 -0400
Message-ID: <429CECE3.1060904@tls.msk.ru>
Date: Wed, 01 Jun 2005 03:01:55 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: PNP parallel&serial ports: module reload fails (2.6.11)?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticied that parport_pc and 8250[_pnp] modules
can't be re-loaded without rebooting when PNP is
turned on in kernel config.  Here's how it looks
like:

[boot]
May 26 07:58:41 linux kernel: pnp: PnP ACPI init
May 26 07:58:41 linux kernel: pnp: PnP ACPI: found 15 devices
May 26 07:58:41 linux kernel: pnp: 00:09: ioport range 0x680-0x6ff has been reserved
May 26 07:58:41 linux kernel: pnp: 00:0d: ioport range 0x400-0x47f could not be reserved
May 26 07:58:41 linux kernel: pnp: 00:0d: ioport range 0x680-0x6ff has been reserved
May 26 07:58:41 linux kernel: pnp: 00:0d: ioport range 0x500-0x53f has been reserved
May 26 07:58:41 linux kernel: pnp: 00:0d: ioport range 0x500-0x53f has been reserved
May 26 07:58:41 linux kernel: pnp: 00:0d: ioport range 0x400-0x47f could not be reserved
May 26 07:58:41 linux kernel: pnp: 00:0d: ioport range 0x295-0x296 has been reserved
May 26 07:58:41 linux kernel: pnp: 00:0d: ioport range 0x3e0-0x3e7 has been reserved
May 26 07:58:41 linux kernel: isapnp: Scanning for PnP cards...
May 26 07:58:41 linux kernel: isapnp: No Plug & Play device found

[modprobe parport_pc]
May 26 07:58:44 linux kernel: parport: PnPBIOS parport detected.
May 26 07:58:44 linux kernel: parport0: PC-style at 0x378, irq 7 [PCSPP]
May 26 07:58:44 linux kernel: lp0: using parport0 (interrupt-driven).

[rmmood parport_pc]
Jun  1 02:45:38 linux kernel: pnp: Device 00:08 disabled.

[modprobe parport_pc]
Jun  1 02:45:46 linux kernel: pnp: Device 00:08 activated.
Jun  1 02:45:46 linux kernel: parport: PnPBIOS parport detected.
Jun  1 02:45:46 linux kernel: pnp: Device 00:08 disabled.

[rmmod parport_pc]
Jun  1 02:45:56 linux kernel: lp: driver loaded but no devices found

[modprobe parport_pc io=0x378 irq=7]
Jun  1 02:46:31 linux kernel: parport 0x378 (WARNING): CTR: wrote 0x0c, read 0xff
Jun  1 02:46:31 linux kernel: parport 0x378 (WARNING): DATA: wrote 0xaa, read 0xff
Jun  1 02:46:31 linux kernel: parport 0x378: You gave this address, but there is probably no parallel port there!
Jun  1 02:46:31 linux kernel: parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Jun  1 02:46:31 linux kernel: lp0: using parport0 (interrupt-driven).

Ie, for some reason, on second module loading, the device
isn't being enabled or something like that, maybe after
first "pnp: Device 00:08 disabled.".  The only way to cure
the problem is to reboot the machine.  The same is true for
8250[_pnp] module aswell, with very similar effects.

Is it just me, or is it some known issue?

And maybe somewhat related issue..  When playing with this stuff on
another machine, I got kernel OOPS on first rmmod of parport_pc:

parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
parport_pc: VIA parallel port: io=0x378, irq=7
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
d027b7cf
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: parport_pc parport 8139too mii crc32 ppp_deflate zlib_deflate zlib_inflate bsd_comp
ppp_async crc_ccitt md5 ipv6 supermount dm_mod sd_mod evdev tuner saa7134 video_buf v4l2_common
v4l1_compat i2c_core ir_common videodev button rtc mousedev 8250_pnp 8250 serial_core usbhid psmouse
ide_cd cdrom ppp_generic slhc usb_storage scsi_mod uhci_hcd usbcore snd_via82xx snd_ac97_codec
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device
snd soundcore floppy ext3 jbd mbcache ide_disk via82cxxx ide_core
CPU:    0
EIP:    0060:[<d027b7cf>]    Not tainted VLI
EFLAGS: 00010286   (2.6.11-c3-6)
EIP is at parport_pc_pci_remove+0xf/0x40 [parport_pc]
eax: cf74f044   ebx: cf74f000   ecx: d0280634   edx: d027b7c0
esi: 00000000   edi: d02805e8   ebp: c5c16000   esp: c5c16f20
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 3347, threadinfo=c5c16000 task=c4e7f5a0)
Stack: cf74f000 cf74f044 c018a324 cf74f068 c01cc8a4 d0280634 d0280634 00000000
        c01cc8c8 d02805e8 d0280780 c01ccca4 d02805e8 d0280780 c01cd178 d02805c0
        c018a4db c5c16000 d027bbdc c01290ba 00000000 70726170 5f74726f 00006370
Call Trace:
  [<c018a324>] pci_device_remove+0x34/0x40
  [<c01cc8a4>] device_release_driver+0x64/0x70
  [<c01cc8c8>] driver_detach+0x18/0x30
  [<c01ccca4>] bus_remove_driver+0x34/0x70
  [<c01cd178>] driver_unregister+0x8/0x20
  [<c018a4db>] pci_unregister_driver+0xb/0x20
  [<d027bbdc>] parport_pc_exit+0x5c/0x5e [parport_pc]
  [<c01290ba>] sys_delete_module+0x12a/0x160
  [<c013e9fa>] unmap_vma_list+0x1a/0x30
  [<c013eced>] do_munmap+0xcd/0x100
  [<c013ed55>] sys_munmap+0x35/0x50
  [<c0102d27>] syscall_call+0x7/0xb
Code: ff ff ff 89 e8 ff d6 85 c0 0f 84 88 fe ff ff eb a6 8d 74 26 00 8d bc 27 00 00 00 00 56 53 83 c0 44 8b 70 74 c7 40 74 00 00 00 00 <8b> 1e 4b 78 18 8d b6 00 00 00 00 8d bf 00 00 00 00 8b 44 9e 04

Thanks.

/mjt
