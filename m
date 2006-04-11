Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWDKPK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWDKPK4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 11:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWDKPK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 11:10:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751365AbWDKPKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 11:10:55 -0400
Date: Tue, 11 Apr 2006 08:10:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jes Sorensen <jes@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       bjorn_helgaas@hp.com, cotte@de.ibm.com
Subject: Re: [patch] do_no_pfn handler
In-Reply-To: <yq0psjonq2p.fsf@jaguar.mkp.net>
Message-ID: <Pine.LNX.4.64.0604110751510.10745@g5.osdl.org>
References: <yq0k6a6uc7i.fsf@jaguar.mkp.net> <yq0psjonq2p.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Apr 2006, Jes Sorensen wrote:
> 
> You mentioned earlier that you preferred an alternative approach, do
> you still feel that given the additional interest from other Bjorn and
> Carsten? If this is still the case, I'd love to get some guidance as
> to what that should be.

I'm still pretty unhappy with this. It's pretty much designed to screw up 
the system by letting the driver do random things that make little or no 
sense from a VM standpoint.

The 

	BUG_ON(!(vma->vm_flags & VM_PFNMAP));

certainly helps, but it still leaves the window open for other problems. 

At the very least, it would also need a

	BUG_ON(is_cow_mapping(vma->vm_flags));

(or at least make it return VM_FAULT_SIGBUS). Because a COW mapping _will_ 
confuse the VM and cause it to do random bad things in vm_normal_page(). 

It also assumes that a negative pfn is ok as an error return, but maybe 
that's fine. I can't think of any architecture that uses all bits of the 
PFN (x86 with PAE can have a full 32-bit PFN, but I don't think any actual 
CPU supports 48 bits of physical addressing?). Something to think about.

			Linus
