Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbTFWVEa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 17:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265486AbTFWVEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 17:04:30 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59789 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265468AbTFWVEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 17:04:22 -0400
Date: Mon, 23 Jun 2003 23:18:00 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
In-Reply-To: <20030623194514.GW6353@lug-owl.de>
Message-ID: <Pine.SOL.4.30.0306232315480.8078-200000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1903590565-1056403080=:8078"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1903590565-1056403080=:8078
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE


On Mon, 23 Jun 2003, Jan-Benedict Glaw wrote:

> Hi!
>
> I've played a bit with my "mirror" machine
>
> - 200MHz Pentium-MMX
> - 64MB RAM
> - jbglaw@mirror:~$ cat /proc/ide/hd*/model
>   WDC AC2850F=09=09# System drive
>   IC35L040AVER07-0=09# \
>   IC35L120AVV207-0=09#   > Storage (with DM/LVM)
>   Maxtor 4W100H6=09# /
> - jbglaw@mirror:~$ lspci |grep IDE
>   00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
> - Linux v2.5.73
> - <*> Intel PIIXn chipsets support
>
> Basically, if I enable Taskfile I/O, the box refuses to boot (basically,
> the first drive sounds really broken like "clack   clack   clack" and no
> data comes off the drive so there's no partition table, no root FS, but
> a panic:) Is anybody interested in nailing this bug down?

YES

> Disabling Taskfile lets me boot the box, but hdc doesn't like TCQ and
> gives errors:
>
> ide_tcq_intr_timeout: timeout waiting for service interrupt
> ide_tcq_intr_timeout: missing isr!
> hdc: invalidating tag queue (0 commands)
> hdc: drive_cmd: status=3D0x51 { DriveReady SeekComplete Error }
> hdc: drive_cmd: error=3D0x04 { DriveStatusError }
> [above messages repeat...]

TCQ shouldn't be enabled on hdc, you have two drives on second ide
channel and current TCQ driver design allows only one drive per channel,
so proper fix is to not enable TCQ :-).

Can you try attached patch?

Regards,
--
Bartlomiej

> IDE's boot log:
>
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=
=3Dxx
> PIIX4: IDE controller at PCI slot 00:07.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> hda: WDC AC2850F, ATA DISK drive
> hdb: IC35L040AVER07-0, ATA DISK drive
> hda: tcq forbidden by blacklist
> hdb: only one drive on a channel supported for tcq
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: IC35L120AVV207-0, ATA DISK drive
> hdd: Maxtor 4W100H6, ATA DISK drive
> hdc: tagged command queueing enabled, command queue depth 32
> hdd: only one drive on a channel supported for tcq
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> hda: task_no_data_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=3D0x04 { DriveStatusError }
> hda: 1667232 sectors (854 MB) w/64KiB Cache, CHS=3D1654/16/63, DMA
>  hda: hda1 hda2 hda3
> hdb: max request size: 128KiB
> hdb: host protected area =3D> 1
> hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=3D79780/16/63, UDMA=
(33)
>  hdb: hdb1 hdb2 hdb3 hdb4
> hdc: max request size: 1024KiB
> hdc: host protected area =3D> 1
> hdc: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=3D15017/255/63, U=
DMA(33)
>  hdc: hdc1 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 hdc11 hdc12 hdc13 hdc14 hdc15=
 hdc16 hdc17 >
> hdd: max request size: 128KiB
> hdd: host protected area =3D> 1
> hdd: 195711264 sectors (100204 MB) w/2048KiB Cache, CHS=3D194158/16/63, U=
DMA(33)
>  hdd: hdd1 < hdd5 hdd6 hdd7 hdd8 hdd9 hdd10 hdd11 hdd12 hdd13 hdd14 >
>
> IDE settings:
> mirror:~# lspci -xxx -v -d 8086:7111
> 00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog=
-if 80 [Master])
>         Flags: bus master, medium devsel, latency 64
>         I/O ports at f000 [size=3D16]
> 00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 01 f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 77 e1 77 e3 bb 00 00 00 0e 00 20 22 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 28 0f 00 00 00 00 00 00
>
> MfG, JBG
>
> --
>    Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>    "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Kr=
ieg
>     fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im I=
rak!
>       ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA=
));

