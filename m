Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288967AbSA2JBL>; Tue, 29 Jan 2002 04:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSA2JBC>; Tue, 29 Jan 2002 04:01:02 -0500
Received: from [195.66.192.167] ([195.66.192.167]:3334 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288967AbSA2JAv>; Tue, 29 Jan 2002 04:00:51 -0500
Message-Id: <200201290859.g0T8xGE26936@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] syscall latency improvement #1
Date: Tue, 29 Jan 2002 10:59:18 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com> <200201281018.g0SAIIE22462@Port.imtp.ilyichevsk.odessa.ua> <3C55282C.7D607CFB@zip.com.au>
In-Reply-To: <3C55282C.7D607CFB@zip.com.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 January 2002 08:30, Andrew Morton wrote:
> > >       s/inline//g
> >
> > I like this.
>
> Well, it's a fairly small optimisation, but it's easy.
>
> I did a patch a while back: 
> http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/inline.patch This is
> purely against core kernel files:

[snip]

How did you find big inlines? Care to share hunter script with me (+ lkml)?

> The first patch should be against Documentation/CodingStyle.
> What are we trying to achieve here?  What are the guidelines
> for when-to and when-to-not?  I'd say:
>
> - If a function has a single call site and is static then it
>   is always correct to inline.

And what if later you (or someone else!) add another call? You may forget to 
remove inline. It adds maintenance trouble while not buying much of speed:
if func is big, inline gains are small, if it's small, it should be inlined 
regardless of number of call sites.

> - If a function is very small (20-30 bytes) then inlining
>   is correct even if it has many call sites.

Small in asm code, _not_ in C. Sometimes seemingly small C explodes into 
horrendous asm.

> - If a function is less-small, and has only one or two
>   *commonly called* call sites, then inlining is OK.

How much less small? We can have both:

inline int f_inlined() { ... }
int f() { return f_inline(); }
...
f_inlined(); /* we need speed here */
f(); /* we save space here */

> - If a function is a leaf function, then it is more inlinable
>   than a function which makes another function call.

100%. Especially when some "cute small functions" called inside happen to be 
inlined too (or are macros).

> fs/inode.c:__sync_one() violates all the above quite
> outrageously :)

Homehow I feel there are more :-)
--
vda
