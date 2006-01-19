Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161206AbWASOEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161206AbWASOEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 09:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbWASOEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 09:04:31 -0500
Received: from cantor2.suse.de ([195.135.220.15]:4522 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161206AbWASOEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 09:04:30 -0500
Date: Thu, 19 Jan 2006 15:04:29 +0100
From: Nick Piggin <npiggin@suse.de>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/2] powerpc: native atomic_add_unless
Message-ID: <20060119140429.GC958@wotan.suse.de>
References: <20060118063636.GA14608@wotan.suse.de> <20060118063921.GB14608@wotan.suse.de> <43CE76B8.1000905@austin.ibm.com> <20060118172822.GG28418@wotan.suse.de> <43CEAD95.5010601@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CEAD95.5010601@austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 03:05:25PM -0600, Joel Schopp wrote:
> >>Why use a separate register here? Why not reuse %0 instead of using %1? 
> >>Registers are valuable.
> >>
> >You still need to get the output (t) because you need to return
> >whether the operation met with the "unless" case or not. If there is
> >a better way to do this then I'd like to know.
> 
> I was thinking something like this would do:
> 
> static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
> {
> 	int t;
> 
> 	__asm__ __volatile__ (
> 	LWSYNC_ON_SMP
> "1:	lwarx	%0,0,%1		# atomic_add_unless\n\
> 	cmpw	%0,%3 \n\
> 	beq-	2f \n\
> 	add	%0,%2,%0 \n"
> 	PPC405_ERR77(0,%1)
> "	stwcx.	%0,0,%1 \n\
> 	bne-	1b \n"
> 	ISYNC_ON_SMP
> 	"subf	%0,%2,%0 \n\
> 2:"
> 	: "=&r" (t)
> 	: "r" (&v->counter), "r" (a), "r" (u)
> 	: "cc", "memory");
> 
> 	return likely(t != u);
> }
> 

Oh yes, for some reason I thought that wouldn't work in all cases,
but I think that's nice. Thanks!

> Though if I could figure out how to get gcc to do it I'd much rather do 
> something like this (which won't compile but I think illustrates the 
> concept):
> 
> static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
> {
> 	int t;
> 
> 	__asm__ __volatile__ (
> 	LWSYNC_ON_SMP
> "1:	lwarx	%0,0,%1		# atomic_add_unless\n\
> 	cmpw	%0,%3 \n\
> 	beq-	3f \n\
> 	add	%0,%2,%0 \n"
> 	PPC405_ERR77(0,%1)
> "	stwcx.	%0,0,%1 \n\
> 	bne-	1b \n"
> 	ISYNC_ON_SMP
> 2:"
> 	: "=&r" (t)
> 	: "r" (&v->counter), "r" (a), "r" (u)
> 	: "cc", "memory");
> 
> 	return 1;
> 3:
> 	return 0;
> }
