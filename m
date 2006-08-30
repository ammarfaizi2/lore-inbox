Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWH3Myp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWH3Myp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWH3Myo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:54:44 -0400
Received: from ns1.suse.de ([195.135.220.2]:11728 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750937AbWH3MyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:54:20 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
Date: Wed, 30 Aug 2006 14:54:12 +0200
User-Agent: KMail/1.9.3
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
References: <200608300838_MC3-1-C9C6-CA79@compuserve.com>
In-Reply-To: <200608300838_MC3-1-C9C6-CA79@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301454.12770.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 14:33, Chuck Ebbert wrote:
> In-Reply-To: <44F557A8.1030605@goop.org>
> 
> On Wed, 30 Aug 2006 02:17:28 -0700, Jeremy Fitzhardinge wrote:
> 
> > > This changes the ABI for signals and ptrace() and that seems like
> > > a bad idea to me.
> > >   
> > 
> > I don't believe it does; it certainly shouldn't change the usermode 
> > ABI.  How do you see it changing?
> 
> Nevermind.  I thought because you changed struct pt_regs in ptrace_abi.h
> it meant a user ABI change.

I think he broke the ptrace ABI actually in the first patch, but only by mistake 
and he promised to fix it :)

> 
> > > And the way things are done now is so ingrained into the i386
> > > kernel that I'm not sure it can be done.  E.g. I found two
> > > open-coded implementations of current, one in kernel_fpu_begin()
> > > and one in math_state_restore().

Perhaps those should be fixed? Is there a reason they are open coded?

> > >   
> > 
> > That's OK.  The current task will still be available in thread_info; 
> 
> But they can get out of sync, e.g. when switch_to() restores the new
> task's esp, the PDA still contains the old pcurrent and they don't get
> synchronized until the write_pda() in __switch_to().

But there is neither kernel_fpu_begin nor math_state_restore inbetween.
And I think interrupts are off too.

> 
> > To be honest, I haven't looked at percpu.h in great detail.  I was 
> > making assumptions about how it works, but it looks like they were wrong.
> 
> Would it make any sense to replace the 'cpu' field in thread_info with
> a pointer to a PDA-like structure?  We could even embed the static per_cpu
> data directly into that struct instead of chasing pointers...

I don't see what advantage it would have. %gs is clearly faster and shorter.

-Andi
