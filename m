Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTLNNOR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 08:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTLNNOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 08:14:17 -0500
Received: from ppp-62-245-210-172.mnet-online.de ([62.245.210.172]:645 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S261569AbTLNNOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 08:14:15 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IRQ disabled (SATA) on NForce2 and my theory
From: Julien Oster <lkml-2315@mc.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Sun, 14 Dec 2003 14:14:17 +0100
Message-ID: <frodoid.frodo.87wu8zzgly.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I got an ASUS A7N8X Deluxe v2.0 and APIC and I/O APIC enabled, thanks
to athcool. (I didn't apply any patches, I just disable CPU Disconnect
with 'athcool off' as first thing on boot).

Now, however, since I am running with APIC, the following error occurs
quite often:

[...]
Dec  8 19:16:20 frodo kernel: hde: DMA disabled
Dec  8 19:16:20 frodo kernel: ide2: reset phy, status=0x00000113, siimage_reset
[...]

Shortly after that, the kernel would report:

Dec  8 19:16:21 frodo kernel: Disabling IRQ #18
Dec  8 19:16:22 frodo kernel: irq 18: nobody cared!

This happens sometimes under very high load on my onboard SATA where
both harddrivers (fast 10000rpm Raptors) are attached to a Linux
Softraid RAID0. IRQ18 is attached to this.

The drive/controller won't recover afterwards, only a reboot helps.

Now, my theory about this: One patch to fix the NForce2 lockups was to
insert a small delay in the acknowledgement of the timer
interrupt. Apparently, the machine would lock up if the timer
interrupt gets acknowledged too fast, meaning too soon.

I now suspect that my IRQ18 problems are a result of exactly the same
cause: IRQ18 getting acknowledged too soon on very high load, thus all
further interrupts won't occur anymore and disk operations come to a
halt.

It was most noticeable for the timer interrupt, because the timer
interrupt is basically always at "high load" and a lack of it would
result in a hard lockup of the board. However, it now seems like the
timer interrupt isn't the only interrupt suffering from this issue.

So, I think inserting the small delay in the appropriate IRQ
handler might fix this, too.

But there's still the question, why the delay is actually needed for
NForce2 boards. That would basically mean that you'll have to
introduce the delay for *every* IRQ, to avoid a lockup of any device
that will do high load at some time. I bet that, if I put my Firewire
Card back in (or just use the onboard Firewire ports) and stream a
video from my DV cam onto the harddisk, it would lock up as well after
a very short time, since those who know DV also know that DV has a
very high bandwidth, half an hour of film is like 40GB or the
like. (However, I can't test this right now, because my DV cam is
currently not accessible)

So, we're still not "rock solid" with NForce2, I guess...
Any idea?

Regards,
Julien
