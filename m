Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTEWV0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 17:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbTEWV0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 17:26:55 -0400
Received: from ns.suse.de ([213.95.15.193]:2054 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264197AbTEWV0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 17:26:53 -0400
Date: Fri, 23 May 2003 23:39:59 +0200
From: Andi Kleen <ak@suse.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org, rmk@arm.linux.org.uk,
       davidm@napali.hpl.hp.com, akpm@digeo.com
Subject: Re: /proc/kcore - how to fix it
Message-ID: <20030523213959.GA1654@wotan.suse.de>
References: <DD755978BA8283409FB0087C39132BD101B00E06@fmsmsx404.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD755978BA8283409FB0087C39132BD101B00E06@fmsmsx404.fm.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 01:52:25PM -0700, Luck, Tony wrote:
> > /dev/mem / dev/kmem has the same problem, it could use that too.
> 
> Hmmm ... so "kclist" needs to be globally visible instead of static,
> probably needs to be maintained by the mem driver rather than kcore.c
> (which might not be configured) ... and would need a new name to
> reflect its many uses (kvmlist?)

One alternative I considered was to use just do a page table lookup.
But I fear that some architectures use direct mapping registers etc.
with mappings not in the page tables for the direct mapping, so it 
probably won't work for everybody.

>  
> > > Other blocks of kernel virtual space can be added as needed, and
> > > removed again (with kclist_del()).  E.g. discontiguous memory
> > 
> > Remove could get racy - /proc/kcore can sleep while accessing such
> > a block. You would need a sleeping lock hold all the time.
> > 
> > What would you need remove for?
> 
> Someday we'll support memory hot-add and hot-remove.  But in the
> more immediate future I think that arch/arm allocates space for
> modules outside of vmalloc-land ... so might want to add space to
> the list on module insert, and remove at rmmod time.

x86-64 does that too. My prefered solution would be to to just handle
the exception when this happens and thread module / vmalloc area as a 
big chunk. But it would probably require too much architecture
specific code again to be practical (on many archs you can just use
__copy_*_user, but some do funky things in there and it won't work
for them)

Ignoring that the choices are either: memcpy to temporary buffer with 
spinlock hold or a semaphore over the copy_to_user.

> 
> Races are a problem ... I'm just not sure how big of a problem.  The
> virtual address to offset mapping stuff below is set up so that the
> offsets of sections in the virtual /proc/kcore file do not change as
> sections appear/disappear (just like the existing kcore code). So
> if you are accessing some vmalloc'd structure and the kernel vfree()s
> some other structure, then you won't get hurt.  But opening /proc/kcore
> and reading the headers doesn't make any promises that memory listed
> in an elf_phdr will still be there by the time you lseek and read,
> which is no different from the existing implementation.

What I'm worrying about is that the kernel will oops when accessing
unmapped memory. That certainly should not happen.

> /proc/kcore is a bit different because it's trying to present
> a regular file view, rather than a char-special file view to
> any tool that wants to use it.  If someone fixes up gdb, objdump,
> readelf, etc. then the macros can be easily removed to provide 1:1
> (though even then it isn't quite 1:1 ... offset in file would be
> "vaddr + elf_buflen" to allow space for the elf headers at the start
> of the file.

You're doing this to handle tools that have signedness bugs while
parsing core files? iirc gdb is clean. What other tools have the 
problem? 

-Andi
