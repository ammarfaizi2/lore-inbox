Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWBANCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWBANCB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWBANCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:02:01 -0500
Received: from mail7.hitachi.co.jp ([133.145.228.42]:7650 "EHLO
	mail7.hitachi.co.jp") by vger.kernel.org with ESMTP id S932432AbWBANCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:02:00 -0500
Message-ID: <43E0B165.2020405@sdl.hitachi.co.jp>
Date: Wed, 01 Feb 2006 22:02:29 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ananth@in.ibm.com, prasanna@in.ibm.com, anil.s.keshavamurthy@intel.com,
       systemtap@sources.redhat.com, jkenisto@us.ibm.com,
       linux-kernel@vger.kernel.org, sugita@sdl.hitachi.co.jp,
       soshima@redhat.com, haoki@redhat.com
Subject: Re: [PATCH][2/2] kprobe: kprobe-booster against 2.6.16-rc1 for i386
References: <43DE0A4D.20908@sdl.hitachi.co.jp>	<43DEB290.1050000@sdl.hitachi.co.jp> <20060131145053.235e27e4.akpm@osdl.org>
In-Reply-To: <20060131145053.235e27e4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew
Andrew Morton wrote:
> These preempt tricks look rather nasty.  Can you please describe what the
> problem is, precisely?  And how this code avoids it?  Perhaps we can find
> something cleaner.

The problem is how to remove the copied instructions of the
kprobe *safely* on the preemptable kernel (CONFIG_PREEMPT=y).

Kprobes basically executes the following actions;

(1)int3
(2)preempt_disable()
(3)kprobe_prehandler()
(4)copied instructioin(single step)
(5)kprobe_posthandler()
(6)preempt_enable()
(7)return to the original code

During the execution of copied instruction, preemption is
disabled (from step (2) to (6)).
When unregistering the probes, Kprobe waits for RCU
quiescent state by using synchronize_sched() after removing
int3 instruction.
Thus we can ensure the copied instruction is not executed.

On the other hand, kprobe-booster executes the following actions;

(1)int3
(2)preempt_disable()
(3)kprobe_prehandler()
(4)preempt_enable()             <-- this one is added by my patch
(5)copied instruction(direct execution)
(6)jmp back to the original code

The problem is that we have no way to prevent preemption on
step (5) or (6). We cannot call preempt_disable() after step (6),
because there are no rooms to do that. Thus, some other
processes may be preempted at step(5) or (6) on preemptable kernel.
And I couldn't find the easy way to ensure that other processes'
stack do *not* have the address of them. (I thought some way
to do that, but those are very costly.)

So currently, I simply boost the kprobe only when the probe
point is already preemption disabled.

> Also, the patch adds a preempt_enable() but I don't see a corresponding
> preempt_disable().  Am I missing something?

It is corresponding to the preempt_disable() in the top of
kprobe_handler().
I copied the code of kprobe_handler() here:

static int __kprobes kprobe_handler(struct pt_regs *regs)
{
        struct kprobe *p;
        int ret = 0;
        kprobe_opcode_t *addr = NULL;
        unsigned long *lp;
        struct kprobe_ctlblk *kcb;

        /*
         * We don't want to be preempted for the entire
         * duration of kprobe processing
         */
        preempt_disable();             <-- HERE
        kcb = get_kprobe_ctlblk();

Best regards,


-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

