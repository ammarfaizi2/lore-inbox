Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVKJHKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVKJHKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 02:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVKJHKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 02:10:47 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52404 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751238AbVKJHKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 02:10:46 -0500
Date: Thu, 10 Nov 2005 23:39:54 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Zachary Amsden <zach@vmware.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
Message-ID: <20051110180954.GD8514@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <200511080439.jA84diI6009951@zach-dev.vmware.com> <200511081412.05285.ak@suse.de> <4370A9F5.4060103@vmware.com> <200511091438.11848.ak@suse.de> <437227FD.6040905@vmware.com> <20051109165804.GA15481@elte.hu> <43723768.2060103@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43723768.2060103@vmware.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 09:52:40AM -0800, Zachary Amsden wrote:
> Ingo Molnar wrote:
> 
> >* Zachary Amsden <zach@vmware.com> wrote:
> >
> > 
> >
> >>>I believe user space kprobes are being worked on by some IBM India folks 
> >>>yes.
> >>>     
> >>>
> >>I'm convinced this is pointless.  What does it buy you over a ptrace 
> >>based debugger?  Why would you want extra code running in the kernel 
> >>that can be done perfectly well in userspace?
> >>   
> >>
> >
> >kprobes are not just for 'debuggers', they are also used for tracing and 
> >other dynamic instrumentation in projects like systemtap. Ptrace is way 
> >too slow and limited for things like that.
> > 
> >
> 
> Well, if there is a justification for it, that means we really should 
> handle all the nasty EIP conversion cases due to segmentation and v8086 
> mode in the kprobes code.  I was hoping that might not be the case.
> 

As Ingo mentioned above, Systemtap uses kprobes infrastructure to provide
dynamic kernel instrumentation. Using which user can add lots of probes 
easily, so we need to take care of this fast path.  

Instead of calling convert_eip_to_linear() for all cases, you can
just check if it is in kernel mode and calculate the address directly

	if (kernel mode)
                addr = regs->eip - sizeof(kprobe_opcode_t);
        else
                addr = convert_eip_to_linear(..);

there by avoiding call to convert_eip_to_linear () for every kernel probes.

As Andi mentioned user space probes support is in progress and 
this address conversion will help in case of user space probes as well.


Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
