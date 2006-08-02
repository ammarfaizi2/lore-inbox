Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWHBO0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWHBO0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 10:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWHBO0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 10:26:49 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:40465 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750859AbWHBO0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 10:26:49 -0400
Message-ID: <44D0B5C6.1040006@shadowen.org>
Date: Wed, 02 Aug 2006 15:25:10 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: moreau francis <francis_moreau2000@yahoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: sparsemem usage
References: <20060802134413.63901.qmail@web25814.mail.ukl.yahoo.com>
In-Reply-To: <20060802134413.63901.qmail@web25814.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moreau francis wrote:
> My board has a really weird mem mapping.
> 
> MEM1: 0xc000 0000 - 32 Mo
> MEM2: 0xd000 0000 - 8 Mo
> MEM3: 0xd800 0000 - 128 Ko
> 
> MEM3 has interesting properties, such as speed and security,
> and I really need to use it.
> 
> I think that sparsemem can deal with such mapping. But I
> encounter an issue when choosing the section bit size. I choose
> SECTION_SIZE_BITS = 17. Therefore the section size is
> equal to the smallest size of my memories. But I get a
> compilation error which is due to this:
> 
> #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
> #error Allocator MAX_ORDER exceeds SECTION_SIZE
> #endif
> 
> I'm not sure to understand why there's such check. To fix this
> I should change MAX_ORDER to 6.
> 
> Is it the only way to fix that ?

The memory allocator buddy location algorithm has an implicit assumption 
that the memory map will be contigious and valid out to MAX_ORDER.  ie 
that we can do relative arithmetic on a page* for a page to find its 
buddy at all times.  The allocator never looks outside a MAX_ORDER 
block, aligned to MAX_ORDER in physical pages.  SPARSEMEM's 
implementation by it nature breaks up the mem_map at the section size. 
Thus for the buddy to work a section must be >= MAX_ORDER in size to 
maintain the contiguity constraint.

However, just because you have a small memory block in your memory map 
doesn't mean that the sparsemem section size needs to be that small to 
match.  If there is any valid memory in any section that section will be 
instantiated and the valid memory marked within it, any invalid memory 
is marked reserved.  The section size bounds the amount of internal 
fragmentation we can have in the mem_map.  SPARSEMEM as its name 
suggests wins biggest when memory is very sparsly populate.  If I am 
reading correctly your memory is actually contigious.

-apw

