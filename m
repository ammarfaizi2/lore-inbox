Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbVLPNeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVLPNeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVLPNeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:34:50 -0500
Received: from smtp102.plus.mail.mud.yahoo.com ([68.142.206.235]:1960 "HELO
	smtp102.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932266AbVLPNet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:34:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=P830MxiaJr9P5HzycNIQ391h4QrpKCNyRZUUWcxPGvgPGqtTrWqrfvnNcB3OZ16N8bJoQES6eRQ42dj7wZ9T8PEGdpAclvCpNpPB1NY1iH5JZwzWfPbdM+u4DiL5Yhre/dGWOystRL4wdls5XgplzBOvkMSYNL3HsFjCayeeoAM=  ;
Message-ID: <43A2C26F.3060101@yahoo.com.au>
Date: Sat, 17 Dec 2005 00:34:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Laurent Pinchart <laurent.pinchart@skynet.be>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM_RESERVED and PG_reserved : Allocating memory for video buffers
References: <200512152009.33758.laurent.pinchart@skynet.be> <43A21807.70504@yahoo.com.au> <200512161233.05411.laurent.pinchart@skynet.be>
In-Reply-To: <200512161233.05411.laurent.pinchart@skynet.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Pinchart wrote:
> On Friday 16 December 2005 02:27, Nick Piggin wrote:

>>vm_insert_page is indeed the right interface for mapping these pages
>>into userspace.
> 
> 
> Ok, that's what I intended to do.
> 
> 
>>You do not have to worry about pages being swapped out, and you shouldn't
>>need to set any unusual vma or page flags. kswapd only walks the lru lists,
>>and it won't even look at any other pages.
> 
> 
> I'd still like to understand how things work (I'm one of those programmers who 
> don't like to code without understanding).
> 
> I think I understand how disk buffers or non-shared pages mapped by a regular 
> file can be reclaimed, but I have trouble with anonymous pages and shared 
> pages.
> 
> First of all, I haven't been to find a definition of an anonymous page. I 
> understand it as a page of memory not backed by a file (pages allocated by 
> vmalloc for instance). If this is wrong, what I'm about to say if probably 
> very wrong as well.
> 

Anonymous memory is memory not backed by a file. However the userspace
program will gain access to your vmalloc memory by mmaping a /dev file,
right?

So the mm kind of treats these pages as file pages (not anonymous),
although it doesn't make much difference because it really has very little
to do with them aside from what you see in vm_insert_page.

> Are anonymous pages ever added to the LRU active list ? I suppose they are 
> not, which is why they are not reclaimed.
> 

They are, see the line

	lru_cache_add_active(page);

in mm/memory.c:do_anonymous_page()

Anonymous memory is basically memory allocated by malloc(), to put simply.

Reclaiming anonymous memory involves writing it out to swap.

> How does the kernel handle shared pages, (if for instance two processes map a 
> regular file with MAP_SHARED) ? They can't be reclaimed before all processes 
> which map them have had their PTEs modified. Is this where reverse mapping 
> comes into play ?
> 

That's right. mm/rmap.c:try_to_unmap()

> Finally, how are devices which map anonymous kernel memory to user space 
> handled ? When a page is inserted in a process VMA using vm_insert_page, it 
> becomes shared between the kernel and user space. Does the kernel see the 
> page as a regular device backed page, and put it in the LRU active list ? You 

No, the kernel won't do anything with it after vm_insert_page (which does
not put it on the LRU) until the process unmaps that page, at which time
all the accounting done by vm_insert_page is undone.

> said I shouldn't need to set any unusual VMA or page flags. What's the exact 
> purpose of VM_RESERVED and VM_IO then ? And when should they be set ?
> 

VM_RESERVED I think was in 2.4 to stop the swapout code looking at that
vma. I don't think you should ever need to set it in 2.6.

VM_IO should be set on memory areas that have can have side effects when
accessing them, like memory mapped IO regions.

> Hope I'm not bothering you too much with all those questions. I don't feel at 
> ease when developping kernel code if I don't have at least a basic 
> understanding of what I'm doing.
> 

That's OK, hope this is of some help.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
