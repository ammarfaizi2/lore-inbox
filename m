Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288930AbSAET1H>; Sat, 5 Jan 2002 14:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288929AbSAET05>; Sat, 5 Jan 2002 14:26:57 -0500
Received: from glisan.hevanet.com ([198.5.254.5]:2825 "EHLO glisan.hevanet.com")
	by vger.kernel.org with ESMTP id <S288934AbSAET0o>;
	Sat, 5 Jan 2002 14:26:44 -0500
Date: Sat, 5 Jan 2002 11:25:26 -0800 (PST)
From: jkl@miacid.net
To: "Joseph S. Myers" <jsm28@cam.ac.uk>
cc: Florian Weimer <fw@deneb.enyo.de>, dewar@gnat.com,
        Dautrevaux@microprocess.com, paulus@samba.org,
        Franz.Sirl-kernel@lauterbach.com, benh@kernel.crashing.org,
        gcc@gcc.gnu.org, jtv@xs4all.nl, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, minyard@acm.org, rth@redhat.com,
        trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <Pine.LNX.4.33.0201041132140.19767-100000@kern.srcf.societies.cam.ac.uk>
Message-ID: <Pine.BSI.4.10.10201051111100.8542-100000@hevanet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jan 2002, Joseph S. Myers wrote:

> 
> On Fri, 4 Jan 2002, Florian Weimer wrote:
> 
> > C99 includes a list of additional guarantees made by many C
> > implementations (in an informative index).  I think we really should
> > check this list (and the list of implementation-defined behavior) and
> > document the choices made by GCC.  In fact, this documentation is
> > required by the standard.
> 
> The list of implementation-defined behavior is already in the manual (in
> extend.texi).  However, the actual documentation isn't yet there, only the
> headings - except for the preprocessor, where it is covered in cpp.texi,
> and the conversion between pointers and integers:
> 
> @item
> @cite{The result of converting a pointer to an integer or
> vice versa (6.3.2.3).}
> 
> A cast from pointer to integer discards most-significant bits if the
> pointer representation is larger than the integer type,
> sign-extends@footnote{Future versions of GCC may zero-extend, or use
> a target-defined @code{ptr_extend} pattern.  Do not rely on sign extension.}
> if the pointer representation is smaller than the integer type, otherwise
> the bits are unchanged.
> @c ??? We've always claimed that pointers were unsigned entities.
> @c Shouldn't we therefore be doing zero-extension?  If so, the bug
> @c is in convert_to_integer, where we call type_for_size and request
> @c a signed integral type.  On the other hand, it might be most useful
> @c for the target if we extend according to POINTERS_EXTEND_UNSIGNED.
> 
> A cast from integer to pointer discards most-significant bits if the
> pointer representation is smaller than the integer type, extends according
> to the signedness of the integer type if the pointer representation
> is larger than the integer type, otherwise the bits are unchanged.
> 
> When casting from pointer to integer and back again, the resulting
> pointer must reference the same object as the original pointer, otherwise
> the behavior is undefined.  That is, one may not use integer arithmetic to
> avoid the undefined behavior of pointer arithmetic as proscribed in 6.5.6/8.
>

Wat this last bit added to the standard after ANSI/ISO 9899-1990?  I'm
looking through my copy and I can't find it.  All I can find is that 

in 6.3.6 Additive Operators

When an expression that has integral type is added to or subtracted from a
pointer [...] Unless both the pointer operand and the result point to
elements of the same array object [...] the behavior is undefined...

but

in 6.3.4 Cast operators

A pointer may be converted to an integral type.  The size of the integer
required and the result are implementation-defined. [...]

An arbitrary integer may be converted to a pointer.  
   ^^^^^^^^^
The result is implementation defined.

	I interpret this to mean that one MAY use integer arithmatic to
do move a pointer outside the bounds of an array.  Specifically, as soon
as I've cast the pointer to an integer, the compiler has an obligation to
forget any assumptions it makes about that pointer.  This is what casts
from pointer to integer are for!  when i say (int)p I'm saying that I
understand the address structure of the machine and I want to manipulate
the address directly.

	If the satandard has changed so this is no longer possible, there
NEEDS to be some other way in the new standard to express the same
concept, or large application domains where C is currently in use will
stop working.  

-JKL


