Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVLPB1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVLPB1p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVLPB1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:27:45 -0500
Received: from smtp103.plus.mail.mud.yahoo.com ([68.142.206.236]:63091 "HELO
	smtp103.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751235AbVLPB1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:27:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=PX//W594fseMpWizUbENVcUlaLI6vqrXled2OUpgYV/2j/WPLvwVkqzu3P5Mb4HWvWcxO6k0PgBQ0xM6vcpuVZu+TUFr4qNXuLDU0u7537hhS+pJXKk+ajiYGTS2JofYm9A8HIRFEzfkVEdWpUDmJYGdBwCC2B0akBPLFXV8zZ8=  ;
Message-ID: <43A21807.70504@yahoo.com.au>
Date: Fri, 16 Dec 2005 12:27:35 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Laurent Pinchart <laurent.pinchart@skynet.be>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM_RESERVED and PG_reserved : Allocating memory for video buffers
References: <200512152009.33758.laurent.pinchart@skynet.be>
In-Reply-To: <200512152009.33758.laurent.pinchart@skynet.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Pinchart wrote:
> Hi everybody,
> 
> I'm writing a Linux driver for a USB Video Class compliant USB device. I 
> manage to understand pretty much everything on my own until the point where I 
> have to allocate video buffers.
> 
> I read other drivers to understand how they proceed. Most of them used vmalloc 
> with SetPageReserved and remap_pfn_range to map the memory to user space. I 
> thought I understood that, when I noticed that vm_insert_page has been added 
> in 2.6.15. I wasn't sure how to prevent pages from being swapped out, so I 
> read the excellent "Understanding the Linux Virtual Memory Manager", but I'm 
> still not sure to understand everything. This is where I ask for your help.
> 
> I need to allocate big buffers, so vmalloc is the way to go, as I don't need 
> contiguous memory. I need to map those buffers to user space, and I 
> understand that vm_insert_page will do the job nicely. My fears come from 
> pages being swapped out. I suppose I need to prevent that, as a page fault in 
> interrupt is a Bad Thing(TM). I'm not sure how PG_reserved and VM_RESERVED 
> interract with eachother. Can kernel pages be swapped out if they are not 
> mapped to user space ? Or does kswapd only walk VMAs when it tries to find 
> pages that will be swapped out ? If the later is true, is it enough to set 
> VM_RESERVED on the VMA in the mmap handler ?
> 

PG_reserved no longer does anything (except catching bugs in old code).
If you are writing new code, you shouldn't use it. Don't copy rvmalloc,
you should be able to use vmalloc directly.

vm_insert_page is indeed the right interface for mapping these pages
into userspace.

You do not have to worry about pages being swapped out, and you shouldn't
need to set any unusual vma or page flags. kswapd only walks the lru lists,
and it won't even look at any other pages.

Good luck,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
