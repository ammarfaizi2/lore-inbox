Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVLPQ3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVLPQ3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 11:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVLPQ3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 11:29:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932300AbVLPQ3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 11:29:23 -0500
Date: Fri, 16 Dec 2005 08:28:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, cfriesen@nortel.com,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
In-Reply-To: <11202.1134730942@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0512160802050.3060@g5.osdl.org>
References: <43A21E55.3060907@yahoo.com.au>  <1134560671.2894.30.camel@laptopd505.fenrus.org>
 <439EDC3D.5040808@nortel.com> <1134479118.11732.14.camel@localhost.localdomain>
 <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com>
 <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain>
 <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain>
 <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain>
 <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com>
  <11202.1134730942@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Dec 2005, David Howells wrote:
> 
> No, they're not. LL/SC is more flexible than CMPXCHG because under some
> circumstances, you can get away without doing the SC, and because sometimes
> you can do one LL/SC in lieu of two CMPXCHG's because LL/SC allows you to
> retrieve the value, consider it and then modify it if you want to. With
> CMPXCHG you have to anticipate, and so you're more likely to get it wrong.

You can think of LL/SC as directly translating into LD/CMPXCHG, so in that 
sense CMPXCHG is no less flexible. LL/SC still has other advantages, 
though. See later.

> I've had a play with x86, and on there CMPXCHG, XCHG and XADD give worse
> performance than INC/DEC for some reason. I assume this is something to do
> with how the PPro CPU optimises itself. On PPro CPUs at least, counting
> semaphores really are the most efficient way. CMPXCHG, whilst it ought to be
> better, really isn't.

The notion that CMPXCHG "ought to be better" is a load of bull.

There are two advantages of "lock inc/dec" over "ld/cmpxchg": one is the 
obvious one that the CPU core just has a much easier time with the 
unconditional one, and never has to worry about things like conditional 
branches or waste cycles on multiple instructions. Just compare the 
sequences:

	lock inc mem

vs

   back:
	load mem,reg1
	reg2 = reg1+1
	cmpxchg mem,reg1,reg2
	jne forward		# get branch prediction right
	return
   forward:
	jmp back

guess which one is faster?

The other one depends on cache coherency: the "lock inc" can just get the 
cacheline for exclusive use immediately ("read with intent to write"). In 
contrast, the ld/cmpxchg first gets the cacheline for reading, and then 
has to turn it into an exclusive one. IOW, there may literally be lots of 
extra bus traffic from doing a load first.

In other words, there are several advantages to just using the simple 
instructions. 

(Of course, some CPU's have "get cacheline for write" instructions, so you 
can then make the second sequence even longer by using that).

Using "xadd" should be fine, although for all I know, even then 
microarchitectural issues may make it cheaper to use the simpler "lock 
add" whenever possible.

In LL/SC, I _think_ LL generally does its read with intent to write. 

			Linus
