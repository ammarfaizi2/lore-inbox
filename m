Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbTHTHsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 03:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTHTHsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 03:48:20 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:10368 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S261737AbTHTHsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 03:48:10 -0400
Message-ID: <D069C7355C6E314B85CF36761C40F9A42E20D1@mailse02.se.axis.com>
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "'Timothy Miller'" <miller@techsource.com>,
       Daniel Forrest <forrest@lmcg.wisc.edu>
Cc: "'Willy Tarreau'" <willy@w.ods.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: generic strncpy - off-by-one error
Date: Wed, 20 Aug 2003 09:43:10 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I combined all my answers to your four mails into this one. ]

> -----Original Message-----
> From: Timothy Miller [mailto:miller@techsource.com] 
> Sent: Monday, August 18, 2003 18:07
> To: Peter Kjellerstedt
> Cc: 'Willy Tarreau'; linux-kernel mailing list
> Subject: Re: generic strncpy - off-by-one error
> 
> Peter Kjellerstedt wrote:
> > For loops       2.867568    5.620561    8.128734   28.286289  
> > Multi byte fill 2.868031    5.670782    6.312027   11.336015  
> > 
> > And here are the numbers for my P4:
> > 
> > For loops       3.060262    5.927378    8.796814   30.659818  
> > Multi byte fill 3.126607    5.898459    7.096685   13.135379  
> > 
> > So there is no doubt that the multi byte version is a clear
> > winner (which was expected, I suppose).
> 
> Cool!  Hey, is this just an exercise, or are we actually going to
> use this?  I would be very happy to have something I contributed 
> to put into the kernel.  :)

I have no idea. But it sure seems like the generic strncpy() could
use some improvement (and probably strcpy() too). However, I guess
one can argue that it is better to keep the generic implementations
as simple as possible, and then have each architecture implement
their own optimized versions.

> > Here is the code that I used:
> > 
> > char *strncpy(char *dest, const char *src, size_t count)
> > {
> > 	char *tmp = dest;
> > 
> > 	while (count && *src) {
> > 		*tmp++ = *src++;
> > 		count--;
> > 	}
> > 
> > 	if (count) {
> 
> Good idea... bad to do so many checks if count is zero.  On the
> other hand, if count is rarely zero, then it's a loss.  Maybe 
> benchmark with and without?

Actually, I think this change would be lost in the noise in
the measurements.

> > 		size_t count2;
> > 
> > 		while (count & (sizeof(long) - 1)) {
> > 			*tmp++ = '\0';
> > 			count--;
> > 		}
> > 
> > 		count2 = count / sizeof(long);
> 
> I know that a good compiler should migrate code to help the CPU 
> pipeline, but how about moving this "count2 = " line up to before 
> the first fill loop.  See if that helps any.  Always good to 
> precompute well in advance.

Cannot do that as the first loop modifies count. 

> > 		while (count2) {
> > 			*((long *)tmp)++ = '\0';
> > 			count2--;
> > 		}
> > 
> > 		count &= (sizeof(long) - 1);
> 
> And move this to before the middle fill loop.

In my later implementations this is not possible any longer.

> > 		while (count) {
> > 			*tmp++ = '\0';
> > 			count--;
> > 		}
> > 	}
> > 
> > 	return dest;
> > }


> Daniel Forrest wrote:
> > On Sat, Aug 16, 2003 at 10:15:14AM +0200, Peter Kjellerstedt wrote:
> 
> > Shouldn't this be:
> > 
> > 		while (tmp & (sizeof(long) - 1)) {
> > 
> > 
> >>			*tmp++ = '\0';
> >>			count--;
> >>		}
> 
> Oh, yeah!  That's right.  We need to check the address.  Also need to 
> cast tmp to (int) or something (doesn't matter what it's cast to, 
> because we only care about the lower 2 or 3 bits).
> 
> Peter, please see if this makes any speed difference.  But it 
> definately needs this fix.

Yes, I added it in my later versions.

> Frankly, I'm surprised it works.  In fact, it might not, but 
> it's hard to tell from the tests just benchmarks.

I actually added verification to my benchmarking program too,
so the later versions I mailed are verified to work the same
as the standard glibc implementation at least.

> Also, if you're doing dense addressing on Alpha, and you do byte 
> accesses the addresses for char are byte addresses, but the code
> does read-modify-write to memory for byte accesses, because in 
> that mode, you can only do 32-bit and 64-bit accesses.  The 
> performance increase could be even greater for Alpha than for x86.
> 
> For Sparc, we might be able to do something with VIS instructions, 
> although I don't know what the setup overhead is.  Sun's memcpy and 
> memset only use VIS when the size is greater than 512, because 
> otherwise, it's not worth it.
> 
> I don't know enough about PowerPC other than the proper use of the 
> "eieio" instruction. :)

Remember that many architectures already have their own architecture
specific implementations. Also note that most of them have not been
modified to do the null-padding... The following architectures have
their own implementations: alpha, h8300, i386, m68k, m68knommu, mips,
ppc, ppc64, s390 and sh. The following use the generic implementation:
arm, arm26, cris, ia64, mips64, parisc, sparc, sparc64, um, v850 and
x86_64.


> Daniel Forrest wrote:
> 
> >  
> > -	if (count) {
> > +	if (count >= sizeof(long)) {
> >  		size_t count2;
> >  
> 
> I like this size check here, but the comparison should be to 
> some number greater than sizeof(long).  There is a threshold 
> below which it's not worth it to do all of the extra loops.  
> If you're going to fill only four bytes, it's probably best 
> to do it just using the last loop.
> 
> Maybe through some trial and error, we could determine what that 
> threshold is.  I'm betting it's something around 2* or 3* word size.

The problem is that this probably varies a lot between different 
architectures, and also processor speeds. Probably best left for
the architecture specific implementations.


> Peter Kjellerstedt wrote:
> > For unaligned source or destination the "Multi copy & fill" 
> > would degenerate into "Multi byte fill". However, for
> > architectures like ix86 and CRIS that can do unaligned long
> > access, it would be a win to remove the UNALIGNED() check,
> > and use long word copying all the time.
> 
> In fact, it's possible to do the copy even if the source and 
> dest are not aligned.  It requires holding pieces of source in 
> a register and doing shifts.  If the CPU is much faster than 
> the memory, this can be a huge win.

This is true. However, this too is probably best left for the
architecture specific implementations.

> > Then whether using memset() or your filling is a win depends
> > on the architecture and how many bytes needs to be filled.
> > For a slow processor with little function call overhead (like
> > CRIS), using memset seems to be a win almost immediately.
> > However, for a fast processor like my P4, the call to memset
> > is not a win until some 1500 bytes need to be filled.
> 
> What is in memset that isn't in the fill code I suggested?

In the CRIS case it sets 12 registers to zero and uses the 
movem instruction to copy them to memory at once (movem is 
normally used to store/restore registers to/from the stack 
on function entry/exit). Thus it can clear 48 bytes each 
time through the loop. And of course the rest of the function
is hand crafted to give the best performance for any count.

//Peter
