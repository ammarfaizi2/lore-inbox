Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWIJIbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWIJIbW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 04:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWIJIbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 04:31:22 -0400
Received: from 1wt.eu ([62.212.114.60]:28946 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750795AbWIJIbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 04:31:21 -0400
Date: Sun, 10 Sep 2006 10:26:49 +0200
From: Willy Tarreau <w@1wt.eu>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kaber@trash.net
Subject: Re: Oops after 30 days of uptime
Message-ID: <20060910082649.GA20814@1wt.eu>
References: <200609011852.39572.linux@rainbow-software.org> <20060909101927.GA12986@1wt.eu> <200609091243.39220.linux@rainbow-software.org> <200609091338.56539.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609091338.56539.linux@rainbow-software.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

OK, I've analysed your oops with your kernel. My conclusions are that you
have a hardware problem (most probably the CPU), because you've hit an
impossible case :

ip_nat_cheat_check() pushed the size of the data (8) on the stack, followed
by the pointer to the data, then called csum_partial() :

c01e657f:       6a 08                   push   $0x8
c01e6581:       52                      push   %edx
c01e6582:       e8 a5 85 00 00          call   c01eeb2c <csum_partial>

In csum_partial(), ECX is filled with the size (8) and ESI with the data
pointer (0xc0227ce8) :

c01eeb32:       8b 4c 24 10             mov    0x10(%esp),%ecx
c01eeb36:       8b 74 24 0c             mov    0xc(%esp),%esi

Then, the size is divided by 32 to count how many 32 bytes blocks can be read
at a time. If the size is lower than 32, the code branches to a special
location which reads 1 word at a time :

c01eeb78:       89 ca                   mov    %ecx,%edx
c01eeb7a:       c1 e9 05                shr    $0x5,%ecx
c01eeb7d:       74 32                   je     c01eebb1 <csum_partial+0x85>

Your oops comes from a few instructions below. The branch has not been taken
while it should have because (8 >> 5) == 0. You can also see from EDX in the
oops that it really was 0x8 when copied from ECX. The rest is pretty obvious.
The data are read 32 bytes at a time after ESI, and ECX is decreased by 1
every 32 bytes. When ESI+0x18 reaches an unmapped area (0xc2000000), you get
the oops, and ECX = 0xfff113e8 as in your oops.

Given that the failing instruction is the most common conditionnal jump, it
is very fortunate that your system can work 30 days before crashing. I think
that your CPU might be running too hot and might get wrong results during
branch prediction. It's also possible that you have a poor power supply.
However, I'm pretty sure that this is not a RAM problem.

Best regards,
Willy

