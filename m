Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317059AbSHBVSf>; Fri, 2 Aug 2002 17:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317078AbSHBVSe>; Fri, 2 Aug 2002 17:18:34 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:24333 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S317059AbSHBVSd>; Fri, 2 Aug 2002 17:18:33 -0400
Date: Fri, 2 Aug 2002 14:21:49 -0700
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Alexander Viro <viro@math.psu.edu>,
       Thunder from the hill <thunder@ngforever.de>,
       Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
Message-ID: <20020802212149.GC4528@bluemug.com>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Alexander Viro <viro@math.psu.edu>,
	Thunder from the hill <thunder@ngforever.de>,
	Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
	Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <20020802194701.GB4528@bluemug.com> <200208022049.g72KnHj453650@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208022049.g72KnHj453650@saturn.cs.uml.edu>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 04:49:17PM -0400, Albert D. Cahalan wrote:
> Mike Touloumtzis writes:
> > On Thu, Aug 01, 2002 at 05:24:37PM -0400, Albert D. Cahalan wrote:
> 
> >> There's just that little overflow problem to worry about,
> >
> > Ummm:
> >
> > -- stuff ASCII digits into u64 (or u32, or whatever)
> > -- if (still more digits)
> >    -- printk("partition too big to mount!\n")
> >    -- return error
> >
> > How hard is that?
> 
> I refer to overflowing the space allowed for your
> partition table. Programs will generate the data,
> then write it out. If the data gets too long, then
> you overwrite part of your first filesystem.
> Alternately, the partition table gets truncated
> at the maximum size -- with or without a '\0'.

Writing the partition table would still have to be done with
knowledge of its maximum size (i.e. the need to worry about
maximum partition table size wouldn't go away, just the need to
set a maximum size for every individual component in the table).

A program should write the ASCII representation into a buffer,
testing at that time for overflow.  I certainly wouldn't
recommend:

FILE *f = fopen("/dev/hda", "r+");
fprintf(f, "%u %u %u%c", foo, bar, baz, '\0');

:-)

> But sure, overflowing a u64 is also a problem.
> This will not be checked for. Either the u64 will
> get overflowed, or the parser will take what fits
> and then mis-interpret the remaining digits as
> a second number.

Are you advocating the use of stupid parsers?

> > Don't write garbage into your partition table.
> 
> I can see multiple ways for this to happen.
> Take the length of the new data, with or without
> the trailing '\0', and write it out. Write the
> whole partition table, including uninitialized
> data that happens to be in memory. (some other
> program will of course not ignore trailing garbage)

If programs writing the partition table know the amount of disk
allocated to the table they can zero-fill the rest (see above).

> >> encouragement of assumptions about the maximum size...
> >> is that a %d or a %llu or what?
> >
> > See above.  Use leading '-' for negative numbers.  ASCII has no
> > 2's complement ambiguity issues.
> 
> You've got to stuff it into something eventually,
> unless you want to implement ASCII math. Will you
> be using plain C, or C++ operator overloading?

I think you are seeing phantom problems where obvious solutions
exist.

Of course you have to stuff the values into native binary formats
eventually.  I'm just talking about on-disk representation,
not in-memory.

On output, you can use the biggest integer size the machine
supports, e.g. %llu, because you wouldn't be able to handle the
partition at all if it was just too big for your machine.  Or you
use bignums and something other than printf(3).  Your attempt
to smear this approach by illogically associating it with C++
operator overloading is ridiculous.

On input, if a value is too big to handle, you just
fprintf(stderr, "Partition too big, tough luck for you!\n");
Or, in the kernel, you refuse to mount it.

Or if you really want to handle big numbers, you use a bignum
package for fdisk.  It's not like there's a magic solution with
_current_ partition tables for handling numbers that are too big.
The current approach to this kind of problem in the kernel is
more or less:

-- Choose a structure which imposes a size limit for every value.
-- When _any_ of those limits overflows, switch to a whole new
   structure.  Implement new code branches, syscalls, etc. as
   needed to handle both old and new versions.

Frankly, that sucks.

> Yeah, just what we need. The /proc mess expanding
> into partition tables. That sounds like a great way
> to increase filesystem destruction performance.

The /proc mess exists because people chose N ad hoc output
formats for /proc files.  If they had a consistent format like
s-expressions or one-value-per-file most problems with /proc
would not exist.

I'm just putting my hope in the belief that sooner or later Al Viro
will realize that there's a lot more similarity between the Plan
9 and Lisp/Scheme approaches to simple, architecture-independent
representations than he thinks, and swoop in to clean up this
mess :-).

miket
