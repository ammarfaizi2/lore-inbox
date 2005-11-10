Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVKJFdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVKJFdz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 00:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVKJFdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 00:33:55 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:18087 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751107AbVKJFdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 00:33:54 -0500
Date: Thu, 10 Nov 2005 22:03:00 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
Message-ID: <20051110163300.GA8514@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <200511080439.jA84diI6009951@zach-dev.vmware.com> <200511081412.05285.ak@suse.de> <4370A9F5.4060103@vmware.com> <20051109093755.GA10361@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109093755.GA10361@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

resending this mail, since my earlier email did not reach lkml.
On Wed, Nov 09, 2005 at 03:07:55PM +0530, Prasanna S Panchamukhi wrote:
> Zach,
> 
> Thanks for doing this.
> 
> On Tue, Nov 08, 2005 at 05:36:53AM -0800, Zachary Amsden wrote:
> > Andi Kleen wrote:
> > 
> > >On Tuesday 08 November 2005 05:39, Zachary Amsden wrote:
> > > 
> > >
> > >>IA-32 linear address translation is loads of fun.
> > >>   
> > >>
> > >
> > >Thanks for doing that audit work. Can you please double check x86-64 code 
> > >is
> > >ok? 
> > >
> > >Actually giving all that complexity maybe it would be better to just
> > >stop handling the case and remove all that. I'm not sure what kprobes 
> > >needs it for - it doesn't even handle user space yet and even if it ever 
> > >does it is unlikely that handling 16bit code makes much sense. And the 
> 
> 
> The code was added to address the problem related to stealing of interrupts from
> VM86. Please see the discussion thread for more details from the URL below
> http://lkml.org/lkml/2004/11/9/214
> 
> > But were kprobes even inteneded for userspace?  There are races here 
> > that are difficult to close without some heavy machinery, and I would 
> > rather not put the machinery in place if simplifying the code is the 
> > right answer.
> 
> Presently kprobes supports only kernel space probes. Work is in progress
> for user space probes support.
> 
> >+       addr = (kprobe_opcode_t *)convert_eip_to_linear(regs,
> >+                                       regs->eip -
> >sizeof(kprobe_opcode_t),
> >+                                       &current->mm->context, &limit);
> >+
> 
> Instead you can check if it is in kernel mode and calculate the address directly 
> first, since it is in the fast path.
> 		addr = regs->eip - sizeof(kprobe_opcode_t);
> 	else
> 		addr = convert_eip_to_linear(..);
> 
> there by avoiding calling convert_eip_to_linear () in case of every kernel probes.
> 
> 
> >+       /* Don't let userspace races re-address into kernel space */
> >+       if ((unsigned long)addr > limit)
> >+               return 0;
> 
> there is no need for this check here in the fast path, because kprobes handles this 
> case by checking if the address is on the kprobes hash list and later returning 
> from that point.
> 
> Please make sure it pass the test case discussed in the thread, URL is below.
> http://lkml.org/lkml/2004/11/9/214
> 
> Thanks
> -Prasanna
> --
> Prasanna S Panchamukhi
> Linux Technology Center
> India Software Labs, IBM Bangalore
> Ph: 91-80-25044636
> <prasanna@in.ibm.com>

-- 
Have a Nice Day!

Thanks & Regards
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
