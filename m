Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbWFVAzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbWFVAzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 20:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWFVAzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:55:54 -0400
Received: from smtp-out.google.com ([216.239.45.12]:56124 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932740AbWFVAzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:55:53 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=iUew4ba/ZU/Bvn9wuwVshclqyRNOmIfEz5LpLDJP9Eoa76FjwzSAik26GzPY7ldkk
	lsLyXcXIvFwgNYSkOaveQ==
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200606220129.47546.ak@suse.de>
References: <200606210329_MC3-1-C305-E008@compuserve.com>
	 <200606220105.18512.ak@suse.de>
	 <1150931922.6885.72.camel@galaxy.corp.google.com>
	 <200606220129.47546.ak@suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 21 Jun 2006 17:55:29 -0700
Message-Id: <1150937729.6885.112.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 01:29 +0200, Andi Kleen wrote:
> On Thursday 22 June 2006 01:18, Rohit Seth wrote:
> > On Thu, 2006-06-22 at 01:05 +0200, Andi Kleen wrote:
> > > On Thursday 22 June 2006 00:59, Rohit Seth wrote:
> > 
> > > > I was thinking of storing it is base address part of the descriptor and
> > > > then using the memory load to read it in vsyscall.  (Keeping the p bit
> > > > to zero in the descriptor).
> > > 
> > > I'm still not sure where and for what you want to use this. In user space 
> > > or in kernel space? And what information should be stored in there?
> > > 
> > 
> > Store the kernel virtual pointer in gdt to access pda in (proposed)
> > vgetcpu in vsyscall. 
> > Using this pointer we can easily reach the cpu and 
> > node numbers and any other information that is there in pda.  For the
> > cpu and node numbers this will get rid of the need to do a serializing
> > operation cpuid.
> > 
> > Does it make any sense?
> 
> Ok to spell it out (please correct me if I misinterpreted you). You want to:
> 
> - Split PDA into kernel part and user exportable part

yes.

> - Export user exportable part to ring 3

yes for vsyscall purposes.

> - Put base address of user exportable part into GDT
> - Access it using that.
> 

These are the steps that I'm proposing in vgetcpu:

Read the GDT pointer in vgetcpu code path.  This is the base of gdt
table.
Read descriptor #20 from base.  
This is the pointer to user visible part of per cpu data structure.

Please let me know if I'm missing something here.

Just a side note, in your vgetcpu patch, would it be better to return
the logical CPU number (as printed in /proc/cpuinfo).  Also, I think
applications would be interested in knowing the physical package id for
cores sharing caches.

 
> I don't think it can work because the GDT only supports 32bit
> base addresses for code/data segments in long mode and you can't put
> a kernel virtual address into 32bit (only user space there) 
> 

Really not using the GDT descriptor in terms of  loading it in any
segment register.

> And you can't get at at the base address anyways because they
> are ignored in long mode (except for fs/gs). For fs/gs you would
> need to save/restore them to reuse them which would be slow.
> 
> You can't also just put them into fs/gs because those are
> already reserved for user space.
> 

That is the reason I'm not proposing to alter existing fs/gs.

> Also I don't know what other information other than cpu/node 
> would be useful, so just using the 20 bits of limit seems plenty to me.
> 


physical id (of the package for exmpale) is another useful field.  I
would also like to see number of interrupts serviced by this cpu, page
faults  etc.  But I think that is a separate discussion.

Thanks,
-rohit

