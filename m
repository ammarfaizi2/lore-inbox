Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311936AbSCTSlH>; Wed, 20 Mar 2002 13:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311937AbSCTSk6>; Wed, 20 Mar 2002 13:40:58 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:44448 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S311936AbSCTSkt>;
	Wed, 20 Mar 2002 13:40:49 -0500
Date: Wed, 20 Mar 2002 13:37:09 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Vamsi Krishna S ." <vamsi@in.ibm.com>
Cc: Mark Gross <mgross@unix-os.sc.intel.com>, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        marcelo@conectiva.com.br, tachino@jp.fujitsu.com, jefreyr@pacbell.net,
        vamsi_krishna@in.ibm.com, richardj_moore@uk.ibm.com,
        hanharat@us.ibm.com, bsuparna@in.ibm.com, bharata@in.ibm.com,
        asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
Message-ID: <20020320133709.A10958@nevyn.them.org>
Mail-Followup-To: "Vamsi Krishna S ." <vamsi@in.ibm.com>,
	Mark Gross <mgross@unix-os.sc.intel.com>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br,
	tachino@jp.fujitsu.com, jefreyr@pacbell.net,
	vamsi_krishna@in.ibm.com, richardj_moore@uk.ibm.com,
	hanharat@us.ibm.com, bsuparna@in.ibm.com, bharata@in.ibm.com,
	asit.k.mallick@intel.com, david.p.howell@intel.com,
	tony.luck@intel.com, sunil.saxena@intel.com
In-Reply-To: <20020315170726.A3405@in.ibm.com> <20020319152959.C55@toy.ucw.cz> <200203192147.g2JLl3W01070@unix-os.sc.intel.com> <20020320113630.A6882@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 11:36:30AM +0530, Vamsi Krishna S . wrote:
> There is serialization at higher level. We take a write lock
> on current->mm->mmap_sem at the beginning of elf_core_dump
> function which is released just before leaving the function.
> So, if one thread enters elf_core_dump and starts dumping core,
> no other thread (same mm) of the same process can start
> dumping.
> 
> static int elf_core_dump(long signr, struct pt_regs * regs, struct file * file)
> {
> 	...
> 	...
>         /* now stop all vm operations */
>         down_write(&current->mm->mmap_sem);
> 	...
> 	...
> 	...
>         up_write(&current->mm->mmap_sem);
>         return has_dumped;
> }

That's not a feature, it's a bug.  You can't take the mmap_sem before
collecting thread status; it will cause a deadlock on at least ia64,
where some registers are collected from user memory.

(Thanks to Manfred Spraul for explaining that to me.)

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
