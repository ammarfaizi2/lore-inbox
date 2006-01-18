Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbWARVGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbWARVGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWARVGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:06:08 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:37796 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030472AbWARVGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:06:07 -0500
Message-ID: <43CEAD95.5010601@austin.ibm.com>
Date: Wed, 18 Jan 2006 15:05:25 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/2] powerpc: native atomic_add_unless
References: <20060118063636.GA14608@wotan.suse.de> <20060118063921.GB14608@wotan.suse.de> <43CE76B8.1000905@austin.ibm.com> <20060118172822.GG28418@wotan.suse.de>
In-Reply-To: <20060118172822.GG28418@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Why use a separate register here? Why not reuse %0 instead of using %1? 
>>Registers are valuable.
>>
> You still need to get the output (t) because you need to return
> whether the operation met with the "unless" case or not. If there is
> a better way to do this then I'd like to know.

I was thinking something like this would do:

static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
{
	int t;

	__asm__ __volatile__ (
	LWSYNC_ON_SMP
"1:	lwarx	%0,0,%1		# atomic_add_unless\n\
	cmpw	%0,%3 \n\
	beq-	2f \n\
	add	%0,%2,%0 \n"
	PPC405_ERR77(0,%1)
"	stwcx.	%0,0,%1 \n\
	bne-	1b \n"
	ISYNC_ON_SMP
	"subf	%0,%2,%0 \n\
2:"
	: "=&r" (t)
	: "r" (&v->counter), "r" (a), "r" (u)
	: "cc", "memory");

	return likely(t != u);
}

Though if I could figure out how to get gcc to do it I'd much rather do 
something like this (which won't compile but I think illustrates the concept):

static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
{
	int t;

	__asm__ __volatile__ (
	LWSYNC_ON_SMP
"1:	lwarx	%0,0,%1		# atomic_add_unless\n\
	cmpw	%0,%3 \n\
	beq-	3f \n\
	add	%0,%2,%0 \n"
	PPC405_ERR77(0,%1)
"	stwcx.	%0,0,%1 \n\
	bne-	1b \n"
	ISYNC_ON_SMP
2:"
	: "=&r" (t)
	: "r" (&v->counter), "r" (a), "r" (u)
	: "cc", "memory");

	return 1;
3:
	return 0;
}
