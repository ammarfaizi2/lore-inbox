Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTDYTfl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 15:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbTDYTfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 15:35:41 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:54501 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261845AbTDYTfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 15:35:39 -0400
Date: Fri, 25 Apr 2003 21:47:28 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marek Habersack <grendel@caudium.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Lost interrupts with IDE DMA on 2.5.x
In-Reply-To: <20030425185802.GA4391@thanes.org>
Message-ID: <Pine.SOL.4.30.0304252143370.602-200000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1051300048=:602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1051300048=:602
Content-Type: TEXT/PLAIN; charset=US-ASCII


Attached patch should help, please try.

--
Bartlomiej

On Fri, 25 Apr 2003, Marek Habersack wrote:

> Hello,
>
>  I've recently added a second drive to my workstation and since then I'm
> getting the following error from time to time:
>
>   Apr 25 20:42:06 beowulf kernel: hda: dma_timer_expiry: dma status == 0x64
>   Apr 25 20:42:06 beowulf kernel: hda: lost interrupt
>   Apr 25 20:42:06 beowulf kernel: hda: dma_intr: bad DMA status (dma_stat=70)
>   Apr 25 20:42:06 beowulf kernel: hda: dma_intr: status=0x50 { DriveReady
>    SeekComplete }
>
> Both drives are new Maxtors (60 and 40GB) on the VIA KT266 chipset (the mobo
> is MSI K7T266 Pro2-A mobo):
>
> ----------VIA BusMastering IDE Configuration----------------
> Driver Version:                     3.36
> South Bridge:                       VIA vt8233a
> Revision:                           ISA 0x0 IDE 0x6
> Highest DMA rate:                   UDMA133
> BM-DMA base:                        0xfc00
> PCI clock:                          33.3MHz
> Master Read  Cycle IRDY:            0ws
> Master Write Cycle IRDY:            0ws
> BM IDE Status Register Read Retry:  yes
> Max DRDY Pulse Width:               No limit
> -----------------------Primary IDE-------Secondary IDE------
> Read DMA FIFO flush:          yes                 yes
> End Sector FIFO flush:         no                  no
> Prefetch Buffer:              yes                 yes
> Post Write Buffer:            yes                 yes
> Enabled:                      yes                 yes
> Simplex only:                  no                  no
> Cable Type:                   80w                 40w
> -------------------drive0----drive1----drive2----drive3-----
> Transfer Mode:       UDMA      UDMA       PIO       DMA
> Address Setup:      120ns     120ns     120ns     120ns
> Cmd Active:          90ns      90ns      90ns      90ns
> Cmd Recovery:        30ns      30ns      30ns      30ns
> Data Active:         90ns      90ns     330ns      90ns
> Data Recovery:       30ns      30ns     270ns      30ns
> Cycle Time:          15ns      15ns     600ns     120ns
> Transfer Rate:  133.3MB/s 133.3MB/s   3.3MB/s  16.6MB/s
>
>   Of course, when the above happens, all disk I/O freezes. The above happens
> only when there's simultaneous activity on both devices. It doesn't happen
> when the devices are on different IDE interfaces. The transfer is always
> retried and completed successfully, so it's not a bad hdd and I can only
> guess the problem is somewhere in the DMA/IRQ handling by the IDE driver. If
> there's not enough information to diagnose/solve the problem, I can do more
> tests (run with 2.4 for a while, run with the generic IDE drive etc.).
>
> TIA,
>
> marek

---559023410-1804928587-1051300048=:602
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="masked_irq.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.30.0304252147280.602@mion.elka.pw.edu.pl>
Content-Description: 
Content-Disposition: attachment; filename="masked_irq.diff"

IyBGaXggbWFza2VkX2lycSBhcmcgaGFuZGxpbmcgZm9yIGlkZV9kb19yZXF1
ZXN0KCkuDQojIFNvbHZlcyAiaGR4OiBsb3N0IGludGVycnVwdCIgYnVnLg0K
Iw0KIyBCYXJ0bG9taWVqIFpvbG5pZXJraWV3aWN6IDxiem9sbmllckBlbGth
LnB3LmVkdS5wbD4NCg0KLS0tIGxpbnV4LTIuNS42OC1iazYvZHJpdmVycy9p
ZGUvaWRlLWlvLmMJRnJpIEFwciAyNSAxNjowODo1MyAyMDAzDQorKysgbGlu
dXgvZHJpdmVycy9pZGUvaWRlLWlvLmMJRnJpIEFwciAyNSAxNjoxMzozNyAy
MDAzDQpAQCAtODUwLDE0ICs4NTAsMTQgQEANCiAJCSAqIGhhcHBlbnMgYW55
d2F5IHdoZW4gYW55IGludGVycnVwdCBjb21lcyBpbiwgSURFIG9yIG90aGVy
d2lzZQ0KIAkJICogIC0tIHRoZSBrZXJuZWwgbWFza3MgdGhlIElSUSB3aGls
ZSBpdCBpcyBiZWluZyBoYW5kbGVkLg0KIAkJICovDQotCQlpZiAoaHdpZi0+
aXJxICE9IG1hc2tlZF9pcnEpDQorCQlpZiAobWFza2VkX2lycSAhPSBJREVf
Tk9fSVJRICYmIGh3aWYtPmlycSAhPSBtYXNrZWRfaXJxKQ0KIAkJCWRpc2Fi
bGVfaXJxX25vc3luYyhod2lmLT5pcnEpOw0KIAkJc3Bpbl91bmxvY2soJmlk
ZV9sb2NrKTsNCiAJCWxvY2FsX2lycV9lbmFibGUoKTsNCiAJCQkvKiBhbGxv
dyBvdGhlciBJUlFzIHdoaWxlIHdlIHN0YXJ0IHRoaXMgcmVxdWVzdCAqLw0K
IAkJc3RhcnRzdG9wID0gc3RhcnRfcmVxdWVzdChkcml2ZSwgcnEpOw0KIAkJ
c3Bpbl9sb2NrX2lycSgmaWRlX2xvY2spOw0KLQkJaWYgKGh3aWYtPmlycSAh
PSBtYXNrZWRfaXJxKQ0KKwkJaWYgKG1hc2tlZF9pcnEgIT0gSURFX05PX0lS
USAmJiBod2lmLT5pcnEgIT0gbWFza2VkX2lycSkNCiAJCQllbmFibGVfaXJx
KGh3aWYtPmlycSk7DQogCQlpZiAoc3RhcnRzdG9wID09IGlkZV9yZWxlYXNl
ZCkNCiAJCQlnb3RvIHF1ZXVlX25leHQ7DQo=
---559023410-1804928587-1051300048=:602--
