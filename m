Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266224AbUHYCDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUHYCDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 22:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269125AbUHYCDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 22:03:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:36589 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266224AbUHYCCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 22:02:51 -0400
Date: Tue, 24 Aug 2004 19:02:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alex Williamson <alex.williamson@hp.com>
cc: Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com
Subject: Re: [BK PATCH] I2C update for 2.6.8-rc1
In-Reply-To: <1093397881.9555.6.camel@tdi>
Message-ID: <Pine.LNX.4.58.0408241847460.17766@ppc970.osdl.org>
References: <20040715000527.GA18923@kroah.com>  <1093384722.8445.10.camel@tdi>
 <20040824220450.GE11165@kroah.com>  <Pine.LNX.4.58.0408241721330.17766@ppc970.osdl.org>
 <1093397881.9555.6.camel@tdi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Aug 2004, Alex Williamson wrote:
> > 
> > How about this _trivial_ change? Does that fix things for you guys? Can 
> > you send the /proc/ioport output if this works out for you, just so that 
> > we can see?
> 
>    Yes, this works.  Please commit.

Greg? Opinions? I'll happily commit it, since it's almost certainly bound
to be better than what we have now, but I have to admit that I could also 
see it causing confusion if two devices are set up by the BIOS to be on 
top of each other (since insert_resource() would indeed allow that).

Now, admittedly, that would be a VERY broken BIOS, and likely such a 
situation wouldn't have worked _anyway_, but you're the PCI maintainer, so 
you get to sit in the hot seat and say aye or nay.

> I still have reservations about exposing this device (that firmware owns
> and we can't possibly synchronize access to), but this is a big
> improvement over the unusable state w/o this change.

In general, it's always a good idea to expose the devices, because if you 
don't, other device drivers may end up thinking part of the addresses are 
free for the taking. Which is why we have ACPI do it's things too.


> Here's my /proc/ioports:
> 
> 1000-107f : 0000:00:1f.0
>   1000-107f : motherboard
>     1000-1003 : PM1a_EVT_BLK
>     1004-1005 : PM1a_CNT_BLK
>     1008-100b : PM_TMR
>     1010-1015 : ACPI CPU throttle
>     1020-1020 : PM2_CNT_BLK
>     1028-102f : GPE0_BLK

Nice and readable.

> 1100-113f : 0000:00:1f.0
>   1100-113f : motherboard

Same.

> 1200-121f : motherboard
>   1200-121f : 0000:00:1f.3

This is apparently the one that used to cause trouble, and you can see it 
from the nesting level: the device nests inside the description, rather 
than the other way around.

This does bring up an alternate fix: namely to do the PCI quirks 
_earlier_.

If we had done the PCI quirk handling and probing for this device _before_
ACPI populated the IO stuff, and we'd never have seen this problem. Why 
did we let ACPI come in first in the first place? Greg? Len?

The right order (I think) should be:
 - walk the existing PCI setup, do the header quirks, populate the device 
   and resource trees..
 - _than_ do the ACPI resources

The allocation of new PCI resources will happen much later - if/when the
device is actually enabled.

Or am I missing something?

		Linus
