Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWFUXaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWFUXaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 19:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWFUXaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 19:30:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:56239 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751521AbWFUXaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 19:30:03 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Date: Thu, 22 Jun 2006 01:29:47 +0200
User-Agent: KMail/1.9.3
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <200606210329_MC3-1-C305-E008@compuserve.com> <200606220105.18512.ak@suse.de> <1150931922.6885.72.camel@galaxy.corp.google.com>
In-Reply-To: <1150931922.6885.72.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606220129.47546.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 June 2006 01:18, Rohit Seth wrote:
> On Thu, 2006-06-22 at 01:05 +0200, Andi Kleen wrote:
> > On Thursday 22 June 2006 00:59, Rohit Seth wrote:
> 
> > > I was thinking of storing it is base address part of the descriptor and
> > > then using the memory load to read it in vsyscall.  (Keeping the p bit
> > > to zero in the descriptor).
> > 
> > I'm still not sure where and for what you want to use this. In user space 
> > or in kernel space? And what information should be stored in there?
> > 
> 
> Store the kernel virtual pointer in gdt to access pda in (proposed)
> vgetcpu in vsyscall. 
> Using this pointer we can easily reach the cpu and 
> node numbers and any other information that is there in pda.  For the
> cpu and node numbers this will get rid of the need to do a serializing
> operation cpuid.
> 
> Does it make any sense?

Ok to spell it out (please correct me if I misinterpreted you). You want to:

- Split PDA into kernel part and user exportable part
- Export user exportable part to ring 3
- Put base address of user exportable part into GDT
- Access it using that.

I don't think it can work because the GDT only supports 32bit
base addresses for code/data segments in long mode and you can't put
a kernel virtual address into 32bit (only user space there) 

And you can't get at at the base address anyways because they
are ignored in long mode (except for fs/gs). For fs/gs you would
need to save/restore them to reuse them which would be slow.

You can't also just put them into fs/gs because those are
already reserved for user space.

Also I don't know what other information other than cpu/node 
would be useful, so just using the 20 bits of limit seems plenty to me.

-Andi
