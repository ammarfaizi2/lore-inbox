Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWCOCwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWCOCwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 21:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWCOCwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 21:52:50 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:55171 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932091AbWCOCwt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 21:52:49 -0500
Date: Tue, 14 Mar 2006 18:57:20 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation
Message-ID: <20060315025720.GN12807@sorel.sous-sol.org>
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <20060313224902.GD12807@sorel.sous-sol.org> <4416078C.4030705@vmware.com> <20060314212742.GL12807@sorel.sous-sol.org> <441743BD.1070108@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441743BD.1070108@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> >1) can't use stack based args, so have to allocate each data structure,
> >which could conceivably fail unless it's some fixed buffer.
> 
> We use a fixed buffer that is private to our VMI layer.  It's a per-cpu 
> packing struct for hypercalls.  Dynamically allocating from the kernel 
> inside the interface layer is a really great way to get into a whole lot 
> of trouble.

Heh, indeed that's why I asked.  per-cpu buffer means ROM state knows
which vcpu is current.  How is this done in OS agnostic method w/out
trapping to hypervisor?  Some shared data that ROM and VMM know about,
and VMM updates as it schedules each vcpu?

> >2) complicates the rom implementation slightly where implementation of
> >each deferrable part of the API needs to have switch (am I deferred or
> >not) to then build the batch, or make direct hypercall.
> 
> This is an overhead that is easily absorbed by the gain.  The direct 
> hypercalls are mostly either always direct, or always queued.  The page 
> table updates already have conditional logic to do the right thing, and 
> Xen doesn't require the queueing of these anymore anyways.  And the 
> flush happens at an explicit point.  The best approach can still be fine 
> tuned.  You could have separate VMI calls for queued vs. non-queued 
> operation.  But that greatly bloats the interface and doesn't make sense 
> for everything.  I believe the best solution is to annotate this in the 
> VMI call itself.  Consider the VMI call number, not as an integer, but 
> as an identifier tuple.  Perhaps I'm going overboard here.  Perhaps not.
> 
> 31--------24-23---------16-15--------8-7-----------0
> | family   | call number | reserved  | annotation |
> ---------------------------------------------------

I agree with your final assessment, needs more threshing out.  It does
feel a bit overkill at first blush.  I worry about these semantic
changes as an annotation instead of explicit API update.  But I guess
we still have more work on finding the right actual interface, not just
the possible ways to annotate the calls.

thanks,
-chris
