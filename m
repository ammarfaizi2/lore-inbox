Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292628AbSCDRnx>; Mon, 4 Mar 2002 12:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292589AbSCDRl4>; Mon, 4 Mar 2002 12:41:56 -0500
Received: from mnh-1-24.mv.com ([207.22.10.56]:46597 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S292599AbSCDRlI>;
	Mon, 4 Mar 2002 12:41:08 -0500
Message-Id: <200203041742.MAA02717@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Mon, 04 Mar 2002 15:09:45 GMT."
             <E16hu5x-0007zd-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 12:42:43 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> That is what mmap defines for a file based mapping yes. Thats a case
> where there isnt much else you can do 

Except the whole point of me starting this thread is that there is something
sane that UML can do *if* it can trap those bus errors in a controlled way.

If UML can detect pages which tmpfs can't back as they leave the allocator,
then it can prevent the rest of the UML kernel from getting randomly SIGBUSed
as it touches those pages.

To recap in case it got lost in the confusion, I want __alloc_pages to call
an arch hook before it return memory, turning every instance of

	if (page)
		return page;

into

	if (page)
		return arch_validate(page);

Unless the arch defines its own arch_validate(), a generic header would
define it as

	static inline arch_validate(struct page_struct *page){ return page; }

or the equivalent macro.

On the other hand, UML would define it to touch each page in the allocation,
trapping SIGBUS there.  If any do SIGBUS, then my orginal proposal was to 
free the block back to the allocator and return NULL.  This would cause a
flurry of allocation failures to things that weren't willing to sleep, and
if that causes trouble, then the caller needed fixing anyway.

A more interesting idea is to hang on to the block and maybe unmap it.  
Umapping would free any backed pages in the block back to tmpfs, giving it 
(and the other UMLs, if any) some breathing room.  Even if the entire block
was unbacked, the UML would lose it as being allocatable and would eventually
be restricted to handing out pages that it had managed to touch before tmpfs
ran out.

This is way more sane than the current get-a-SIGBUS-someplace-random-and-panic
situation I have now.

Given that we are talking about tmpfs running out of space, the host still
has plenty of free memory, and UML kernel stacks can receive the SIGBUS
(because they've been allocated with this mechanism), is this still 
objectionable?

				Jeff

