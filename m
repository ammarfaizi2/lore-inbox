Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSHBWub>; Fri, 2 Aug 2002 18:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSHBWub>; Fri, 2 Aug 2002 18:50:31 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:54797 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S316541AbSHBWua>; Fri, 2 Aug 2002 18:50:30 -0400
Date: Fri, 2 Aug 2002 15:53:47 -0700
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Alexander Viro <viro@math.psu.edu>,
       Thunder from the hill <thunder@ngforever.de>,
       Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
Message-ID: <20020802225347.GI4116@bluemug.com>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Alexander Viro <viro@math.psu.edu>,
	Thunder from the hill <thunder@ngforever.de>,
	Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
	Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <20020802212149.GC4528@bluemug.com> <200208022212.g72MCsu456903@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208022212.g72MCsu456903@saturn.cs.uml.edu>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 06:12:54PM -0400, Albert D. Cahalan wrote:
>
> > Of course you have to stuff the values into native binary formats
> > eventually.  I'm just talking about on-disk representation,
> > not in-memory.
> 
> Ah, but it has to get into memory at some point.
> There it will need a data type. Changing the data
> type involves changing the parser and inventing
> yet another in-memory struct anyway.

Right, but if each of your in-memory structs is localized to the
kernel (i.e. not present in the partition table, and not exported
to userspace via /proc or syscalls), then you can just increase
field sizes and recompile the kernel, without the need to support
both structure layouts in the kernel in perpetuity.

For efficiency reasons the kernel will always need to export
structs to userspace but partition information probably shouldn't
get a performance exemption.

> Fine, no operator overloading:
> 
> err = ascii_math_make_number(baz, 512); // baz = 512
> if(err){
>   // handle error here
> }
> err = ascii_math_add(foo, bar, baz); // foo = bar + baz
> if(err){
>   // handle error here
> }

Yes, this is more or less what a bignum package would implement,
albeit with a much more efficient representation that ASCII
strings.  But actually manipulating values in bignum format
should be left to utilities like fdisk that want to be generic.
The kernel and boot loaders would just load values into 'u32
a' and 'u32 b' (or whatever type) and add them with 'a + b'.
I'm not in any way advocating bignum arithmetic in the kernel.

> With a 32-bit binary field, programs will use 32-bit types.
> With a 64-bit binary field, programs will use 64-bit types.
> With an ASCII format, every program will use a different type.

Right, which would allow intelligence on the part of the programs,
like using 32-bit types on 32-bit architectures where values are
known to max out at 32-bits (I'm thinking of, say, /proc here)
and 64-bit values on 64-bit architectures.

> It does, a bit, but it sure beats hidden per-program
> limits caused by every program converting the ASCII
> to a different in-memory structure.

So create a library and flame people who don't link against it
and screw up their parsing.  At least this way only some programs
would have hidden limits, not all of them.

> >> Yeah, just what we need. The /proc mess expanding
> >> into partition tables. That sounds like a great way
> >> to increase filesystem destruction performance.
> >
> > The /proc mess exists because people chose N ad hoc output
> > formats for /proc files.  If they had a consistent format like
> > s-expressions or one-value-per-file most problems with /proc
> > would not exist.
> 
> That only solves a superficial problem. It doesn't let
> you reliably handle changing data types and keywords.

s-expressions do--the first value in each parenthesized expression
is the keyword.  For instance, if you have the tree:

/proc
    /sys
        /net
            /ipsec
                /inbound_policy_check (== 1)
            /ipv4
                /icmp_echo_ignore_all (== 0)
                /icmp_echo_ignore_broadcasts (== 0)

Via, say, a magic 'cat /proc/serialize', you could view this as:

(sys (net (ipsec (inbound_policy_check 1)
          (ipv4 (icmp_echo_ignore_all 0)
                (icmp_echo_ignore_broadcasts 0)))))

without the pretty-printing, of course.  Likewise you could
cat /proc/sys/serialize to see just that subtree.

All this information is available already in the kernel and
'parsing' the resulting s-expressions is mostly a matter of
counting parenthesis nesting depth, matching keywords, and doing
ASCII->numeric conversions.

I'm not religious about s-expressions but they do solve this
problem fairly well.  People who are religiously anti-LISP should
pretend I used { } in the above.

Of course this all relies on a one-value-per-file /proc, which is
regrettably not the case now; that's why I chose /proc/sys for
the above example.

miket
