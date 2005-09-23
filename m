Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVIWHNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVIWHNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 03:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVIWHNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 03:13:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36012 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750726AbVIWHNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 03:13:51 -0400
To: Dave Anderson <anderson@redhat.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       fastboot-bounces@lists.osdl.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [PATCH] Kdump(x86): add note type NT_KDUMPINFO	
 tokernelcore dumps
References: <OF0A1E6B6F.F00DC760-ON87257084.005F99D6-88257084.00634A38@us.ibm.com>
	<4332FD56.2F5256F5@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 23 Sep 2005 01:12:23 -0600
In-Reply-To: <4332FD56.2F5256F5@redhat.com> (Dave Anderson's message of
 "Thu, 22 Sep 2005 14:52:06 -0400")
Message-ID: <m1ll1ob6lk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Anderson <anderson@redhat.com> writes:

> So does elf_core_dump() as well, but to gdb it's useless AFAICT...

We can always post_process things when generating a core dump
if we have enough information.

> Hey -- I wasn't even aware of the "crashing_cpu" variable.  
> That would work just fine.
>
> Still a "panic_task", and perhaps even a "crash_page_size" variable
> would be nice as well.   No additional notes required...

To avoid defining an ABI that we need to maintain there is some
benefit in simply using static variables.  But the form of the
information really isn't the concern.

Where we capture the information and how reliable is that capture
is the concern.

To capture page size the easiest and most reliable way I can see
to do is to modify vmlinux.lds.S to contain something like:
>	 _page_shift = PAGE_SHIFT;
Giving you an absolute symbol _page_shift in vmlinux that
contains the value you need, without overhead in the running
kernel.

crashing_cpu makes sense to capture in some form, we definitely
need to compute something that will allow us to write to
a per cpu area on an SMP system.

The big concern at this point is that the code has not undergone
a serious stability audit.  So it is the expectation that there
is still code we can remove and modify to increase the likely hood
of getting a crash dump.

Currently we know that stack overflows sometimes happen and that
they are a source of kernel crashes.  It would be good if we could
take a crash dump despite them.  To do that requires code more
robust than we have today.  Quite likely it means that we will
not be able to reliably capture the task_struct of the crashing cpu.

Eric
