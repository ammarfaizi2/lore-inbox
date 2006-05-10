Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWEJMR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWEJMR4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 08:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWEJMR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 08:17:56 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:33493 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964937AbWEJMRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 08:17:55 -0400
Date: Wed, 10 May 2006 17:47:50 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com, akpm@osdl.org,
       Andi Kleen <ak@suse.de>, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, hch@infradead.org
Subject: Re: [RFC] [PATCH 6/6] Kprobes: Remove breakpoints from the copied  pages
Message-ID: <20060510121750.GD12463@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060509065455.GA11630@in.ibm.com> <20060509065917.GA22493@in.ibm.com> <20060509070106.GB22493@in.ibm.com> <20060509070508.GC22493@in.ibm.com> <20060509070911.GD22493@in.ibm.com> <20060509071204.GE22493@in.ibm.com> <20060509071523.GF22493@in.ibm.com> <Pine.LNX.4.64.0605091747050.10238@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605091747050.10238@blonde.wat.veritas.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 06:04:50PM +0100, Hugh Dickins wrote:
> On Tue, 9 May 2006, Prasanna S Panchamukhi wrote:
> > This patch removes the breakpoints if the pages read from the page
> > cache contains breakpoints. If the pages containing the breakpoints
> > is copied from the page cache, the copied image would also contain
> > breakpoints in them. This could be a major problem for tools like
> > tripwire etc and cause security concerns, hence must be prevented.
> > This patch hooks up the actor routine, checks if the executable was
> > a probed executable using the file inode and then replaces the
> > breakpoints with the original opcodes in the copied image.
> 
> You've done a nice job of making the code look like kernel code
> throughout, it's a much tidier patchset than many.
> 
> With that said... it looks to me like one of the scariest and
> most inappropriate sets I can remember.  Getting the kernel to
> connive in presenting an incoherent view of its pagecache:
> I don't think we'd ever want that.
> 

As Andi Kleen and Christoph suggested pagecache contention can be avoided
using the COW approach.

Advantages of COW:

1. No need to hookup file_read_actor() to remove the breakpoints if a
   the probed page was read from pagecache.
2. No need to hookup readpage(s)() to insert probes when pages are
   read into the memory.
                                                                                
Some thoughts about COW implications AFAIK
                                                                                
1. Need to hookup mmap() to make a per process copy.
2. Bring in the pages just to insert the probes.
3. All the text pages need to be in memory until process exits.
4. Free up the per process text pages by hooking exit() and exec().
5. Maskoff probes visible across fork(), by hooking fork().
                                                                                
Any implications ?
                                                                                

Thanks
Prasanna
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
