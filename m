Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVCIGmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVCIGmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVCIGmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:42:43 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:488 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262381AbVCIGme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:42:34 -0500
Subject: Re: Query: Kdump: Core Image ELF Format
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Dave Anderson <anderson@redhat.com>, haren myneni <hbabu@us.ibm.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       gdb <gdb@sources.redhat.com>
In-Reply-To: <m1br9um313.fsf@ebiederm.dsl.xmission.com>
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
	 <m1br9um313.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 12:13:49 +0530
Message-Id: <1110350629.31878.7.camel@wks126478wss.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 11:00 -0700, Eric W. Biederman wrote: 
> vivek goyal <vgoyal@in.ibm.com> writes:
> 
> > Hi,
> > 
> > Kdump (A kexec based crash dumping mechanism) is going to export the
> > kernel core image in ELF format. ELF was chosen as a format, keeping in
> > mind that gdb can be used for limited debugging and "Crash" can be used
> > for advanced debugging.
> 
> When I suggested ELF for this purpose it was not so much that it was
> directly usable.  But rather it was an existing file format that could
> do the job, was well understood, and had enough extensibility
> through the PT_NOTES segment to handle the weird cases.
> 
> > Core image ELF headers are prepared before crash and stored at a safe
> > place in memory. These headers are retrieved over a kexec boot and final
> > elf core image is prepared for analysis. 
> > 
> > Given the fact physical memory can be dis-contiguous, One program header
> > of type PT_LOAD is created for every contiguous memory chunk present in
> > the system. Other information like register states etc. is captured in
> > notes section.
> > 
> > Now the issue is, on i386, whether to prepare core headers in ELF32 or
> > ELF64 format. gdb can not analyze ELF64 core image for i386 system. I
> > don't know about "crash". Can "crash" support ELF64 core image file for
> > i386 system?
> > 
> > Given the limitation of analysis tools, if core headers are prepared in
> > ELF32 format then how to handle PAE systems? 
> > 
> > Any thoughts or suggestions on this?
> 
> Generate it ELF64.  We also have the problem that the kernels virtual
> addresses are not used in the core dump either.   Which a post-processing
> tool will also have to address as well. 

That sounds good. But we loose the advantage of doing limited debugging
with gdb. Crash (or other analysis tools) will still take considerable
amount of time before before they are fully ready and tested.

How about giving user the flexibility to choose. What I mean is
introducing a command line option in kexec-tools to choose between ELF32
and ELF64 headers. For the users who are not using PAE systems, they can
very well go with ELF32 headers and do the debugging using gdb.

This also requires, setting the kernel virtual addresses while preparing
the headers. KVA for linearly mapped region is known in advance and can
be filled at header creation time and gdb can directly operate upon this
region.

> 
> What I aim on at was a simple picture of memory decorated with the
> register state.  We should be able to derive everything beyond that.
> And the fact that it is all in user space should make it straight
> forward to change if needed.
> 
> Eric
>  

