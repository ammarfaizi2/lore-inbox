Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265140AbTL2UEZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265368AbTL2UEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:04:25 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:11494 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id S265140AbTL2UCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:02:22 -0500
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Subpages (was: Page Colouring)
Date: Mon, 29 Dec 2003 15:02:20 -0500
User-Agent: KMail/1.5.4
Cc: mfedyk@matchmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
       Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <179fV-1iK-23@gated-at.bofh.it> <20031229025507.GT22443@holomorphy.com> <Pine.LNX.4.58.0312282000390.11299@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312282000390.11299@home.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312291501.32541.phillips@arcor.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 December 2003 23:09, Linus Torvalds wrote:
> On Sun, 28 Dec 2003, William Lee Irwin III wrote:
> > Doubtful. I suspect he may be referring to pgcl (sometimes called
> > "subpages"), though Dan Phillips hasn't been involved in it. I guess
> > we'll have to wait for Linus to respond to know for sure.
>
> I didn't see the patch itself, but I spent some time talking to Daniel
> after your talk at the kernel summit. At least I _think_ it was him I was
> talking to - my memory for names and faces is basically zero.
>
> Daniel claimed to have it working back then, and that it actually shrank
> the kernel source code. The basic approach is to just make PAGE_SIZE
> larger, and handle temporary needs for smaller subpages by just
> dynamically allocating "struct page" entries for them. The size reduction
> came from getting rid of the "struct buffer_head", because it ends up
> being just another "small page".
>
> Daniel, details?

Hi Linus,

Your description is accurate.  Another reason for code size shrinkage is 
getting rid of the loops across buffers in the block IO library, e.g., 
block_read_full_page.

Subpages only make sense for file-backed memory, which conveniently lets the 
page cache keep track of subpages.  Each address_space has pages of all the 
same size, which may be smaller, larger or the same as PAGE_CACHE_SIZE.  The 
first case, "subpages", is the interesting one.

An address_space with subpages has base pages of PAGE_CACHE_SIZE for its 
"even" entries and up to N-1 dynamically allocated struct pages for the "odd"  
entries where N is PAGE_CACHE_SIZE divided by the subpage size.  Base pages 
are normal members of mem_map.  Subpages are not referenced by mem_map, but 
only by the page cache.  They are created by operations such as 
find_or_create_page, which first creates a base page if necessary.  A counter 
field in the page flags of the base page keeps track of how many subpages 
share a base page's physical memory; when this field goes to zero the base 
page may be removed from the page cache.

Subpages always have a ->virtual field regardless of whether mem_map pages do.  
This is used for virt_to_phys and to locate the base page when a subpage is 
freed.

Page fault handling doesn't change much if at all, since the faulting address 
is rounded down to a physical page, which will be a base page.

Most of the changes for subpages are in the buffer.c page cache operations and 
are largely transparent to the VMM, though PAGE_CACHE_SHIFT becomes 
mapping->page_shift, which touches a lot of files.  As you noted, buffer_head 
functionality can be taken over by struct page and buffers become expendible.  
However it is not necessary to cross that bridge immediately; page buffer 
lists continue to work though the buffer list is never longer than one.

With a little more work, subpages can be used to shrink mem_map: implement a 
larger PAGE_CACHE_SIZE then use subpages to handle ABI problems.  In this 
case faults on subpages are possible and the fault path probably needs to 
know something about it.  With a larger-than-physical PAGE_CACHE_SIZE we can 
finally have large buffers, though the kernel would have to be compiled for 
it.  Some more work to allowing mapping->page_shift to be larger than 
PAGE_CACHE_SIZE would complete the process of generalizing the page size.  My 
impression is, this isn't too messy, most of the impact is on faulting.  Bill 
and others are already familiar with this I think.  The work should dovetail.

I took a stab at implementing subpages some time ago in 2.4 and got it mostly 
working but not quite bootable.  I did find out roughly how invasive the 
patch is, which is: not very, unless I've overlooked something major.  I'll 
get busy on a 2.6 prototype, and of course I'll listen attentively for 
reasons why this plan won't work.

Regards,

Daniel

