Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVCPAQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVCPAQH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVCPAQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:16:07 -0500
Received: from fmr24.intel.com ([143.183.121.16]:41951 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262183AbVCPALl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:11:41 -0500
Date: Tue, 15 Mar 2005 16:10:54 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Dave Jones <davej@redhat.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rohit Seth <rohit.seth@intel.com>
Subject: Re: [PATCH] Reading deterministic cache parameters and exporting it in /sysfs
Message-ID: <20050315161054.A2251@unix-os.sc.intel.com>
References: <20050315152448.A1697@unix-os.sc.intel.com> <20050315233620.GC14380@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050315233620.GC14380@redhat.com>; from davej@redhat.com on Tue, Mar 15, 2005 at 06:36:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 06:36:20PM -0500, Dave Jones wrote:
> On Tue, Mar 15, 2005 at 03:24:48PM -0800, Venkatesh Pallipadi wrote:
>  >  
>  > The attached patch adds support for using cpuid(4) instead of cpuid(2), to get 
>  > CPU cache information in a deterministic way for Intel CPUs, whenever 
>  > supported. The details of cpuid(4) can be found here
>  > 
>  > IA-32 Intel Architecture Software Developer's Manual (vol 2a)
>  > (http://developer.intel.com/design/pentium4/manuals/index_new.htm#sdm_vol2a)
>  > and
>  > Prescott New Instructions (PNI) Technology: Software Developer's Guide
>  > (http://www.intel.com/cd/ids/developer/asmo-na/eng/events/43988.htm)
>  >  
>  > The advantage of using the cpuid(4) ('Deterministic Cache Parameters Leaf') are:
>  > * It provides more information than the descriptors provided by cpuid(2)
>  > * It is not table based as cpuid(2). So, we will not need changes to the 
>  >   kernel to support new cache descriptors in the descriptor table (as is the 
>  >   case with cpuid(2)).
>  >  
>  > The patch also adds a bunch of interfaces under 
>  > /sys/devices/system/cpu/cpuX/cache, showing various information about the
>  > caches.
> 
> Why does this need to be in kernel-space ? 

Currently, the CPU cache information is printed as a part of kernel bootup
messages and /proc/cpuinfo using cpuid(2). This patch is trying to use cpuid(4)
to print the messages in these places. I think this part of the patch is
required. Otherwise, we may end up printing 0 cache sizes on some CPUs.
It will also reduce the zero_cache_size_complaints on lkml :-).

> Is there some reason that prevents
> you from enhancing x86info for example ?  I really want to live to see the
> death of /proc/cpuinfo one day, and reinventing it in sysfs seems pointless
> if it can all be done in userspace.
> Given that the most useful field is of limited use to a majority of users,
> and those that are interested can read this from userspace, this has me very puzzled.

Agreed. Exporting it in /sysfs is debatable. And some of the information like,
'Which CPUs are sharing what caches' may not be useful today. But,
with CPUs with HT and multiple cores and combinations of it, sharing different
caches, having this information will be useful inside the kernel as well. 
scheduler for example. We can setup some of the scheduler domain parameters 
based on whether L2 is shared or not. 
Also, we felt, exporting this information to userspace in a consistent way will
help userspace apps to do various things like binding to specific CPUs, using
the working set size based on cache size, etc, to optimize the performance. 
Again, this can be done in userspace as well. But, if kernel is already doing
it, it may be better to export it from the kernel space.

Thanks,
Venki

