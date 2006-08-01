Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWHAIig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWHAIig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWHAIig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:38:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55229 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751002AbWHAIig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:38:36 -0400
Date: Tue, 1 Aug 2006 01:38:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vitezslav Samel <samel@mail.cz>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: too low MAX_MP_BUSSES
Message-Id: <20060801013826.09c9324d.akpm@osdl.org>
In-Reply-To: <20060731115545.GA3292@pc11.op.pod.cz>
References: <20060731115545.GA3292@pc11.op.pod.cz>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 13:55:45 +0200
Vitezslav Samel <samel@mail.cz> wrote:

> 	Hi!
> 
>   I tried upgrading our server (i386 arch) from 2.6.16 to 2.6.17 but there
> were some odd messages in dmesg:
> 
> 	MP table busid value (32) for bustype ISA is too large, max. supported is 31
> 
> and (repeated 315 times):
> 
> 	unknown bus type 32
> 
> I found out that 50% of the processor time was spent in softirq and the timers
> ran too fast. I didn't look for what else was wrong.
> 
>   Tracked down to this change in 2.6.17-rc2:
> 
> diff -urN linux-2.6.17-rc1/arch/i386/kernel/mpparse.c linux-2.6.17-rc2/arch/i386/kernel/mpparse.c
> +       if (m->mpc_busid >= MAX_MP_BUSSES) {
> +               printk(KERN_WARNING "MP table busid value (%d) for bustype %s "
> +                       " is too large, max. supported is %d\n",
> +                       m->mpc_busid, str, MAX_MP_BUSSES - 1);
> +               return;
> +       }
> 
>  Uping the MAX_MP_BUSSES value in include/asm-i386/mach-default/mach_mpspec.h
> to 64 makes the machine work O.K.
> The system is HP DL380 g4 with 1 Xeon CPU, kernel compiled non-SMP.
> 
>   Here is excerpt from mptable output:
> ---
> Bus:            Bus ID  Type
>                  0       PCI
>                  1       PCI
>                  2       PCI
>                  3       PCI
>                  4       PCI
>                  5       PCI
>                  6       PCI
>                 10       PCI
>                 32       ISA
> ---
> The last item is the offending one.
> 
> Please, can you consider up the default value of MAX_MP_BUSSES?
> 
> P.S.: also tested 2.6.18-rc3, the same - bad - result
> 

mach-default uses 32 and mach-generic uses 260, so I doubt if there's a big
downside to increasing mach-default.  I expect distros ship with
mach-generic, so you're a rare case.

<tries to remember who works on this and fails>

Andi?  Can you see any problems with increasing the mach-default setting?

Thanks.
