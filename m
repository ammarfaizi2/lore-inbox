Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318136AbSHIDsg>; Thu, 8 Aug 2002 23:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318140AbSHIDsg>; Thu, 8 Aug 2002 23:48:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25864 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318136AbSHIDsf> convert rfc822-to-8bit; Thu, 8 Aug 2002 23:48:35 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] [2.5] asm-generic/atomic.h and changes to arm, parisc,
	mips, m68k, sh, cris to use it
Date: 8 Aug 2002 20:52:01 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aive91$r53$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0208090018470.8911-100000@serv> <1028846417.1669.95.camel@ldb> <1028851871.28883.126.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g793q2j16188
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1028851871.28883.126.camel@irongate.swansea.linux.org.uk>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> On Thu, 2002-08-08 at 23:40, Luca Barbieri wrote:
> > > The compiler can cache the value in a register
> > It shouldn't since it is volatile and the machine has instructions with
> > memory operands.
> 
> I'm curious what part of C99 guarantees that it must generate
> 
> 	add 1 to memory
> 
> not
> 
> 	load memory
> 	add 1
> 	store memory
> 
> It certainly guarantees not to cache it for use next statement, but does
> it actually persuade the compiler to use direct operations on memory ?
> 
> I'm not a C99 language lawyer but genuinely curious
> 

C99 basically doesn't guarantee *anything* about "volatile", except
that it works as a keyword.  It really can't, since the C standard
doesn't have a model for either hardware I/O or multithreaded
execution, effectively the two cases for which "volatile" matters; the
exact wording in the standard is за6.7.3.6:

    An object that has volatile-qualified type may be modified in ways
    unknown to the implementation or have other unknown side
    effects. Therefore any expression referring to such an object
    shall be evaluated strictly according to the rules of the abstract
    machine, as described in 5.1.2.3. Furthermore, at every sequence
    point the value last stored in the object shall agree with that
    prescribed by the abstract machine, except as modified by the
    unknown factors mentioned previously.114) What constitutes an
    access to an object that has volatile-qualified type is
    implementation-defined.

114) A volatile declaration may be used to describe an object
     corresponding to a memory-mapped input/output port or an object
     accessed by an asynchronously interrupting function. Actions on
     objects so declared shall not be   optimized out   by an
     implementation or reordered except as permitted by the rules for
     evaluating expressions.

It therefore becomes a quality of implementation issue, assuming there
are instructions that do that.  Even so, it's iffy... should it
generate "lock incl" on x86, for example?

*In practice*, what can be safely assumed for a volatile object is
that:

a) A store to the volatile location will correspond to exactly one
   "store" hardware operations (note that multiple stores to the same
   object between sequence points are illegal in C);

b) If there is exactly one read reference to a volatile object between
   sequence points, it will correspond to exactly one "load" operation
   in hardware.  If there is are n read references to the same
   volatile objects between adjacent sequence points, it will
   correspond to some number m "load" operations such that 1 <= m <= n.

c) For either of these, if the volatile object is too large or has the
   wrong alignment to handle atomically in hardware, it will in effect
   be treated like some number of smaller atomic objects.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
