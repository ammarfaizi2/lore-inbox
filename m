Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTEJBfh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 21:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTEJBfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 21:35:37 -0400
Received: from zero.aec.at ([193.170.194.10]:41742 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263636AbTEJBfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 21:35:36 -0400
Date: Sat, 10 May 2003 03:48:03 +0200
From: Andi Kleen <ak@muc.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
Message-ID: <20030510014803.GA16407@averell>
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <3EBBE7E2.1070500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBBE7E2.1070500@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 07:39:46PM +0200, Ulrich Drepper wrote:
> 
> > In some vendor kernels it's already in /proc/pid/mapped_base, but that is 
> > quite costly to change. That would probably give you the best of both, Just 
> > set it to a low value for the thread stacks and then reset it to the default.
> > 
> > I guess that would be the better solution for your stacks. 
> 
> Are you sure this is the best solution?  It means the mmap regions for

No, I'm not sure.

On further thinking the mapped_base would not be useful for you currently,
because at least in the SuSE/AMD64 kernel it only applies to 32bit processes.

The real solution is probably to pass in the search start hint in mmap's
address argument and not use MAP_32BiT. 

e.g. use something like

	/* 
  	 * Current gcc still needs PROT_EXEC because it doesn't call
	 * __enable_execute_stack for trampolines yet.
 	 */
	stack = mmap(0x1000, stack_size, PROT_READ|PROT_WRITE|PROT_EXEC, 	
		     MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);

This will give you memory at the beginning of the address space and 
beyond 4GB if needed.

This may still be slow, but fixing the search algorithm is a different
problem that can be tackled separately.

> Oh, and please rename MAP_32BIT to MAP_31BIT.  This will save nerves on
> all sides.

I bet changing it will cost more nerves in supporting all these people
whose software doesn't compile anymore. And it's not really a lie. 2GB 
is 32bit too.

-Andi
