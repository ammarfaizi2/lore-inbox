Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275483AbTHNUJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275490AbTHNUJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:09:46 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:13069 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S275483AbTHNUJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:09:10 -0400
Message-ID: <3F3BEFE3.9000905@techsource.com>
Date: Thu, 14 Aug 2003 16:24:03 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error
References: <D069C7355C6E314B85CF36761C40F9A42E20AB@mailse02.se.axis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Kjellerstedt wrote:

>>
>>Nice!
> 
> 
> I can but agree.
> 
> 
>>How about this:
>>
>>
>>char *strncpy(char * s1, const char * s2, size_t n)
>>{
>>	register char *s = s1;
>>
>>	while (n && *s2) {
>>		n--;
>>		*s++ = *s2++;
>>	}
>>	while (n--) {
>>		*s++ = 0;
>>	}
>>	return s1;
>>}
> 
> 
> This may be improved further:
> 
> char *strncpy(char *dest, const char *src, size_t count)
> {
> 	char *tmp = dest;
> 
> 	while (count) {
> 		if (*src == '\0')
> 			break;
> 
> 		*tmp++ = *src++;
> 		count--;
> 	}
> 
> 	while (count) {
> 		*tmp++ = '\0';
> 		count--;
> 	}
> 
> 	return dest;
> }
> 
> Moving the check for *src == '\0' into the first loop seems
> to let the compiler reuse the object code a little better
> (may depend on the optimizer). 

While I can understand that certain architectures may benefit from that 
alteration, I am curious as to what SPECIFICALLY it is doing that is 
different.  How do they differ?

> Also note that your version
> of the second loop needs an explicit  comparison with -1,
> whereas mine uses an implicit comparison with 0.

I don't understand why you say I need an explicit comparison with -1. 
My first loop exits either with the number of bytes remaining in the 
buffer or with zero if it's copied count number of bytes.

The second loop WOULD require a comparison with -1 IF the "count--" were 
not inside of the loop body.  As it IS in the loop body, there is no 
need for that.  My second loop has an implicit comparison against zero.

> Testing on the CRIS architecture, your version is 24 instructions,
> whereas mine is 18. For comparison, Eric's one is 12 and the
> currently used implementation is 26 (when corrected for the
> off-by-one error by comparing with > 1 rather than != 0 in the
> second loop).

If I understand it correctly, the corrected original needs that explicit 
comparison because the decrement is in the loop conditional.  My 
implementation (and yours) corrects this by moving the decrement into 
the body of the loop.

Also, while instruction count is sometimes a good indication of 
algorithm efficiency, I would argue that our two-loop version is 
probably the same speed as the single-loop version for copying 
characters, but ours is faster for zeroing the rest of the target buffer.

> 
> Here is another version that I think is quite pleasing
> aesthetically (YMMV) since the loops are so similar (it is 21
> instructions on CRIS):
> 
> char *strncpy(char *dest, const char *src, size_t count)
> {
> 	char *tmp = dest;
> 
> 	for (; count && *src; count--)
> 		*tmp++ = *src++;
> 
> 	for (; count; count--)
> 		*tmp++ = '\0';
> 
> 	return dest;
> }

I agree that this is definately a more elegant look to the code, and I 
would prefer what you have done here.  But what puzzles me is that this 
is functionally and logically equivalent to my code.

So, this code:

for (A; B; C) {}

is the same as this:

A;
while (B) {
	...
	C;
}


So why is it that this mere syntactic difference causes the compiler to 
produce a better result?


> This is probably the version I would choose if I were to decide
> as the object code generated for the actual loops are optimal in
> this version (at least for CRIS).

Sounds wise to me.

> 
>>This reminds me a lot of the ORIGINAL, although I didn't pay much 
>>attention to it at the time, so I don't remember.  It may be that
>>the original had "n--" in the while () condition of the first 
>>loop, rather than inside the loop.
>>
>>I THINK the original complaint was that n would be off by 1 
>>upon exiting the first loop.  The fix is to only decrement n 
>>when n is nonzero.
>>
>>If s2 is short enough, then we'll exit the first loop on the nul byte 
>>and fill in the rest in the second loop.  Since n is only decremented 
>>with we actually write to s, we will only ever write n bytes.  No 
>>off-by-one.
>>
>>If s2 is too long, the first loop will exit on n being zero, 
>>and since it doesn't get decremented in that case, it'll be 
>>zero upon entering the second loop, thus bypassing it properly.
>>
>>Erik's code is actually quite elegant, and its efficiency is probably 
>>essentially the same as my first loop.  But my second loop would 
>>probably be faster at doing the zero fill.
>>
>>
>>Now, consider this for the second loop!
>>
>>	while (n&3) {
> 
> 
> I think sizeof(int)-1 would be better than 3. ;)
> And long would probably be better for the 64-bit architectures?

Yeah, I know.  I deal with 32-bit vs 64-bit all the time.  I was just 
using this as an example and leaving it as an exercise for the reader to 
infer the 64-bit case.

Also, this approach would be good for some architectures (x86, PPC, 
etc.), but may be either an incredible improvement or no help at all for 
some architectures which do weird things with addressing (like alpha 
with its sparse vs. dense addressing).

Also, some compilers may not migrate operations around so intelligently, 
so it might help, for instance, to move the "n &= 3;" to between the "l 
= n>>2;" and the middle loop, because it gives the CPU time to compute l 
for the middle loop while computing n.


> 
>>		*s++ = 0;
>>		n--;
>>	}
>>	l = n>>2;
>>	while (l--) {
>>		*((int *)s)++ = 0;
>>	}
>>	n &= 3;
>>	while (n--) {
>>		*s++ = 0;
>>	}
>>
>>This is only a win for relatively long nul padding.  How often is the 
>>padding long enough?
> 
> 
> I guess another way would be to replace the second loop with
> memset(s, '\0', n), but that would probably only be a win for
> quite long paddings.


That depends entirely on how memset is written.  What IS in memset?

If it's inlined, and it's very well optimized, then it's probably a 
great win.

