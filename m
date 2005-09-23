Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVIWFTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVIWFTs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 01:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVIWFTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 01:19:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:42934 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750928AbVIWFTs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 01:19:48 -0400
Date: Fri, 23 Sep 2005 10:49:38 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Haren Myneni <hbabu@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Dave Anderson <anderson@redhat.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       fastboot-bounces@lists.osdl.org
Subject: Re: [Fastboot] [PATCH] Kdump(x86): add note type NT_KDUMPINFO	tokernel core dumps
Message-ID: <20050923051938.GD3736@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m1zmq5awsn.fsf@ebiederm.dsl.xmission.com> <OF0A1E6B6F.F00DC760-ON87257084.005F99D6-88257084.00634A38@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0A1E6B6F.F00DC760-ON87257084.005F99D6-88257084.00634A38@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 11:04:43AM -0700, Haren Myneni wrote:
> fastboot-bounces@lists.osdl.org wrote on 09/22/2005 09:31:52 AM:
> 
> > Dave Anderson <anderson@redhat.com> writes:
> > 
> > > Just flagging the cpu, and then mapping that to the stack pointer 
> found in
> > > the associated NT_PRSTATUS register set should work OK too.  It gets
> > > a little muddy if it crashed while running on an IRQ stack, but it
> > still can be
> > > tracked back from there as well.  (although not if the crashing 
> > task overflowed
> > > the IRQ stack)
> > 
> > You can't track it back from the crashing cpu if the IRQ stack overflows
> > either.  So I would rather have crash confused when trying to find the
> > task_struct.  Then to have the kernel fail avoidably while attempting
> > to capture a core dump. 
> > 
> > Even if you overflow the stack wit a bit of detective work it should 
> still
> > be possible to show the stack overflowed and correct for it when 
> analyzing
> > the crash dump.  Doing anything like that from a crashing cpu (in a
> > reliable way) is very hard. 
> > 
> > > The task_struct would be ideal though -- if the kernel's use of 
> task_structs
> > > changes in the future, well, then crash is going to need a serious 
> re-write
> > > anyway...  FWIW, netdump and diskdump use the NT_TASKSTRUCT note
> > > note to store just the "current" pointer, and not the whole 
> > task_struct itself,
> > > which would just be a waste of space in the ELF header for 
> crash'spurposes.
> > > And looking at the gdb sources, it appears to be totally ignored.  Who
> > > uses the NT_TASKSTRUCT note anyway?
> > 
> > Good question, especially as the kernel exports whatever we have for
> > a task struct today in the ELF note.  No ABI compatibility is
> > maintained.
> > 
> > Given all of that I recommend an empty NT_TASKSTRUCT to flag the
> > crashing cpu, for now.
> 
> At present /proc/kcore writes the complete task structure for 
> NT_TASKSTRUCT note section. Thought it is the standard. Hence created 
> separate note section. The other option is the crash tool can directly 
> read "crashing_cpu variable" from the vmcore to determine the panic cpu. 
> Similarly, we can define panic_task variable in the kernel.

crashing_cpu was introduced recently to handle one of the problems caused
due to NMI. I think we should not be relying on this variable. we get the
value of crashing_cpu by making smp_processor_id() call and this value will
be corrupted in case of stack overflow.

During OLS, Eric had suggested to either find a way to disable NMI after 
panic() or may be read LAPIC id. Reading LAPIC id seems to be more reliable.
I think mkdump folks already do something similar.

So, in short, using crashing_cpu might not be a good idea. Down the line
this varibale might not be present at all. 

> 
> Basically, we can use some global structure in the kernel and dump any 
> needed information which we do not need to invoke any analysis tools 
> (crash, gdb). Dumping CPU control registers can also be done this way 
> without creating separate note section.
> 
> Thanks
> Haren
> 
> Anyway, we already have crashing_cpu variable in the kernel. 
> > 
> > Eric
> > _______________________________________________
> > fastboot mailing list
> > fastboot@lists.osdl.org
> > https://lists.osdl.org/mailman/listinfo/fastboot

> _______________________________________________
> fastboot mailing list
> fastboot@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/fastboot

