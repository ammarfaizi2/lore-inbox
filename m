Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758474AbWK0RqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758474AbWK0RqR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 12:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758475AbWK0RqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 12:46:17 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:34963 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1758408AbWK0RqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 12:46:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NcxzOpxzkFFgQ1K/JEKRNAp6zbIP/nh0m1t/ePak7M18JQw6VpEvV0hhucqhhG9TMfdQVg9Ai4ILQGCDFhy/Av8qWq1xpl0Msz9ulQ/nY/bsApbmFEVMzC9ZPcUdXjXP2dk/WHCFmXga2mkoUaX/EiZSZHlPov0ugfG9V86uHqQ=
Message-ID: <e6babb600611270946o738327feqd7a18f2f1ff8fccd@mail.gmail.com>
Date: Mon, 27 Nov 2006 10:46:15 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: ieee1394: host adapter disappears on 1394 bus reset
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <456B1C52.4040305@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600611220731p67b15e51q95f524683070ae80@mail.gmail.com>
	 <4564C4C7.5060403@s5r6.in-berlin.de>
	 <e6babb600611221628nd9430c6pe3ab36e9862b3b6d@mail.gmail.com>
	 <e6babb600611270739k27e1ed51va3cd82ccfa0b77ff@mail.gmail.com>
	 <456B1C52.4040305@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
But perhaps more importantly, how are the IRQs distributed?
> # cat /proc/interrupts

This is almost right after boot.  I generated about 40 bus resets just
to stir things up a little:

           CPU0       CPU1       CPU2       CPU3
  0:      33660      36393      30037      69980    IO-APIC-edge  timer
  1:          0          0          1         10    IO-APIC-edge  i8042
  8:          0          0          0          0    IO-APIC-edge  rtc
  9:          0          0          0          0   IO-APIC-level  acpi
 12:          0          0          0        113    IO-APIC-edge  i8042
 15:          0        270        686        215    IO-APIC-edge  ide1
 50:          1          0      11567          7   IO-APIC-level  aic79xx
 58:          0          0          0          0   IO-APIC-level  ehci_hcd:usb1
 66:          0          0          0          0   IO-APIC-level  ohci_hcd:usb2
 74:          0          1          7         80   IO-APIC-level
ohci1394, ohci1394
 82:          7         23         30         28   IO-APIC-level  ohci1394
 90:          2         28         17         71   IO-APIC-level  eth0
 98:          9         27         21       9182   IO-APIC-level  eth1
106:         19         17         20         26   IO-APIC-level  ohci1394
114:         16         26         34         12   IO-APIC-level  ohci1394
233:          0          0         15          0   IO-APIC-level  aic79xx
NMI:        410         78         75         77
LOC:     166733     166657     166542     166432
ERR:          0
MIS:          0

Also:
I couldn't cause the problem when using 4 Fireboard 800s through
several hundred bus resets (usually took <= 40 for the Indigita card)

> Please add
>         reg_read(ohci, OHCI1394_IntMaskSet);
> right before hpsb_selfid_complete(host, phyid, isroot);. This will flush
> the previous reg_write before hpsb_selfid_complete starts doing
> unspeakable things.

Okay, so the code looks like this now:

                        DBGMSG("PhyReqFilter=%08x%08x",
                               reg_read(ohci,OHCI1394_PhyReqFilterHiSet),
                               reg_read(ohci,OHCI1394_PhyReqFilterLoSet));

                        reg_read(ohci, OHCI1394_IntMaskSet);

                        hpsb_selfid_complete(host, phyid, isroot);

                        DBGMSG( "IntEventClear %08x "
                                "IntEventSet %08x "
                                "IntMaskSet %08x",
                                reg_read(ohci, OHCI1394_IntEventClear),
                                reg_read(ohci, OHCI1394_IntEventSet),
                                reg_read(ohci, OHCI1394_IntMaskSet));

this is in 2.6.16-rt29 which has proved to be the easiest to provoke.
I actually couldn't get 2.6.18 to break earlier this morning (few
hundred resets).

Okay, I've lost host1 (on the Indigita), but this time the last print
statement is:

Nov 27 10:38:27 spanky kernel: ohci1394: fw-host1: IntEventClear
00000000 IntEventSet 04588000 IntMaskSet 818300f3

just like all the other hosts.  I can confirm that no bus reset
handlers are called, and there are another 4,000 lines of statements
from the other hosts after the last from host1.

-- 
Robert Crocombe
rcrocomb@gmail.com
