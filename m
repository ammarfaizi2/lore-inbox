Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135225AbREDLfM>; Fri, 4 May 2001 07:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136189AbREDLex>; Fri, 4 May 2001 07:34:53 -0400
Received: from 13dyn74.delft.casema.net ([212.64.76.74]:30726 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S135225AbREDLeo>; Fri, 4 May 2001 07:34:44 -0400
Message-Id: <200105041134.NAA03383@cave.bitwizard.nl>
Subject: Re: Possible PCI subsystem bug in 2.4
In-Reply-To: <Pine.LNX.4.21.0105031106030.30573-100000@penguin.transmeta.com>
 from Linus Torvalds at "May 3, 2001 11:12:04 am"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Fri, 4 May 2001 13:34:11 +0200 (MEST)
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Edward Spidre <beamz_owl@yahoo.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 3 May 2001, Alan Cox wrote:
> > 
> > Obvious one is to go to the next power of two clear. 
> 
> The question is mainly _which_ power of two. 
> 
> I don't think we can round up infinitely, as that might just end up
> causing us to not have any PCI space at all. Or we could end up deciding
> that real PCI space is memory, and then getting a clash when a real device
> tries to register its bios-allocated area that clashes with our extreme
> rounding.
> 
> I suspect it would be safe to round up to the next megabyte, possibly up
> to 64MB or so. But much more would make me nervous.
> 
> Any suggestions? 

The amount of RAM in a machine almost always has just one or two "1"
bits. 

8, 16, 20, 24, 32, 36, 40, 48, 64, 80 Mb were the numbers that you'd
see in the early Pentium times, right?

So rounding up would mean: Add one until the number of 1-bits in the
address is less than 3. People with 3 or more differently sized DIMMS
in their machine will experience a slightly ineffcient round-up. 

Speed this up with: Find-lowest-1-bit, add that. 

Example you quoted:
                                                nr of 1 bits. 
BIOS-proclaimed end-of-ram: 	0x13fff0000         15
lowest 1-bit: 			0x000010000          1
add:                            0x140000000          2


long round_highmem (long val)
{
	while (hweight32 (val) > 2)
		val += 1 << ffs (val); 
	return val;
}

		Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
