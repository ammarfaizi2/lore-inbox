Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWAEWTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWAEWTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWAEWTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:19:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43979 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750726AbWAEWTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:19:02 -0500
Date: Thu, 5 Jan 2006 14:17:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Nicolas Pitre <nico@cam.org>, Joel Schopp <jschopp@austin.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
In-Reply-To: <20060105220305.GA8372@elte.hu>
Message-ID: <Pine.LNX.4.64.0601051411570.3169@g5.osdl.org>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com>
 <Pine.LNX.4.64.0601042133230.27409@localhost.localdomain>
 <Pine.LNX.4.64.0601041847330.3279@g5.osdl.org> <20060105144016.GB16816@elte.hu>
 <Pine.LNX.4.64.0601050810240.3169@g5.osdl.org> <20060105220305.GA8372@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, Ingo Molnar wrote:
>
> [ long details removed ]
> 
> to sum it up: atomic_dec/inc_return() alone is not enough to implement 
> critical sections, on a number of architectures. atomic_xchg() seems to 
> have similar problems too.

Yes.

> the patch below adds the smp_mb() barriers to the generic headers, which 
> should now fulfill all the ordering requirements, on every architecture.  
> It only relies on one property of the atomic primitives: that they wont 
> get reordered with respect to themselves, so an atomic_inc_ret() and an 
> atomic_dec_ret() cannot switch place.
> 
> Can you see any hole in this reasoning?

No. The alternative is to just make the ordering requirements 
for "atomic_dec_return()" and "atomic_xchg()" be absolute. Say that they 
have to be full memory barriers, and push the problem into the low-level
architecture.

I _think_ your patch is the right approach, because most architectures are 
likely to do their own fast-paths for mutexes, and as such the generic 
ones are more of a template for how to do it, and hopefilly aren't that 
performance critical.

			Linus
