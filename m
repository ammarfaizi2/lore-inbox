Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVA1ATd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVA1ATd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVA1AQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:16:45 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:20502
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261335AbVA1APn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:15:43 -0500
Date: Fri, 28 Jan 2005 01:15:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mauriciolin@gmail.com, tglx@linutronix.de, marcelo.tosatti@cyclades.com,
       edjard@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: User space out of memory approach
Message-ID: <20050128001543.GA8518@opteron.random>
References: <20050122033219.GG11112@dualathlon.random> <3f250c7105012513136ae2587e@mail.gmail.com> <1106689179.4538.22.camel@tglx.tec.linutronix.de> <3f250c71050125161175234ef9@mail.gmail.com> <20050126004901.GD7587@dualathlon.random> <3f250c7105012710541d3e7ad1@mail.gmail.com> <20050127221129.GX8518@opteron.random> <20050127142943.3fea07df.akpm@osdl.org> <20050127225854.GZ8518@opteron.random> <20050127153535.7cc94c10.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127153535.7cc94c10.akpm@osdl.org>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 03:35:35PM -0800, Andrew Morton wrote:
> On x86 we could perhaps test for non-nullness of tsk->thread->io_bitmap_ptr?

yes for ioports. But I'm afraid I was too optimistic about eflags for
iopl, that's not in the per-task tss, it's only stored at the very top
of the kernel stack and inherit during fork/clone. So we probably need
to check esp0 and read the top of the stack to see if a task has eflags
set. esp0 is definitely stored in the thread struct when the task is
rescheduled, and it cannot change for each given task, so we can access
it even while the task is runnable and it shouldn't be corrupted by
iret. But the problem is sysenter is optimized not to save eflags on the
kernel stack, so the top of the stack - 12bytes would not contain eflags
if sysenter is in use.

So basically we'd need to change iopl to propagate the info to the task
struct synchronously somehow, because we can't read it reliably from the
kernel stack.
