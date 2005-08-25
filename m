Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVHYOyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVHYOyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbVHYOyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:54:47 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:1065 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1750945AbVHYOyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:54:46 -0400
Date: Thu, 25 Aug 2005 07:54:45 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: question on memory barrier
Message-ID: <20050825145445.GD7319@hexapodia.org>
References: <20050824194836.GA26526@hexapodia.org> <20050825091403.6380.qmail@web25805.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050825091403.6380.qmail@web25805.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 11:14:03AM +0200, moreau francis wrote:
> --- Andy Isaacson <adi@hexapodia.org> a écrit :
> > The first register write will be completed before the second register
> > write because you use writel, which is defined to have the semantics you
> > want.  (It uses a platform-specific method to guarantee this, possibly
> > "volatile" or "asm("eieio")" or whatever method your platform requires.)
> 
> I'm compiling Linux kernel for a MIPS32 cpu.

Funny, me too.  (Well, mostly MIPS64, but some MIPS32.)

> On my platform, writel seems
> expand to:
> 
>     static inline writel(u32 val, volatile void __iomem *mem)
>     {
>             volatile u32 *__mem;
>             u32 __val;
> 
>             __mem = (void *)((unsigned long)(mem));
>             __val = val;
> 
>             *__mem = __val;
>     }
> 
> I don't see the magic in it since "volatile" keyword do not handle memory
> ordering constraints...Linus wrote on volatile keyword, see
> http://www.ussg.iu.edu/hypermail/linux/kernel/0401.0/1387.html

Did you *read* the post?

# The _only_ acceptable use of "volatile" is basically:
# 
# - in _code_ (not data structures), where we might mark a place as making
#   a special type of access. For example, in the PCI MMIO read functions,
#   rather than use inline assembly to force the particular access (which
#   would work equally well), we can force the pointer to a volatile type.

That's *exactly* what the writel you quote above does!

The thing that Linus is railing against is stupidity like

struct my_dev_regs {
	volatile u8 reg0;
};

That "volatile" does not do what you might think it would do.

To return to the point directly at hand - on MIPS architectures to date,
simply doing your memory access through a "volatile u32 *" is sufficient
to ensure that the IO hits the bus (assuming that your pointer points to
kseg1, not kseg0, or is otherwise uncached), because 'volatile' forces
gcc to generate a "sw" for each store, and all MIPS so far have been
designed so that multiple uncached writes to mmio locations do generate
multiple bus transactions.

I'm not an architect, but I think it would be possible to build a MIPS
where this was not the case, and require additional contortions from
users.  Such a MIPS would suck to program and would probably fail in the
marketplace, and there's no compelling benefit to doing so; ergo, I
would expect "volatile" to continue to be sufficient on MIPS.

> make drivers/mydev.i should do the job

Thanks for the pointer!  

> but preprocessor doesn't expand inline
> functions. So I won't be able to see the expanded writel function.

But you can simply search backwards in the .i file!  The whole point of
inline functions is that they're present in the postprocessed text.  The
vim command "#" is useful for this.

-andy
