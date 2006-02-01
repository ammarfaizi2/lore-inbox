Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWBANC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWBANC1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWBANC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:02:26 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:3275 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S964887AbWBANCQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:02:16 -0500
Message-ID: <43E0B177.9020607@sdl.hitachi.co.jp>
Date: Wed, 01 Feb 2006 22:02:47 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: ananth@in.ibm.com, prasanna@in.ibm.com, anil.s.keshavamurthy@intel.com,
       systemtap@sources.redhat.com, jkenisto@us.ibm.com,
       linux-kernel@vger.kernel.org, sugita@sdl.hitachi.co.jp,
       soshima@redhat.com, haoki@redhat.com
Subject: Re: [PATCH] kretprobe: kretprobe-booster against 2.6.16-rc1 for i386
References: <43DE0A53.3060801@sdl.hitachi.co.jp>	<43DEC13E.8020200@sdl.hitachi.co.jp> <20060131145540.3e9a78be.akpm@osdl.org>
In-Reply-To: <20060131145540.3e9a78be.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew
Andrew Morton wrote:
> Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp> wrote:
>>-	regs->eip = orig_ret_address;
>>
>>-	reset_current_kprobe();
>> 	spin_unlock_irqrestore(&kretprobe_lock, flags);
>>-	preempt_enable_no_resched();
>
> Again, the patch removes a preempt_enable() and doesn't add a
> preempt_disable().  Maybe this is to balance the earlier patch.  If so,
> they should both be in the same patch so the kernel works OK at each stage.
> You didn't include a description of what this patch actually does.

That is not to balance the previous patch. Here is the reason and
the description of kretprobe-booster.

The kretprobe basically invokes kprobe twice as following actions;

At function entrance:
(1) int3 (1st kprobe)
(2) preempt_disable
(3) call pre_handler_kretprobe ()
(3-1) store original return address to a retprobe instance
(3-2) modify return address.
(4) copied instructioin(single step)
(5) preempt_enable

At function exit:
(1) return to kretprobe_trampoline
(2) int3 (2nd kprobe)
(3) preempt_disable()
(4) call trampoline_probe_handler()
(4-1) find the corresponding instance and call true handler.
(4-2) restore original return address to regs->eip
(4-3) preempt_enable()
(5) return to int3 handler (do NOT execute single step)

The first kprobe is to modify return address of the function,
and the second is to call the true kretprobe's handler from
the function return point. The first kprobe is executed
normally. But the second does not execute single-step,
because the copied instruction of the probe is always "nop".

In the other hand, kretprobe-booster modifies the process at
function exit as following actions;

At function exit:
(1) return to kretprobe_trampoline
(2) store registers
(3) call trampoline_handler()
(3-1) find the corresponding instance and call true handler.
(3-2) return original return address
(4) restore registers and the original return address.
(5) return to original function caller.

There are no kprobes, and any instructions are not removed.
So, there is no need to disable preemption.
This is the reason why I removed preempt_enable().

Best regards,


-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp


