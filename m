Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbUCTGL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 01:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbUCTGL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 01:11:28 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:11676 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263234AbUCTGL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 01:11:26 -0500
Date: Fri, 19 Mar 2004 22:09:07 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040319220907.1e07d36f.pj@sgi.com>
In-Reply-To: <20040320031843.GY2045@holomorphy.com>
References: <1079651064.8149.158.camel@arrakis>
	<20040318165957.592e49d3.pj@sgi.com>
	<1079659184.8149.355.camel@arrakis>
	<20040318175654.435b1639.pj@sgi.com>
	<1079737351.17841.51.camel@arrakis>
	<20040319165928.45107621.pj@sgi.com>
	<20040320031843.GY2045@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The stack footprint of cpumasks is a concern in general. I don't have a
> good answer to this. The half-answer I anticipate is that the truly
> larger systems will configure themselves with deeper stacks.

Sounds like a good enough answer to me.


That is, a richer API can help - more 

> This is one of the areas where I believe I carried out some innovation.
> cpumask_const_t allows more aggressive conversion to call-by-reference

True, you did do some substantial work there, and for const objects,
calls by value and reference can be used interchangeably, for best
performance, without semantic impact.

However, something about the current cpus_*_const() macros doesn't seem
to be having the desired impact.  I see five uses in files matching
include/asm-i386/mach-*/mach_apic.h, and one in include/asm-x86_64/smp.h
That's all.  None, for example, in any ia64 code.

That's it.  And why should one have to code explicitly the choice of
the cpus_*_const() variant?  Shouldn't each macro know which of routines
it calls change things, and which don't, letting it pass a pointer to
the read-only routines if that helps?  It knows the sizes as well, so
it can even pick and choose which variation of code to generate.

If one needs an explicit call by reference to avoid passing a multi-word
object, one should ask the user to pass an explicit pointer, to a
routine or macro that expects a pointer to a non-const, not an apparent
value.  Shouldn't try to hide the reference semantics behind quasi-const
labels.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
