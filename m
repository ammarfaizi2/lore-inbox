Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268772AbTBZPLr>; Wed, 26 Feb 2003 10:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268773AbTBZPLq>; Wed, 26 Feb 2003 10:11:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24594 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268772AbTBZPLp>;
	Wed, 26 Feb 2003 10:11:45 -0500
Message-ID: <3E5CDB83.1070400@pobox.com>
Date: Wed, 26 Feb 2003 10:21:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marcus Meissner <meissner@suse.de>, "David S. Miller" <davem@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       engebret@us.ibm.com
Subject: Re: [PATCH] fixed pcnet32 multicast listen on big endian
References: <Pine.GSO.4.21.0302231154190.28500-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0302231154190.28500-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> On Sun, 23 Feb 2003, Geert Uytterhoeven wrote:
> 
>>On Wed, 5 Feb 2003, Marcus Meissner wrote:
>>
>>>This fixes multicast listen for pcnet32 on at least powerpc and powerpc64
>>>kernels.
>>>
>>>The mcast_table is in memory referenced by the card and so it needs
>>>to be accessed in little endian mode.
>>>
>>>Ciao, Marcus
>>>
>>>--- linux-2.4.19/drivers/net/pcnet32.c.be	2003-02-05 07:59:27.000000000 +0100
>>>+++ linux-2.4.19/drivers/net/pcnet32.c	2003-02-05 08:00:22.000000000 +0100
>>>@@ -1534,7 +1534,9 @@
>>> 	
>>> 	crc = ether_crc_le(6, addrs);
>>> 	crc = crc >> 26;
>>>-	mcast_table [crc >> 4] |= 1 << (crc & 0xf);
>>>+	mcast_table [crc >> 4] = le16_to_cpu(
>>
>>                                 ^^^^^^^^^^^
>>
>>>+		le16_to_cpu(mcast_table [crc >> 4]) | (1 << (crc & 0xf))
>>>+	);
>>
>>Shouldn't the first conversion be `cpu_to_le16'?
> 
> 
> Ugh, a quick grep shows that this driver _always_ uses `le*_to_cpu()' to
> convert from CPU to little endian.

Cosmetically you are correct, and I prefer it to be changed eventually.

However programatically, it has no effect, because those cpu_to_foo and 
foo_to_cpu functions either swap, or they don't.  Direction doesn't 
matter terribly much :)

	Jeff



