Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131030AbQKVSv0>; Wed, 22 Nov 2000 13:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131016AbQKVSvK>; Wed, 22 Nov 2000 13:51:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7183 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129602AbQKVSux>;
        Wed, 22 Nov 2000 13:50:53 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011221600.eAMG0Ps07904@flint.arm.linux.org.uk>
Subject: Re: silly [< >] and other excess
To: christian.gennerat@vz.cit.alcatel.fr (Christian Gennerat)
Date: Wed, 22 Nov 2000 16:00:24 +0000 (GMT)
Cc: Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3A1BCD2C.8F489FB3@vz.cit.alcatel.fr> from "Christian Gennerat" at Nov 22, 2000 02:42:05 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Gennerat writes:
> Andries.Brouwer@cwi.nl a =E9crit :
> >  I also left something else
> > that always annoyed me: valuable screen space (on a 24x80 vt)
> > is lost by these silly [< >] around addresses in an Oops.
> > They provide no information at all, but on the other hand
> > cause loss of information because these lines no longer
> > fit in 80 columns causing line wrap and the loss of the
> > top of the Oops.]

They provide no information to the human reader, but they tell klogd
(and other tools) that the enclosed value is a kernel address that
should be looked up in the System.map file and decoded into name +
offset.

> What a good idea!

What a bad idea to remove them.

> --- arch/i386/kernel/traps.c.orig Mon Oct  2 20:57:01 2000
> +++ arch/i386/kernel/traps.c Sun Nov  5 14:33:52 2000
> @@ -142,11 +142,12 @@
>     * out the call path that was taken.
>     */
>    if (((addr >=3D (unsigned long) &_stext) &&
> +    (i<32) &&
>         (addr <=3D (unsigned long) &_etext)) ||
>        ((addr >=3D module_start) && (addr <=3D module_end))) {
>     if (i && ((i % 8) =3D=3D 0))
>      printk("\n       ");
> -   printk("[<%08lx>] ", addr);
> +   printk("%08lx ", addr);
>     i++;
>    }
>   }

What happened to the tabs?  It looks like you're using the deadly evil
quoted-printable mime encoding format which seems to h ave spannered the
patch.

> --- kernel/panic.c.orig Tue Jun 20 23:32:27 2000
> +++ kernel/panic.c Sun Nov  5 07:53:04 2000
> @@ -56,7 +56,7 @@
>   va_end(args);
>   printk(KERN_EMERG "Kernel panic: %s\n",buf);
>   if (in_interrupt())
> -  printk(KERN_EMERG "In interrupt handler - not syncing\n");
> +  printk(KERN_EMERG "In interrupt handler - not syncing");
>   else if (!current->pid)
>    printk(KERN_EMERG "In idle task - not syncing\n");
>   else

IMHO, panic here is a better idea; I've had many a time when I get oops
after oops.  Take for instance "scheduling in interrupt".  This causes
a NULL pointer de-reference, which then calls die() which goes on to call
do_exit() which then calls schedule() which then causes a NULL pointer
de-reference, which then calls die() which goes on to call do_exit() which
then calls schedule() which then causes a NULL pointer de-reference etc.

End result is a constant stream of oopsen fast scrolling by on screen until
such time something gets corrupted which breaks the loop.

PS, if you want to catch an oops which locks the machine, use a serial
console to log it.  If its a non-locking oops, examine the message log.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