---559023410-1903590565-1056403080=:8078
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ide-tcq-init-fixes.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.30.0306232318000.8078@mion.elka.pw.edu.pl>
Content-Description: 
Content-Disposition: attachment; filename="ide-tcq-init-fixes.patch"

DQpbaWRlXSBUQ1EgaW5pdGlhbGl6YXRpb24gZml4ZXMNCg0KLSBkbyBub3Qg
ZW5hYmxlIFRDUSBpbiBpZGVfaW5pdF9kcml2ZSgpLCBpdHMgdG9vIGVhcmx5
DQotIGVuYWJsZSBUQ1EgaW4gX19pZGVfZG1hX29uKCkgb25seSBpZiBDT05G
SUdfQkxLX0RFVl9JREVfVENRX0RFRkFVTFQ9eQ0KDQogZHJpdmVycy9pZGUv
aWRlLWRtYS5jICAgfCAgICA4ICsrKystLS0tDQogZHJpdmVycy9pZGUvaWRl
LXByb2JlLmMgfCAgICA1IC0tLS0tDQogaW5jbHVkZS9saW51eC9pZGUuaCAg
ICAgfCAgICAxIC0NCiAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLXB1TiBkcml2ZXJzL2lkZS9p
ZGUtcHJvYmUuY35pZGUtdGNxLWluaXQtZml4ZXMgZHJpdmVycy9pZGUvaWRl
LXByb2JlLmMNCi0tLSBsaW51eC0yLjUuNzMvZHJpdmVycy9pZGUvaWRlLXBy
b2JlLmN+aWRlLXRjcS1pbml0LWZpeGVzCU1vbiBKdW4gMjMgMjM6MTA6MTEg
MjAwMw0KKysrIGxpbnV4LTIuNS43My1yb290L2RyaXZlcnMvaWRlL2lkZS1w
cm9iZS5jCU1vbiBKdW4gMjMgMjM6MTA6MTEgMjAwMw0KQEAgLTk4Myw3ICs5
ODMsNiBAQCBzdGF0aWMgdm9pZCBpZGVfaW5pdF9xdWV1ZShpZGVfZHJpdmVf
dCAqDQogCSANCiAJYmxrX2luaXRfcXVldWUocSwgZG9faWRlX3JlcXVlc3Qs
ICZpZGVfbG9jayk7DQogCXEtPnF1ZXVlZGF0YSA9IEhXR1JPVVAoZHJpdmUp
Ow0KLQlkcml2ZS0+cXVldWVfc2V0dXAgPSAxOw0KIAlibGtfcXVldWVfc2Vn
bWVudF9ib3VuZGFyeShxLCAweGZmZmYpOw0KIA0KIAlpZiAoIWh3aWYtPnJx
c2l6ZSkNCkBAIC0xMDA1LDEwICsxMDA0LDYgQEAgc3RhdGljIHZvaWQgaWRl
X2luaXRfcXVldWUoaWRlX2RyaXZlX3QgKg0KIHN0YXRpYyB2b2lkIGlkZV9p
bml0X2RyaXZlKGlkZV9kcml2ZV90ICpkcml2ZSkNCiB7DQogCWlkZV90b2dn
bGVfYm91bmNlKGRyaXZlLCAxKTsNCi0NCi0jaWZkZWYgQ09ORklHX0JMS19E
RVZfSURFX1RDUV9ERUZBVUxUDQotCUhXSUYoZHJpdmUpLT5pZGVfZG1hX3F1
ZXVlZF9vbihkcml2ZSk7DQotI2VuZGlmDQogfQ0KIA0KIC8qDQpkaWZmIC1w
dU4gZHJpdmVycy9pZGUvaWRlLWRtYS5jfmlkZS10Y3EtaW5pdC1maXhlcyBk
cml2ZXJzL2lkZS9pZGUtZG1hLmMNCi0tLSBsaW51eC0yLjUuNzMvZHJpdmVy
cy9pZGUvaWRlLWRtYS5jfmlkZS10Y3EtaW5pdC1maXhlcwlNb24gSnVuIDIz
IDIzOjEwOjExIDIwMDMNCisrKyBsaW51eC0yLjUuNzMtcm9vdC9kcml2ZXJz
L2lkZS9pZGUtZG1hLmMJTW9uIEp1biAyMyAyMzoxMDoxMSAyMDAzDQpAQCAt
NTIzLDggKzUyMyw3IEBAIGludCBfX2lkZV9kbWFfb2ZmX3F1aWV0bHkgKGlk
ZV9kcml2ZV90ICoNCiAJaWYgKEhXSUYoZHJpdmUpLT5pZGVfZG1hX2hvc3Rf
b2ZmKGRyaXZlKSkNCiAJCXJldHVybiAxOw0KIA0KLQlpZiAoZHJpdmUtPnF1
ZXVlX3NldHVwKQ0KLQkJSFdJRihkcml2ZSktPmlkZV9kbWFfcXVldWVkX29m
Zihkcml2ZSk7DQorCUhXSUYoZHJpdmUpLT5pZGVfZG1hX3F1ZXVlZF9vZmYo
ZHJpdmUpOw0KIA0KIAlyZXR1cm4gMDsNCiB9DQpAQCAtNTg1LDggKzU4NCw5
IEBAIGludCBfX2lkZV9kbWFfb24gKGlkZV9kcml2ZV90ICpkcml2ZSkNCiAJ
aWYgKEhXSUYoZHJpdmUpLT5pZGVfZG1hX2hvc3Rfb24oZHJpdmUpKQ0KIAkJ
cmV0dXJuIDE7DQogDQotCWlmIChkcml2ZS0+cXVldWVfc2V0dXApDQotCQlI
V0lGKGRyaXZlKS0+aWRlX2RtYV9xdWV1ZWRfb24oZHJpdmUpOw0KKyNpZmRl
ZiBCTEtfREVWX0lERV9UQ1FfREVGQVVMVA0KKwlIV0lGKGRyaXZlKS0+aWRl
X2RtYV9xdWV1ZWRfb24oZHJpdmUpOw0KKyNlbmRpZg0KIA0KIAlyZXR1cm4g
MDsNCiB9DQpkaWZmIC1wdU4gaW5jbHVkZS9saW51eC9pZGUuaH5pZGUtdGNx
LWluaXQtZml4ZXMgaW5jbHVkZS9saW51eC9pZGUuaA0KLS0tIGxpbnV4LTIu
NS43My9pbmNsdWRlL2xpbnV4L2lkZS5ofmlkZS10Y3EtaW5pdC1maXhlcwlN
b24gSnVuIDIzIDIzOjEwOjExIDIwMDMNCisrKyBsaW51eC0yLjUuNzMtcm9v
dC9pbmNsdWRlL2xpbnV4L2lkZS5oCU1vbiBKdW4gMjMgMjM6MTA6MTEgMjAw
Mw0KQEAgLTcyNiw3ICs3MjYsNiBAQCB0eXBlZGVmIHN0cnVjdCBpZGVfZHJp
dmVfcyB7DQogCXVuc2lnbmVkIGF0YV9mbGFzaAk6IDE7CS8qIDE9cHJlc2Vu
dCwgMD1kZWZhdWx0ICovDQogCXVuc2lnbmVkIGJsb2NrZWQgICAgICAgIDog
MTsJLyogMT1wb3dlcm1hbmFnbWVudCB0b2xkIHVzIG5vdCB0byBkbyBhbnl0
aGluZywgc28gc2xlZXAgbmljZWx5ICovDQogCXVuc2lnbmVkIHZkbWEJCTog
MTsJLyogMT1kb2luZyBQSU8gb3ZlciBETUEgMD1kb2luZyBub3JtYWwgRE1B
ICovDQotCXVuc2lnbmVkIHF1ZXVlX3NldHVwCTogMTsNCiAJdW5zaWduZWQg
YWRkcmVzc2luZzsJCS8qICAgICAgOiAzOw0KIAkJCQkJICogIDA9MjgtYml0
DQogCQkJCQkgKiAgMT00OC1iaXQNCg0KXw0K
---559023410-1903590565-1056403080=:8078--
