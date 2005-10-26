Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbVJZBbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbVJZBbz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 21:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVJZBbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 21:31:55 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:48819 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932516AbVJZBby convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 21:31:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b5U3IsujpHpodPFr15GV7a/QnPBEdmkesc8YFq4Ff3T9lPrzhZupFzZnzLQkAUDpN/p70XfGKte4S94IgVKLymD6f16QY8JpH6cYsdIXo9r6qJLYT+dcCpKJOqtZIrvYJdbFU23CwzHaparzmRoT70LCy0LWvEvReySg/Y21MCg=
Message-ID: <c29537840510251831p7b9adb5aibc6c5dd927e564d4@mail.gmail.com>
Date: Tue, 25 Oct 2005 18:31:51 -0700
From: "Jason R. Martin" <nsxfreddy@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Call for PIIX4 chipset testers
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/05, Linus Torvalds <torvalds@osdl.org> wrote:
>
> While trying to figure out why one of Alan's laptops didn't like certain
> resource allocations, it dawned on Ivan and me that the PIIX4 (aka
> "82371AB PCI-TO-ISA/IDE Xcelerator", aka "old venerable Intel core
> chipset") actually has a lot more PCI resources that it decodes than the
> two big special cases we had been quirking out.
>
> It's an old chipset by now, but it was very very common, so I bet people
> still have them around. If doing /sbin/lspci on your machine mentions
> something like
>
>         Intel Corporation 82371AB/EB/MB PIIX4 ISA
>
> can you please test out this patch and report what it says in dmesg?
>
> It should report a number of quirks, and the easiest way to get them all
> is to just do
>
>         dmesg -s 1000000 | grep PIIX4
>
> and send it to me (and you might as well cc linux-kernel too in this
> thread, so that we'll get the thing archived for later). Preferably
> together with the output of "cat /proc/ioport" and "/sbin/lspci -xxx".
>
> The patch shouldn't actually change any allocations - right now it only
> prints out the new PCI quirks it tries to decode. And before I make the
> PCI layer actually know about these quirks, I'd want to have several
> reports about the output, just to verify that the code works. I don't
> actually have any PIIX4-based machine myself any more (the curse of
> frequent upgrades).

This is from a Toshiba Portege 7010CT:

[root@portege ~]# dmesg -s 1000000 | grep PIIX4
PCI quirk: region fe00-fe3f claimed by PIIX4 ACPI
PCI quirk: region fe60-fe7f claimed by PIIX4 SMB
PIIX4 devres B PIO at 006d-0070
PIIX4 devres I PIO at 038c-038f
PIIX4 devres J PIO at 0530-053f
PIIX4: IDE controller at PCI slot 0000:00:05.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later

[root@portege ~]# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0022-0022 : PM2_CNT_BLK
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-1fff : PCI CardBus #01
2000-2fff : PCI CardBus #01
3000-3fff : PCI CardBus #05
4000-4fff : PCI CardBus #05
5000-500f : 0000:00:05.1
  5000-5007 : ide0
  5008-500f : ide1
ee00-eeff : 0000:00:0d.0
fe00-fe3f : 0000:00:05.3
  fe00-fe3f : motherboard
    fe00-fe03 : PM1a_EVT_BLK
    fe04-fe05 : PM1a_CNT_BLK
    fe08-fe0b : PM_TMR
    fe0c-fe0f : GPE0_BLK
fe40-fe41 : motherboard
fe50-fe55 : motherboard
  fe50-fe55 : ACPI CPU throttle
fe60-fe7f : 0000:00:05.3
  fe70-fe7f : motherboard
fe90-fe97 : motherboard
fe9e-fe9e : motherboard
feac-feac : motherboard
ff60-ff7f : 0000:00:09.0
ff80-ff9f : 0000:00:06.0
  ff80-ff9f : e100
ffe0-ffff : 0000:00:05.2

[root@portege ~]# /sbin/lspci -xxx
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX
Host bridge (AGP disabled) (rev 02)
00: 86 80 92 71 06 00 00 a2 02 00 00 06 00 40 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 01 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 0c a0 00 00 00 00 00 29 03 10 11 01 00 00 00 00
60: 04 08 0c 0c 0c 0c 0c 0c 00 00 00 00 00 00 00 00
70: 20 1f 4a b8 00 00 0f 01 07 07 5a 00 10 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 80 00 00 00 04 61 00 00 00 05 00 00 00 00 00 00
a0: 00 00 00 00 03 02 00 1f 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 df ff ff ff 18 0c 00 00 00 00 00 00
d0: 04 04 04 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 80 00 00 00 00 00 00 00 00
f0: 40 01 00 00 00 f8 00 60 20 0f 00 00 00 00 00 00

00:04.0 VGA compatible controller: Neomagic Corporation NM2200
[MagicGraph 256AV] (rev 12)
00: c8 10 05 00 07 00 90 02 12 00 00 03 00 40 00 00
10: 08 00 00 df 00 00 80 ff 00 00 70 ff 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 01 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 ff
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 21 06
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:05.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00: 86 80 10 71 0f 00 80 02 02 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 cd 00 b3 04
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0b 0b 0b 80 10 00 00 00 00 fe 80 00 00 00 00 00
70: 00 00 00 00 00 00 0c 0c 00 00 00 00 00 00 00 00
80: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 50 54 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 07 03 00 60 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 21 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 28 0f 00 00 00 00 00 00

00:05.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 50 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 a3 07 a3 00 00 00 00 01 00 02 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 28 0f 00 00 00 00 00 00

00:05.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 28 0f 00 00 00 00 00 00

00:05.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 fe 00 00 82 f1 1e 00 00 38 00 00 00 00 00 00
50: 03 00 00 00 00 00 00 00 67 00 00 02 0f 00 00 02
60: 6d 00 f2 40 00 00 00 00 b2 00 10 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 8c 03 13 00 30 05 1f 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 71 fe 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 28 0f 00 00 00 00 00 00

00:06.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 05)
00: 86 80 29 12 07 00 90 02 05 00 00 02 08 40 00 00
10: 08 f0 ff de 81 ff 00 00 00 00 60 ff 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 02 00
30: 00 00 50 ff dc 00 00 00 00 00 00 00 0b 01 08 38
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 31 fe
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Communication controller: Toshiba America Info Systems FIR
Port (rev 23)00: 79 11 01 07 05 00 00 04 23 00 80 07 00 40 00 00
10: 61 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 79 11 01 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
40: a0 00 02 b7 00 f2 04 22 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
00: 79 11 0a 06 07 00 80 04 07 00 07 06 00 00 82 00
10: 00 00 10 10 00 00 80 04 00 01 04 00 00 00 00 12
20: 00 f0 ff 13 00 00 00 14 00 f0 ff 15 00 10 00 00
30: fc 1f 00 00 00 20 00 00 fc 2f 00 00 0b 01 80 05
40: 79 11 01 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: d0 10 00 86 02 00 00 00 00 00 00 00 00 d1 00 00
b0: cf 3f 3f 3f 20 10 08 0a 00 01 01 00 f1 03 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00

00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
00: 79 11 0a 06 07 00 80 04 07 00 07 06 00 00 82 00
10: 00 10 10 10 00 00 80 04 00 05 08 00 00 00 00 16
20: 00 f0 ff 17 00 00 00 18 00 f0 ff 19 00 30 00 00
30: fc 3f 00 00 00 40 00 00 fc 4f 00 00 0b 02 80 05
40: 79 11 01 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: d0 20 00 86 02 00 00 00 00 00 00 00 00 d1 00 00
b0: cf 3f 3f 3f 20 10 08 0a 00 01 01 00 f1 03 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00

00:0d.0 Multimedia controller: C-Cube Microsystems Cinemaster C 3.0
DVD Decoder (rev 02)
00: 3f 12 88 88 05 00 10 02 02 00 80 04 00 40 00 00
10: 01 ee 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3f 12 88 88
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 04 80
40: 02 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Jason
