Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131974AbRCYDSk>; Sat, 24 Mar 2001 22:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131976AbRCYDSb>; Sat, 24 Mar 2001 22:18:31 -0500
Received: from unthought.net ([212.97.129.24]:48779 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S131974AbRCYDSU>;
	Sat, 24 Mar 2001 22:18:20 -0500
Date: Sun, 25 Mar 2001 05:17:38 +0200
From: Jakob Østergaard <jakob@unthought.net>
To: Kevin Buhr <buhr@stat.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
Message-ID: <20010325051738.A11943@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Kevin Buhr <buhr@stat.wisc.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com> <vba1yrr7w9v.fsf@mozart.stat.wisc.edu> <15032.1585.623431.370770@pizda.ninka.net> <vbay9ty50zi.fsf@mozart.stat.wisc.edu> <vbaelvp3bos.fsf@mozart.stat.wisc.edu> <20010322193549.D6690@unthought.net> <vbawv9hyuj0.fsf@mozart.stat.wisc.edu> <20010324104849.B9686@unthought.net> <vbabsqrvt6o.fsf@mozart.stat.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <vbabsqrvt6o.fsf@mozart.stat.wisc.edu>; from buhr@stat.wisc.edu on Sat, Mar 24, 2001 at 01:54:39PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2001 at 01:54:39PM -0600, Kevin Buhr wrote:
> Jakob Østergaard <jakob@unthought.net> writes:
> > 
> > It's important that you use at least -O3 to get inlining too.
> [ . . . ]
> > 25 MB doesn't count  ;)
> 
> Aggh!  I feel like I'm in a comedy sketch.  You tell me "do that".  
> I do that.  You tell me, "you should try this instead", so I do this.
> Then, you tell me, "but you should really do the other."

I'm sorry, I was wrong about gtk-- being hairy enough, and I should have
apologized earler.

> 
> You're the one who suggested "gtk--" as a test case.  Built out of the
> box, it uses "-O2".  If there were magical settings or sekret
> incantations, I wish you'd mentioned them when you suggested it.

Yes, yes.  I guess even Qt won't do the trick either. I know at least one of
the KDE packages will, it uses Qt and if you set compilation options to -O6 it
will grow to ~100MB.

A few years ago when I compiled Mico, that one would make GCC chew up a few
hundred megs as well, if compilation options were set to use heavy
optimization.

But never mind about C++ test cases now...

> 
> > No, map merging is obviously a good idea if it can be done at little cost.
> > There has to be other cases out there than GCC 2.96 (which is still the
> > best damn C++ compiler to ship on any GNU/Linux distribution in history)
> 
> If something has a cost, even a little cost, and no one can find a
> benefit, then implementing it is not "obviously" a good idea.  That's
> why Linus asked for a real-world example before he spent time
> complicating the algorithms and adding checks that incur a cost for
> every process, even those that won't get any benefit.

I just felt that many other parts of the kernel try hard to make it as
inexpensive as possible to use kernel functionality, and that the VM naturally
should do the same (to a reasonable extent, of course, as with the other
layers).

For example, if I use thousands of TCP connections, the network layer folks
have been working hard to ensure that I can actually do that with good
performance.

It would feel "wrong" - I think - if the VM had this special rule that "you can
use MMAP, but if you do it a lot the kernel becomes horribly inefficient".
Especially because it was just proved that such behaviour could be completely
eliminated without a big performance overhead on other more simpler users of
the VM.

It's just my oppinion - of course - but I think it's very nice that under Linux
you can actually use the system calls to do lots of neat tricks (such as the
GCC mmap one, or having a thousand TCP connnections open), without being
penalized too heavily.  Using lots of system calls is not necessarily always
bad design.

> 
> > As someone else already pointed out GCC-3.0 will improve it's allocation,
> > but it *still* allocates many maps - less than before, but still potentially
> > lots...
> 
> Yes.  Zach's explanation is the first thing I've seen that makes a
> case for some benefit (besides babysitting GCC 2.96) without
> conflicting with the data I'm getting.

But the bad case was a garbage collector in GCC.  The mmap tricks seem like
some you may be inclined to actually use in something like garbage collectors.
Are we sure that the developers of all other garbage collectors out there
foresaw this problem and didn't do mmap tricks ?

When running the Haskell interpreter "Hugs", I see lots of lines like this from
strace:
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
But I don't have any "big" haskell codes, so I don't know if Haskell does actually
exhibit the gcc-2.96 pattern too...

Maybe some Haskell / ML / Java folks could comment further on this ?

> 
> As I've noted elsewhere, I see no change at all in system time for GCC
> 3.0 between 2.4.2 and 2.4.3-pre7.  Given Zach's explanation, I'm
> prepared to believe there might be a difference with, say, a 500meg
> arena (or perhaps something as small as a 100meg arena).
> 
> > It will still have the 70x performance increase on kernel memory map
> > handling as demonstrated in my benchmark just posted.  However, it will
> > be 70x of much less than with 2.96.
> 
> For my test cases under 3.0, it looks like 70 times zero.  However,
> I'm now prepared to believe that it could be 70 times something
> non-zero for certain very hairy source files.

Or maybe 70x something large for some case we just don't know about yet ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
