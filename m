Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbTAQNrr>; Fri, 17 Jan 2003 08:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbTAQNrr>; Fri, 17 Jan 2003 08:47:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51730 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267500AbTAQNrq>; Fri, 17 Jan 2003 08:47:46 -0500
Date: Fri, 17 Jan 2003 13:56:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: kai@tp1.ruhr-uni-bochum.de, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
Message-ID: <20030117135638.A376@flint.arm.linux.org.uk>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	kai@tp1.ruhr-uni-bochum.de, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <15911.64825.624251.707026@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15911.64825.624251.707026@harpo.it.uu.se>; from mikpe@csd.uu.se on Fri, Jan 17, 2003 at 01:55:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 01:55:21PM +0100, Mikael Pettersson wrote:
> This oops occurs for every module, not just af_packet.ko, at
> resolve_symbol()'s first call to __find_symbol().
> 
> What happens is that __find_symbol() oopses because the kernel's
> symbol table is in la-la land. (Note the bogus kernel adress
> 2220c021 it tried to dereference above.)
> 
> Reverting 2.5.59's patch to arch/i386/vmlinux.lds.S cured the
> problem and modules now load correctly for me.
> 
> I don't know if this is a problem also for non-i386 archs.

Well:

        __start___ksymtab = .;                                          \
        __ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {         \
                *(__ksymtab)                                            \
        }                                                               \
        __stop___ksymtab = .;                                           \

breaks on some ARM binutils (from a couple of years ago.)  The most
reliable way we've found in with ARM binutils is to place the symbols
inside the section - this appears to work 100% every single time and
I've never had any reports of failure (whereas I did with the symbols
outside as above.)

On the topic of these changes, I'd prefer it if people didn't silently
run around making random stuff generic when there are subtle differences
between each architecture version without:

1. querying why things are different.
2. waiting a reasonable time for replies to why things are different.
3. copying such changes to the architecture maintainers for review
   in case steps 1 and 2 failed.

Unfortunately, it seems that the BK disease is growing and seems to
be killing the review process, as some people here predicted it
would. ;(

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

