Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263135AbVGNT7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbVGNT7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVGNT7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:59:40 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:49044 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S263105AbVGNT6J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:58:09 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Thu, 14 Jul 2005 20:58:15 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050713144551.GA26067@elte.hu> <20050713153003.GA30917@elte.hu>
In-Reply-To: <20050713153003.GA30917@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507142058.15350.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 Jul 2005 16:30, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> > it worked upon the first try, and indeed my testbox crashed within 10
> > seconds:
> >
> >  BUG: Unable to handle kernel NULL pointer dereference
> >  BUG: Unable to handle kernel NULL pointer dereference at virtual address
> > 00000006
>
> a couple of crashes later i got an important clue:
>
>  BUG: bad soft irq-flag value 00000f64, openvpn/3386!
>   [<c0104052>] dump_stack+0x1f/0x21 (20)
>   [<c013b883>] check_soft_flags+0x73/0xc9 (24)
>   [<00000f78>] 0xf78 (1066836133)
>
> it turns out that a small portion of the softirq processing path was
> still using the soft IRQ-flag, instead of the raw IRQ-flag! Given enough
> irq and softirq workload, we were interrupted in a piece of code where
> the data structure was inconsistent. (tinfo.task was already changed,
> but %esp not yet) Since interrupts were enabled during the crash
> printout, it would crash again and again as it got more interrupts. The
> backtrace printout crashed too due to the inconsistency. That's why you
> got those repeat ============= lines.
>
> the patch below should fix this bug and i've uploaded the -51-30 patch
> with this fix included. Could you check whether 4K stacks are now stable
> for you under PREEMPT_RT?
>
> so your intuitition about this being related to 4K stacks was completely
> right.
>

Ingo,

This fixes the issue. It's one more 'crossed t' on the rt-preempt patches.

I'll let you know if I discover anything else; your work has already allowed 
us to bring the responsiveness of our instrument to 300us which is low enough 
for the real-time PCR industry. Thanks a lot!

This debugging process has been extremely eye opening, thanks for the detailed 
descriptions of what's gone wrong at every stage. I just wish I was competent 
enough to fix these things myself.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
