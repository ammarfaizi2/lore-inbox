Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVIZG3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVIZG3l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVIZG3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:29:41 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:665 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932407AbVIZG3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:29:40 -0400
Date: Mon, 26 Sep 2005 11:59:34 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>
Cc: Dave Anderson <anderson@redhat.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       fastboot-bounces@lists.osdl.org
Subject: Re: [Fastboot] [PATCH] Kdump(x86): add note type NT_KDUMPINFO tokernelcore dumps
Message-ID: <20050926062934.GA3805@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <OF0A1E6B6F.F00DC760-ON87257084.005F99D6-88257084.00634A38@us.ibm.com> <4332FD56.2F5256F5@redhat.com> <m1ll1ob6lk.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ll1ob6lk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 01:12:23AM -0600, Eric W. Biederman wrote:
> Dave Anderson <anderson@redhat.com> writes:
> 
> > So does elf_core_dump() as well, but to gdb it's useless AFAICT...
> 
> We can always post_process things when generating a core dump
> if we have enough information.
> 
> > Hey -- I wasn't even aware of the "crashing_cpu" variable.  
> > That would work just fine.
> >
> > Still a "panic_task", and perhaps even a "crash_page_size" variable
> > would be nice as well.   No additional notes required...
> 
> To avoid defining an ABI that we need to maintain there is some
> benefit in simply using static variables.  But the form of the
> information really isn't the concern.
> 
> Where we capture the information and how reliable is that capture
> is the concern.
> 
> To capture page size the easiest and most reliable way I can see
> to do is to modify vmlinux.lds.S to contain something like:
> >	 _page_shift = PAGE_SHIFT;
> Giving you an absolute symbol _page_shift in vmlinux that
> contains the value you need, without overhead in the running
> kernel.
> 
> crashing_cpu makes sense to capture in some form, we definitely
> need to compute something that will allow us to write to
> a per cpu area on an SMP system.
> 
> The big concern at this point is that the code has not undergone
> a serious stability audit.  So it is the expectation that there
> is still code we can remove and modify to increase the likely hood
> of getting a crash dump.
> 
> Currently we know that stack overflows sometimes happen and that
> they are a source of kernel crashes.  It would be good if we could
> take a crash dump despite them.  To do that requires code more
> robust than we have today.  Quite likely it means that we will
> not be able to reliably capture the task_struct of the crashing cpu.
> 


Ok. After all this discussion looks like time to drop the patch. The
architectures which need page_size, they can modify vmlinux.ld.S to 
embed the information in vmlinux. 

Crash can do without pointer to crashing cpu's task_struct as well
(Though it is more work on crash's part). At the same time this information
can not possibly be captured in kernel reliably after the crash.

Identifying crashing cpu is important. Empty NT_KDUMPINFO would have done
the job but use of variables will avoid defining ABI. For the time being
crashing_cpu will do the job. Ofcourse this code is not robust enough to
handle stack overflow situations and that shall have to be taken care of. 

Andrew, Could you please drop this patch from -mm.

kdumpx86-add-note-type-nt_kdumpinfo-to-kernel-core-dumps.patch

Thanks
Vivek

> Eric

> _______________________________________________
> fastboot mailing list
> fastboot@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/fastboot

