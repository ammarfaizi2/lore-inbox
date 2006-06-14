Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWFNRen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWFNRen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 13:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWFNRen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 13:34:43 -0400
Received: from ns.suse.de ([195.135.220.2]:48071 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932131AbWFNRem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 13:34:42 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Wed, 14 Jun 2006 19:34:36 +0200
User-Agent: KMail/1.9.3
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz
References: <200606140942.31150.ak@suse.de> <200606141752.02361.ak@suse.de> <4490399F.1090104@redhat.com>
In-Reply-To: <4490399F.1090104@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606141934.36911.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 June 2006 18:30, Ulrich Drepper wrote:
> > Eventually we'll need a dynamic format but I'll only add it 
> > for new calls that actually require it for security.
> > vgetcpu doesn't need it.
> 
> Just introduce the vdso now, add all new vdso calls there.  There is no
> reason except laziness to continue with these moronic fixed addresses.
> They only get in the way of address space layout change/optimizations.

The user address space size on x86-64 is final (baring the architecture gets extended
to beyond 48bit VA). We already use all positive
space. But the vsyscalls don't even live in user address space.

> >>> long vgetcpu(int *cpu, int *node, unsigned long *tcache)
> >> Do you expect the value returned in *cpu and*node to require an error
> >> value?  If not, then why this fascination with signed types?
> > 
> > Shouldn't make a difference.
> 
> If there is no reason for a signed type none should be used.  It can
> only lead to problems.

Ok i can change it to unsigned if you feel that strongly about it.

> 
> This reminds me: what are the values for the CPU number?  Are they
> continuous?  Are they the same as those used in the affinity syscalls 
> (they better be)?  

Yes of course.

> With hotplug CPUs, are CPU numbers "recycled"? 

I think if the same CPU gets unplugged and replugged it should
get the same number. Otherwise new numbers should be allocated.


> Yes, in this one case 
> you might at this point in time only need two words.  But
> 
> - this might change

Alan suggested adding some padding which probably
makes sense, although I frankly don't see the implementation
changing.  Variable length would be clear overkill and I refuse
to overdesign this.

> - there might be other future functions in the vdso which need memory.
>   It is a huge pain to provide more and more of these individual
>   variables.  Better allocate one chunk.

Why is it a problem? It's just var __thread isn't it?
 
> 
> > If some other function needs a cache too it can define its own.
> > I don't see any advantage of using a shared buffer.
> 
> I believe it that _you_ don't see it.  Because the pain is in the libc.
>  The code to set up stack frames has to be adjusted for each new TLS
> variable.  It is better to do it once in a general way which is what I
> suggested.

Hmm, I thought user space could define arbitary own __threads. I certainly
used that in some of my code. Why is it a problem for the libc to do the same?

Anyways even if it's such a big problem you can put it all in
one chunk and partition it yourself given the fixed size. I don't think
the kernel code should concern itself about this.

-Andi
