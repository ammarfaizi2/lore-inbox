Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbTADU1A>; Sat, 4 Jan 2003 15:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbTADU1A>; Sat, 4 Jan 2003 15:27:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9279 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261398AbTADU07>; Sat, 4 Jan 2003 15:26:59 -0500
To: suparna@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andy Pfiffer <andyp@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       wa@almesberger.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [PATCH][CFT] kexec (rewrite) for 2.5.52
References: <m1smwql3av.fsf@frodo.biederman.org>
	<20021231200519.A2110@in.ibm.com> <m11y3uldt9.fsf@frodo.biederman.org>
	<20030103181100.A10924@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jan 2003 13:34:12 -0700
In-Reply-To: <20030103181100.A10924@in.ibm.com>
Message-ID: <m1ptrck62j.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> On Fri, Jan 03, 2003 at 03:37:06AM -0700, Eric W. Biederman wrote:
> > Suparna Bhattacharya <suparna@in.ibm.com> writes:
> > 
> > > The good news is that it worked for me. Not only that, I have just 
> > > managed to get lkcd to save a dump in memory and then write it out 
> > > to disk after a kexec soft boot ! I haven't tried real panic cases yet 
> > > (which probably won't work rightaway :) ) and have testing and 
> > > tuning to do. But kexec seems to be looking good.
> > 
> > Nice.  Any pointers besides lkcd.sourceforge.net
> 
> I haven't posted this code to lkcd as yet - so far I'd only
> checked in the preparatory code reshuffle into lkcd cvs. There are
> still some things to improve and think about, but am planning
> to upgrade to the latest tree early next week and put things
> out, and then work on it incrementally.

O.k.

> > For the kexec on panic case there is a little code motion yet to be
> > done so that no memory allocations need to happen.  The big one is
> > setting up a page table with the reboot code buffer identity mapped.
> 
> I missed noticing that.
> Bootimg avoided the allocation at this stage. It did something like 
> this:
> 
> +static unsigned long get_identity_mapped_page(void)
> +{
> +       set_pgd(pgd_offset(current->active_mm, 
> + 	virt_to_phys(unity_page)), __pgd((_KERNPG_TABLE 
> + 	_PAGE_PSE + (virt_to_phys(unity_page)&PGDIR_MASK))));
> +       return (unsigned long)unity_page;
> +}
> 
> where unity page is within directly mapped memory (not highmem).

With unity_page being allocated ahead of time...
But there is some other trick it is pulling to make certain the
intermediate page table entries are present.  Spooky and I don't want
to go there.

> > I am tempted to do the identity mapping of the reboot code buffer in
> > init_mm, but for starters I will look at how complex it will be to
> > have a spare mm just sitting around for that purpose.  When I get
> > to dealing with the architectures like the hammer, and the alpha where
> > you always need page tables I will need to develop an architecture
> > specific hook for building the page tables needed by the
> > code residing in the reboot code buffer, (because virtual memory
> > cannot be disabled), but that should be straight forward.
> 
> A spare mm may be something which I could use for the crash dump
> pages mapping possibly simpler than the way it is maintained
> right now ... but haven't given enough thought to it yet.

Given that it is likely only to be a temporary thing I doubt it will
help.  A very interesting question along those lines is how do 
you get at all of the memory you are dumping, especially in PAE mode.
I have not seen the code that handles that part at all...

Eric
