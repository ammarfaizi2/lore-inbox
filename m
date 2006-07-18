Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWGRUBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWGRUBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 16:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWGRUBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 16:01:18 -0400
Received: from ozlabs.org ([203.10.76.45]:50561 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932378AbWGRUBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 16:01:17 -0400
Subject: Re: [Xen-devel] Re: [RFC PATCH 15/33] move segment checks to
	subarch
From: Rusty Russell <rusty@rustcorp.com.au>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060718192533.GA2654@sequoia.sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091952.263186000@sous-sol.org>
	 <1153249601.5467.31.camel@localhost.localdomain>
	 <20060718192533.GA2654@sequoia.sous-sol.org>
Content-Type: text/plain
Date: Wed, 19 Jul 2006 06:00:50 +1000
Message-Id: <1153252850.5467.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 12:25 -0700, Chris Wright wrote:
> * Rusty Russell (rusty@rustcorp.com.au) wrote:
> > On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> > > plain text document attachment (i386-segments)
> > > We allow for the fact that the guest kernel may not run in ring 0.
> > > This requires some abstraction in a few places when setting %cs or
> > > checking privilege level (user vs kernel).
> > 
> > Zach had an alternate patch for this, which didn't assume the kernel ran
> > in a compile-time known ring, but is otherwise very similar.  I've put
> > it below for discussion (but Zach now tells me the asm parts are not
> > required: Zach, can you mod this patch and comment?).
> 
> This patch also doesn't have a compile time known ring, it's using
> get_kernel_cs() because the Xen method for booting native is dynamic and
> would resolve to ring 0 in that case (XENFEAT_supervisor_mode_kernel).

I was referring to the different ways the two patches figure out whether
we're in user mode:

Yours:
 static inline int user_mode(struct pt_regs *regs)
 {
       return (regs->xcs & USER_MODE_MASK) != 0;
 }

Where you have for native:
	#define USER_MODE_MASK 3
vs Xen:
	#define USER_MODE_MASK 2

Zach's patch does this:

 static inline int user_mode(struct pt_regs *regs)
 {
	return (regs->xcs & SEGMENT_RPL_MASK) == 3;
 }

I'm no x86pert, but the latter seems more generic to me (user mode is
ring 3, vs. usermode is anything >= 2).  Perhaps they are in fact
equivalent?

Thanks!
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

