Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUAFSq3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUAFSq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:46:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:10698 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265275AbUAFSq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:46:26 -0500
Date: Tue, 6 Jan 2004 10:46:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paulo Marques <pmarques@grupopie.com>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, johnstultz@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
In-Reply-To: <3FFAFE7A.7030404@grupopie.com>
Message-ID: <Pine.LNX.4.58.0401061033490.9166@home.osdl.org>
References: <1073405053.2047.28.camel@mulgrave> <Pine.LNX.4.58.0401060819000.2653@home.osdl.org>
 <3FFAFE7A.7030404@grupopie.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, Paulo Marques wrote:
> 
> What about this instead? I don't like very much this kind of construction, but 
> it seems that it would prevent the lock altogether:
> 
> 	u32 jiff_high1, jiff_high2, jiff_low
> 
> 	do {
> 		jiff_high1 = ((volatile) jiffies_64) >> 32;
> 		jiff_low = ((volatile) jiffies_64);
> 		jiff_high2 = ((volatile) jiffies_64) >> 32;
> 	}
> 	while(jiff_high1 != jiff_high2);

Yes, we used to do things like that at some point (and your code is 
buggy: by leaving out the size, the "volatile" cast casts to the implicit 
"int" size in C). 

It doesn't work in SMP environments, since the "ordering" by volatile is 
only a single-CPU ordering. This is just one of the reasons why "volatile" 
isn't very useful.

Also, the above still assumes an update ordering between low and high (it
assumes that both set of bits get written back simultaneously). Which is
not necessarily true on a software _or_ hardware ordering level.

So on the reader side you'd need to add an explicit "rmb()" between the
two reads of the high bits, and on the writer side you'd need to always 
make sure that you do an atomic 64-bt write.

Since the "rmb()" is as expensive as the sequence lock, the above wouldn't
much help.

> If there is anyway to avoid the volatiles there, it would be much cleaner.

Not only is there a need to avoid them, they don't help in the least,
since you need the explicit CPU ordering macro anyway. And that ordering 
macro is the true cost of "seq_read_lock()", so...

In contrast, the reason the simple "assume some values are stable" patch
actually _does_ help is that it doesn't depend on any ordering constraints
at all.  So it literally can be done lock-less, because it knows about
something much more fundamental: it depends on the _behaviour_ of the
values.

Basically, in the kernel, the expensive part about any lock is literally 
the ordering. There are other things that can be expensive too (if the 
lock is bouncing back and forth between CPU's, that becomes really 
exensive really quickly), but to a first order and especially on locks 
that aren't themselves fundamentally highly contended for, the CPU 
serialization implied in the lock is the expensive part.

So converting that serialization to a "lockless" algorithm that still
depends on ordering usually doesn't much help for those locks. The
"ordering" part is still serializing, and the main win ends up being on 
64-CPU systems etc where you can at least avoid the cacheline bounces.

Indeed, I think it was 64-CPU systems that caused the sequence lock stuff, 
not so much the "normal" 2- and 4-way boxes.

If you want to improve on the sequence lock, you need to take advantage of
inherent data knowledge (in this case the knowledge that you don't care
about the exact value, and that you know how the bits are updated).

		Linus
