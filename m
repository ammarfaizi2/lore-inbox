Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130129AbRB1Lm5>; Wed, 28 Feb 2001 06:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbRB1Lmq>; Wed, 28 Feb 2001 06:42:46 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39173 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130129AbRB1Lmf>; Wed, 28 Feb 2001 06:42:35 -0500
Subject: Re: 2.4.2-ac6 hangs on boot w/AMD Elan SC520 dev board
To: bmoyle@mvista.com (Brian Moyle)
Date: Wed, 28 Feb 2001 11:45:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, bmoyle@mvista.com
In-Reply-To: <200102280312.TAA13404@bia.mvista.com> from "Brian Moyle" at Feb 27, 2001 07:12:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Y539-0005XE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> memory map that hangs (added debugging to setup.S to determine E820 map):
>    hand-copied physical RAM map:
>     bios-e820: 000000000009f400 @ 0000000000000000 (usable)
>     bios-e820: 0000000000000c00 @ 000000000009f400 (reserved)
>     bios-e820: 0000000003f00000 @ 0000000000100000 (usable)
>     bios-e820: 0000000003f00000 @ 0000000000100000 (usable)
>     bios-e820: 0000000000100000 @ 00000000fff00000 (reserved)
>    (at this point, it appears to be in an infinite printk loop <?>)
> 
> I didn't spend much time looking into the printk loop, but it seems to 
> end up there, even if CONFIG_DEBUG_BUGVERBOSE is not defined, as if the 
> ".byte 0x0f,0x0b" is causing the loop to begin.
> 
> Any ideas/suggestions/comments?

Having been over the code the problem is indeed the bios reporting overlapping
/duplicated ranges. That will cause a crash in mm/bootmem when we try and free
the range twice.

I suspect you need to add some code to take the E820 map and remove any
overlaps from it, favouring ROM over RAM if the types disagree (for safety),
and filter them before you register them with the bootmem in 
arch/i386/kernel/setup.c



