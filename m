Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbUKRJP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUKRJP0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 04:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbUKRJP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 04:15:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:8888 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261753AbUKRJPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 04:15:19 -0500
Date: Thu, 18 Nov 2004 01:15:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: cliffw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5 - badness in enable_irg, BUG
Message-Id: <20041118011504.7dc87fe6.akpm@osdl.org>
In-Reply-To: <20041118095253.GA16054@elte.hu>
References: <20041115093759.721ac964.cliffw@osdl.org>
	<20041117210219.43a36302.akpm@osdl.org>
	<20041118095253.GA16054@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > BUG: using smp_processor_id() in preemptible [00000001] code: mkdir/11768
> > > caller is munmap_notify+0x7b/0x90 [oprofile]
> > >  [<c020a465>] smp_processor_id+0xb5/0xc0
> > >  [<f8912a4b>] munmap_notify+0x7b/0x90 [oprofile]
> > >  [<f8912a4b>] munmap_notify+0x7b/0x90 [oprofile]
> > >  [<c012b55d>] notifier_call_chain+0x2d/0x50
> > >  [<c011dd93>] profile_munmap+0x33/0x50
> > >  [<c01536f7>] sys_munmap+0x27/0x80
> > >  [<c01046d3>] syscall_call+0x7/0xb
> > 
> > ho hum, I guess we should suppress these oprofile warnings somehow.
> > 
> > Ingo, is there an smp_processor_id() variant which bypasses the warning?
> 
> yeah, just use _smp_processor_id() for the checking-less variant.

OK.

> > btw, this:
> 
> > is insane.   Any chance of simplifying it all?
> 
> since usually there are lots of arch-level false positives it didnt seem
> prudent to enable the warning unconditionally for every arch. So an arch
> can enable it right now by changing its smp_processor_id definition to
> __smp_processor_id - and the #ifdefs will do their job to adapt. Once
> most architectures have this enabled (right now only x86 and x64 have
> it) we could simplify it down by making it unconditional but right now i
> dont think it's a good idea.
> 

Well can we at least stick a comment in there explaining to the
long-suffering reader what the difference is between smp_processor_id(),
_smp_processor_id() and __smp_processor_id()?  And what the architecture's
options are?

Or should we go through every arch and rename their smp_processor_id() to
__smp_processor_id()?  That would make sense, and would simplify that piece
of code.
