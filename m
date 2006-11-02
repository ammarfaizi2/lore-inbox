Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbWKBSIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbWKBSIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 13:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWKBSIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 13:08:17 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:13460 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751537AbWKBSIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 13:08:16 -0500
Date: Thu, 2 Nov 2006 13:07:33 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       Mel Gorman <mel@csn.ul.ie>, Andi Kleen <ak@muc.de>,
       fastboot@lists.osdl.org
Subject: Re: [PATCH] x86_64: setup saved_max_pfn correctly (kdump)
Message-ID: <20061102180733.GD8074@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061102131934.24684.93195.sendpatchset@localhost> <20061102142812.GB8074@in.ibm.com> <aec7e5c30611020940g73ff373cjbca4c684c5ed8cc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c30611020940g73ff373cjbca4c684c5ed8cc6@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 02:40:26AM +0900, Magnus Damm wrote:
> On 11/2/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >On Thu, Nov 02, 2006 at 10:19:34PM +0900, Magnus Damm wrote:
> >> x86_64: setup saved_max_pfn correctly
> >>
> >> 2.6.19-rc4 has broken CONFIG_CRASH_DUMP support on x86_64. It is 
> >impossible
> >> to read out the kernel contents from /proc/vmcore because saved_max_pfn 
> >is set
> >> to zero instead of the max_pfn value before the user map is setup.
> >>
> >> This happens because saved_max_pfn is initialized at parse_early_param() 
> >time,
> >> and at this time no active regions have been registered. save_max_pfn is 
> >setup
> >> from e820_end_of_ram(), more exact find_max_pfn_with_active_regions() 
> >which
> >> returns 0 because no regions exist.
> >>
> >> This patch fixes this by registering before and removing after the call
> >> to e820_end_of_ram().
> >>
> >> Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
> >> ---
> >>
> >>  Applies to 2.6.19-rc4.
> >>
> >>  arch/x86_64/kernel/e820.c |    2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> --- 0002/arch/x86_64/kernel/e820.c
> >> +++ work/arch/x86_64/kernel/e820.c    2006-11-02 21:37:19.000000000 +0900
> >> @@ -594,7 +594,9 @@ static int __init parse_memmap_opt(char
> >>                * size before original memory map is
> >>                * reset.
> >>                */
> >> +             e820_register_active_regions(0, 0, -1UL);
> >>               saved_max_pfn = e820_end_of_ram();
> >> +             remove_all_active_ranges();
> >>  #endif
> >>               end_pfn_map = 0;
> >>               e820.nr_map = 0;
> >
> >This looks fine to me for the time being.
> 
> Great, thanks.
> 

I looked at Mel's suggestion of shifting the call to
e820_register_active_regions() above parse_early_param() and that should
be a better solution.

> >Down the line I am thinking that how about passing saved_max_pfn as
> >command line parameter. I think that way we don't have to pass all the
> >memmap= options to second kernel and kexec-tools can pass the memory map
> >through parameter segment. This memory map can be modified to represent
> >only the memory which can be used by second kernel and not the whole of
> >the memory.
> 
> Hm, I'm not sure how that will improve things. Isn't memmap= just used
> to inform the secondary kernel which space it can use? You need to
> tell it somehow regardless - I think the current implementation seems
> to work pretty well. But I guess you mean that we should pass an
> modified e820 map that only includes valid areas for the second
> kernel. That may simplify things. But changing the interface is
> painful.
> 

Actually kexec already passes a memory map to second kernel through
parameter segment. We can just modify that memory map instead of 
passing it through memmap= command line options. Currently memory map
passed by kexec is used to calculate the saved_max_pfn and it can be
calculated using a command line parameter. So effectively I am replacing
multiple memmap= command line parameter with one.

> Right now I feel that so many things are happening in the kdump world
> that it's difficult just to keep the current code working as is.
> 

I agree. Probably we should do it later.

> >I think this will simplify the logic and also save us precious comand
> >line in second kernel for kdump purposes.
> 
> I remember seeing some email regarding extending the amount of command
> line space, that's an alternative approach if we are running out of
> space.

I had also seen those patches. Does not seem to be upstream. Don't know
what happened to those.

Thanks
Vivek
