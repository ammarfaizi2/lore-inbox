Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267796AbUIOXdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267796AbUIOXdM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267779AbUIOXat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:30:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:47784 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267770AbUIOX0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:26:19 -0400
Date: Wed, 15 Sep 2004 16:26:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <roland@topspin.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more careful about iospace accesses..
In-Reply-To: <52zn3rupw8.fsf@topspin.com>
Message-ID: <Pine.LNX.4.58.0409151546400.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <52zn3rupw8.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Subject line changed to avoid getting caught as spam ;]

On Wed, 15 Sep 2004, Roland Dreier wrote:
>
> Linus, while we're on the subject of new sparse checks, could you give
> a quick recap of the semantics of the new __leXX types (and what
> __bitwise means to sparse)?  I don't think I've ever seen this stuff
> described on LKML.

[ The bitwise checks are actually by Al Viro, but I'll explain the basic
  idea. Al is Cc'd so that he can add any corrections or extensions. ]

Sparse allows a number of extra type qualifiers, including address spaces 
and various random extra restrictions on what you can do with them. There 
are "context" bits that allow you to use a symbol or type only in certain 
contexts, for example, and there are type qualifiers like "noderef" that 
just say that a pointer cannot be dereferenced (it looks _exactly_ like a 
pointer in all other respects, but trying to actually access anything 
through it will cause a sparse warning).

The "bitwise" attribute is very much like the "noderef" one, in that it
restricts how you can use an expression of that type. Unlike "noderef",
it's designed for integer types, though. In fact, sparse will refuse to
apply the bitwise attribute to non-integer types.

As the name suggests, a "bitwise" expression is one that is restricted to
only a certain "bitwise" operations that make sense within that class. In
particular, you can't mix a "bitwise" class with a normal integer
expression (the constant zero happens to be special, since it's "safe"  
for all bitwise ops), and in fact you can't even mix it with _another_
bitwise expression of a different type.

And when I say "different", I mean even _slightly_ different. Each typedef 
creates a type of it's own, and will thus create a bitwise type that is 
not compatible with anything else. So if you declare

	int __bitwise i;
	int __bitwise j;

the two variables "i" and "j" are _not_ compatible, simply because they
were declared separately, while in the case of

	int __bitwise i, j;

they _are_ compatible. The above is a horribly contrieved example, as it
shows an extreme case that doesn't make much sense, but it shows how
"bitwise" always creates its own new "class".

Normally you'd always use "__bitwise"  in a typedef, which effectively
makes that particular typedef one single "bitwise class". After that, you 
can obviously declare any number of variables in that class.

Now apart from the classes having to match, "bitwise" as it's name
suggests, also restricts all operations within that class to a subset of
"bit-safe" operations. For example, addition isn't "bit-safe", since
clearly the carry-chain moves bits around. But you can do normal bit-wise
operations, and you can compare the values against other values in the
same class, since those are all "bit-safe".

Oh, as an example of something that isn't obviously bit-safe: look out for
things like bit negation: doing a ~ is ok on an bitwise "int" type, but it
is _not_ ok on a bitwise "short" or "char". Why?  Because on a bitwise
"int" you actually stay within the type. But doing the same thing on a
short or char will move "outside" the type by virtue of setting the high
bits (normal C semantics: a short gets promoted to an "int", so doign a
bitwise negation on a short will actually set the high bits).

So as far as sparse is concerned, a "bitwise" type is not really so much 
about endianness as it is about making sure bits are never lost or moved 
around.

For example, you can use the bitwise operation to verify the __GFP_XXX 
mask bits. Right now they are just regular integers, which means that you 
can write

	kmalloc(GFP_KERNEL, size);

and the compiler will not notice anything wrong. But something is
_seriously_ wrong: the GFP_KERNEL should be the _second_ argument. If we
mark it to be a "bitwise" type (which it is), that bug would have been
noticed immediately, and you could still do all the operations that are
valid of GFP_xxx values.

See the usage?

In the byte-order case, what we have is:

	typedef __u16 __bitwise __le16;
	typedef __u16 __bitwise __be16;
	typedef __u32 __bitwise __le32;
	typedef __u32 __bitwise __be32;
	typedef __u64 __bitwise __le64;
	typedef __u64 __bitwise __be64;

and if you think about the above rules about what is acceptable for 
bitwise types, you'll likely immediately notivce that it automatically 
means

 - you can never assign a __le16 type to any other integer type or any 
   other bitwise type. You'd get a warnign about incompatible types. Makes 
   sense, no?
 - you can only do operations that are safe within that byte order. For 
   example, it is safe to do a bitwise "&" on two __le16 values. Clearly 
   the result is meaningful.
 - if you want to go outside that bitwise type, you have to convert it 
   properly first. For example, if you want to add a constant to a __le16 
   type, you can do so, but you have to use the proper sequence:

	__le16 sum, a, b;

	sum = a + b;	/* INVALID! "warning: incompatible types for operation (+)" */
	sum = cpu_to_le16(le16_to_cpu(a) + le16_to_cpu(b));	/* Ok */

See? 

In short, "bitwise" is about more than just byte-order, but the semantics 
of bitwise-restricted ops happen to be the semantics that are valid for 
byte-order operations too.

Oh, btw, right now you only get the warnings from sparse if you use
"-Wbitwise" on the command line. Without that, sparse will ignore the
bitwise attribute.

		Linus
