Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274918AbTHPUNY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 16:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274920AbTHPUNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 16:13:24 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:27783 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S274918AbTHPUNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 16:13:17 -0400
Message-ID: <D069C7355C6E314B85CF36761C40F9A42E20BD@mailse02.se.axis.com>
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "'Timothy Miller'" <miller@techsource.com>,
       Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: generic strncpy - off-by-one error
Date: Sat, 16 Aug 2003 22:08:24 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Timothy Miller [mailto:miller@techsource.com] 
> Sent: Friday, August 15, 2003 19:47
> To: Peter Kjellerstedt
> Cc: linux-kernel mailing list
> Subject: Re: generic strncpy - off-by-one error
> 
> Peter Kjellerstedt wrote:
> 
> >>While I can understand that certain architectures may benefit 
> >>from that alteration, I am curious as to what SPECIFICALLY it 
> >>is doing that is different.  How do they differ?
> > 
> > I do not know if this will give you anything, but here is
> > the disassembled CRIS version of your first while loop 
> > (note that the branch instructions have one delay slot,
> > and that dest, src and count are in $r10, $r11 and $r12):
> > 
> >   while (count && *src)
> >    805d8:       6cc6                    test.d $r12
> >    805da:       1830                    beq 805f4
> >    805dc:       6a96                    move.d $r10,$r9
> 
> Ok, test count and exit if count is zero.
> 
> I take it that this move is the copy of the dst to a 
> temporary variable?

Yes.

> >    805de:       8b0b                    test.b [$r11]
> >    805e0:       1230                    beq 805f4
> >    805e2:       0f05                    nop 
> 
> Test *s and exit if zero.
> 
> >   {
> >     count--;
> >    805e4:       81c2                    subq 1,$r12
> 
> 
> >     *tmp++ = *src++;
> >    805e6:       4bde                    move.b [$r11+],$r13
> 
> Fetch *s and increment.  This is redundant.  Why didn't it 
> know to fetch *s above and keep it in a register?

I think this is the way gcc produces while loops (not exactly
my area of expertise).

> >    805e8:       6cc6                    test.d $r12
> >    805ea:       0830                    beq 805f4
> >    805ec:       c9df                    move.b $r13,[$r9+]
> 
> Test count and exit if count is zero.  Why is it doing this 
> again?  Why not jump back to the top?  Oh, wait... in that 
> case, for the loop to exit, it would jump to the top and then 
> jump back to past the end, rather than just failing one branch.

Yes.

> I see that the delay slot was filled with the store to *dst.  But is 
> there also some pipeline latency that makes this worth while?

As far as I know this should be a win.

> >    805ee:       8b0b                    test.b [$r11]
> >    805f0:       f320                    bne 805e4
> >    805f2:       0f05                    nop 
> 
> Test *src AGAIN and loop if nonzero.  Redundant.

No. Note that $r11 was increased after the move at 805e6,
so what it tests here is the next byte to be copied. Once
the loop is running this is the only test of *src. However,
the code isn't optimal as it causes two reads of *src, but
it was not trivial to modify the assembler code to get
optimal behavior for this version, so I can understand 
that the compiler did not make it.

> >   }
> > 
> > And here is my first while loop:
> > 
> >   while (count)
> >    8062c:       6cc6                    test.d $r12
> >    8062e:       1030                    beq 80640
> >    80630:       6a96                    move.d $r10,$r9
> 
> Test count and bypass if zero.  Also, copy dst.
> 
> >   {
> >     count--;
> >     if (!(*tmp++ = *src++))
> >    80632:       4bde                    move.b [$r11+],$r13
> >    80634:       c9db                    move.b $r13,[$r9]
> 
> Move data
> 
> >    80636:       890f                    test.b [$r9+]
> 
> Interesting how (a) it moved the increment to the test, and 
> (b) it makes a redundant read of the dest.
> 
> Does this arch not get condition codes from things other than 
> test and compare?

Only moves TO a register results in the status flags being
changed. But I do not know why the compiler doesn't produce
either 

	move.b [$r11+],$r13
	move.b $r13,[$r9+]
	test.b $r13

or even better

	move.b [$r11+],$r13
	move.b $r13,[$r9+]

for this code, as I believe they should be equivalent, but with
better cycle counts. I will ask our compiler guy next week...

> And why didn't it test $r13 instead?  Wouldn't that have been 
> a lot more efficient?

One rather than two cycles.
 
> >    80638:       0630                    beq 80640
> >    8063a:       81c2                    subq 1,$r12
> 
> Exit on zero and decrement count.
> 
> >       break;
> >    8063c:       f520                    bne 80632
> >    8063e:       0f05                    nop 
> 
> Loop.
> 
> >   }
> > 
> > 
> >>>Also note that your version
> >>>of the second loop needs an explicit  comparison with -1,
> >>>whereas mine uses an implicit comparison with 0.
> >>
> >>I don't understand why you say I need an explicit comparison 
> >>with -1. My first loop exits either with the number of bytes 
> >>remaining in the buffer or with zero if it's copied count 
> >>number of bytes.
> > 
> > 
> > I was talking about the second loop. The object code the compiler
> > produces for your version actually tests the count variable after
> > it decreases it, which is why it tests for -1.
> 
> Why does it do that?  Is that somehow more optimal?  Why 
> doesn't it test BEFORE it decrements?  Isn't that more 
> straightforward?

