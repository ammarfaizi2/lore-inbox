Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318864AbSG1AgC>; Sat, 27 Jul 2002 20:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318867AbSG1AgC>; Sat, 27 Jul 2002 20:36:02 -0400
Received: from dsl-213-023-021-146.arcor-ip.net ([213.23.21.146]:25729 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318864AbSG1AgB>;
	Sat, 27 Jul 2002 20:36:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Russell Lewis <spamhole-2001-07-16@deming-os.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Looking for links: Why Linux Doesn't Page Kernel Memory?
Date: Sun, 28 Jul 2002 02:40:05 +0200
X-Mailer: KMail [version 1.3.2]
References: <3D418DFD.8000007@deming-os.org>
In-Reply-To: <3D418DFD.8000007@deming-os.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Yc6Q-0001yA-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 July 2002 19:59, Russell Lewis wrote:
> I have spent some time working on AIX, which pages its kernel memory. 
> It pins the interrupt handler functions, and any data that they access, 
> but does not pin the other code.
> 
> I'm looking for links as to why (unless I'm mistaken) Linux doesn't do 
> this, so I can better understand the system.

You could say that most of the kernel memory is paged because it consists of 
disk cache and pages that are handed out to be mapped into process memory.  
Slab caches - The kernel's working memory - are not paged at all.  Instead, 
certain 'well-known' caches (inode, dentry, quota) are scanned for 
inactive/unused objects, which are evicted on the theory that they can be 
readily reconstructed from the file store if needed again.  Buffer heads are 
treated similarly, but with a different mechanism.

That leaves quite a few bits and pieces of slab cache in the 'misc' category 
(including all kmalloc'd memory) and I guess we just cross our fingers, try 
not to be too wasteful with it, and hope for the best.

There are two elephants in the bathtub: the mem_map array, which holds a few 
bytes of state information for each physical page in the system, and page 
tables, neither of which are swapped or pruned in any way.  We are now 
beginning to suffer pretty badly because of this, on certain high end 
configurations.  The problem is, these structures have to keep track of much 
more than just the kernel memory.  The former has to have entries for all of 
the high memory pages (not addressable within the kernel's normal virtual 
address space) and the latter has to keep track of pages mapped into every 
task in the system, in other words, a virtually unlimited amount of memory 
(pun intended).  Solutions are being pursued.  Paging page tables to swap is 
one of the solutions being considered, though nobody has gone so far as to 
try it yet.  An easier solution is to place page tables in high memory, and a 
patch for this exists.  There is also work being done on page table sharing.

Hmm, that was more than I intended to write, but you have to be aware of all 
of this to be able to think seriously about the question of why kernel memory 
isn't paged.  Besides the complexity, the real reason is performance.  It 
would be slower to take faults on all the different flavors of pages the 
kernel deals with than to check explicitly for the presence of objects the 
kernel needs to work with, such as file cache and inodes.  This would also 
conflict with the large (4 meg) pages used to map the kernel itself.  There 
would be extra costs for memory cache reloading (some architectures) and tlb 
shootdowns (all architectures).  Finally, on 32 bit processors, where will 
you get all the virtual memory space you need to map hundreds or thousands of 
cached files?

So there you are, a once-over-lightly of a simple question that has a 
not-so-simple answer.  We sort-of page some kernel memory, but not with the 
hardware faulting mechanism.  Some kernel memory isn't paged or pruned and 
perhaps needs to be.  We wave our hands at the rest as small change.

-- 
Daniel
