Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285618AbSAEVnj>; Sat, 5 Jan 2002 16:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286222AbSAEVna>; Sat, 5 Jan 2002 16:43:30 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:19622 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S285618AbSAEVnL>; Sat, 5 Jan 2002 16:43:11 -0500
Date: Sat, 5 Jan 2002 21:42:57 +0000 (GMT)
From: "Joseph S. Myers" <jsm28@cam.ac.uk>
X-X-Sender: <jsm28@kern.srcf.societies.cam.ac.uk>
To: <jkl@miacid.net>
cc: Florian Weimer <fw@deneb.enyo.de>, <dewar@gnat.com>,
        <Dautrevaux@microprocess.com>, <paulus@samba.org>,
        <Franz.Sirl-kernel@lauterbach.com>, <benh@kernel.crashing.org>,
        <gcc@gcc.gnu.org>, <jtv@xs4all.nl>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.linuxppc.org>, <minyard@acm.org>, <rth@redhat.com>,
        <trini@kernel.crashing.org>, <velco@fadata.bg>
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <Pine.BSI.4.10.10201051150430.8542-100000@hevanet.com>
Message-ID: <Pine.LNX.4.33.0201052119080.10636-100000@kern.srcf.societies.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002 jkl@miacid.net wrote:

> I don't particularly like the interpretation stated in DR260, but that
> doesn't matter.  It still doesn't give the compiler permission to make
> something "undefined behavior" that the standard says is "implementation
> defined".  The standard says an arbitrary integer (arbitrary means there
> are no restrictions on how it was produced) can be converted to a pointer
> and that the implementation must define what the results of this are.
>   All DR260 is saying is that the compiler can do certain sorts of deep
> analysis on the code to decide whether my pointer is valid.  It doesn't
> apply to the case of casting to an integer, munging, then casting back
> because the the implementation is supposed to provide a rule for when
> such pointers are valid.

It says that a pointer is more than a sequence of bits, that the
provenance of a pointer determines whether it can be used to access an
object to which it points.  (This notion is already explicit in the
standard for "restrict" - which has various confusing issues when you go
beyond its intended purpose of making code, to do the sort of things done
in Fortran 77, as fast as in Fortran 77, see
<URL:http://www.cbau.freeserve.co.uk/RestrictPointers.html>.  Related are 
the exact meaning of "effective type" (see also the question about 
type-based aliasing rules in DR#236), and exactly how large the object 
that can be accessed through a pointer is (we know that in accesses to a 
multidimensional array, each index must be within its bounds, but there 
are other problems).  See Nick Maclaren's "What is an object?" discussion 
- WG14 reflector sequence 9350, but I don't think it's been more widely 
published.)

In the case of GCC, and casting integers to pointers, a rule has been
provided: the value of the pointer is determined by the bits, and the
provenance, determining what can be accessed, is derived from that of the
integer.  This works fine with uses such as masking off a few bits to get
a more aligned pointer, since there we are still accessing the original
object.  (I think the bounded pointers work also handles certain
cast-adjust-cast-back cases specially, to preserve the bounds when such
idioms are used rather than creating an unbounded pointer.)  Simply
documenting the bits of the pointer, and not what it can access, would not
be sufficient documentation of the results of the cast, but the
documentation describes both.

-- 
Joseph S. Myers
jsm28@cam.ac.uk

