Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263096AbRFMOxp>; Wed, 13 Jun 2001 10:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbRFMOxe>; Wed, 13 Jun 2001 10:53:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45580 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262607AbRFMOxY>;
	Wed, 13 Jun 2001 10:53:24 -0400
Date: Wed, 13 Jun 2001 15:52:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Keith Owens <kaos@ocs.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq
Message-ID: <20010613155246.A21143@flint.arm.linux.org.uk>
In-Reply-To: <15143.29246.712747.936864@pizda.ninka.net> <10322.992441398@ocs4.ocs-net> <15143.30453.762432.702411@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15143.30453.762432.702411@pizda.ninka.net>; from davem@redhat.com on Wed, Jun 13, 2001 at 07:21:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2001 at 07:21:41AM -0700, David S. Miller wrote:
> I can't believe there is no reliable way to get rid of that
> pesky "$" gcc is adding to the symbol.  Oh well...

GCC on ARM does a similar thing - all constants in the assembler are
prefixed with '#' or '@'.  Using the 'i' constraint adds this.  This
behaviour is actually useful when you want to pass a constant or a
register - it allows GCC to make the decision for you, and do the
right thing in the assembler fragment.  Eg, the following code used
to be in the kernel until 2.3:

extern __inline__ void __outb (unsigned int value, unsigned int port)
{
        unsigned long temp;
        __asm__ __volatile__(
        "tst    %2, #0x80000000\n\t"
        "mov    %0, %4\n\t"
        "addeq  %0, %0, %3\n\t"
        "strb   %1, [%0, %2, lsl #2]    @ outb"
        : "=&r" (temp)
        : "r" (value), "r" (port), "Ir" (PCIO_BASE - IO_BASE), "Ir" (IO_BASE)
        : "cc");
}

%3 and %4 might be a constant:
	mov	r5, #0x03000000

or a real register if the constant can't be loaded in one instruction:
	mov	r5, r1

'I' in this case means "a constant suitable for use with the arithmetic
instructions".

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

