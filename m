Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbRCXJuB>; Sat, 24 Mar 2001 04:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131627AbRCXJtv>; Sat, 24 Mar 2001 04:49:51 -0500
Received: from unthought.net ([212.97.129.24]:44163 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S131626AbRCXJtb>;
	Sat, 24 Mar 2001 04:49:31 -0500
Date: Sat, 24 Mar 2001 10:48:49 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Kevin Buhr <buhr@stat.wisc.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Serge Orlov <sorlov@con.mcst.ru>,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
Message-ID: <20010324104849.B9686@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Kevin Buhr <buhr@stat.wisc.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Serge Orlov <sorlov@con.mcst.ru>, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com> <vba1yrr7w9v.fsf@mozart.stat.wisc.edu> <15032.1585.623431.370770@pizda.ninka.net> <vbay9ty50zi.fsf@mozart.stat.wisc.edu> <vbaelvp3bos.fsf@mozart.stat.wisc.edu> <20010322193549.D6690@unthought.net> <vbawv9hyuj0.fsf@mozart.stat.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <vbawv9hyuj0.fsf@mozart.stat.wisc.edu>; from buhr@stat.wisc.edu on Thu, Mar 22, 2001 at 10:32:51PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 10:32:51PM -0600, Kevin Buhr wrote:
> Jakob Østergaard <jakob@unthought.net> writes:
> >
> > Try compiling something like Qt/KDE/gtk-- which are really heavy on
> > templates (with all the benefits and drawbacks of that).
> 
> Okay, I just compiled gtk-- 1.0.3 (with CFLAGS = "-O2 -g") under three
> versions of GCC (Debian 2.95.3, RedHat 2.96, and a CVS pull of the
> "gcc-3_0-branch") on the same Debian machine running kernel 2.4.2.

It's important that you use at least -O3 to get inlining too.

> 
> In all cases, the "cc1plus" processes appeared to max out around 25M
> total size.  The "maps" pseudofiles for the 2.95.3 and and 3.0
> compiles never grew past 250 lines, but the "maps" pseudofiles for the
> RedHat 2.96 compile were gigantic, jumping to 3000 or 5000 lines at
> times.

25 MB doesn't count  ;)

> 
> The results speak for themselves:
> 
>     CVS gcc 3.0:          Debian gcc 2.95.3:   RedHat gcc 2.96:
>                       
>     real    16m8.423s     real    8m2.417s     real    12m24.939s
>     user    15m23.710s    user    7m22.200s    user    10m14.420s
>     sys     0m48.730s     sys     0m41.040s    sys     2m13.910s 
> maps:    <250 lines           <250 lines          >3000 lines
> 
> Obviously, the *real* problem is RedHat GCC 2.96.  If Linus bothers to
> write this patch (he probably already has), its only proven benefit so
> far is that it improves the performance of a RedHat-specific, orphaned
> G++ development snapshot that everyone (the people of RedHat most of
> all) will be glad to be rid of as soon as possible.

No, map merging is obviously a good idea if it can be done at little cost.
There has to be other cases out there than GCC 2.96 (which is still the
best damn C++ compiler to ship on any GNU/Linux distribution in history)

As someone else already pointed out GCC-3.0 will improve it's allocation,
but it *still* allocates many maps - less than before, but still potentially
lots...

> 
> The numbers above suggest that the patch is unlikely to have a
> positive impact on the performance of either officially released GCC
> versions or the upcoming 3.0 release.

It will still have the 70x performance increase on kernel memory map
handling as demonstrated in my benchmark just posted.  However, it will
be 70x of much less than with 2.96.

Granted, the impact will be much smaller on GCC-3.0 in terms of wall clock
ticks, but I bet there is some other code out there that also triggers the
map-nightmare.

> 
> Drifting off topic...

We can continue on /.  ;)

> 
> > Mozilla uses C++ mainly as "extended C" - due to compatibility concerns.
> 
> This statement is potentially misleading.
> 
> I think most people will believe you to mean "using C++ as a better C"
> in the sense of Stroustrup: using the small, conventional-language
> subset of C++ that looks like C but has stronger type checking,
> function and operator overloading, default arguments, "//" style
> comments, reference types, and other syntactic and semantic sugar.

Yes

> 
> Mozilla does not use C++ as "extended C" in this sense.  While it does
> use a *subset* of C++ for compatibility reasons, the subset includes
> extensive use of class lattices and polymorphism as well as extensive
> (albeit simple and carefully constructed) uses of templates for its
> utility classes, including string and component-autoreferencing
> template classes and functions that are used throughout the source.
> The only major C++ facilities that are not used are the standard
> library, RTTI, namespaces, and exception handling, but other than that
> it's a good, real-world C++ test case.

Ok - I just read the coding guidelines for Mozilla, that's where I got
my information from...  In general (except for the exceptions I guess),
rule number one is "Don't use templates". Rule 5 is "Don't use the namespace
facility". Rule 16 is "Don't put constructors in header files".   All
stuff that leads to much much shorter symbols (type names) and less code
inlining - something that makes the job a lot easier for GCC.

Putting template classes and functions in header files with heavy inlining
is something that makes GCC memory usage explode.  I managed to write a
few hundred lines once I couldn't compile because GCC couldn't allocate
more than 800-900 MB (old glibc and GCC).   The code was badly designed
and easily fixed, but it demonstrated this feature in GCC nicely.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
