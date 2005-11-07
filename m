Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVKGS7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVKGS7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVKGS7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:59:52 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7552 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964941AbVKGS7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:59:52 -0500
Subject: RE: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Adam Litke <agl@us.ibm.com>
To: Andy Nelson <andy@thermo.lanl.gov>
Cc: ak@suse.de, nickpiggin@yahoo.com.au, rohit.seth@intel.com, akpm@osdl.org,
       arjan@infradead.org, arjanv@infradead.org, gmaxwell@gmail.com,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie, mingo@elte.hu,
       torvalds@osdl.org
In-Reply-To: <20051107003452.3A0B41855A0@thermo.lanl.gov>
References: <20051107003452.3A0B41855A0@thermo.lanl.gov>
Content-Type: text/plain
Organization: IBM
Date: Mon, 07 Nov 2005 12:58:53 -0600
Message-Id: <1131389934.25133.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-06 at 17:34 -0700, Andy Nelson wrote:
> Hi folks,
> 
> >Not sure how applications seamlessly can use the proposed hugetlb zone
> >based on hugetlbfs.  Depending on the programming language, it might
> >actually need changes in libs/tools etc.
> 
> This is my biggest worry as well. I can't recall the details
> right now, but I have some memories of people telling me, for
> example, that large pages on linux were not now available to 
> fortran programs period, due to lack of toolchain/lib stuff, 
> just as you note. What the reasons were/are I have no idea. I 
> do know that the Power 5 numbers I quoted a couple of days ago
> required that the sysadmin apply some special patches to linux
> and linking to extra library. I don't know what patches (they
> came from ibm), but for xlf95 on Power5, the library I had to 
> link with was this one:  
> 
>     -T /usr/local/lib64/elf64ppc.lbss.x
> 
> 
> No changes were required to my code, which is what I need,
> but codes that did not link to this library would not run on 
> a kernel that had the patches installed, and code that did 
> link with this library would not run on a kernel that didn't 
> have those patches. 
> 
> I don't know what library this is or what was in it, but I 
> cant imagine it would have been something very standard or
> mainline, with that sort of drastic behavior. Maybe the ibm
> folk can explain what this was about.

Wow.  It's amazing how these things spread from my little corner of the
universe ;)  What you speak of sounds dangerously close to what I've
been working on lately.  Indeed it is not standard at all yet.  

I am currently working on an new approach to what you tried.  It
requires fewer changes to the kernel and implements the special large
page usage entirely in an LD_PRELOAD library.  And on newer kernels,
programs linked with the .x ldscript you mention above can run using all
small pages if not enough large pages are available.

For the curious, here's how this all works:
1) Link the unmodified application source with a custom linker script which
does the following:
  - Align elf segments to large page boundaries
  - Assert a non-standard Elf program header flag (PF_LINUX_HTLB)
    to signal something (see below) to use large pages.
2) Boot a kernel that supports copy-on-write for PRIVATE hugetlb pages
3) Use an LD_PRELOAD library which reloads the PF_LINUX_HTLB segments into
large pages and transfers control back to the application.

> I will ask some folks here who should know how it may work
> on intel/amd machines about how large pages can be used 
> this coming week, when I attempt to do page size speed 
> testing for my code, as I promised before, as I promised
> before, as I promised before. 

I have used this method on ppc64, x86, and x86_64 machines successfully.
I'd love to see how my system works for a real-world user so if you're
interested in trying it out I can send you the current version.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

