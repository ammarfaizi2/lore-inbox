Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268745AbUILOiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268745AbUILOiu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 10:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268746AbUILOit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 10:38:49 -0400
Received: from [211.58.254.17] ([211.58.254.17]:37011 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S268745AbUILOib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 10:38:31 -0400
Date: Sun, 12 Sep 2004 23:38:25 +0900
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, zwane@fsmlabs.com
Subject: Re: [PATCH] Interrupt entry CONFIG_FRAME_POINTER fix
Message-ID: <20040912143825.GA17260@home-tj.org>
References: <20040912091628.GB13359@home-tj.org> <20040912132454.6cf1d60c.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912132454.6cf1d60c.ak@suse.de>
User-Agent: Mutt/1.5.6+20040818i
From: Tejun Heo <tj@home-tj.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 12, 2004 at 01:24:54PM +0200, Andi Kleen wrote:
> I don't think your patch is correct, you don't restore rbp ever and
> it gets corrupted.

 R15 R14 R13 R12 RBP RBX are callee-saved and they aren't
saved/restored during kernel entry unless they are explicitly needed
(ptrace, etc..).  interrupt macro which I modified is used only for
IRQ handling and apic interrupts, both of which aren't supposed to
modify any of above registers.

 So, in the original code, when CONFIG_DEBUG is off only caller-saved
registers are saved and restored, and when the option is on, SAVE_ALL
is used but it's saved only to link back to the original stack such
that the debugger can track back into the previous frame.  The current
code contains a line to restore rbp in ret_from_interrupt (other
calle-saved registers are not restored), but I don't think that line
is necessary.  Unless somebody explicitly changes regs->rbp, the value
would be always the same, and if somebody is allowed to modify the
contents of regs when CONFIG_DEBUG is turned on, we should be
restoring all the callee-saved registers not just rbp.

> I think the correct change is to fix profile_pc() to not reference
> rbp,

 I thought about that, but CONFIG_FRAME_POINTER is a debug feature
anyway, and it seemed reasonable to allow frame linking on interrupts
when the option turned on (x86 also supports back linking when
CONFIG_FRAME_POINTER is turned on).

> but just hardcode the rsp offset for the FP and non FP cases (8
> and 0)

 You lost me here.  regs->rbp is used in profile_pc() if the interrupt
occurs while the kernel is running spinlock codes.  To attribute ticks
spent during spinlock operations to the locking/unlocking function,
profile_pc() reads the return value of the frame which was running
before the interrupt occurs.  Are you saying that we can track back
into the previous frame without saving rbp?  We can read the next
frame's(do_IRQ's) rbp storage area, but that doesn't seem to be a very
good idea to me.

-- 
tejun

