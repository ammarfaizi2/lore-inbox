Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267506AbTACMbg>; Fri, 3 Jan 2003 07:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267508AbTACMbg>; Fri, 3 Jan 2003 07:31:36 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:59027 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267506AbTACMbe>;
	Fri, 3 Jan 2003 07:31:34 -0500
Date: Fri, 3 Jan 2003 18:11:00 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andy Pfiffer <andyp@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       wa@almesberger.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [PATCH][CFT] kexec (rewrite) for 2.5.52
Message-ID: <20030103181100.A10924@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <m1smwql3av.fsf@frodo.biederman.org> <20021231200519.A2110@in.ibm.com> <m11y3uldt9.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m11y3uldt9.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Fri, Jan 03, 2003 at 03:37:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 03:37:06AM -0700, Eric W. Biederman wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> writes:
> 
> > The good news is that it worked for me. Not only that, I have just 
> > managed to get lkcd to save a dump in memory and then write it out 
> > to disk after a kexec soft boot ! I haven't tried real panic cases yet 
> > (which probably won't work rightaway :) ) and have testing and 
> > tuning to do. But kexec seems to be looking good.
> 
> Nice.  Any pointers besides lkcd.sourceforge.net

I haven't posted this code to lkcd as yet - so far I'd only
checked in the preparatory code reshuffle into lkcd cvs. There are
still some things to improve and think about, but am planning
to upgrade to the latest tree early next week and put things
out, and then work on it incrementally.

> 
> For the kexec on panic case there is a little code motion yet to be
> done so that no memory allocations need to happen.  The big one is
> setting up a page table with the reboot code buffer identity mapped.

I missed noticing that.
Bootimg avoided the allocation at this stage. It did something like 
this:

+static unsigned long get_identity_mapped_page(void)
+{
+       set_pgd(pgd_offset(current->active_mm, 
+ 	virt_to_phys(unity_page)), __pgd((_KERNPG_TABLE 
+ 	_PAGE_PSE + (virt_to_phys(unity_page)&PGDIR_MASK))));
+       return (unsigned long)unity_page;
+}

where unity page is within directly mapped memory (not highmem).

> 
> I am tempted to do the identity mapping of the reboot code buffer in
> init_mm, but for starters I will look at how complex it will be to
> have a spare mm just sitting around for that purpose.  When I get
> to dealing with the architectures like the hammer, and the alpha where
> you always need page tables I will need to develop an architecture
> specific hook for building the page tables needed by the
> code residing in the reboot code buffer, (because virtual memory
> cannot be disabled), but that should be straight forward.

A spare mm may be something which I could use for the crash dump
pages mapping possibly simpler than the way it is maintained
right now ... but haven't given enough thought to it yet.

> 
> My goal is to have no locks on the kexec part of the panic path.  And
> the current memory allocations are the only really bad part of that.

OK.

> 
> A dump question.  Why doesn't the lkcd stuff use the normal ELF core
> dump format?  allowing ``gdb vmlinux core'' to work?

I guess its ultimately a choice of format,  how much processing 
to do at dump time, vs afterwards prior to analysis, and whether
it captures all aspects relevant for the kind of analysis
intended. The lkcd dump format appears to designed in a way that 
makes it suitable for crash dumping kind of situations. It takes 
an approach of simplifying work at dump time (desirable). It 
enables pages to be dumped right away in any order with a header 
preceding the page dumped, which makes it easier to support extraction 
of information from truncated dumps. This also makes it easier to do 
selective dumping and placement of more critical data earlier 
in the dump.

Secondly, it retains the notion of pages being dumped by physical 
address, with interpretation/conversions from virt-to-phys on 
analysis being taken care of the analyser or convertor. For example
there has been work on a post processor that generates a core file 
from the lkcd dump corresponding to a given task/address space 
context for analysis via gdb. Similarly there is a capibility
in lcrash that lets one generate a (smaller) selected subset of 
dumped state from an existing dump, which can be mailed out from 
a remote site for analysis.

The tradeoff is that there is a bit of pre-processing that happens
prior to analysis for generation of an index, or conversion
depending on what analysis tool gets used. But that time is less
crucial than actual dump time.

Am cc'ing lkcd-devel on this one - there are experts who can
add to this or answer this question better than I can. 

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

