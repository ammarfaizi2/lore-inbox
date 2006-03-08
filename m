Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWCHXIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWCHXIQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWCHXIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:08:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030266AbWCHXIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:08:14 -0500
Date: Wed, 8 Mar 2006 15:06:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: bcrl@kvack.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
       netdev@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add
 percpu_counter_mod_bh
Message-Id: <20060308150609.344c62fa.akpm@osdl.org>
In-Reply-To: <20060308222528.GE4493@localhost.localdomain>
References: <20060308015808.GA9062@localhost.localdomain>
	<20060308015934.GB9062@localhost.localdomain>
	<20060307181301.4dd6aa96.akpm@osdl.org>
	<20060308202656.GA4493@localhost.localdomain>
	<20060308203642.GZ5410@kvack.org>
	<20060308210726.GD4493@localhost.localdomain>
	<20060308211733.GA5410@kvack.org>
	<20060308222528.GE4493@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> On Wed, Mar 08, 2006 at 04:17:33PM -0500, Benjamin LaHaise wrote:
> > On Wed, Mar 08, 2006 at 01:07:26PM -0800, Ravikiran G Thirumalai wrote:
> > 
> > Last time I checked, all the major architectures had efficient local_t 
> > implementations.  Most of the RISC CPUs are able to do a load / store 
> > conditional implementation that is the same cost (since memory barriers 
> > tend to be explicite on powerpc).  So why not use it?
> 
> Then, for the batched percpu_counters, we could gain by using local_t only for 
> the UP case. But we will have to have a new local_long_t implementation 
> for that.  Do you think just one use case of local_long_t warrants for a new
> set of apis?
> 

local_t maps onto 32-bit values on 32-bit machines and onto 64-bit values
on 64-bit machines.  unsigned longs.  I don't quite trust the signedness
handling across all archs.

<looks>

Yes, alpha (for example) went and made its local_t's signed, which is wrong
and dangerous.

ia64 is signed.

mips is signed.

parisc is signed.

s390 is signed.

sparc64 is signed.

x86_64 is signed 32-bit!

All other architectures use unsigned long.  A fiasco.

Once decrapify-asm-generic-localh.patch is merged I think all architectures
can and should use asm-generic/local.h.

Until decrapify-asm-generic-localh.patch has been merged and the downstream
arch consolidation has happened and the signedness problems have been
carefully reviewed and fixed I wouldn't go within a mile of local_t.

Once all that is sorted out then yes, it makes sense to convert per-cpu
counters to local_t.  Note that local_t is unsigned, and percpu_counter
needs to treat it as signed.

We should also move the out-of-line percpu_counter implementation over to
lib/something.c (in obj-y).

But none of that has anything to do with these patches.
