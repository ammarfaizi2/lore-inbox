Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311578AbSCTF62>; Wed, 20 Mar 2002 00:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311579AbSCTF6S>; Wed, 20 Mar 2002 00:58:18 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:20920 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S311578AbSCTF57>;
	Wed, 20 Mar 2002 00:57:59 -0500
Date: Wed, 20 Mar 2002 11:36:30 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Mark Gross <mgross@unix-os.sc.intel.com>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br, dan@debian.org,
        tachino@jp.fujitsu.com, jefreyr@pacbell.net, vamsi_krishna@in.ibm.com,
        richardj_moore@uk.ibm.com, hanharat@us.ibm.com, bsuparna@in.ibm.com,
        bharata@in.ibm.com, asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
Message-ID: <20020320113630.A6882@in.ibm.com>
Reply-To: vamsi@in.ibm.com
In-Reply-To: <20020315170726.A3405@in.ibm.com> <20020319152959.C55@toy.ucw.cz> <200203192147.g2JLl3W01070@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is serialization at higher level. We take a write lock
on current->mm->mmap_sem at the beginning of elf_core_dump
function which is released just before leaving the function.
So, if one thread enters elf_core_dump and starts dumping core,
no other thread (same mm) of the same process can start
dumping.

static int elf_core_dump(long signr, struct pt_regs * regs, struct file * file)
{
	...
	...
        /* now stop all vm operations */
        down_write(&current->mm->mmap_sem);
	...
	...
	...
        up_write(&current->mm->mmap_sem);
        return has_dumped;
}

Vamsi.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5262355 Extn: 3959
Internet: vamsi@in.ibm.com

On Tue, Mar 19, 2002 at 01:49:58PM -0500, Mark Gross wrote:
> On Tuesday 19 March 2002 10:29 am, Pavel Machek wrote:
> > > + *
> > > + * Sets the current->cpu_mask to the current cpu to avoid cpu migration
> > > durring the dump. + * This cpu will also be the only cpu the other
> > > threads will be allowed to run after + * coredump is completed. This
> > > seems to be needed to fix some SMP races.  This still + * needs some more
> > > thought though this solution works.
> >
> > What about
> >
> > app has 5 threads. 1st dumps core, and starts setting cpus_allowed mask to
> > thread 2. Meanwhile 3nd thread resets the mask back.
> >
> This patch was intended to prevent this from happening.  I hope I didn't miss 
> something.
> 
> The dumping thread doesn't proceed until the other CPU's have gotten into 
> kernel mode and done 2 IPI's.  One to reschedule the other cpu's and one to 
> synchronize before exiting suspend_other_threads.  
> 
> The way the IPI's are sent out by this patch, the other CPUs get 2 IPI's and 
> execute at least one IRET, and hence at least one call to schedule, before 
> the dumping process continues.  This one call to schedule on each of the 
> other cpu's is what's needed to get all possible related thread processes 
> swapped out for the duration of the dump.
> 
> Unless the IPI's and associated IRET's get dropped by the system, that 3rd 
> thread will not get a chance to touch the cpu_masks before the dumping 
> process is finished taking its dump and resume_other_threads gets called.   
> Because it will have been scheduled out.  
> 
> --mgross
