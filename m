Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287012AbRL1Ugk>; Fri, 28 Dec 2001 15:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287008AbRL1Ugc>; Fri, 28 Dec 2001 15:36:32 -0500
Received: from mail.sonytel.be ([193.74.243.200]:16359 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S287011AbRL1UgO>;
	Fri, 28 Dec 2001 15:36:14 -0500
Date: Fri, 28 Dec 2001 21:36:05 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Sym53c8xx tape corruption squashed! (was: Re: SCSI Tape corruption
 - update)
In-Reply-To: <Pine.GSO.4.21.0112051628480.5865-100000@mullein.sonytel.be>
Message-ID: <Pine.GSO.4.21.0112282115310.277-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Geert Uytterhoeven wrote:
> On Fri, 2 Nov 2001, [ISO-8859-1] Gérard Roudier wrote:
> > On Thu, 1 Nov 2001, Geert Uytterhoeven wrote:
> > As driver sym-2 is planned to replace sym53c8xx in the future, it would be
> > interesting to give it a try on your hardware. There are some source
> > available from ftp.tux.org, but I can provide you with a flat patch
> > against the stock kernel version you want. You may let me know.
> 
> I tried sym-2 (2.4.17-pre2) and it didn't show up the problem, which is good!
> 
> More news from the old driver:
> 
>     1.5c            OK
>     1.5d            OK
>     1.5e            page fault in interrupt handler 0xa53c0c68
>     1.5f            lock up
>     1.5pre-g1       lock up
>     1.5pre-g2       lock up
>     1.5pre-g3       corruption
>     1.5g            corruption
> 
> So it happened somewhere in between 1.5d and 1.5pre-g3. I'll see whether I can
> get any of the intermediates to run...

I made all intermediate versions to work.

The problem is introduced in 1.5pre-g2 by the following change:

diff -urN callisto-1.5g-pre2a/sym53c8xx.c callisto-1.5g-pre2+/sym53c8xx.c
--- callisto-1.5g-pre2a/sym53c8xx.c	Fri Dec 28 21:12:30 2001
+++ callisto-1.5g-pre2+/sym53c8xx.c	Fri Dec 28 20:11:10 2001
@@ -11981,7 +11981,7 @@
 	**    (latency timer >= burst length + 6, we add 10 to be quite sure)
 	*/
 
-	if ((pci_fix_up & 4) && chip->burst_max) {
+	if (chip->burst_max && (latency_timer == 0 || (pci_fix_up & 4))) {
 		uchar lt = (1 << chip->burst_max) + 6 + 10;
 		if (latency_timer < lt) {
 			printk(NAME53C8XX 

This change causes the PCI latency timer to be changed from 0 to 80.

The sym-2 driver has a define for modifying the PCI latency timer
(SYM_SETUP_PCI_FIX_UP), but it is never used, so I see no corruption.

Is this a hardware bug in my SCSI host adapter (53c875 rev 04) or my host
bridge (VLSI VAS96011/12 Golden Gate II for PPC), or a software bug in the
driver (wrong burst_max)?

To recapitulate, the bug causes error bursts of (almost always) 32 bytes long.
The incorrect bytes are always a copy of previous data, at a fixed offset (10
kiB on my (now dead) DDS-1 tape drive, 32 kiB on my Plexwriter).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

