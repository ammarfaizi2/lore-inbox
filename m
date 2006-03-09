Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbWCIAfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbWCIAfD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWCIAfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:35:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932654AbWCIAfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:35:00 -0500
Date: Wed, 8 Mar 2006 16:32:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: bcrl@kvack.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
       netdev@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add
 percpu_counter_mod_bh
Message-Id: <20060308163258.36f3bd79.akpm@osdl.org>
In-Reply-To: <20060309001803.GF4493@localhost.localdomain>
References: <20060308015808.GA9062@localhost.localdomain>
	<20060308015934.GB9062@localhost.localdomain>
	<20060307181301.4dd6aa96.akpm@osdl.org>
	<20060308202656.GA4493@localhost.localdomain>
	<20060308203642.GZ5410@kvack.org>
	<20060308210726.GD4493@localhost.localdomain>
	<20060308211733.GA5410@kvack.org>
	<20060308222528.GE4493@localhost.localdomain>
	<20060308224140.GC5410@kvack.org>
	<20060308154321.0e779111.akpm@osdl.org>
	<20060309001803.GF4493@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> On Wed, Mar 08, 2006 at 03:43:21PM -0800, Andrew Morton wrote:
> > Benjamin LaHaise <bcrl@kvack.org> wrote:
> > >
> > > I think it may make more sense to simply convert local_t into a long, given 
> > > that most of the users will be things like stats counters.
> > > 
> > 
> > Yes, I agree that making local_t signed would be better.  It's consistent
> > with atomic_t, atomic64_t and atomic_long_t and it's a bit more flexible.
> > 
> > Perhaps.  A lot of applications would just be upcounters for statistics,
> > where unsigned is desired.  But I think the consistency argument wins out.
> 
> It already is... for most of the arches except x86_64.

x86 uses unsigned long.

> And on -mm, the asm-generic version uses atomic_long_t for local_t (signed
> long) which seems right.

No, it uses unsigned long.  The only place where signedness matters is
local_read(), and there it is typecast to ulong.

> Although, I wonder why we use:
> 
> #define local_read(l) ((unsigned long)atomic_long_read(&(l)->a))
> 
> It would return a huge value if the local counter was even -1 no?

It's casting a signed long to an unsigned long.  That does the right thing.
Yes, it'll convert -1 to 0xffffffff[ffffffff].

