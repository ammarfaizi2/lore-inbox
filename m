Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751943AbWCFRUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbWCFRUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWCFRT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:19:59 -0500
Received: from mail.gmx.de ([213.165.64.20]:35040 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751943AbWCFRT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:19:58 -0500
X-Authenticated: #20450766
Date: Mon, 6 Mar 2006 18:19:55 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Sergei Steshenko <steshenko_sergei@list.ru>,
       alsa-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [Alsa-user] arecord under 2.6.15.4-rt17 ->overruns...
In-Reply-To: <1141509605.14714.11.camel@mindpipe>
Message-ID: <Pine.LNX.4.60.0603051915020.3204@poirot.grange>
References: <Pine.LNX.4.60.0603022032040.4969@poirot.grange> 
 <1141331113.3042.5.camel@mindpipe>  <Pine.LNX.4.60.0603022132160.4969@poirot.grange>
  <1141333305.3042.14.camel@mindpipe>  <Pine.LNX.4.60.0603022207160.3033@poirot.grange>
  <1141334604.3042.17.camel@mindpipe>  <Pine.LNX.4.60.0603022226130.3033@poirot.grange>
  <1141335418.3042.25.camel@mindpipe>  <Pine.LNX.4.60.0603030012070.3397@poirot.grange>
  <1141342018.3042.40.camel@mindpipe>  <Pine.LNX.4.60.0603030707270.2959@poirot.grange>
  <1141410043.3042.116.camel@mindpipe>  <Pine.LNX.4.60.0603041429340.3283@poirot.grange>
  <20060304154357.74f74cac@localhost>  <Pine.LNX.4.60.0603041823560.3601@poirot.grange>
  <1141495123.3042.181.camel@mindpipe>  <Pine.LNX.4.60.0603042046450.3135@poirot.grange>
 <1141509605.14714.11.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding lkml and PCI-maintainer to CC: Short description of the problem - 
VERY high latency during audio recording, sometimes more  than a second 
with 2.6.15, 2.6.0, 2.4.32.)

On Sat, 4 Mar 2006, Lee Revell wrote:

> Yes it's not likely to be a RAM problem, but broken interrupt routing or
> an ACPI issue.

BIOS is already the newest version. Another thing:

linux/Documentation/sound/oss/VIA-chipset:

Running sound cards on VIA chipsets

o       There are problems with VIA chipsets and sound cards that appear to
        lock the hardware solidly. Test programs under DOS have verified the
        problem exists on at least some (but apparently not all) VIA boards

o       VIA have so far failed to bother to answer support mail on the subject
        so if you are a VIA engineer feeling aggrieved as you read this
        document go chase your own people. If there is a workaround please
        let us know so we can implement it.

... and later:

Linux implements a workaround providing your chipset is PCI and you compiled
with PCI Quirks enabled. If so you will see a message
        "Activating ISA DMA bug workarounds"

during booting. If you have a VIA PCI chipset that hangs when you use the
sound and is not generating this message even with PCI quirks enabled
please report the information to the linux-kernel list (see REPORTING-BUGS).

in drivers/pci/quirks.c:

/*
 *      VIA Apollo KT133 needs PCI latency patch
 *      Made according to a windows driver based patch by George E. Breese
 *      see PCI Latency Adjust on http://www.viahardware.com/download/viatweak.shtm
 *      Also see http://www.au-ja.org/review-kt133a-1-en.phtml for
 *      the info on which Mr Breese based his work.
 *
 *      Updated based on further information from the site and also on
 *      information provided by VIA
 */

and later:

        /*
         *      Ok we have the problem. Now set the PCI master grant to
         *      occur every master grant. The apparent bug is that under high
         *      PCI load (quite common in Linux of course) you can get data
         *      loss when the CPU is held off the bus for 3 bus master requests
         *      This happens to include the IDE controllers....
         *
         *      VIA only apply this fix when an SB Live! is present but under
         *      both Linux and Windows this isnt enough, and we have seen
         *      corruption without SB Live! but with things like 3 UDMA IDE
         *      controllers. So we ignore that bit of the VIA recommendation..
         */

        pci_read_config_byte(dev, 0x76, &busarb);
        /* Set bit 4 and bi 5 of byte 76 to 0x01
           "Master priority rotation on every PCI master grant */
        busarb &= ~(1<<5);
        busarb |= (1<<4);
        pci_write_config_byte(dev, 0x76, busarb);
        printk(KERN_INFO "Applying VIA southbridge workaround\n");

which in itself is wrong - the comment says "set bit 5 & 6 to 1", but 
the code clears bit 6. Anyway, on my PC:

0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 e7 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
40: 08 01 00 00 00 80 62 e6 01 01 44 00 00 00 f0 f3
50: 0e 76 34 00 00 b0 5a 90 00 04 ff 08 d0 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 21 88 42 02 04 e4 00 00 00 00 00 00
		      ^^
80: 01 00 00 00 00 09 00 00 00 60 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 41 00 00 00 00 00 00 00 00 00

So, bit 4 is not set... I added busarb to the printk above and it prints 
0xd2. Why is it reset to 0x42 again later??? Found nothing in 
drivers/ide/pci/via82cxxx.c... I could read it back to check it did get 
written.

Thanks
Guennadi
---
Guennadi Liakhovetski
