Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVJFKET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVJFKET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 06:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVJFKET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 06:04:19 -0400
Received: from mail.suse.de ([195.135.220.2]:62598 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750780AbVJFKET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 06:04:19 -0400
From: Andi Kleen <ak@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.14-rc3-rt2
Date: Thu, 6 Oct 2005 12:04:32 +0200
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>, Mark Knecht <markknecht@gmail.com>,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       acpi-devel@lists.sourceforge.net
References: <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com> <20051006084920.GB22397@elte.hu> <Pine.LNX.4.58.0510060544390.28535@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0510060544390.28535@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510061204.33045.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 October 2005 11:48, Steven Rostedt wrote:
> On Thu, 6 Oct 2005, Ingo Molnar wrote:
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > ahh ... I would not be surprised if this caused actual problems on
> > > > x64 in the upstream kernel too: using save_flags() over u32 will
> > > > corrupt a word on the stack ...
> > >
> > > Actually, it's still safe upstream.  The locks are taken via a function
> > > defined as:
> > >
> > > unsigned long acpi_os_acquire_lock(acpi_handle handle)
> > > {
> > > 	unsigned long flags;
> > > 	spin_lock_irqsave((spinlock_t *) handle, flags);
> > > 	return flags;
> > > }
> > >
> > > So a u32 flags with
> > >
> > >   flags = acpi_os_acquire_lock(lock);
> > >
> > > would be safe, unless a 64 bit machine stored the value of IR in the
> > > upper word, which I don't know of any archs that do that.
> >
> > ok. But this still looks very volatile. Nowhere do we guarantee (or can
> > we guarantee) that silently zeroing out the upper 32 bits of flags is
> > safe!
>
> Andi,
>
> So, should I send my patch upstream?

It's a theoretical only issue for mainline right now. The only architectures 
using the ACPI code are i386,x86-64,ia64. The first two are ok with 
truncating. The IA64 PSR is longer than 32bit, but unless I'm misreading the 
code they only care about the "i" bit which is also in the lower 32bit (Tony 
can probably confirm/deny) 

Still might be good to clean up, but certainly not a urgent issue.

-Andi
