Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262503AbSJAUNs>; Tue, 1 Oct 2002 16:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262505AbSJAUNs>; Tue, 1 Oct 2002 16:13:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12484 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262503AbSJAUNq>;
	Tue, 1 Oct 2002 16:13:46 -0400
Date: Tue, 1 Oct 2002 22:29:02 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
Message-ID: <Pine.LNX.4.44.0210012219460.21087-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Oct 2002, Linus Torvalds wrote:

> > the attached (compressed) patch is the next iteration of the workqueue
> > abstraction. There are two major categories of changes:
> 
> Pease don't introduce more typedefs. They only hide what the hell the
> thing is, which is actively _bad_ for structures, since passing a
> structure by value etc is something that should never be done, for
> example.
>
> The few saved characters of typing do not actually _buy_ you anything
> else, and only obscures what the thing is.
> 
> Also, it's against the Linux coding standard, which does not like adding
> magic single-letter suffixes to things - that also is the case for your
> strange "_s" suffix for a structure (the real suffix is "_struct").

yes i agree that it's bad in the current context of Linux, mainly because
the use of typedefs is inconsistent - the search-and-replace of work_t,
cpu_workqueue_t and workqueue_t is what needs to happen, i'm not arguing
about that - and the real discussion ends here.

-------------------------------------------------------------------------
but, at the danger of getting into another religious discussion.

Despite all the previous fuss about the problems of typedefs, i've never
had *any* problem with using typedefs in various code i wrote. It only
ever made things cleaner - to me. I had no problems with supposed
declaration limitations of typedefs or anything either. I in fact consider
it a feature that an unclean hiearchy of include files cannot be plastered
with typedef predeclarations.

what issue remains is purely the compactness and effectivity of the source
code representation. It confuses the human eye (at least mine) to see
'struct ' all over again. (In fact 'unsigned int' is confusing as well, so
i tend to use 'int' wherever possible safely.)

*If* the consistent convention were to use the _t postfix for complex
'derived' types, it would create more compact and more readable kernel
code. Why does it have to be:

 static inline void __list_add(struct list_head *new,
                               struct list_head *prev,
                               struct list_head *next);

why not a simple:

 static inline void __list_add(list_t *new, list_t prev, list_t *new);

perhaps it's because i dont use syntax highlighting, where the 'struct'
keyword sticks out and is not nearly as confusing as in an all-grey
display of the source code.

> Remember: typing out something is not bad. It's _especially_ not bad if
> the typing makes it more clear what the thing is.

I think writing out stuff makes sense only as long as it carries real,
important and unique information that triggers the proper association in
the human brain, without using up too much cognitive power (which is
needed for other stuff like writing code).

and in fact i believe that *not* writing out stuff that does nto matter is
just as important, to increase the signal-to-noise ratio of the visible
code area. I often find myself wondering about variable names and function
names, trying to make them shorter, without them losing any of their
expressive value.

and typing out 'struct ' all the time, i believe, often hides the real
information.

Real information such as a field _name_, or a type _name_, is the
essential stuff. All the rest, like paranthesis or commas are important
glue that needs to be as minimal and as expressive as possible - and it's
very rare that a 7-character construct carries any powerful meaning. In
fact i strongly believe that 'struct ' does not deserve the space it takes
- the fact that the type is 'complex' needs to be 'glued' upon the name,
it should not contaminate the name itself. Sure, we need to know what the
type is, but more so do we need to know *which* specific type it is.

I think everyone agrees that screen real estate (which is what the brain
also sees at once) must be used sparingly, and essential information must
be preserved. The most common abstractions need abbreviations (as long as
they do not limit understandability) - eg. a comma or paranthesis is an
essential tool - basically every other symbol is used up as well. I cant
see where the problem is with using _t postfixes to mark abstract
sub-types - everywhere.

i've done a quick experiment, every .h and .c file from the 2.5.40 kernel
in a single file:

 -rw-rw-r--    1 mingo    mingo    133851995 Oct  1 21:55 all-struct.c

and the same file, but this time all 165636 occurances of 'struct '
replaced with '_t':

 -rw-rw-r--    1 mingo    mingo    132819955 Oct  1 21:57 all-t.c

this shaves off almost 1% from the source code size. It might not look
significant, but i think it is a significant reduction in screen real
estate usage. For more complex pieces of code it can be more significant
than this average number - easily 5% or more.

sure, there is the problem of pte_t and kdev_t, which we want to deal with
as integer-alike basic types, but they are an order less important and
less frequent than complex types, so we might as well rename pte_t and use
another convention there.

and i found the _t convention especially useful in cases where there's
complex code, which wants to be split up into multiple inline functions.  
And i believe once a function declaration becomes multiline it quickly
loses its efficiency.

> I've done a global search-and-replace on the patch. The resulting patch
> is actually _cleaner_, because it also matches more closely the old code
> (which used "struct tq_struct"), so things like tabbed comment alignment
> etc tend to be more correct (not always, but closer).

now what sense on earth does the duplication of 'struct' in 'struct
tq_struct' make? I very well know it's a 'struct' upon the first reading
of it.

Source code has precisely the same kind of very subtle, finegrained and
interwoven usability problems as desktop applications. I agree that
consistency is more important than having the absolute best rules, but i
do not buy 'struct tq_struct' over 'work_t'.

if we have to go with the 'struct' convention then rather 'struct work'
and 'struct workqueue' and 'struct cpu_workqueue'. (neither of them
collides with any other symbol in the existing namespace.)

This is perhaps one of the few areas where FreeBSD 'looks' a bit cleaner
than Linux. [at places where their code does not drown in #ifdefs that is
- everyone has their own set of problems.]

There _is_ a sort of Huffman code possible for source code as well (at
least for the common constructs), and one of the successes of C was that
it is 'concept-compact' above all. After all this is one reason that moved
people away from 'GOSUB B' to 'b();'.

C is still an inconsitent and limited language if compared with some of
the other highlevel languages, but it is compact and thus uses a minimum
of 'in-brain instruction cache'. I can see a parallel between the success
of C and the success of the x86 instruction set here ...

but, i'm trying to argue about taste, which is admittedly not an exact
science. :)

btw., usability was one of the main reasons why i thought alot about
changing to the word 'task' to 'work' or not. The 'wq' abbreviation has
the problem that it's kindof already used for the 'waitqueue' concept.  
But the 'task' word is already taken as well, and i thought it's more
correct to have the type name right than to have an absolutely unique
typical variable name. (But it's not a clear winner so i might be wrong.)

	Ingo


