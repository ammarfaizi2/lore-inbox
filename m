Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbTEWUj0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264185AbTEWUj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:39:26 -0400
Received: from fmr01.intel.com ([192.55.52.18]:14846 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264183AbTEWUjV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:39:21 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: /proc/kcore - how to fix it
Date: Fri, 23 May 2003 13:52:25 -0700
Message-ID: <DD755978BA8283409FB0087C39132BD101B00E06@fmsmsx404.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /proc/kcore - how to fix it
Thread-Index: AcMhY1Kxs6Y+F2jHSWqw2tADsIWWeAABldOQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@linuxia64.org>,
       <rmk@arm.linux.org.uk>, <davidm@napali.hpl.hp.com>, <akpm@digeo.com>
X-OriginalArrivalTime: 23 May 2003 20:52:25.0762 (UTC) FILETIME=[37311020:01C3216D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /dev/mem / dev/kmem has the same problem, it could use that too.

Hmmm ... so "kclist" needs to be globally visible instead of static,
probably needs to be maintained by the mem driver rather than kcore.c
(which might not be configured) ... and would need a new name to
reflect its many uses (kvmlist?)
 
> > Other blocks of kernel virtual space can be added as needed, and
> > removed again (with kclist_del()).  E.g. discontiguous memory
> 
> Remove could get racy - /proc/kcore can sleep while accessing such
> a block. You would need a sleeping lock hold all the time.
> 
> What would you need remove for?

Someday we'll support memory hot-add and hot-remove.  But in the
more immediate future I think that arch/arm allocates space for
modules outside of vmalloc-land ... so might want to add space to
the list on module insert, and remove at rmmod time.

Races are a problem ... I'm just not sure how big of a problem.  The
virtual address to offset mapping stuff below is set up so that the
offsets of sections in the virtual /proc/kcore file do not change as
sections appear/disappear (just like the existing kcore code). So
if you are accessing some vmalloc'd structure and the kernel vfree()s
some other structure, then you won't get hurt.  But opening /proc/kcore
and reading the headers doesn't make any promises that memory listed
in an elf_phdr will still be there by the time you lseek and read,
which is no different from the existing implementation.

> 
> > The second piece of abstraction is the kc_vaddr_to_offset() and
> > kc_offset_to_vaddr() macros.  These provide mappings from kernel
> > virtual addresses to offsets in the virtual file that /proc/kcore
> > instantiates.  I hope they are sufficient to avoid negative offset
> > problems that plagued the old /proc/kcore.  Default versions are
> > provided for the old behaviour (mapping simply adds/subtracts
> > PAGE_OFFSET).  For ia64 I just need to use a different offset
> > as all kernel virtual allocations are in the high 37.5% of the
> > 64-bit virtual address space.
> 
> I'm not sure it is a good idea from the interface standpoint, 
> especially for /dev/kmem.  It would surely be confusing for the user.

I agree. /dev/kmem should provide a flat 1:1 map ... and leave users
to deal with all the negative addresses.  Applications already expect
this (because on x86 the kernel is already in negative space).

/proc/kcore is a bit different because it's trying to present
a regular file view, rather than a char-special file view to
any tool that wants to use it.  If someone fixes up gdb, objdump,
readelf, etc. then the macros can be easily removed to provide 1:1
(though even then it isn't quite 1:1 ... offset in file would be
"vaddr + elf_buflen" to allow space for the elf headers at the start
of the file.

-Tony
