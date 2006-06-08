Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWFHHNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWFHHNM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWFHHNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:13:12 -0400
Received: from science.horizon.com ([192.35.100.1]:10054 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750847AbWFHHNL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:13:11 -0400
Date: 8 Jun 2006 03:13:10 -0400
Message-ID: <20060608071310.16166.qmail@science.horizon.com>
From: linux@horizon.com
To: jfritschi@freenet.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following seem to me to be simplifications, and so
make the code more readable.  For what it's worth...

- It would be nice to delete the R6 and R7 definitions in order to
  make clear that %esp and %ebp are NOT used as general-purpose registers.

- ctx, tmp1, tmp2, new1 and new2 are only used in "## D" form.
  It would be simpler to include the D suffix at the call site
  and remove 5 characters per use from the macro expansion.

- That would let you get rid of half of the macro definitions.
  You only need R0, R1, R2, R3, R8 and R9.
  The rest could simply be replaced by %r10d, etc.

- Changing the argument order to (a, b, newa, newb, olda, oldb)
  would make it clearer what's changing and what's staying the
  same between rounds.

- You could also get rid of the ## D sufixes on olda and oldb, but that's
  of more dubious benefit.

- How about making the macros more specific and not passing in the
  constant arguments ctx, tmp1, tmp2, key1 and key2?


Having looked at the code that much, I started seeing potential
code improvements:

- Why schedule the loading of the round keys so far in advance?
  They're going to be L1 hits anyway, and anything amd64 can do lots
  of code reordering.  There are no stores to act as fences.
  You could just to an xor stright into where you need the values.

- Why copy a -> olda and b->oldb at the end of each round?  Why not
  just do

+	encrypt_last_round(R0,R1,R8,R9,R2,R3,R5,  0,R10,R11,R12,R13);
+	encrypt_last_round(R2,R3,R0,R1,R8,R9,R5,  8,R10,R11,R12,R13);
+	encrypt_last_round(R8,R9,R2,R3,R0,R1,R5,2*8,R10,R11,R12,R13);
+	encrypt_last_round(R0,R1,R8,R9,R2,R3,R5,3*8,R10,R11,R12,R13);
+	encrypt_last_round(R2,R3,R0,R1,R8,R9,R5,4*8,R10,R11,R12,R13);
etc.?

Oh, but wait!  The ONLY inputs, AFAICT, to newa are
+	mov	olda  ## D,	newa ## D;\
+	mov	oldb ## D,	newb ## D;\
+	xor	key1 ## D,	newa ## D;\
+	xor	key2 ## D,	newb ## D;\

So why not just make newa and olda the same register, thereby removing that
mov as well, and replace the other uses of newa and newb in the loop
with appropriate temps?


That would make the round function:
+/*
+ * The twofish round function.
+ * This is very close to a standard Feistel cipher:
+ * (c,d) ^= F(a,b,round_key)
+ * But twofish adds one-bit rotations.
+ * Other registers used:
+ * %rdi points to the context structure including the key schedule
* * %r9d is a temporary.
+ * %r10d and %r11d hold the F() function output.
+ */
+#define\
+ encrypt_round(a,b,c,d,round)\
+	movzx	a ## B,		%r9d;\
+	mov	s0(%rdi,%r9,4),	%r10d;\
+	movzx	a ## H,		%r9d;\
+	ror	$16,		a ## D;\
+	xor     s1(%rdi,%r9,4),	%r10d;\
+	movzx	a ## B,		%r9d;\
+	xor     s2(%rdi,%r9,4),	%r10d;\
+	movzx	a ## H,		%r9d;\
+	xor     s3(%rdi,%r9,4),	%r10d;\
+	ror	$16,		a ## D;\
+	movzx	b ## B,		%r9d;\
+	mov     s1(%rdi,%r9,4),	%r11d;\
+	movzx	b ## H,		%r9d;\
+	ror	$16,		b ## D;\
+	xor	s2(%rdi,%r9,4),	%r11d;\
+	movzx	b ## B,		%r9d;\
+	xor	s3(%rdi,%r9,4),	%r11d;\
+	movzx	b ## H,		%r9d;\
+	xor     s0(%rdi,%r9,4),	%r11d;\
+	ror	$15,		b ## D;\
+	add	%r11d,		%r10d;\
+	add	%r10d,		%r11d;\
+	add	k+round(%rdi),	%r10d;\
+	add	k+4+round(%rdi),%r11d;\
+	xor	%r10d,		c ## D;\
+	xor	%r11d,		d ## D;\
+	ror	$1,		c ## D

Notice that this has saved three registers (%r8, %r12, %r13) and
eliminated six mov instructions.

(Admittedly, unbenchmarked and untested.)

If I wanted to worry about scheduling, I might move the b-side S-box
lookups ahead of the a-side to give that "ror $1,c" a smidgen more time
to complete, and then interleave them:

+#define\
+ encrypt_round(a,b,c,d,round)\
+	movzx	b ## B,		%r9d;\
+	mov     s1(%rdi,%r9,4),	%r11d;\
+	movzx	a ## B,		%r9d;\
+	mov	s0(%rdi,%r9,4),	%r10d;\
+	movzx	b ## H,		%r9d;\
+	xor	s2(%rdi,%r9,4),	%r11d;\
+	ror	$16,		b ## D;\
+	movzx	a ## H,		%r9d;\
+	xor     s1(%rdi,%r9,4),	%r10d;\
+	ror	$16,		a ## D;\
+	movzx	b ## B,		%r9d;\
+	xor	s3(%rdi,%r9,4),	%r11d;\
+	movzx	a ## B,		%r9d;\
+	xor     s2(%rdi,%r9,4),	%r10d;\
+	movzx	b ## H,		%r9d;\
+	xor     s0(%rdi,%r9,4),	%r11d;\
+	ror	$15,		b ## D;\
+	movzx	a ## H,		%r9d;\
+	xor     s3(%rdi,%r9,4),	%r10d;\
+	ror	$16,		a ## D;\
+	add	%r11d,		%r10d;\
+	add	%r10d,		%r11d;\
+	add	k+round(%rdi),	%r10d;\
+	add	k+4+round(%rdi),%r11d;\
+	xor	%r10d,		c ## D;\
+	xor	%r11d,		d ## D;\
+	ror	$1,		c ## D

And you could eliminate one more instruction by re-ordering the a-side
S box lookups to do the "high half" lookups first, and then merging the
resultant leading ror $16 with the trailing ror $1:
(Note that this changes the required loop setup slightly.)

+#define\
+ encrypt_round(a,b,c,d,round)\
+	rol	$15,		a ## D;\
+	movzx	b ## B,		%r9d;\
+	mov     s1(%rdi,%r9,4),	%r11d;\
+	movzx	a ## B,		%r9d;\
+	mov	s2(%rdi,%r9,4),	%r10d;\
+	movzx	b ## H,		%r9d;\
+	xor	s2(%rdi,%r9,4),	%r11d;\
+	ror	$16,		b ## D;\
+	movzx	a ## H,		%r9d;\
+	xor     s3(%rdi,%r9,4),	%r10d;\
+	ror	$16,		a ## D;\
+	movzx	b ## B,		%r9d;\
+	xor	s3(%rdi,%r9,4),	%r11d;\
+	movzx	a ## B,		%r9d;\
+	xor     s0(%rdi,%r9,4),	%r10d;\
+	movzx	b ## H,		%r9d;\
+	xor     s0(%rdi,%r9,4),	%r11d;\
+	ror	$15,		b ## D;\
+	movzx	a ## H,		%r9d;\
+	xor     s1(%rdi,%r9,4),	%r10d;\
+	add	%r11d,		%r10d;\
+	add	%r10d,		%r11d;\
+	add	k+round(%rdi),	%r10d;\
+	add	k+4+round(%rdi),%r11d;\
+	xor	%r10d,		c ## D;\
+	xor	%r11d,		d ## D

I haven't looked at the x86_32 code to see how many of these ideas
could be adapted there.  Unfortunately, even with the reduction, this
still uses 8 registers, one more than possible on x86_32.

Probably the best thing to do there would be to de-interleave the
a->%r10d and b->%r11d computations and spill (push/pop) the
necessary register around the second block.  Something like:

ctx in %edi
%ebp and %esi are temps

+#define\
+ encrypt_round(a,b,c,d,round)\
+	rol	$15,		a ## D;\
+	movzx	b ## B,		%esi;\
+	mov     s1(%edi,%esi,4),%ebp;\
+	movzx	b ## H,		%esi;\
+	xor	s2(%edi,%esi,4),%ebp;\
+	ror	$16,		b ## D;\
+	movzx	b ## B,		%esi;\
+	xor	s3(%edi,%esi,4),%ebp;\
+	movzx	b ## H,		%esi;\
+	xor     s0(%edi,%esi,4),%ebp;\
+	ror	$15,		b ## D;\
+	push	%ebp;\
+	movzx	a ## B,		%esi;\
+	mov	s2(%edi,%esi,4),%ebp;\
+	movzx	a ## H,		%esi;\
+	xor     s3(%edi,%esi,4),%ebp;\
+	ror	$16,		a ## D;\
+	movzx	a ## B,		%esi;\
+	xor     s0(%edi,%esi,4),%ebp;\
+	movzx	a ## H,		%esi;\
+	xor     s1(%edi,%esi,4),%ebp;\
+	pop	%esi;\
+	add	%esi,		%ebp;\
+	add	%ebp,		%esi;\
+	add	k+round(%edi),	%ebp;\
+	add	k+4+round(%edi),%esi;\
+	xor	%ebp,		c ## D;\
+	xor	%esi,		d ## D

(Legalese: These code changes are in the public domain.  All of the code
modifications presented here are simply the straightforward execution
of the (uncopyrightable) ideas presented in the text, and therefore
not protectable.  The only "creative" portions are the comment, the use
of the variable names "c" and "d", and the choice of registers in the
32-bit code, for which copyright is abandoned.)


And even bigger hack would be to rearrange the context structure to
have the key first, then interleave the s0 and s1 boxes and use the
(%rdi,%r9,8) addressing mode to access them.  That would, if you
pre-offset %rdi a little bit so the key was at a negative offset,
allow you to use a byte-offset addressing mode on 6 of the 10 loads in
each round.  (Compared to 2 of 10 without.)

In fact, on x86_64, you could go to the extreme of dedicating a register
to point to the base of each of the S-boxes, so there is no displacement
byte in the opcode at all.  That has to help the I-cache and the
instruction decoders enough to pay for the additional setup instructions.
