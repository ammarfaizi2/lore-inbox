Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWGGXTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWGGXTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWGGXTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:19:04 -0400
Received: from relay00.pair.com ([209.68.5.9]:62473 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S932386AbWGGXSy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:18:54 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: "J.A. =?iso-8859-1?q?Magall=F3n?=" <jamagallon@ono.com>
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Fri, 7 Jul 2006 18:18:25 -0500
User-Agent: KMail/1.9.3
Cc: "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20060705114630.GA3134@elte.hu> <Pine.LNX.4.64.0607071718080.23767@turbotaz.ourhouse> <20060708004943.05dbb10c@werewolf.auna.net>
In-Reply-To: <20060708004943.05dbb10c@werewolf.auna.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607071818.50296.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 July 2006 17:49, J.A. Magallón wrote:
> On Fri, 7 Jul 2006 17:22:22 -0500 (CDT), Chase Venters 
<chase.venters@clientec.com> wrote:
> > > .L7:
> > >    movl    $1, mtx    <=========
> > >    movl    spinvar, %eax
> > >    movl    $0, mtx    <=========
> > >    testl   %eax, %eax
> > >    jne .L7
> > >    popl    %ebp
> > >    ret
> >
> > NO! It's not better. You're still not syncing or locking the bus! If you
> > refer to the fact that the "movl $1" has magically appeared, that's
> > because you've just PAPERED OVER THE PROBLEM WITH "volatile", which is
> > _exactly_ what Linus is telling you NOT TO DO.
>
> BTW, I really don't mind if a given architecnture has to lock the bus or
> say a prayer to Budha to reload a variable. I want it to be reloaded at
> every (or a certain, in case of a (volatile)mtx cast) usage. The compiler
> is the responsible of knowing what to do. What if nextgen P4 Xeon do not
> need a bus lock ? Will you rewrite the kernel ?

You are missing the point. Your code is obviously trying to implement locks, 
which is why you've called your functions lock() and unlock(). It is 
impossible, on any architecture, to implement correct locks in pure C. Your 
locks are incapable of working in the kernel _or_ in user space.

Barriers are a different but related point. If you want to know more about 
barriers, and why they exist, please read Documentation/memory-barriers.txt 
in full. (FYI, Locked bus operations on x86 imply memory barriers.)

Locks are supposed to prevent sections of your code from being interrupted by 
something that touches the same data. Because both the compiler and the 
processor reserve the right to re-order your loads and stores, any lock that 
does not form a memory barrier both for the CPU and for the compiler is 
broken. Because you cannot form a CPU memory barrier from C (much less the 
ATOMIC COMPARE AND SWAP you need to implement a lock), any lock implemented 
in pure C is broken by definition. 

Your code is wrong. Barring some fundamental change to the way things work, 
locks and/or barriers are always going to be necessary.

Your usage of 'volatile' of course changes the generated code output. It will 
force the compiler to reload the variable. The problem with your lock code is 
that reloading the variable _IS NOT ENOUGH_. Hence your usage of volatile is 
a broken way to paper over the problem.

'volatile' in general, for the kernel, is wrong because it isn't specific 
enough and it causes the compiler to generate bad code.

But hey, maybe some day we'll all be proven wrong. Some magical new computer 
architecture will appear, and on that day, we will rewrite the kernel.

Thanks,
Chase
