Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276824AbRJHMvh>; Mon, 8 Oct 2001 08:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276872AbRJHMv1>; Mon, 8 Oct 2001 08:51:27 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55682 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S276824AbRJHMvJ>; Mon, 8 Oct 2001 08:51:09 -0400
Date: Mon, 8 Oct 2001 08:51:25 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ian Thompson <ithompso@stargateip.com>
cc: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: RE: How can I jump to non-linux address space?
In-Reply-To: <NFBBIBIEHMPDJNKCIKOBGEIOCAAA.ithompso@stargateip.com>
Message-ID: <Pine.LNX.3.95.1011008083502.19610A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001, Ian Thompson wrote:

> Hey Dick,
> 
> Thanks for the help!  A couple more questions for you...
> 
> > You use ioremap() to create a virtual address from 0x1000. Then
> > you copy the relocated code, currently in some array, to the relocated
> > address (0x1000), using the cookie returned from ioremap().
> 
> How does this make the virtual address the same as the physical address?  Or
> are addr's in the first page (or 1st MB?) automatically mapped to the same
> address when you call ioremap()?  I printed out the __ioremap() addr's for
> 0x1000 and 0x3000, and neither of the virt addr's were equal to the physical
> ones.
> 

[Snipped...]
I was refering to Intel, not ARM hardware. You can look at the
setup code in your architecture specific tree and see if you
can figure it out. I have never even seen ARM hardware, much
less used it so I can't help there.

FYI, what you get from ioremap() is not a number that will mean
anything, even when it's mapped to the physical address. Often,
on some kernel versions, just to prevent module writers from
cheating, it is poisoned so it only works with the defined
macros. Therefore, it is a "cookie", not something you can
initialize a pointer with.

However, in Intel, for hacking only, the address that you can
use to initialize a pointer with is the address you re-mapped,
ORed with PAGE_OFFSET. If the address is below 1 megabyte,
there is a 1:1 mapping of virtual to physical addresses in
the Intel Linux kernel. This allows the page table to exist
at an address that can be accessed from 32-bit linear-mode
startup.

This is useful if you want to access something physical. For instance
if you want to find the physical address of bad memory. A user-mode
memory checker can exercise memory until something failed. Then it
can write some magic numbers on both sides of the failing address.

A kernel module could then search for the magic numbers, returning
the 32-bit linear offset of the bad memory. This is quicker than
writing a module to scan all the PTEs, returning the translation
offset.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


