Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292870AbSCSVtZ>; Tue, 19 Mar 2002 16:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292888AbSCSVtH>; Tue, 19 Mar 2002 16:49:07 -0500
Received: from scfdns02.sc.intel.com ([143.183.152.26]:222 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S292870AbSCSVsz>; Tue, 19 Mar 2002 16:48:55 -0500
Message-Id: <200203192147.g2JLl3W01070@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Pavel Machek <pavel@suse.cz>, "Vamsi Krishna S ." <vamsi@in.ibm.com>
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
Date: Tue, 19 Mar 2002 13:49:58 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        marcelo@conectiva.com.br, dan@debian.org, tachino@jp.fujitsu.com,
        jefreyr@pacbell.net, vamsi_krishna@in.ibm.com,
        richardj_moore@uk.ibm.com, hanharat@us.ibm.com, bsuparna@in.ibm.com,
        bharata@in.ibm.com, asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
In-Reply-To: <20020315170726.A3405@in.ibm.com> <20020319152959.C55@toy.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 March 2002 10:29 am, Pavel Machek wrote:
> > + *
> > + * Sets the current->cpu_mask to the current cpu to avoid cpu migration
> > durring the dump. + * This cpu will also be the only cpu the other
> > threads will be allowed to run after + * coredump is completed. This
> > seems to be needed to fix some SMP races.  This still + * needs some more
> > thought though this solution works.
>
> What about
>
> app has 5 threads. 1st dumps core, and starts setting cpus_allowed mask to
> thread 2. Meanwhile 3nd thread resets the mask back.
>
This patch was intended to prevent this from happening.  I hope I didn't miss 
something.

The dumping thread doesn't proceed until the other CPU's have gotten into 
kernel mode and done 2 IPI's.  One to reschedule the other cpu's and one to 
synchronize before exiting suspend_other_threads.  

The way the IPI's are sent out by this patch, the other CPUs get 2 IPI's and 
execute at least one IRET, and hence at least one call to schedule, before 
the dumping process continues.  This one call to schedule on each of the 
other cpu's is what's needed to get all possible related thread processes 
swapped out for the duration of the dump.

Unless the IPI's and associated IRET's get dropped by the system, that 3rd 
thread will not get a chance to touch the cpu_masks before the dumping 
process is finished taking its dump and resume_other_threads gets called.   
Because it will have been scheduled out.  

--mgross
