Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129065AbRBDCxk>; Sat, 3 Feb 2001 21:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129071AbRBDCxa>; Sat, 3 Feb 2001 21:53:30 -0500
Received: from platan.vc.cvut.cz ([147.32.240.81]:28426 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S129065AbRBDCxZ>; Sat, 3 Feb 2001 21:53:25 -0500
Date: Sun, 4 Feb 2001 03:52:06 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: Promise PDC20265, VIA KT133 and corruption
Message-ID: <20010204035206.A21747@platan.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,
  if you remember, last week I complained that Promise corrupts data
when I copy them from hdh to hde. Today I did some more experiments
(running 2.4.1-ac1) and found:

1) Debian sid's 'cmp' prints incorrect offsets when files differ
   in more than one place if distance > cmp buffer size :-(
2) When I read data from hdh (UDMA2 Toshiba) sometime last four
   bytes of 4KB page (== probably last 4 bytes of read request)
   are not read at all and old contents of page is left here
   (it happens about once per 20MB read; and in about 1% of
   these last 8 bytes of page are incorrect).
   I have no idea whether promise or KT133 is at fault, but
   it for sure does not happen under Windows...
3) During write some corruption can happen on either hde (IBM
   DTLA-307045 running UDMA5) or hdh - it looks like that
   data are shifted on HDD, as fsck then complains about
   imagic set, dtime set while inode not deleted and so on,
   and then it cleaned inodes 178200-178300 from my hde :-(
   Fortunately they were mostly in old kernel trees,
   not in current data (except one inode, which was just
   created by dpkg)
4) So I compiled kernel without IDE DMA support at all and now
   everything works at PIO4 without any corruption...

  If anybody has any idea what I should try to get UDMA to
work under Linux here...

lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:0a.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)

					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
