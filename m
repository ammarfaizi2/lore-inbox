Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVH2SVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVH2SVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVH2SVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:21:10 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:20686 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S1751269AbVH2SVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:21:08 -0400
Date: Mon, 29 Aug 2005 18:20:56 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: linux-raid <linux-raid@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Where is the performance bottleneck?
Message-ID: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="646810922-1673426110-1125339656=:24072"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--646810922-1673426110-1125339656=:24072
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hello

I have a system with the following setup:

     Board is Tyan S4882 with AMD 8131 Chipset
     4 Opterons 848 (2.2GHz)
     8 GB DDR400 Ram (2GB for each CPU)
     1 onboard Symbios Logic 53c1030 dual channel U320 controller
     2 SATA disks put together as a SW Raid1 for system, swap and spares
     8 SCSI U320 (15000 rpm) disks where 4 disks (sdc, sdd, sde, sdf)
       are on one channel and the other four (sdg, sdh, sdi, sdj) on
       the other channel.

The U320 SCSI controller has a 64 bit PCI-X bus for itself, there is no other
device on that bus. Unfortunatly I was unable to determine at what speed
it is running, here the output from lspci -vv:

02:04.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-
         Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
         Latency: 72 (4250ns min, 4500ns max), Cache Line Size 10
         Interrupt: pin A routed to IRQ 217
         Region 0: I/O ports at 3000 [size=256]
         Region 1: Memory at fe010000 (64-bit, non-prefetchable) [size=64K]
         Region 3: Memory at fe000000 (64-bit, non-prefetchable) [size=64K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable
                 Address: 0000000000000000  Data: 0000
         Capabilities: [68] PCI-X non-bridge device.
                 Command: DPERE- ERO- RBC=2 OST=0
                 Status: Bus=2 Dev=4 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple,

02:04.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-
         Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
         Latency: 72 (4250ns min, 4500ns max), Cache Line Size 10
         Interrupt: pin B routed to IRQ 225
         Region 0: I/O ports at 3400 [size=256]
         Region 1: Memory at fe030000 (64-bit, non-prefetchable) [size=64K]
         Region 3: Memory at fe020000 (64-bit, non-prefetchable) [size=64K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable
                 Address: 0000000000000000  Data: 0000
         Capabilities: [68] PCI-X non-bridge device.
                 Command: DPERE- ERO- RBC=2 OST=0
                 Status: Bus=2 Dev=4 Func=1 64bit+ 133MHz+ SCD- USC-, DC=simple,

How does one determine the PCI-X bus speed?

Anyway, I thought with this system I would get theoretically 640 MB/s using
both channels. I tested several software raid setups to get the best possible
write speeds for this system. But testing shows that the absolute maximum I
can reach with software raid is only approx. 270 MB/s for writting. Which is
very disappointing.

The tests where done with 2.6.12.5 kernel from kernel.org, scheduler is the
deadline and distribution is fedora core 4 x86_64 with all updates. Chunksize
is always the default from mdadm (64k). Filesystem was always created with the
command mke2fs -j -b4096 -O dir_index /dev/mdx.

I also have tried with 2.6.13-rc7, but here the speed was much lower, the
maximum there was approx. 140 MB/s for writting.

Here some tests I did and the results with bonnie++:

Version  1.03        ------Sequential Output------ --Sequential Input- --Random-
                      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine         Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
Raid0 (8 disk)15744M 54406  96 247419 90 100752 25 60266  98 226651 29 830.2   1
Raid0s(4 disk)15744M 54915  97 253642 89 73976  18 59445  97 198372 24 659.8   1
Raid0s(4 disk)15744M 54866  97 268361 95 72852  17 59165  97 187183 22 666.3   1
Raid0p(4 disk)15744M 54017  96 149897 57 60202  15 59048  96 156887 20 381.8   1
Raid0p(4 disk)15744M 54771  98 156129 59 54130  14 58941  97 157543 20 520.3   1
Raid1+0       15744M 52496  94 202497 77 55928  14 60150  98 270509 34 930.2   1
Raid0+1       15744M 53927  95 194492 66 53430  15 49590  83 174313 30 884.7   1
Raid5 (8 disk)15744M 55881  98 153735 51 61680  24 56229  95 207348 44 741.2   1
Raid5s(4 disk)15744M 55238  98 81023  28 36859  14 56358  95 193030 38 605.7   1
Raid5s(4 disk)15744M 54920  97 83680  29 36551  14 56917  95 185345 35 599.8   1
Raid5p(4 disk)15744M 53681  95 54517  20 44932  17 54808  93 172216 33 371.1   1
Raid5p(4 disk)15744M 53856  96 55901  21 34737  13 55810  94 181825 36 607.7   1
/dev/sdc      15744M 53861  95 102270 35 25718   6 37273  60 76275   8 377.0   0
/dev/sdd      15744M 53575  95 96846  36 26209   6 37248  60 76197   9 378.4   0
/dev/sde      15744M 54398  94 87937  28 25540   6 36476  59 76520   8 380.4   0
/dev/sdf      15744M 53982  95 109192 38 26136   6 38516  63 76277   9 383.0   0
/dev/sdg      15744M 53880  95 102625 36 26458   6 37926  61 76538   9 399.1   0
/dev/sdh      15744M 53326  95 106447 39 26570   6 38129  62 76427   9 384.3   0
/dev/sdi      15744M 53103  94 96976  33 25632   6 36748  59 76658   8 386.4   0
/dev/sdj      15744M 53840  95 105521 39 26251   6 37146  60 76097   9 384.8   0

Raid1+0        - Four raid1's where each disk of one raid1 hangs on one
                  channel. The setup was done as follows:
                              Raid1 /dev/md3 (sdc + sdg)
                              Raid1 /dev/md4 (sdd + sdh)
                              Raid1 /dev/md5 (sde + sdi)
                              Raid1 /dev/md6 (sdf + sdj)
                              Raid0 /dev/md7 (md3 + md4 + md5 + md6)
Raid0+1        - Raid1 over two raid0 each having four disks:
                              Raid0 /dev/md3 (sdc + sdd + sde + sdf)
                              Raid0 /dev/md4 (sdg + sdh + sdi + sdj)
                              Raid1 /dev/md5 (md3 + md4)
Raid0s(4 disk) - Consists of Raid0 /dev/md3 sdc + sdd + sde + sdf or
                  Raid0 /dev/md4 sdg + sdh + sdi + sdj and the test where
                  done separate once for md3 and then for md4.
Raid0p(4 disk) - Same as Raid0s(4 disk) only the test for md3 and md4 where
                  done at the same time (parallel).
Raid5s(4 disk) - Same as Raid0s(4 disk) only with Raid5.
Raid5p(4 disk) - Same as Raid0p(4 disk) only with Raid5.

Additional tests where done with a little C program (attached to this mail)
that I wrote a long time ago. It measures the time it takes to write a file
of the given size, first result is without fsync() and second result with
fsync(). It is called with two parameters, the first is the file size in
Kilobytes and the second is the blocksize in bytes. The program was always
started as follows:

          fw 16121856 4096

I choose 4096 as blocksize since this is value that is suggested by stat()
st_blksize. With larger values the transfer rate increases.

Here the results in MB/s:
Raid0 (8 disk) 203.017 191.649
Raid0s(4 disk) 200.331 166.129
Raid0s(4 disk) 198.013 165.465
Raid0p(4 disk) 143.781 118.832
Raid0p(4 disk) 146.592 117.703
Raid0+1        206.046 118.670
Raid5 (8 disk) 181.382 115.037
/dev/sdc        94.439  56.928
/dev/sdd        89.838  55.711
/dev/sde        84.391  51.545
/dev/sdf        87.549  57.368
/dev/sdg        92.847  57.799
/dev/sdh        94.615  58.678
/dev/sdi        89.030  54.945
/dev/sdj        91.344  56.899

Why do I only get 247 MB/s for writting and 227 MB/s for reading (from the
bonnie++ results) for a Raid0 over 8 disks? I was expecting to get nearly
three times those numbers if you take the numbers from the individual disks.

What limit am I hitting here?

Thanks,
Holger
-- 
--646810922-1673426110-1125339656=:24072
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fw.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0508291820560.24072@diagnostix.dwd.de>
Content-Description: 
Content-Disposition: attachment; filename="fw.c"

LyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLw0KLyogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgRmlsZSBXcml0ZSBQZXJmb3JtYW5jZSAg
ICAgICAgICAgICAgICAgICAgICAgICAqLw0KLyogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPT09PT09PT09PT09PT09PT09PT09PSAgICAgICAgICAg
ICAgICAgICAgICAgICAqLw0KLyoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqLw0KDQojaW5jbHVkZSA8c3RkaW8uaD4gICAgICAvKiBwcmludGYo
KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICov
DQojaW5jbHVkZSA8c3RyaW5nLmg+ICAgICAvKiBzdHJjbXAoKSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQojaW5jbHVk
ZSA8c3RkbGliLmg+ICAgICAvKiBleGl0KCksIGF0b2koKSwgY2FsbG9jKCks
IGZyZWUoKSAgICAgICAgICAgICAgICAgICovDQojaW5jbHVkZSA8dW5pc3Rk
Lmg+ICAgICAvKiB3cml0ZSgpLCBzeXNjb25mKCksIGNsb3NlKCksIGZzeW5j
KCkgICAgICAgICAgICAgICovDQojaW5jbHVkZSA8c3lzL3RpbWVzLmg+ICAv
KiB0aW1lcygpLCBzdHJ1Y3QgdG1zICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICovDQojaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQojaW5jbHVkZSA8
c3lzL3N0YXQuaD4NCiNpbmNsdWRlIDxmY250bC5oPg0KI2luY2x1ZGUgPGVy
cm5vLmg+DQojaW5jbHVkZSA8c3RkYXJnLmg+DQoNCiNkZWZpbmUgTUFYTElO
RSAgICAgICAgICAgICA0MDk2DQojZGVmaW5lIEJVRlNJWkUgICAgICAgICAg
ICAgNTEyDQojZGVmaW5lIERFRkFVTFRfRklMRV9TSVpFICAgMzE0NTcyODAN
CiNkZWZpbmUgVEVTVF9GSUxFICAgICAgICAgICAidGVzdC5maWxlIg0KI2Rl
ZmluZSBGSUxFX01PREUgICAgICAgICAgIChTX0lSVVNSIHwgU19JV1VTUiB8
IFNfSVJHUlAgfCBTX0lST1RIKQ0KDQoNCnN0YXRpYyB2b2lkIGVycl9kb2l0
KGludCwgY2hhciAqLCB2YV9saXN0KSwNCiAgICAgICAgICAgIGVycl9xdWl0
KGNoYXIgKiwgLi4uKSwNCiAgICAgICAgICAgIGVycl9zeXMoY2hhciAqLCAu
Li4pOw0KDQoNCi8qIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyBt
YWluKCkgIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjKi8N
CmludA0KbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0Kew0KICAgcmVn
aXN0ZXIgICAgbiwNCiAgICAgICAgICAgICAgIGxvb3BzLA0KICAgICAgICAg
ICAgICAgcmVzdDsNCiAgIGludCAgICAgICAgIGZkLA0KICAgICAgICAgICAg
ICAgb2ZsYWcsDQogICAgICAgICAgICAgICBibG9ja3NpemUgPSBCVUZTSVpF
Ow0KICAgb2ZmX3QgICAgICAgZmlsZXNpemUgPSBERUZBVUxUX0ZJTEVfU0la
RTsNCiAgIGNsb2NrX3QgICAgIHN0YXJ0LA0KICAgICAgICAgICAgICAgZW5k
LA0KICAgICAgICAgICAgICAgc3luY2VuZDsNCiAgIGxvbmcgICAgICAgIGNs
a3RjazsNCiAgIGNoYXIgICAgICAgICpidWY7DQogICBzdHJ1Y3QgdG1zICB0
bXNkdW1teTsNCg0KICAgaWYgKChhcmdjID4gMSkgJiYgKGFyZ2MgPCA1KSkN
CiAgIHsNCiAgICAgIGZpbGVzaXplID0gKG9mZl90KWF0b2koYXJndlsxXSkg
KiAxMDI0Ow0KICAgICAgaWYgKGFyZ2MgPT0gMykNCiAgICAgICAgIGJsb2Nr
c2l6ZSA9IGF0b2koYXJndlsyXSk7DQogICAgICBlbHNlICBpZiAoYXJnYyA9
PSA0KQ0KICAgICAgICAgICAgICAgZXJyX3F1aXQoIlVzYWdlOiAlcyBbZmls
ZXNpemVdIFtibG9ja3NpemVdIik7DQogICB9DQogICBlbHNlICBpZiAoYXJn
YyAhPSAxKQ0KICAgICAgICAgICAgZXJyX3F1aXQoIlVzYWdlOiAlcyBbZmls
ZXNpemVdIFtibG9ja3NpemVdIiwgYXJndlswXSk7DQoNCiAgIGlmICgoY2xr
dGNrID0gc3lzY29uZihfU0NfQ0xLX1RDSykpIDwgMCkNCiAgICAgIGVycl9z
eXMoInN5c2NvbmYgZXJyb3IiKTsNCg0KICAgLyogSWYgY2xrdGNrPTAgaXQg
ZG9zbid0IG1ha2Ugc2VuY2UgdG8gcnVuIHRoZSB0ZXN0ICovDQogICBpZiAo
Y2xrdGNrID09IDApDQogICB7DQogICAgICAodm9pZClwcmludGYoIjBcbiIp
Ow0KICAgICAgZXhpdCgwKTsNCiAgIH0NCg0KICAgaWYgKChidWYgPSBjYWxs
b2MoYmxvY2tzaXplLCBzaXplb2YoY2hhcikpKSA9PSBOVUxMKQ0KICAgICAg
ZXJyX3N5cygiY2FsbG9jIGVycm9yIik7DQoNCiAgIGZvciAobiA9IDA7IG4g
PCBibG9ja3NpemU7IG4rKykNCiAgICAgIGJ1ZltuXSA9ICdUJzsNCg0KICAg
bG9vcHMgPSBmaWxlc2l6ZSAvIGJsb2Nrc2l6ZTsNCiAgIHJlc3QgPSBmaWxl
c2l6ZSAlIGJsb2Nrc2l6ZTsNCg0KICAgb2ZsYWcgPSBPX1dST05MWSB8IE9f
Q1JFQVQ7DQoNCiAgIGlmICgoZmQgPSBvcGVuKFRFU1RfRklMRSwgb2ZsYWcs
IEZJTEVfTU9ERSkpIDwgMCkNCiAgICAgIGVycl9xdWl0KCJDb3VsZCBub3Qg
b3BlbiAlcyIsIFRFU1RfRklMRSk7DQoNCiAgIGlmICgoc3RhcnQgPSB0aW1l
cygmdG1zZHVtbXkpKSA9PSAtMSkNCiAgICAgIGVycl9zeXMoIkNvdWxkIG5v
dCBnZXQgc3RhcnQgdGltZSIpOw0KDQogICBmb3IgKG4gPSAwOyBuIDwgbG9v
cHM7IG4rKykNCiAgICAgIGlmICh3cml0ZShmZCwgYnVmLCBibG9ja3NpemUp
ICE9IGJsb2Nrc2l6ZSkNCiAgICAgICAgICAgIGVycl9zeXMoIndyaXRlIGVy
cm9yIik7DQogICBpZiAocmVzdCA+IDApDQogICAgICBpZiAod3JpdGUoZmQs
IGJ1ZiwgcmVzdCkgIT0gcmVzdCkNCiAgICAgICAgICAgIGVycl9zeXMoIndy
aXRlIGVycm9yIik7DQoNCiAgIGlmICgoZW5kID0gdGltZXMoJnRtc2R1bW15
KSkgPT0gLTEpDQogICAgICBlcnJfc3lzKCJDb3VsZCBub3QgZ2V0IGVuZCB0
aW1lIik7DQoNCiAgICh2b2lkKWZzeW5jKGZkKTsNCg0KICAgaWYgKChzeW5j
ZW5kID0gdGltZXMoJnRtc2R1bW15KSkgPT0gLTEpDQogICAgICBlcnJfc3lz
KCJDb3VsZCBub3QgZ2V0IGVuZCB0aW1lIik7DQoNCiAgICh2b2lkKWNsb3Nl
KGZkKTsNCiAgIGZyZWUoYnVmKTsNCg0KICAgKHZvaWQpcHJpbnRmKCIlZiAl
ZlxuIiwgKGRvdWJsZSlmaWxlc2l6ZSAvICgoZG91YmxlKShlbmQgLSBzdGFy
dCkgLyAoZG91YmxlKWNsa3RjayksDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAoZG91YmxlKWZpbGVzaXplIC8gKChkb3VibGUpKHN5bmNlbmQgLSBz
dGFydCkgLyAoZG91YmxlKWNsa3RjaykpOw0KDQogICBleGl0KDApOw0KfQ0K
DQoNCnN0YXRpYyB2b2lkDQplcnJfc3lzKGNoYXIgKmZtdCwgLi4uKQ0Kew0K
ICAgdmFfbGlzdCAgYXA7DQoNCiAgIHZhX3N0YXJ0KGFwLCBmbXQpOw0KICAg
ZXJyX2RvaXQoMSwgZm10LCBhcCk7DQogICB2YV9lbmQoYXApOw0KICAgZXhp
dCgxKTsNCn0NCg0KDQpzdGF0aWMgdm9pZA0KZXJyX3F1aXQoY2hhciAqZm10
LCAuLi4pDQp7DQogICB2YV9saXN0ICBhcDsNCg0KICAgdmFfc3RhcnQoYXAs
IGZtdCk7DQogICBlcnJfZG9pdCgwLCBmbXQsIGFwKTsNCiAgIHZhX2VuZChh
cCk7DQogICBleGl0KDEpOw0KfQ0KDQoNCnN0YXRpYyB2b2lkDQplcnJfZG9p
dChpbnQgZXJybm9mbGFnLCBjaGFyICpmbXQsIHZhX2xpc3QgYXApDQp7DQog
ICBpbnQgICBlcnJub19zYXZlOw0KICAgY2hhciAgYnVmW01BWExJTkVdOw0K
DQogICBlcnJub19zYXZlID0gZXJybm87DQogICAodm9pZCl2c3ByaW50Zihi
dWYsIGZtdCwgYXApOw0KICAgaWYgKGVycm5vZmxhZykNCiAgICAgICh2b2lk
KXNwcmludGYoYnVmK3N0cmxlbihidWYpLCAiOiAlcyIsIHN0cmVycm9yKGVy
cm5vX3NhdmUpKTsNCiAgICh2b2lkKXN0cmNhdChidWYsICJcbiIpOw0KICAg
ZmZsdXNoKHN0ZG91dCk7DQogICAodm9pZClmcHV0cyhidWYsIHN0ZGVycik7
DQogICBmZmx1c2goTlVMTCk7ICAgICAvKiBGbHVzaGVzIGFsbCBzdGRpbyBv
dXRwdXQgc3RyZWFtcyAqLw0KICAgcmV0dXJuOw0KfQ0K

--646810922-1673426110-1125339656=:24072--

