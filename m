Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271021AbRHOEwL>; Wed, 15 Aug 2001 00:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271018AbRHOEwA>; Wed, 15 Aug 2001 00:52:00 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:38152 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S271021AbRHOEvo>;
	Wed, 15 Aug 2001 00:51:44 -0400
Message-ID: <3B79FB42.66D55B63@yahoo.com>
Date: Wed, 15 Aug 2001 00:32:02 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.19 i586)
MIME-Version: 1.0
To: Riley Williams <rhw@MemAlpha.CX>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <Pine.LNX.4.33.0108102221050.20472-100000@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams wrote:

> 
>  > You have six drivers loaded, when you only need three (i.e.
>  > io=0x340,0x320,0x2c0 for ne options etc. etc). So you end up
>  > wasting some memory, and a worse icache behaviour as well.
> 
> Are you sure of this? My understanding (both from reading the code and
> from what others I respect have said) is that it is impossible to load
> any given module more than once, so the above will result in one copy
> each of the ne, ne2k-pci and tulip drivers being loaded.

Here is an example of what I was talking about:

# insmod wd -o wd0 io=0x280 irq=10
# insmod wd -o wd1 io=0x680 irq=3
# insmod wd -o wd2 io=0xa80 irq=4
# insmod wd -o wd3 io=0xe80 irq=9
# cat /proc/modules
wd3                2            0
wd2                2            0
wd1                2            0
wd0                2            0
8390               2    [wd3 wd2 wd1 wd0]      0
# rmmod wd3 wd2 wd1 wd0
#
# insmod wd io=0x280,0x680,0xa80,0xe80 irq=10,3,4,9
# cat /proc/modules
wd                 2		0
8390               2	[wd]	0
#

The 1st way (4 copies of the driver present) will work, but is not
as efficient as the 2nd way (one copy present).

[Don't look too hard at the I/O addresses or you will realize there was 
only one card in this particular machine anyway...]

Paul.


