Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130861AbQLTDSH>; Tue, 19 Dec 2000 22:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130868AbQLTDR6>; Tue, 19 Dec 2000 22:17:58 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:20125 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S130861AbQLTDRn>; Tue, 19 Dec 2000 22:17:43 -0500
Date: Wed, 20 Dec 2000 03:47:10 +0100
From: David Weinehall <tao@acc.umu.se>
To: Marc Joosen <mjoosen@us.ibm.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e820 memory detection fix for ThinkPad
Message-ID: <20001220034709.E8435@khan.acc.umu.se>
In-Reply-To: <OF28B11D4D.E0E35F30-ON852569BA.007BEF88@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <OF28B11D4D.E0E35F30-ON852569BA.007BEF88@pok.ibm.com>; from mjoosen@us.ibm.com on Tue, Dec 19, 2000 at 07:16:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2000 at 07:16:40PM -0500, Marc Joosen wrote:
> 
> 
>   Hi Alan, lkml-readers,
> 
>   This is a tiny patch to make the int15/e820 memory mapping work on IBM
> ThinkPads. Until now, I have had to give lilo a mem= option with one meg
> of RAM less than I actually have, so ACPI events don't overwrite any
> data. The only alternative was to use one of the patches available on
> http://www.pell.portland.or.us/~orc/Memory/, but these are quite big. I
> tracked down the problem, at least for the ThinkPad 600X (2645-4EU), to
> arch/i386/boot/setup.S: apparently the bios doesn't retain the value of
> register %edx, so after the first entry is read the ascii word `SMAP' is
> lost and further entries won't be recognized. The solution is simple,
> just move the assignment 6 lines down so it's inside the loop that is
> done for every entry.
>   This patch is for 2.4.0-test7..12, but it should work for pre13
> kernels and even 2.2 kernels with the memory map backport:
> 
> --- linux/arch/i386/boot/setup.S.orig    Sat Dec  9 05:56:07 2000
> +++ linux/arch/i386/boot/setup.S   Sat Dec  9 06:43:03 2000
> @@ -292,7 +292,6 @@
>  #
> 
>  meme820:
> -    movl $0x534d4150, %edx        # ascii `SMAP'
>      xorl %ebx, %ebx               # continuation counter
>      movw $E820MAP, %di            # point into the whitelist
>                               # so we can have the bios
> @@ -300,6 +299,7 @@
> 
>  jmpe820:
>      movl $0x0000e820, %eax        # e820, upper word zeroed
> +    movl $0x534d4150, %edx        # ascii `SMAP'
>      movl $20, %ecx           # size of the e820rec
>      pushw     %ds                 # data record.
>      popw %es

If this simple patch solves your problem, great! But in that case,
PLEASE add a note telling WHY the assignment is done for every
iteration; else some smarthead will probably submit a patch someday
in the future along the lines of "assigning this only once makes the
loop faster"...

Anyhow, good spotting!


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
