Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTDTWy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 18:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263729AbTDTWy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 18:54:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31493 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263728AbTDTWy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 18:54:26 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
Date: Sun, 20 Apr 2003 23:06:05 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b7v94t$p99$1@penguin.transmeta.com>
References: <200304201811_MC3-1-3537-1648@compuserve.com>
X-Trace: palladium.transmeta.com 1050879965 26265 127.0.0.1 (20 Apr 2003 23:06:05 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 20 Apr 2003 23:06:05 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200304201811_MC3-1-3537-1648@compuserve.com>,
Chuck Ebbert  <76306.1226@compuserve.com> wrote:
>
> I found this while trying to forward-port my .66 patch to make
>the redirect table look like this:

Btw, why would you _want_ your redirect table to look like that?

> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
> 00 001 01  0    0    0   0   0    1    1    E7     <== timer at level E
> 01 001 01  0    0    0   0   0    1    1    30     <== start at 30, not 31

Starting at 31 is better, because..

> 02 000 00  1    0    0   0   0    0    0    00
> 03 001 01  0    0    0   0   0    1    1    38
> 04 001 01  0    0    0   0   0    1    1    40
> 05 001 01  0    0    0   0   0    1    1    48
> 06 001 01  0    0    0   0   0    1    1    50
> 07 001 01  0    0    0   0   0    1    1    58
> 08 001 01  0    0    0   0   0    1    1    60
> 09 001 01  0    0    0   0   0    1    1    68
> 0a 001 01  0    0    0   0   0    1    1    70
> 0b 001 01  0    0    0   0   0    1    1    78
> 0c 001 01  0    0    0   0   0    1    1    88     <== only one device at 8

Then we'd have devices at 81 and 89 (two per block of 16 is ok, but 80
isn't ok because we use that for system calls).

And having two devices in the 8x series means that it takes more irq
sources to overflow and start to re-use the 3x block - and we want to
delay re-using the 3x block as long as possible due to the silly "only
one pending irq per block" rule that some intel APIC's have.

So that's why FIRST_DEVICE_VECTOR is normally 31 - because it gives a
nicer pattern for the first round of allocations, and that's the common
case (machines with hundreds of APIC irq sources are still rare, the
common case is a single IOAPIC with 24 or so pins).

		Linus
