Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310321AbSCGN1K>; Thu, 7 Mar 2002 08:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310320AbSCGN1D>; Thu, 7 Mar 2002 08:27:03 -0500
Received: from pop.gmx.de ([213.165.64.20]:39570 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S310317AbSCGN0r>;
	Thu, 7 Mar 2002 08:26:47 -0500
Message-Id: <200203071040.g27AeT000778@Shakuras.Universe.lan>
From: Carsten Weinhold <carsten.weinhold@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [ide-scsi] hard lock while burning a cd (in 2.4.x)
Date: Thu, 7 Mar 2002 14:00:21 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_LGTLBO9ARQXD08KPWBCM"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_LGTLBO9ARQXD08KPWBCM
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

I recently experienced a hard lock while burning a cd. I was able to=20
reproduce it with kernel 2.4.17, 2.4.18 and 2.4.19-pre2, other versions=20
untested. A friend of my mine could crash his machine, too, even though=20
his hardware is completely different.
It always happened when fixation or blanking of a CDRW finished while=20
trying to read from my DVD drive.

I've attached the OOPS output (processed by ksymoops) and a shell=20
script to reproduce the problem. However this only happened with the=20
following setup (and similar):

- DVD drive is master, CD burner is slave on the same IDE channel
- both drives operate in SCSI-emulation (!important!)
- DMA is on (both drives)

Deactivating DMA for the CD burner or using the DVD drive as an ATAPI=20
device keeps the computer alive. But the DVD drive still doesn't read=20
while fixation/blanking is done (causing a DMA timeout on the DVD=20
drive).

Namely, I got the following warnings/errors:

scsi : aborting command due to timeout : pid 9349, scsi0, channel 0, id=20
0, lun 0
 Read (10) 00 00 00 41 61 00 00 01 00
(two more similar messages)
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status error: status=3D0x68 { DriveReady DeviceFault DataRequest }
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: irq timeout: status=3D0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=3D0xc0 { Busy }

After a few seconds the kernel said oops:

-----------------------------------------------------------------------
ksymoops 2.4.3 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address ef84a752
c020d0c1
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c020d0c1>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
   eax: ef84a5d2   ebx: cd602e40   ecx: 00000000   edx: cd602e40
   esi: c0362210   edi: 000000c0   ebp: c6e3c000   esp: c0303ebc
   ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=3Dc0303000)
Stack: cd602e40 c0362210 000000c0 c03621d0 000000c0 00000000 cd602e40=20
cff75900
       c0362210 c01f6002 00000000 c142d680 c0362110 c142d680 c020d2d0=20
000000c0
       c01f6c00 c0362210 c02b8ba2 000000c0 c142d680 c01f6a70 00000000=20
c033a280
Call Trace: [<c01f6002>] [<c020d2d0>] [<c01f6c00>] [<c01f6a70>]=20
[<c011c2b2>]
   [<c011c32f>] [<c010acc6>] [<c011931a>] [<c0119420>] [<c011904a>]=20
[<c010812d>]
   [<c010a068>] [<c0105193>] [<c0110895>] [<c0110790>] [<c0105170>]=20
[<c0105202>]
   [<c0105000>] [<c0105027>]
Code: c7 80 80 01 00 00 00 00 07 00 83 7c 24 14 00 0f 84 9f 01 00

>>EIP; c020d0c0 <idescsi_end_request+70/280>   <=3D=3D=3D=3D=3D
Trace; c01f6002 <ide_error+122/170>
Trace; c020d2d0 <idescsi_pc_intr+0/240>
Trace; c01f6c00 <ide_timer_expiry+190/1e0>
Trace; c01f6a70 <ide_timer_expiry+0/1e0>
Trace; c011c2b2 <timer_bh+222/260>
Trace; c011c32e <do_timer+3e/70>
Trace; c010acc6 <timer_interrupt+66/120>
Trace; c011931a <bh_action+1a/50>
Trace; c0119420 <ksoftirqd+20/b0>
Trace; c011904a <do_softirq+5a/b0>
Trace; c010812c <do_IRQ+9c/b0>
Trace; c010a068 <call_do_IRQ+6/e>
Trace; c0105192 <default_idle+22/30>
Trace; c0110894 <apm_cpu_idle+104/140>
Trace; c0110790 <apm_cpu_idle+0/140>
Trace; c0105170 <default_idle+0/30>
Trace; c0105202 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>
Trace; c0105026 <rest_init+26/30>
Code;  c020d0c0 <idescsi_end_request+70/280>
00000000 <_EIP>:
Code;  c020d0c0 <idescsi_end_request+70/280>   <=3D=3D=3D=3D=3D
   0:   c7 80 80 01 00 00 00      movl   $0x70000,0x180(%eax)   <=3D=3D=3D=
