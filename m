Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129301AbQKBTCD>; Thu, 2 Nov 2000 14:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129304AbQKBTBx>; Thu, 2 Nov 2000 14:01:53 -0500
Received: from ra.lineo.com ([204.246.147.10]:54434 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129301AbQKBTBj>;
	Thu, 2 Nov 2000 14:01:39 -0500
Message-ID: <3A01B8BB.A17FE178@Rikers.org>
Date: Thu, 02 Nov 2000 11:55:55 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <200011012345.PAA20284@pizda.ninka.net> <20001101172100.A5081@fsmlabs.com> <200011020011.QAA20585@pizda.ninka.net> <8tqcng$d8p$1@cesium.transmeta.com>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 11/02/2000
 12:01:36 PM,
	Serialize complete at 11/02/2000 12:01:36 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Alright, I've been lurking long enough on this thread. What say we
consider the option of building the kernel with a compiler other than
gcc? This would imply a slightly different structure to the makefiles
and code.

There are two immediate reasons I can come up with for this:

1. There are architectures where some other compiler may do better
optimizations than gcc. I will cite some examples here, no need to argue
out the point unless you disagree with the POSSIBILITY that this may be
true on at least one architecture. Anyway, possibilities include
Compaq's compiler on alpha, HP's compiler on hppa, Intel's compiler (or
rather plugins to another vendors compiler) on ia64, Metrowerk's
compiler on PPC, etc.

2. There are architectures where gcc is not yet available, but vendor C
compilers are.

I suggest that we avoid gcc extensions as much as possible, barring
performance hits. When there is an ANSI way of doing things we should
choose that route. Where there is not, then isolate the gcc way such
that compiler vendors can either:

1. implement the gcc way and conditional compile that code.

2. implement some other way and easily add that conditional code.

I've been looking into this here at Lineo for some of these vendors.
Here is a brief list of things I've come across:

1. C++ style comments

Occurs in over 4000 lines of source and header files. :-( Should be
converted to ansi c comments? We will probably want to just skirt this
issue for now as the next rev of ANSI C is likely to include ANSI C++
style comments.

2. Inline assembly statements

mostly in arch/ tree. Frequently used in macros as well. Much of this
will incur performance penalties if moved to external assembly files.
Some would require moving supported C code over as well. Hence many of
these will probably translate into conditional compilation based on the
compiler to avoid and performance hit for the mainstream case.

3. Declaring attributes of functions

The __attribute__ options: noreturn, const, format, section,
constructor, destructor, unused, and  weak. weak and section are needed.
The rest can be ignored? These might want to be converted to #defines
such that alternative compilers can implement them differently.

4. Specifying attributes of variables

The __attribute__ options: aligned, packed, section and weak. As above
these will likely be #defines to handle different compiler syntax.

5. Conditionals with omitted operands

The missing operands should just be added into the mainstream source.

6. Referring to a type with typeof

no recommendation yet.

7. Macros with variable numbers of arguments

no recommendation yet.

8. Inquiring on alignment of types or variables (__alignof__)

no recommendation yet.

Well, I got a bit more long winded than I planned, but there it is.
Thoughts?

"H. Peter Anvin" wrote:
> 
> Followup to:  <200011020011.QAA20585@pizda.ninka.net>
> By author:    "David S. Miller" <davem@redhat.com>
> In newsgroup: linux.dev.kernel
> >
> > We already know we are a bunch of pinheads wrt. the userland compiler
> > issue, full stop.  It need not be restated several hundred more times.
> > Believe me, after such a large fiasco, we have listened :-)
> >
> > But, on the other hand, to say that "kgcc" comceptually is something
> > only Red Hat has ever done is a factual error, that is all I am trying
> > to state, nothing more.
> >
> 
> I think at least supporting a "kgcc" compiler makes sense,
> conceptually (although it probably should have been called "kcc", but
> it's too late now.)
> 
> The kernel uses a lot of gcc extensions, and history shows that these
> extensions aren't as stable as the compiler system as a whole.
> 
>         -hpa
-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
