Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312891AbSD2QxL>; Mon, 29 Apr 2002 12:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312894AbSD2QxK>; Mon, 29 Apr 2002 12:53:10 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:54418 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312891AbSD2QxK>; Mon, 29 Apr 2002 12:53:10 -0400
Date: Mon, 29 Apr 2002 10:50:05 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>, Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org, Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <5390000.1020102605@flay>
In-Reply-To: <20020427004641.L19278@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>                 page = virt_to_page(__va(phys_addr));
>>
>> ...
>>
>> __va() is defined, on Alpha, to be:
>> 
>> 	# define __va(x)  ((void *)((unsigned long) (x) + PAGE_OFFSET))
>> 
>> ...
>> 
>> Now, what happens if 'kaddr' is below PAGE_OFFSET (because the user has
>> opened /dev/mem and mapped some random bit of physical memory space)?

But we generated kaddr by using __va, as above? If the user mapped /dev/mem
and created a second possible answer for a P->V mapping, that seems
irrelevant, as long as __va always returns the "primary" mapping into kernel
virtual address space.

I'd agree we're lacking some error checking here (maybe virt_to_page should
be an inline that checks that kaddr really is a kernel virtual address), but I 
can't see a real practical problem in the scenario you describe. As other
people seem to be able to, maybe I'm missing something ;-)

I'm not sure if your arch is a 32-bit or 64-bit arch, but I see more of a problem
in this code if we do "page = virt_to_page(__va(phys_addr));" on a physaddr
that's in HIGHMEM on a 32 bit arch, in which we get garbage from the wrapping,
and Daniel's "page = phys_to_page(phys_addr);" makes infintely more sense.

Martin.