=3D=3D
Code;  c020d0c6 <idescsi_end_request+76/280>
   7:   00 07 00
Code;  c020d0ca <idescsi_end_request+7a/280>
   a:   83 7c 24 14 00            cmpl   $0x0,0x14(%esp,1)
Code;  c020d0ce <idescsi_end_request+7e/280>
   f:   0f 84 9f 01 00 00         je     1b4 <_EIP+0x1b4> c020d274=20
<idescsi_end_request+224/280>

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.
-----------------------------------------------------------------------

I'm using the hardware/software:
--------------------------------

AMD Athlon on AMD Irongate chipset
Pioneer DVD-ROM ATAPIModel DVD-114 0110 (hdc alias scd0)
SONY CD-RW CRX140E (hdd alias scd1)
Linux 2.4.18 (whith crypto patch)
cdrecord 1.10


Greetings,

Carsten

PS: Could you please CC all following messages to me: cw.news@gmx.net


--------------Boundary-00=_LGTLBO9ARQXD08KPWBCM
Content-Type: application/x-shellscript;
  name="ide-scsi-problem.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ide-scsi-problem.sh"

IyEgL2Jpbi9zaAoKY2F0IC9kZXYvc2NkMCA+IC9kZXYvbnVsbCAmCmNkcmVjb3JkIC1ibGFuaz1t
aW5pbWFsIC1zcGVlZD00IGtkPTMgZGV2PTAsMSwwIHx8IHsgZWNobyAiY2RyZWNvcmQgZmFpbGVk
IjsgZXhpdCAxOyB9CmVjaG8gIllvdSdyZSBsdWNreSEgTXkgbWFjaGluZSBjcmFzaGVkIGJlZm9y
ZSB0aGlzIG1lc3NhZ2UgY291bGQgYmUgcHJpbnRlZCAuLi4iCgo=

--------------Boundary-00=_LGTLBO9ARQXD08KPWBCM
Content-Type: text/plain;
  charset="iso-8859-15";
  name="ide-scsi-ksymoops.output"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ide-scsi-ksymoops.output"

