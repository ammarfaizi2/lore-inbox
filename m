Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWBJRfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWBJRfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWBJRfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:35:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58600 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751356AbWBJRfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:35:38 -0500
Date: Fri, 10 Feb 2006 09:35:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <Pine.LNX.4.64.0602100904330.19172@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0602100923400.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
 <43EAFEB9.2060000@yahoo.com.au> <20060209004208.0ada27ef.akpm@osdl.org>
 <43EB3801.70903@yahoo.com.au> <20060209094815.75041932.akpm@osdl.org>
 <43EC0A44.1020302@yahoo.com.au> <20060209195035.5403ce95.akpm@osdl.org>
 <43EC0F3F.1000805@yahoo.com.au> <20060209201333.62db0e24.akpm@osdl.org>
 <43EC16D8.8030300@yahoo.com.au> <20060209204314.2dae2814.akpm@osdl.org>
 <43EC1BFF.1080808@yahoo.com.au> <20060209211356.6c3a641a.akpm@osdl.org>
 <43EC24B1.9010104@yahoo.com.au> <20060209215040.0dcb36b1.akpm@osdl.org>
 <43EC2C9A.7000507@yahoo.com.au> <20060209221324.53089938.akpm@osdl.org>
 <43EC3326.4080706@yahoo.com.au> <20060209224656.7533ce2b.akpm@osdl.org>
 <43EC3961.3030904@yahoo.com.au> <20060209231432.03a09dee.akpm@osdl.org>
 <43EC8A06.40405@yahoo.com.au> <Pine.LNX.4.64.0602100815580.19172@g5.osdl.org>
 <43ECC69D.1010001@yahoo.com.au> <Pine.LNX.4.64.0602100904330.19172@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Feb 2006, Linus Torvalds wrote:
> 
> So WRITE_SYNC has clearly different behaviour. There's a good reason the 
> kernel internally has "start write" + "wait for write", and I'll repeat: 
> none of those reasons go away just because you move to user space.

Btw, just to clarify: there _are_ things that do change when you go from 
user space to kernel space. It's true that you lose some visibility, and 
it's also true that the kernel has more than just "start write" semantics. 

So the kernel actually has "start write, but don't wait for stuff that 
has IO already pending", and "start write, and if writeback was active on 
a re-dirtied page, wait for and re-start it". 

I don't know if user space wants quite -that- much choice. The "start 
write but ignore busy areas" doesn't actually make sense together with 
"wait for it", since you don't know what (if any) you're really waiting 
for.

So it's really three operations
 - try to start flushing, so that you'll have less work pending later
 - start flushing
 - wait for any pending flush

[ From a pure "correctness" angle, we could say that "start flushing" 
  is the same as "wait for pending" + "try to start". However, the "IO 
  should overlap as much as possible" argument says that that is the
  wrong thing to do, since we can start flushing non-pending IO before we 
  wait for the old pending one ]

Now, most user programs probably don't care one whit.

But I think Andrew's patch makes sense. It exposes the internal kernel 
working in a logical fasion for people who do care. Yes, it's 
Linux-specific, but hey, so is arguing about the exact semantics of 
MS_INVALIDATE (which is version-specific).

		Linus
