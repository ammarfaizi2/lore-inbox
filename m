Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWILMO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWILMO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 08:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWILMO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 08:14:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:62702 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932277AbWILMO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 08:14:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=DYWXF/lzkQ0T4GrgJ0CwIu3iVyFObkAQasIy0QuhdVHXm8h9lDw8Q8fD+WW3x3whicA131OMZr3rUFJCTfKpMDzs0W/1dBgIV09uRzQIIhMRbrkBW+FYUTHkv9h5fUGM2sd/9JJdM6SOcyW84AJTf77URlMCVDWcWTn2JeLDxMI=
Date: Tue, 12 Sep 2006 14:13:35 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjanv@infradead.org
Subject: Re: lockdep warning in check_flags()
Message-ID: <20060912141335.GM3775@slug>
References: <20060908011317.6cb0495a.akpm@osdl.org> <20060909083523.GG1121@slug> <20060911054335.GC11269@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060911054335.GC11269@elte.hu>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 07:43:35AM +0200, Ingo Molnar wrote:
> 
> * Frederik Deweerdt <deweerdt@free.fr> wrote:
> 
> > Lockdep issues the following warning:
> > 
> > [   16.835268] Freeing unused kernel memory: 260k freed
> > [   16.842715] Write protecting the kernel read-only data: 432k
> > [   17.796518] BUG: warning at kernel/lockdep.c:2359/check_flags()
> 
> this warning means that the "soft" and "hard" hardirqs-disabled state 
> got out of sync: the irqtrace tracking code thinks that hardirqs are 
> disabled, while in reality they are enabled. The thing to watch for are 
> new "stii" instructions in entry.S (and other assembly code), without a 
> matching TRACE_HARDIRQS_ON call. [Another, rarer possiblity is NMI code 
> saving/restoring interrupts - do you have NMIs enabled? (are there any 
> NMI counts in /proc/interrupts?)]
NMIs were disabled. But I've just booted -mm2 and the warning went away.
Could this be related to the recent pda changes?
FWIW, I did the bisection (inserting TRACE_HARDIRQS_ON between
sysenter_past_esp and the cli) and it gave the following result:
In entry.S:
310
311         pushl %eax
312         CFI_ADJUST_CFA_OFFSET 4
313         SAVE_ALL
314         GET_THREAD_INFO(%ebp)
315
If I put TRACE_HARDIRQS_ON at line 310, lockdep complains about having
interrupts enabled and being told to re-enable them. If I put
TRACE_HARDIRQS_ON at line 315, lockdep goes back to the original
message.

Regards,
Frederik
> 
> lockdep automatically generates a minimal trace of hardirqs-off 
> state-setting:
> 
> > [   17.885839] irq event stamp: 8318
> > [   17.892746] hardirqs last  enabled at (8317): [<c01032c8>] restore_nocheck+0x12/0x15
> > [   17.906778] hardirqs last disabled at (8318): [<c0103203>] sysenter_past_esp+0x6c/0x99
> > [   17.921481] softirqs last  enabled at (7128): [<c0123cd1>] __do_softirq+0xe9/0xfa
> > [   17.936962] softirqs last disabled at (7121): [<c0123d3e>] do_softirq+0x5c/0x60
> 
> this means that the last registered 'hardirqs off' event was 
> sysenter_past_esp, i.e. the normal sysenter syscall entry code - but 
> nothing re-enabled hardirqs - which is weird, given that you ended up in 
> sys_brk().
> 
> > I've replaced the DEBUG_LOCKS_WARN_ON by a BUG, and it appears that 
> > the user space program calling sys_brk is hotplug.
> 
> (ok, i'll enhance the debug printout to include the process name and 
> PID.)
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