a3N5bW9vcHMgMi40LjMgb24gaTY4NiAyLjQuMTguICBPcHRpb25zIHVzZWQKICAgICAtViAoZGVm
YXVsdCkKICAgICAtayAvcHJvYy9rc3ltcyAoZGVmYXVsdCkKICAgICAtbCAvcHJvYy9tb2R1bGVz
IChkZWZhdWx0KQogICAgIC1vIC9saWIvbW9kdWxlcy8yLjQuMTgvIChkZWZhdWx0KQogICAgIC1t
IC9ib290L1N5c3RlbS5tYXAtMi40LjE4IChkZWZhdWx0KQoKV2FybmluZzogWW91IGRpZCBub3Qg
dGVsbCBtZSB3aGVyZSB0byBmaW5kIHN5bWJvbCBpbmZvcm1hdGlvbi4gIEkgd2lsbAphc3N1bWUg
dGhhdCB0aGUgbG9nIG1hdGNoZXMgdGhlIGtlcm5lbCBhbmQgbW9kdWxlcyB0aGF0IGFyZSBydW5u
aW5nCnJpZ2h0IG5vdyBhbmQgSSdsbCB1c2UgdGhlIGRlZmF1bHQgb3B0aW9ucyBhYm92ZSBmb3Ig
c3ltYm9sIHJlc29sdXRpb24uCklmIHRoZSBjdXJyZW50IGtlcm5lbCBhbmQvb3IgbW9kdWxlcyBk
byBub3QgbWF0Y2ggdGhlIGxvZywgeW91IGNhbiBnZXQKbW9yZSBhY2N1cmF0ZSBvdXRwdXQgYnkg
dGVsbGluZyBtZSB0aGUga2VybmVsIHZlcnNpb24gYW5kIHdoZXJlIHRvIGZpbmQKbWFwLCBtb2R1
bGVzLCBrc3ltcyBldGMuICBrc3ltb29wcyAtaCBleHBsYWlucyB0aGUgb3B0aW9ucy4KClVuYWJs
ZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyBlZjg0
YTc1MgpjMDIwZDBjMQoqcGRlID0gMDAwMDAwMDAKT29wczogMDAwMgpDUFU6ICAgIDAKRUlQOiAg
ICAwMDEwOls8YzAyMGQwYzE+XSAgICBUYWludGVkOiBQClVzaW5nIGRlZmF1bHRzIGZyb20ga3N5
bW9vcHMgLXQgZWxmMzItaTM4NiAtYSBpMzg2CkVGTEFHUzogMDAwMTAwMDIKICAgZWF4OiBlZjg0
YTVkMiAgIGVieDogY2Q2MDJlNDAgICBlY3g6IDAwMDAwMDAwICAgZWR4OiBjZDYwMmU0MAogICBl
c2k6IGMwMzYyMjEwICAgZWRpOiAwMDAwMDBjMCAgIGVicDogYzZlM2MwMDAgICBlc3A6IGMwMzAz
ZWJjCiAgIGRzOiAwMDE4ICAgZXM6IDAwMTggICBzczogMDAxOApQcm9jZXNzIHN3YXBwZXIgKHBp
ZDogMCwgc3RhY2twYWdlPWMwMzAzMDAwKQpTdGFjazogY2Q2MDJlNDAgYzAzNjIyMTAgMDAwMDAw
YzAgYzAzNjIxZDAgMDAwMDAwYzAgMDAwMDAwMDAgY2Q2MDJlNDAgY2ZmNzU5MDAKICAgICAgIGMw
MzYyMjEwIGMwMWY2MDAyIDAwMDAwMDAwIGMxNDJkNjgwIGMwMzYyMTEwIGMxNDJkNjgwIGMwMjBk
MmQwIDAwMDAwMGMwCiAgICAgICBjMDFmNmMwMCBjMDM2MjIxMCBjMDJiOGJhMiAwMDAwMDBjMCBj
MTQyZDY4MCBjMDFmNmE3MCAwMDAwMDAwMCBjMDMzYTI4MApDYWxsIFRyYWNlOiBbPGMwMWY2MDAy
Pl0gWzxjMDIwZDJkMD5dIFs8YzAxZjZjMDA+XSBbPGMwMWY2YTcwPl0gWzxjMDExYzJiMj5dCiAg
IFs8YzAxMWMzMmY+XSBbPGMwMTBhY2M2Pl0gWzxjMDExOTMxYT5dIFs8YzAxMTk0MjA+XSBbPGMw
MTE5MDRhPl0gWzxjMDEwODEyZD5dCiAgIFs8YzAxMGEwNjg+XSBbPGMwMTA1MTkzPl0gWzxjMDEx
MDg5NT5dIFs8YzAxMTA3OTA+XSBbPGMwMTA1MTcwPl0gWzxjMDEwNTIwMj5dCiAgIFs8YzAxMDUw
MDA+XSBbPGMwMTA1MDI3Pl0KQ29kZTogYzcgODAgODAgMDEgMDAgMDAgMDAgMDAgMDcgMDAgODMg
N2MgMjQgMTQgMDAgMGYgODQgOWYgMDEgMDAKCj4+RUlQOyBjMDIwZDBjMCA8aWRlc2NzaV9lbmRf
cmVxdWVzdCs3MC8yODA+ICAgPD09PT09ClRyYWNlOyBjMDFmNjAwMiA8aWRlX2Vycm9yKzEyMi8x
NzA+ClRyYWNlOyBjMDIwZDJkMCA8aWRlc2NzaV9wY19pbnRyKzAvMjQwPgpUcmFjZTsgYzAxZjZj
MDAgPGlkZV90aW1lcl9leHBpcnkrMTkwLzFlMD4KVHJhY2U7IGMwMWY2YTcwIDxpZGVfdGltZXJf
ZXhwaXJ5KzAvMWUwPgpUcmFjZTsgYzAxMWMyYjIgPHRpbWVyX2JoKzIyMi8yNjA+ClRyYWNlOyBj
MDExYzMyZSA8ZG9fdGltZXIrM2UvNzA+ClRyYWNlOyBjMDEwYWNjNiA8dGltZXJfaW50ZXJydXB0
KzY2LzEyMD4KVHJhY2U7IGMwMTE5MzFhIDxiaF9hY3Rpb24rMWEvNTA+ClRyYWNlOyBjMDExOTQy
MCA8a3NvZnRpcnFkKzIwL2IwPgpUcmFjZTsgYzAxMTkwNGEgPGRvX3NvZnRpcnErNWEvYjA+ClRy
YWNlOyBjMDEwODEyYyA8ZG9fSVJRKzljL2IwPgpUcmFjZTsgYzAxMGEwNjggPGNhbGxfZG9fSVJR
KzYvZT4KVHJhY2U7IGMwMTA1MTkyIDxkZWZhdWx0X2lkbGUrMjIvMzA+ClRyYWNlOyBjMDExMDg5
NCA8YXBtX2NwdV9pZGxlKzEwNC8xNDA+ClRyYWNlOyBjMDExMDc5MCA8YXBtX2NwdV9pZGxlKzAv
MTQwPgpUcmFjZTsgYzAxMDUxNzAgPGRlZmF1bHRfaWRsZSswLzMwPgpUcmFjZTsgYzAxMDUyMDIg
PGNwdV9pZGxlKzQyLzYwPgpUcmFjZTsgYzAxMDUwMDAgPF9zdGV4dCswLzA+ClRyYWNlOyBjMDEw
NTAyNiA8cmVzdF9pbml0KzI2LzMwPgpDb2RlOyAgYzAyMGQwYzAgPGlkZXNjc2lfZW5kX3JlcXVl
c3QrNzAvMjgwPgowMDAwMDAwMCA8X0VJUD46CkNvZGU7ICBjMDIwZDBjMCA8aWRlc2NzaV9lbmRf
cmVxdWVzdCs3MC8yODA+ICAgPD09PT09CiAgIDA6ICAgYzcgODAgODAgMDEgMDAgMDAgMDAgICAg
ICBtb3ZsICAgJDB4NzAwMDAsMHgxODAoJWVheCkgICA8PT09PT0KQ29kZTsgIGMwMjBkMGM2IDxp
ZGVzY3NpX2VuZF9yZXF1ZXN0Kzc2LzI4MD4KICAgNzogICAwMCAwNyAwMCAKQ29kZTsgIGMwMjBk
MGNhIDxpZGVzY3NpX2VuZF9yZXF1ZXN0KzdhLzI4MD4KICAgYTogICA4MyA3YyAyNCAxNCAwMCAg
ICAgICAgICAgIGNtcGwgICAkMHgwLDB4MTQoJWVzcCwxKQpDb2RlOyAgYzAyMGQwY2UgPGlkZXNj
c2lfZW5kX3JlcXVlc3QrN2UvMjgwPgogICBmOiAgIDBmIDg0IDlmIDAxIDAwIDAwICAgICAgICAg
amUgICAgIDFiNCA8X0VJUCsweDFiND4gYzAyMGQyNzQgPGlkZXNjc2lfZW5kX3JlcXVlc3QrMjI0
LzI4MD4KCiA8MD5LZXJuZWwgcGFuaWM6IEFpZWUsIGtpbGxpbmcgaW50ZXJydXB0IGhhbmRsZXIh
CgoxIHdhcm5pbmcgaXNzdWVkLiAgUmVzdWx0cyBtYXkgbm90IGJlIHJlbGlhYmxlLgo=

--------------Boundary-00=_LGTLBO9ARQXD08KPWBCM--
