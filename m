Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275485AbTHOJ66 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 05:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275889AbTHOJ66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 05:58:58 -0400
Received: from [212.209.10.216] ([212.209.10.216]:51858 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S275485AbTHOJ6e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 05:58:34 -0400
Message-ID: <D069C7355C6E314B85CF36761C40F9A42E20B5@mailse02.se.axis.com>
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "'Timothy Miller'" <miller@techsource.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: generic strncpy - off-by-one error
Date: Fri, 15 Aug 2003 11:53:41 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Timothy Miller [mailto:miller@techsource.com] 
> Sent: Thursday, August 14, 2003 22:24
> To: Peter Kjellerstedt
> Cc: linux-kernel mailing list
> Subject: Re: generic strncpy - off-by-one error
> 
> Peter Kjellerstedt wrote:
> 
> >>
> >>Nice!
> > 
> > 
> > I can but agree.
> > 
> > 
> >>How about this:
> >>
> >>
> >>char *strncpy(char * s1, const char * s2, size_t n)
> >>{
> >>	register char *s = s1;
> >>
> >>	while (n && *s2) {
> >>		n--;
> >>		*s++ = *s2++;
> >>	}
> >>	while (n--) {
> >>		*s++ = 0;
> >>	}
> >>	return s1;
> >>}
> > 
> > 
> > This may be improved further:
> > 
> > char *strncpy(char *dest, const char *src, size_t count)
> > {
> > 	char *tmp = dest;
> > 
> > 	while (count) {
> > 		if (*src == '\0')
> > 			break;
> > 
> > 		*tmp++ = *src++;
> > 		count--;
> > 	}
> > 
> > 	while (count) {
> > 		*tmp++ = '\0';
> > 		count--;
> > 	}
> > 
> > 	return dest;
> > }
> > 
> > Moving the check for *src == '\0' into the first loop seems
> > to let the compiler reuse the object code a little better
> > (may depend on the optimizer). 
> 
> While I can understand that certain architectures may benefit 
> from that alteration, I am curious as to what SPECIFICALLY it 
> is doing that is different.  How do they differ?

I do not know if this will give you anything, but here is
the disassembled CRIS version of your first while loop 
(note that the branch instructions have one delay slot,
and that dest, src and count are in $r10, $r11 and $r12):

  while (count && *src)
   805d8:       6cc6                    test.d $r12
   805da:       1830                    beq 805f4
   805dc:       6a96                    move.d $r10,$r9
   805de:       8b0b                    test.b [$r11]
   805e0:       1230                    beq 805f4
   805e2:       0f05                    nop 
  {
    count--;
   805e4:       81c2                    subq 1,$r12
    *tmp++ = *src++;
   805e6:       4bde                    move.b [$r11+],$r13
   805e8:       6cc6                    test.d $r12
   805ea:       0830                    beq 805f4
   805ec:       c9df                    move.b $r13,[$r9+]
   805ee:       8b0b                    test.b [$r11]
   805f0:       f320                    bne 805e4
   805f2:       0f05                    nop 
  }

And here is my first while loop:

  while (count)
   8062c:       6cc6                    test.d $r12
   8062e:       1030                    beq 80640
   80630:       6a96                    move.d $r10,$r9
  {
    count--;
    if (!(*tmp++ = *src++))
   80632:       4bde                    move.b [$r11+],$r13
   80634:       c9db                    move.b $r13,[$r9]
   80636:       890f                    test.b [$r9+]
   80638:       0630                    beq 80640
   8063a:       81c2                    subq 1,$r12
      break;
   8063c:       f520                    bne 80632
   8063e:       0f05                    nop 
  }

> > Also note that your version
> > of the second loop needs an explicit  comparison with -1,
> > whereas mine uses an implicit comparison with 0.
> 
> I don't understand why you say I need an explicit comparison 
> with -1. My first loop exits either with the number of bytes 
> remaining in the buffer or with zero if it's copied count 
> number of bytes.

I was talking about the second loop. The object code the compiler
produces for your version actually tests the count variable after
it decreases it, which is why it tests for -1.

> The second loop WOULD require a comparison with -1 IF the 
> "count--" were not inside of the loop body.  As it IS in the 
> loop body, there is no need for that.  My second loop has an 
> implicit comparison against zero.

Hmm, your second loop from above looks like:

	while (n--) {
		*s++ = 0;
	}

whereas mine looks like:

 	while (count) {
 		*tmp++ = '\0';
 		count--;
 	}

You seem to be referring to my version, where what you say is true.

> > Testing on the CRIS architecture, your version is 24 instructions,
> > whereas mine is 18. For comparison, Eric's one is 12 and the
> > currently used implementation is 26 (when corrected for the
> > off-by-one error by comparing with > 1 rather than != 0 in the
> > second loop).
> 
> If I understand it correctly, the corrected original needs 
> that explicit comparison because the decrement is in the loop 
> conditional.  My implementation (and yours) corrects this by 
> moving the decrement into the body of the loop.
> 
> Also, while instruction count is sometimes a good indication of 
> algorithm efficiency, I would argue that our two-loop version is 
> probably the same speed as the single-loop version for copying 
> characters, but ours is faster for zeroing the rest of the 
> target buffer.

Seems to be the case, yes.

> > Here is another version that I think is quite pleasing
> > aesthetically (YMMV) since the loops are so similar (it is 21
> > instructions on CRIS):
> > 
> > char *strncpy(char *dest, const char *src, size_t count)
> > {
> > 	char *tmp = dest;
> > 
> > 	for (; count && *src; count--)
> > 		*tmp++ = *src++;
> > 
> > 	for (; count; count--)
> > 		*tmp++ = '\0';
> > 
> > 	return dest;
> > }
> 
> I agree that this is definately a more elegant look to the 
> code, and I would prefer what you have done here.  But what 
> puzzles me is that this is functionally and logically 
> equivalent to my code.
> 
> So, this code:
> 
> for (A; B; C) {}
> 
> is the same as this:
> 
> A;
> while (B) {
> 	...
> 	C;
> }
> 
> 
> So why is it that this mere syntactic difference causes the 
> compiler to produce a better result?

I wish I new. Actually in the CRIS case, it seems to be an
optimizer thing. If I change your first loop from

	while (n && *s2) {
		n--;
		*s++ = *s2++;
	}

to

	while (n && *s2) {
		*s++ = *s2++;
		n--;
	}

it gives the expected object code, i.e., the same as my
first for loop. So here is a modified version of your
code that gives exactly the same object code (for CRIS) 
as my version with the for loops:

char *strncpy(char * s1, const char * s2, size_t n)
{
	register char *s = s1;

	while (n && *s2) {
		*s++ = *s2++;
		n--;
	}
	while (n) {
		*s++ = 0;
		n--;
	}
	return s1;
}

//Peter
