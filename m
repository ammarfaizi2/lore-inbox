Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbQLRRIJ>; Mon, 18 Dec 2000 12:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129971AbQLRRIA>; Mon, 18 Dec 2000 12:08:00 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:9482 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129627AbQLRRHq>;
	Mon, 18 Dec 2000 12:07:46 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Date: Mon, 18 Dec 2000 17:35:09 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: test13-pre3
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@chiara.elte.hu,
        torvalds@transmeta.com
X-mailer: Pegasus Mail v3.40
Message-ID: <100841C16F12@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Dec 00 at 13:58, Maciej W. Rozycki wrote:

>  What is this change about?
> 
> diff -u --recursive --new-file v2.4.0-test12/linux/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
> --- v2.4.0-test12/linux/arch/i386/kernel/smpboot.c      Mon Dec 11 17:59:43 2000
> +++ linux/arch/i386/kernel/smpboot.c    Thu Dec 14 14:54:40 2000
> @@ -694,6 +694,11 @@
>         apic_write_around(APIC_ICR, APIC_DM_STARTUP
>                     | (start_eip >> 12));
>  
> +       /*
> +        * Give the other CPU some time to accept the IPI.
> +        */
> +       udelay(300);
> +
>         Dprintk("Startup point 1.\n");
>  
>         Dprintk("Waiting for send to finish...\n");
> 
> There is the following code is just after it, making the above change
> just useless garbage:

No. Without udelay() before first printk() it just does not boot on my
motherboard. There were two choices: either remove all printk() from
these loops (define Dprintk to null), or add udelay(x), where x >= 200,
before first printk. I sent patch twice to linux-kernel, and to 
mingo@redhat.com, and nobody said anything against it.
 
>         timeout = 0;
>         do {
>             Dprintk("+");
>             udelay(100);
>             send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
>         } while (send_status && (timeout++ < 1000));
> 
>         /*
>          * Give the other CPU some time to accept the IPI.
>          */
>         udelay(200);
> 
> If we need 600usecs of delay for certain systems, then why not just make
> it like below?

No. If there is no udelay() before first printk(), on my GA-6VXD7 board
(SMP VIA 694X) only 'Startup point 1.' is printed, but no 'Waiting
for send to finish...'. So maybe we do not need udelay(200) below loop,
but for sure we need udelay() before first printk(). (my board works
without ANY udelay() in smpboot.c, except one I added... This one is 
required.) If somebody lives in Prague, and wants to come with logical
analyzer (or if I should come with motherboard), I'm willing to continue
testing. But current idea is that inb/outb done by cursor positioning
code is incompatible with something else done in secondary CPU startup.
(it boots also without any kernel change with 'console=ttyS0,9600', but 
it may be caused by slow serial line)

Without delay() both CPU die, and board does not react to anything except
hard reset anymore (and sometime it does not react even to hard reset; lookup
for my messages during last week).
                                    Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
