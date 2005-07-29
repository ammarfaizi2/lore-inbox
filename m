Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVG2VDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVG2VDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVG2VBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:01:06 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:57431 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262557AbVG2VAU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:00:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VnrNK0lFvSnLpwAYreqjMJMKQeTknP4kFcZWbeEQzL8ELEBiojUq3ui+buAjAVFj3F128hHVB8/6p25sQaFjxmnD4cQIrLS338QO28gSn6Ylo17nFdy4IjsbHTmu/oloZzmDTPAUWYbdSWaTSDIR1qrBMi/0ks3spK2Zy5gj91I=
Message-ID: <4ae3c140507291400230ca65c@mail.gmail.com>
Date: Fri, 29 Jul 2005 17:00:20 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: bert hubert <bert.hubert@netherlabs.nl>, Xin Zhao <uszhaoxin@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Why dump_stack results different so much?
In-Reply-To: <20050729203403.GA30603@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140507291327143a9d83@mail.gmail.com>
	 <20050729203403.GA30603@outpost.ds9a.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.

Below is the code that print the kernel calling trace:

/**********************************************************************************/
void show_trace(struct task_struct *task, unsigned long * stack)
{
	unsigned long ebp;

	if (!task)
		task = current;

	if (task == current) {
		/* Grab ebp right from our regs */
		asm ("movl %%ebp, %0" : "=r" (ebp) : );
	} else {
		/* ebp is the last reg pushed by switch_to */
		ebp = *(unsigned long *) task->thread.esp;
	}

	while (1) {
		struct thread_info *context;
		context = (struct thread_info *)
			((unsigned long)stack & (~(THREAD_SIZE - 1)));
		ebp = print_context_stack(context, stack, ebp);
		stack = (unsigned long*)context->previous_esp;
		if (!stack)
			break;
		printk(" =======================\n");
	}
}
/**********************************************************************************/

>From this code, I can see that the show_trace does not scan and guess
the pointers. Instead, it use "previous_esp" to extract the esp and
thus the returning eip. Am I right?

Cheers,
xin




On 7/29/05, bert hubert <bert.hubert@netherlabs.nl> wrote:
> On Fri, Jul 29, 2005 at 04:27:16PM -0400, Xin Zhao wrote:
> > I supprisely noticed that the dump_stack results are quite different!
> > Why did I get the calling traces below our_ssy_open() and above
> > syscall_call()?  Any thought on this? Many thanks!
> 
> This might depend on compiling with frame pointers, or not. I recall that at
> one point, the kernel did a basic scan of addresses that looked like likely
> candidates to have been pointers, and printed those.
> 
> Frame pointers are hailed as improving backtraces. They are in the 'kernel
> hacking' section of the kernel configuration.
> 
> Sorry that I can't be more precise, but try turning on frame pointers.
> 
> Good luck!
> 
> --
> http://www.PowerDNS.com      Open source, database driven DNS Software
> http://netherlabs.nl              Open and Closed source services
>
