Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWIWEvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWIWEvT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 00:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWIWEvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 00:51:19 -0400
Received: from ozlabs.org ([203.10.76.45]:38030 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750945AbWIWEvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 00:51:18 -0400
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <20060922123215.GA98728@muc.de>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
	 <1158926106.26261.8.camel@localhost.localdomain>
	 <1158926215.26261.11.camel@localhost.localdomain>
	 <1158926308.26261.14.camel@localhost.localdomain>
	 <1158926386.26261.17.camel@localhost.localdomain>
	 <20060922123215.GA98728@muc.de>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 14:51:15 +1000
Message-Id: <1158987075.26261.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-22 at 14:32 +0200, Andi Kleen wrote:
> BTW I changed my copy sorry. I redid the early PDA support
> to not be in assembler.
> 
> On Fri, Sep 22, 2006 at 09:59:45PM +1000, Rusty Russell wrote:
> > This patch actually uses the gs register to implement the per-cpu
> > sections.  It's fairly straightforward: the gs segment starts at the
> > per-cpu offset for the particular cpu (or 0, in very early boot).  
> > 
> > We also implement x86_64-inspired (via Jeremy Fitzhardinge) per-cpu
> > accesses where a general lvalue isn't needed.  These
> > single-instruction accesses are slightly more efficient, plus (being a
> > single insn) are atomic wrt. preemption so we can use them to
> > implement cpu_local_inc etc.
> 
> The problem is nobody uses cpu_local_inc() etc :/ And it is difficult
> to use in generic code because of the usual preemption issues 
> (and being slower on other archs in many cases compared to preempt disabling
> around larger block of code) 

True, they were primarily designed for the SNMP counters in networking
(as per your comment in snmp.h).  They're now dynamic per-cpu pointers,
which adds a new wrinkle though 8(

> Without that it is the same code as Jeremy's variant
> %gs memory reference + another reference with offset as far as I can see.
> 
> So while it looks nice I don't think it will have advantages. Or did
> i miss something?

Mainly that it makes more sense to use the existing per-cpu concept than
introduce another kind of per-cpu var within a special structure, but
it's also more efficient (see other post).  Hopefully it will spark
interest in making dynamic-percpu pointers use the same offset scheme,
now x86 will experience the benefits.

And we might even get a third user of local_t!

Cheers,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

