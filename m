Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310139AbSCUKO0>; Thu, 21 Mar 2002 05:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310154AbSCUKOS>; Thu, 21 Mar 2002 05:14:18 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:14729 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S310139AbSCUKOF>; Thu, 21 Mar 2002 05:14:05 -0500
Date: Thu, 21 Mar 2002 15:46:50 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: dan@debian.org
Cc: Mark Gross <mgross@unix-os.sc.intel.com>, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        marcelo@conectiva.com.br, tachino@jp.fujitsu.com, jefreyr@pacbell.net,
        vamsi_krishna@in.ibm.com, richardj_moore@uk.ibm.com,
        hanharat@us.ibm.com, bsuparna@in.ibm.com, bharata@in.ibm.com,
        asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
Message-ID: <20020321154650.A1435@in.ibm.com>
Reply-To: vamsi@in.ibm.com
In-Reply-To: <20020315170726.A3405@in.ibm.com> <20020319152959.C55@toy.ucw.cz> <200203192147.g2JLl3W01070@unix-os.sc.intel.com> <20020320113630.A6882@in.ibm.com> <20020320133709.A10958@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

Thanks for pointing this out. I see that this change has now gone into
2.4.18 as well as 2.5.4. We would ensure that the down_write happens
only after the registers of all threads are collected.

Coming back to the original point raised by Pavel, indeed there is 
nothing preventing external code (any other kernel modules) modifying
the cpus_allowed field from under us. This could get worse in 2.5.x
where a user could change cpu affinity (through proc or a syscall, 
though I don't think the patches providing this are accepted as yet).

Vamsi.

On Wed, Mar 20, 2002 at 01:37:09PM -0500, Daniel Jacobowitz wrote:
> On Wed, Mar 20, 2002 at 11:36:30AM +0530, Vamsi Krishna S . wrote:
> > There is serialization at higher level. We take a write lock
> > on current->mm->mmap_sem at the beginning of elf_core_dump
> > function which is released just before leaving the function.
> > So, if one thread enters elf_core_dump and starts dumping core,
> > no other thread (same mm) of the same process can start
> > dumping.
> > <snip>
> 
> That's not a feature, it's a bug.  You can't take the mmap_sem before
> collecting thread status; it will cause a deadlock on at least ia64,
> where some registers are collected from user memory.
> 
> (Thanks to Manfred Spraul for explaining that to me.)
> 
> -- 
> Daniel Jacobowitz                           Carnegie Mellon University
> MontaVista Software                         Debian GNU/Linux Developer

-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5262355 Extn: 3959
Internet: vamsi@in.ibm.com
