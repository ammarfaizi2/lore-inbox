Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWCGSah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWCGSah (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWCGSag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:30:36 -0500
Received: from mail.gmx.de ([213.165.64.20]:36822 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751349AbWCGSag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:30:36 -0500
X-Authenticated: #20450766
Date: Tue, 7 Mar 2006 19:30:25 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Sergei Steshenko <steshenko_sergei@list.ru>,
       alsa-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [Alsa-user] arecord under 2.6.15.4-rt17 ->overruns...
In-Reply-To: <Pine.LNX.4.60.0603051915020.3204@poirot.grange>
Message-ID: <Pine.LNX.4.60.0603071851190.3662@poirot.grange>
References: <Pine.LNX.4.60.0603022032040.4969@poirot.grange> 
 <1141331113.3042.5.camel@mindpipe>  <Pine.LNX.4.60.0603022132160.4969@poirot.grange>
  <1141333305.3042.14.camel@mindpipe>  <Pine.LNX.4.60.0603022207160.3033@poirot.grange>
  <1141334604.3042.17.camel@mindpipe>  <Pine.LNX.4.60.0603022226130.3033@poirot.grange>
  <1141335418.3042.25.camel@mindpipe>  <Pine.LNX.4.60.0603030012070.3397@poirot.grange>
  <1141342018.3042.40.camel@mindpipe>  <Pine.LNX.4.60.0603030707270.2959@poirot.grange>
  <1141410043.3042.116.camel@mindpipe>  <Pine.LNX.4.60.0603041429340.3283@poirot.grange>
  <20060304154357.74f74cac@localhost>  <Pine.LNX.4.60.0603041823560.3601@poirot.grange>
  <1141495123.3042.181.camel@mindpipe>  <Pine.LNX.4.60.0603042046450.3135@poirot.grange>
 <1141509605.14714.11.camel@mindpipe> <Pine.LNX.4.60.0603051915020.3204@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2006, Guennadi Liakhovetski wrote:

> in drivers/pci/quirks.c:
> 
> /*
>  *      VIA Apollo KT133 needs PCI latency patch
>  *      Made according to a windows driver based patch by George E. Breese
>  *      see PCI Latency Adjust on http://www.viahardware.com/download/viatweak.shtm
>  *      Also see http://www.au-ja.org/review-kt133a-1-en.phtml for
>  *      the info on which Mr Breese based his work.
>  *
>  *      Updated based on further information from the site and also on
>  *      information provided by VIA
>  */
> 
> and later:
> 
>         /*
>          *      Ok we have the problem. Now set the PCI master grant to
>          *      occur every master grant. The apparent bug is that under high
>          *      PCI load (quite common in Linux of course) you can get data
>          *      loss when the CPU is held off the bus for 3 bus master requests
>          *      This happens to include the IDE controllers....
>          *
>          *      VIA only apply this fix when an SB Live! is present but under
>          *      both Linux and Windows this isnt enough, and we have seen
>          *      corruption without SB Live! but with things like 3 UDMA IDE
>          *      controllers. So we ignore that bit of the VIA recommendation..
>          */
> 
>         pci_read_config_byte(dev, 0x76, &busarb);
>         /* Set bit 4 and bi 5 of byte 76 to 0x01
>            "Master priority rotation on every PCI master grant */
>         busarb &= ~(1<<5);
>         busarb |= (1<<4);
>         pci_write_config_byte(dev, 0x76, busarb);
>         printk(KERN_INFO "Applying VIA southbridge workaround\n");
> 
> which in itself is wrong - the comment says "set bit 5 & 6 to 1", but 
> the code clears bit 6. Anyway, on my PC:
> 
> 0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
> 00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 e7 80
> 30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
> 40: 08 01 00 00 00 80 62 e6 01 01 44 00 00 00 f0 f3
> 50: 0e 76 34 00 00 b0 5a 90 00 04 ff 08 d0 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 21 88 42 02 04 e4 00 00 00 00 00 00
> 		      ^^
> 80: 01 00 00 00 00 09 00 00 00 60 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 41 00 00 00 00 00 00 00 00 00
> 
> So, bit 4 is not set... I added busarb to the printk above and it prints 
> 0xd2. Why is it reset to 0x42 again later??? Found nothing in 
> drivers/ide/pci/via82cxxx.c... I could read it back to check it did get 
> written.

Ok, my mistake. The quirk checks the southbridge revision, but configures 
byte 0x76 on the host (north) bridge, where it does get successfully set 
and remains set. But it doesn't seem to help. Still, at least the comment 
is wrong - it contradicts the code. Who is the author of that quirk? Any 
comments whether my problem seems similar to what others observed with 
this chipset?

And my audio still doesn't work properly...

Thanks
Guennadi
---
Guennadi Liakhovetski
