Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWIJKn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWIJKn3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 06:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWIJKn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 06:43:28 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:9994 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1750722AbWIJKn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 06:43:28 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: Oops after 30 days of uptime
Date: Sun, 10 Sep 2006 12:43:25 +0200
User-Agent: KMail/1.9.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kaber@trash.net
References: <200609011852.39572.linux@rainbow-software.org> <200609091338.56539.linux@rainbow-software.org> <20060910082649.GA20814@1wt.eu>
In-Reply-To: <20060910082649.GA20814@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609101243.25772.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 September 2006 10:26, Willy Tarreau wrote:
> Hi Ondrej,
>
> OK, I've analysed your oops with your kernel. My conclusions are that you
> have a hardware problem (most probably the CPU), because you've hit an
> impossible case :
>
> ip_nat_cheat_check() pushed the size of the data (8) on the stack, followed
> by the pointer to the data, then called csum_partial() :
>
> c01e657f:       6a 08                   push   $0x8
> c01e6581:       52                      push   %edx
> c01e6582:       e8 a5 85 00 00          call   c01eeb2c <csum_partial>
>
> In csum_partial(), ECX is filled with the size (8) and ESI with the data
> pointer (0xc0227ce8) :
>
> c01eeb32:       8b 4c 24 10             mov    0x10(%esp),%ecx
> c01eeb36:       8b 74 24 0c             mov    0xc(%esp),%esi
>
> Then, the size is divided by 32 to count how many 32 bytes blocks can be
> read at a time. If the size is lower than 32, the code branches to a
> special location which reads 1 word at a time :
>
> c01eeb78:       89 ca                   mov    %ecx,%edx
> c01eeb7a:       c1 e9 05                shr    $0x5,%ecx
> c01eeb7d:       74 32                   je     c01eebb1 <csum_partial+0x85>
>
> Your oops comes from a few instructions below. The branch has not been
> taken while it should have because (8 >> 5) == 0. You can also see from EDX
> in the oops that it really was 0x8 when copied from ECX. The rest is pretty
> obvious. The data are read 32 bytes at a time after ESI, and ECX is
> decreased by 1 every 32 bytes. When ESI+0x18 reaches an unmapped area
> (0xc2000000), you get the oops, and ECX = 0xfff113e8 as in your oops.
>
> Given that the failing instruction is the most common conditionnal jump, it
> is very fortunate that your system can work 30 days before crashing. I
> think that your CPU might be running too hot and might get wrong results
> during branch prediction. It's also possible that you have a poor power
> supply. However, I'm pretty sure that this is not a RAM problem.

Thank you very much for the analysis. Good that it's not a kernel bug.
The CPU is 33MHz UMC GreenCPU which does not run hot even without a heatsink. 
It's powered directly from 5V so it might be the power supply.

> Best regards,
> Willy
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ondrej Zary
