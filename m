Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268213AbUIBTDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268213AbUIBTDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268234AbUIBTDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:03:53 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:48253 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S268213AbUIBTDv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:03:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Early USB handoff
Date: Thu, 2 Sep 2004 12:03:52 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B30162E74A@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Early USB handoff
Thread-Index: AcSQiUxggx6wmmHmTceFv0f7QItR1AAjrI1Q
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Pete Zaitcev" <zaitcev@redhat.com>,
       "David Brownell" <david-b@pacbell.net>
Cc: <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 02 Sep 2004 19:03:50.0690 (UTC) FILETIME=[953AF820:01C4911F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> I'm also not clear what kind of BIOS quirk it's trying to
>> resolve.  Is the issue just that PCI setup from Linux, long
>> before the HCD initializes, ends up confusing the BIOS
>> on those "summit" machines?  What symptoms would
>> suggest that I should try this option, on non-summit boxes?
>
>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=126984
>
>Here's the interesting part:
>
>> The hardware team here narrowed down the boot time hang to a 
>BIOS bug 
>> where the USB Legacy support feature causes register 
>corruption. This 
>> is unfortunately due to architecture timing constraints and 
>cannot be 
>> fixed with a BIOS update. Disabling Legacy USB support works around 
>> the issue, but leaves the user w/o keyboard support in grub.  
[snip]
>I suspect Aleks hits a similar issue with some other hardware.
>
>-- Pete
>

Pete, thanks for an explanation & reference. Though, I also got
"not authorized" while trying to access it.

Patch is supposed to resolve at least 2 issues (I ran into 
both of them on different laptops):
1. USB Legacy support problem Pete mentioned above
2. Boot lockup problem due to an interrupt shared with HC 
   on a platform with legacy free BIOS.

Symptoms for second one are described here:
http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg267
77.html

  Basically, in a case of legacy free BIOS, HC is not in 
SMM mode, and USB IRQ is routed to PCI IRQ line and generates
interrupts. When this IRQ is enabled in PIC (by driver that 
starts before HC driver), system is flooded with interrupts.
  One solution is to reset HC, but it takes some time (at 
least 50ms). I agree that it might duplicate SOME code in HC 
driver, but HC init executes too late. Well, if handoff has 
been done early, it might not be necessary to do the same in 
HC driver.

Aleks.
