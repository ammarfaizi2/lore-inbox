Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275283AbTHSB23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275294AbTHSB23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:28:29 -0400
Received: from waste.org ([209.173.204.2]:19872 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S275283AbTHSB1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:27:32 -0400
Date: Mon, 18 Aug 2003 20:27:22 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, rddunlap@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context
Message-ID: <20030819012722.GH16387@waste.org>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org> <20030815173246.GB9681@redhat.com> <20030815123053.2f81ec0a.rddunlap@osdl.org> <20030816070652.GG325@waste.org> <20030818140729.2e3b02f2.rddunlap@osdl.org> <20030819001316.GF22433@redhat.com> <20030818171545.5aa630a0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818171545.5aa630a0.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 05:15:45PM -0700, Andrew Morton wrote:
> Dave Jones <davej@redhat.com> wrote:
> >
> > How spooky. now I got one too, (minus the noise).
> > 
> > Call Trace:
> >  [<c0120022>] __might_sleep+0x5b/0x5f
> 
> It would be useful to know whether this was triggered by in_atomic() or by
> irqs_disabled().  We're suspecting the latter.

Everything points to it being a fault handler.

Here's my current understanding:

 some part of X calls sys_vm86()
 sys_vm86 stashes pointer to userspace structure
 do_sys_vm86 fiddles with register structures to setup 16-bit transition
 do_sys_vm86 goes to 16-bit mode _through the userspace return path_
 fault occurs in 16-bit code
 handle_vm86_fault invoked through interrupt
 save_v86_state writes into stashed userspace structure (might_sleep)
 return_to_32bit swaps register sets around
 return_to_32bit returns to the original userspace context

Because we never return to the context of the sys_vm86 syscall, we're
never again in an appropriate place to copy the registers over. A
cleaner way to do this is to setup return_to_32bit to return to the
point just after where sys_vm86 returns to 16bit mode and copy the
registers to userspace in normal process context.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
