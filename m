Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272679AbTG1GvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272682AbTG1GvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:51:14 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2257 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S272679AbTG1GvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:51:09 -0400
Date: Mon, 28 Jul 2003 09:06:20 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test2: IDE TCQ locks up on Promise chip.
Message-ID: <20030728070620.GA3037@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a board with VIA KT133 and Promise 20265(R) jumpered for UATA/100
(rather than ATA/RAID), an IBM DTLA-307045 drive is attached to the
Promise controller (/dev/hde). On boot-up, the kernel tries to enable
tagged command queueing for that drive, but the completion interrupt
never occurs, so the kernel resets the ATA channel. fdisk -l /dev/hde hangs.

I haven't yet tried the drive with the VIA chip, so I cannot say whether
-test2 TCQ is hosed altogether or just on the Promise chip.

Note: FreeBSD-4 (FreeBSD-5 doesn't support ATA TCQ at the moment) has
blacklisted this Promise chip for ATA TCQ:

http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/dev/ata/ata-disk.c?rev=1.60.2.24&content-type=text/x-cvsweb-markup&only_with_tag=RELENG_4

Check the function ad_tagsupported(), it blacklists my chip (the third /case/ applies):

    switch (adp->device->channel->chiptype) {
    case 0x4d33105a: /* Promises before TX2 doesn't work with tagged queuing */
    case 0x4d38105a:
    case 0x0d30105a:
    case 0x4d30105a:
        return 0;
    }

lspci excerpts:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 10)
...
00:10.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV4 [Riva TnT] (rev 04)

00:00.0 Class 0600: 1106:0305 (rev 02)
00:01.0 Class 0604: 1106:8305
00:07.0 Class 0601: 1106:0686 (rev 22)
00:07.1 Class 0101: 1106:0571 (rev 10)
...
00:10.0 Class 0180: 105a:0d30 (rev 02)
01:00.0 Class 0300: 10de:0020 (rev 04)

-- 
Matthias Andree
