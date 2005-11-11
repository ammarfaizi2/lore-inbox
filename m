Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVKKUsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVKKUsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVKKUsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:48:10 -0500
Received: from main.gmane.org ([80.91.229.2]:23491 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751190AbVKKUsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:48:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [PATCH consolidate =?utf-8?b?c3lzX3B0cmFjZQ==?=
Date: Fri, 11 Nov 2005 20:45:18 +0000 (UTC)
Message-ID: <loom.20051111T213148-66@post.gmane.org>
References: <20051101051221.GA26017@lst.de> <20051101050900.GA25793@lst.de> <10611.1130845074@warthog.cambridge.redhat.com> <20051102153143.5005a87b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 151.97.230.52 (Opera/8.5 (X11; Linux x86_64; U; en))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm <at> osdl.org> writes:

> 
> David Howells <dhowells <at> redhat.com> wrote:
> >
> > Christoph Hellwig <hch <at> lst.de> wrote:
> > 

> >  (1) Make a sys_ptrace() *jump* to arch_ptrace() instead of calling it, thus
> >      obviating the extra return step.
> > 

> If we can remove the lock_kernel() and move the final put_task_struct()
> into each arch_ptrace() then we can end sys_ptrace() with

> 	return arch_ptrace(....);

> and with luck, gcc will convert it into a tailcall for us.

Yep, it can do it, especially if CONFIG_REGPARM is enabled.

> It's probably not the first place to start doing such optimisation tho.

Boys, you risk being burned. I'm sorry I'll have to teach you a lesson. I'm 
especially sorry because I had to learn it the hard way...

prevent_tail_call is there for a reason (grep for it in kernel/exit.c)

* If you do:

int do_foo(params...) {
...
}

asmlinkage int sys_foo(params...) {
        return do_foo(a_new_param, params...);
}

* and do_foo and sys_foo have different prototypes (such as in the example or in 
the patch),

THEN

GCC can reorder/change parameters of sys_foo on the stack, to make them match 
the do_foo call.

Since those parameters are afterwards restored into userspace registers (which 
are supposed to be unchanged), we get userspace breakage.

But only if userspace uses the registers afterwards, and if it calls with int 
0x80 (there's no restoring otherwise, or something such).

I know this because I did once this exact error, and it was very hard to 
diagnose (actually, it was in a UML-patch and I got breakage in UML). Also, it 
was triggered only when CONFIG_REGPARM is enabled. If needed, I can point out 
real examples (but you already should know).

