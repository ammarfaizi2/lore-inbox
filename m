Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbVIWMBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbVIWMBY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 08:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbVIWMBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 08:01:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:60119 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750896AbVIWMBX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 08:01:23 -0400
Date: Fri, 23 Sep 2005 17:31:07 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Anderson <anderson@redhat.com>, Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       fastboot-bounces@lists.osdl.org
Subject: Re: [Fastboot] [PATCH] Kdump(x86): add note type NT_KDUMPINFO tokernelcore dumps
Message-ID: <20050923120107.GB7440@in.ibm.com>
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

That's a cool idea. I just tested it. 

[vivek@vivegoya linux]$ readelf -s vmlinux | grep __page_shift
 28865: 0000000c     0 NOTYPE  GLOBAL DEFAULT  ABS __page_shift

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

Agreed.
