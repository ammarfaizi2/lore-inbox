Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSHBWJi>; Fri, 2 Aug 2002 18:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSHBWJi>; Fri, 2 Aug 2002 18:09:38 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:47884 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S313087AbSHBWJg>;
	Fri, 2 Aug 2002 18:09:36 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208022212.g72MCsu456903@saturn.cs.uml.edu>
Subject: Re: 2.5.28 and partitions
To: miket@bluemug.com (Mike Touloumtzis)
Date: Fri, 2 Aug 2002 18:12:54 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
       viro@math.psu.edu (Alexander Viro),
       thunder@ngforever.de (Thunder from the hill),
       peter@chubb.wattle.id.au (Peter Chubb), pavel@ucw.cz (Pavel Machek),
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020802212149.GC4528@bluemug.com> from "Mike Touloumtzis" at Aug 02, 2002 02:21:49 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Touloumtzis writes:
> On Fri, Aug 02, 2002 at 04:49:17PM -0400, Albert D. Cahalan wrote:
>> Mike Touloumtzis writes:
>>> On Thu, Aug 01, 2002 at 05:24:37PM -0400, Albert D. Cahalan wrote:

>>>> There's just that little overflow problem to worry about,
>>>
>>> Ummm:
>>>
>>> -- stuff ASCII digits into u64 (or u32, or whatever)
>>> -- if (still more digits)
>>>    -- printk("partition too big to mount!\n")
>>>    -- return error
>>>
>>> How hard is that?
>>
>> I refer to overflowing the space allowed for your
>> partition table. Programs will generate the data,
>> then write it out. If the data gets too long, then
>> you overwrite part of your first filesystem.
>> Alternately, the partition table gets truncated
>> at the maximum size -- with or without a '\0'.
>
> Writing the partition table would still have to be done with
> knowledge of its maximum size (i.e. the need to worry about
> maximum partition table size wouldn't go away, just the need to
> set a maximum size for every individual component in the table).
>
> A program should write the ASCII representation into a buffer,
> testing at that time for overflow.  I certainly wouldn't
> recommend:
>
> FILE *f = fopen("/dev/hda", "r+");
> fprintf(f, "%u %u %u%c", foo, bar, baz, '\0');
>
> :-)

The above, and worse, will be used. Face reality.
Now, what problem were you trying to solve?
The data all ends up as binary data types anyway,
so you're not escaping any limitations. You're
just hiding them, and letting stuff break when
the limitations get hit.

>> But sure, overflowing a u64 is also a problem.
>> This will not be checked for. Either the u64 will
>> get overflowed, or the parser will take what fits
>> and then mis-interpret the remaining digits as
>> a second number.
>
> Are you advocating the use of stupid parsers?

I'm telling you that this isn't your ideal world.
Stupid parsers are damn common.

BTW, many text data formats don't deserve anything
better anyway, because the format itself is ill-defined.

Prime example: /proc/cpuinfo
See also: /proc/*/status SigCgt/SigCat name change

>>> Don't write garbage into your partition table.
>>
>> I can see multiple ways for this to happen.
>> Take the length of the new data, with or without
>> the trailing '\0', and write it out. Write the
>> whole partition table, including uninitialized
>> data that happens to be in memory. (some other
>> program will of course not ignore trailing garbage)
>
> If programs writing the partition table know the amount of disk
> allocated to the table they can zero-fill the rest (see above).

Yeah, they could do that. Many will not. Reality again...
Using ASCII is just asking for bugs. It's begging and
pleading for bugs, especially when you really do have to
fit this variable-size data into a fixed-size space.

>>>> encouragement of assumptions about the maximum size...
>>>> is that a %d or a %llu or what?
>>>
>>> See above.  Use leading '-' for negative numbers.  ASCII has no
>>> 2's complement ambiguity issues.
>>
>> You've got to stuff it into something eventually,
>> unless you want to implement ASCII math. Will you
>> be using plain C, or C++ operator overloading?
>
> I think you are seeing phantom problems where obvious solutions
> exist.
>
> Of course you have to stuff the values into native binary formats
> eventually.  I'm just talking about on-disk representation,
> not in-memory.

Ah, but it has to get into memory at some point.
There it will need a data type. Changing the data
type involves changing the parser and inventing
yet another in-memory struct anyway.

> On output, you can use the biggest integer size the machine
> supports, e.g. %llu, because you wouldn't be able to handle the
> partition at all if it was just too big for your machine.  Or you
> use bignums and something other than printf(3).  Your attempt
> to smear this approach by illogically associating it with C++
> operator overloading is ridiculous.

I was being kind. I could have mentioned LISP or Scheme.
Oddly, you volunteered them already yourself!

Fine, no operator overloading:

err = ascii_math_make_number(baz, 512); // baz = 512
if(err){
  // handle error here
}
err = ascii_math_add(foo, bar, baz); // foo = bar + baz
if(err){
  // handle error here
}
// ...
// blah, blah
// ...
err = ascii_math_free(baz); // don't forget to free memory
if(err){
  // handle error here
}

> On input, if a value is too big to handle, you just
> fprintf(stderr, "Partition too big, tough luck for you!\n");
> Or, in the kernel, you refuse to mount it.

With a 32-bit binary field, programs will use 32-bit types.
With a 64-bit binary field, programs will use 64-bit types.
With an ASCII format, every program will use a different type.

> Or if you really want to handle big numbers, you use a bignum
> package for fdisk.  It's not like there's a magic solution with
> _current_ partition tables for handling numbers that are too big.
> The current approach to this kind of problem in the kernel is
> more or less:
>
> -- Choose a structure which imposes a size limit for every value.
> -- When _any_ of those limits overflows, switch to a whole new
>    structure.  Implement new code branches, syscalls, etc. as
>    needed to handle both old and new versions.
>
> Frankly, that sucks.

It does, a bit, but it sure beats hidden per-program
limits caused by every program converting the ASCII
to a different in-memory structure.

>> Yeah, just what we need. The /proc mess expanding
>> into partition tables. That sounds like a great way
>> to increase filesystem destruction performance.
>
> The /proc mess exists because people chose N ad hoc output
> formats for /proc files.  If they had a consistent format like
> s-expressions or one-value-per-file most problems with /proc
> would not exist.

That only solves a superficial problem. It doesn't let
you reliably handle changing data types and keywords.

> I'm just putting my hope in the belief that sooner or later Al Viro
> will realize that there's a lot more similarity between the Plan
> 9 and Lisp/Scheme approaches to simple, architecture-independent
> representations than he thinks, and swoop in to clean up this
> mess :-).

I'm hoping he'll realize the similarity and back away in horror.

