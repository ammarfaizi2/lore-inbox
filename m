Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312042AbSCTTNn>; Wed, 20 Mar 2002 14:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312039AbSCTTNb>; Wed, 20 Mar 2002 14:13:31 -0500
Received: from scfdns02.sc.intel.com ([143.183.152.26]:58318 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S312031AbSCTTNU>; Wed, 20 Mar 2002 14:13:20 -0500
Message-Id: <200203201912.g2KJC2W24374@unix-os.sc.intel.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Daniel Jacobowitz <dan@debian.org>, "Vamsi Krishna S ." <vamsi@in.ibm.com>
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
Date: Wed, 20 Mar 2002 11:14:56 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br,
        tachino@jp.fujitsu.com, jefreyr@pacbell.net, vamsi_krishna@in.ibm.com,
        richardj_moore@uk.ibm.com, hanharat@us.ibm.com, bsuparna@in.ibm.com,
        bharata@in.ibm.com, asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
In-Reply-To: <20020315170726.A3405@in.ibm.com> <20020320113630.A6882@in.ibm.com> <20020320133709.A10958@nevyn.them.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've only JUST started on the Itanium version of this patch.  In my initial 
testing, after hacking around some of the compilation issues,  I do get a 
type of process freezing when attempting this.  Could be this bug.  

Thanks for the tip ;)

--mgross



On Wednesday 20 March 2002 01:37 pm, Daniel Jacobowitz wrote:
> On Wed, Mar 20, 2002 at 11:36:30AM +0530, Vamsi Krishna S . wrote:
> > There is serialization at higher level. We take a write lock
> > on current->mm->mmap_sem at the beginning of elf_core_dump
> > function which is released just before leaving the function.
> > So, if one thread enters elf_core_dump and starts dumping core,
> > no other thread (same mm) of the same process can start
> > dumping.
> > 
> > static int elf_core_dump(long signr, struct pt_regs * regs, struct file *
> > file) {
> >       ...
> >       ...
> >         /* now stop all vm operations */
> >         down_write(&current->mm->mmap_sem);
> >       ...
> >       ...
> >       ...
> >         up_write(&current->mm->mmap_sem);
> >         return has_dumped;
> > }
>
> That's not a feature, it's a bug.  You can't take the mmap_sem before
> collecting thread status; it will cause a deadlock on at least ia64,
> where some registers are collected from user memory.
>
> (Thanks to Manfred Spraul for explaining that to me.)