It would be hard to do in assembler, since after the test
instruction is executed one must do the branch instruction, 
and there is no way to do the decrementation in-between
without affecting the status flags.

We can easily change the code and move the decrementation into
it since we do not care what happens to count after the loop
(or can take the changed value into account), but the compiler
cannot (easily) do this as it would change the value count has
after the loop (-1 vs. 0).

> In any event, couldn't that be fixed by moving the decrement 
> into the loop?
> 
> > 
> >>The second loop WOULD require a comparison with -1 IF the 
> >>"count--" were not inside of the loop body.  As it IS in the 
> >>loop body, there is no need for that.  My second loop has an 
> >>implicit comparison against zero.
> > 
> > 
> > Hmm, your second loop from above looks like:
> > 
> > 	while (n--) {
> > 		*s++ = 0;
> > 	}
> > 
> > whereas mine looks like:
> > 
> >  	while (count) {
> >  		*tmp++ = '\0';
> >  		count--;
> >  	}
> > 
> > You seem to be referring to my version, where what you say is true.
> 
> And what I was saying was that since what the while should 
> test is the value before the decrement, I assumed that the 
> test would be before the decrement.

See my answer above.

> >>I agree that this is definately a more elegant look to the 
> >>code, and I would prefer what you have done here.  But what 
> >>puzzles me is that this is functionally and logically 
> >>equivalent to my code.
> >>
> >>So, this code:
> >>
> >>for (A; B; C) {}
> >>
> >>is the same as this:
> >>
> >>A;
> >>while (B) {
> >>	...
> >>	C;
> >>}
> >>
> >>
> >>So why is it that this mere syntactic difference causes the 
> >>compiler to produce a better result?
> > 
> > 
> > I wish I new. Actually in the CRIS case, it seems to be an
> > optimizer thing. If I change your first loop from
> > 
> > 	while (n && *s2) {
> > 		n--;
> > 		*s++ = *s2++;
> > 	}
> > 
> > to
> > 
> > 	while (n && *s2) {
> > 		*s++ = *s2++;
> > 		n--;
> > 	}
> > 
> > it gives the expected object code, i.e., the same as my
> > first for loop. So here is a modified version of your
> > code that gives exactly the same object code (for CRIS) 
> > as my version with the for loops:
> 
> A decent optimizer should know that the "n--" and the "*s++ = 
> *s2++" are independent and migrate them to optimal positions.

I agree. I think I will have to ask our compiler guy about
this too...

> Furthermore, I put the "n--" first because I assumed that the 
> compiler might be stupid about it.  The idea is to order the 
> statements so that the results of a given instruction are being 
> computed while the next one is being decoded.
> 
> My assumption was that the code would branch back to the loop test 
> (rather than make a second one) at the end of the loop and 
> then test n. 

Assumptions does not seem to work when dealing with the 
compiler. ;) My tests with benchmarking this code has clearly
taught me that...

>   Therefore, decrementing n earlier would be a win in terms of having 
> the result earlier for the test, reducing pipline stall.

I guess trying to optimize generic code is not very easy
as what is optimal on one architecture may be bad on some
other. However, it should be possible to get better results
than what the current implementation does.

//Peter
