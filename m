Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbULQVvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbULQVvo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 16:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbULQVvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 16:51:43 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61574 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262175AbULQVsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 16:48:31 -0500
Subject: Re: [patch] [RFC] make WANT_PAGE_VIRTUAL a config option
From: Dave Hansen <haveblue@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       geert@linux-m68k.org, ralf@linux-mips.org,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.61.0412171818090.793@scrub.home>
References: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com>
	 <Pine.LNX.4.61.0412170133560.793@scrub.home>
	 <1103244171.13614.2525.camel@localhost>
	 <Pine.LNX.4.61.0412170150080.793@scrub.home>
	 <1103246050.13614.2571.camel@localhost>
	 <Pine.LNX.4.61.0412170256500.793@scrub.home>
	 <1103257482.13614.2817.camel@localhost>
	 <Pine.LNX.4.61.0412171132560.793@scrub.home>
	 <1103299179.13614.3551.camel@localhost>
	 <Pine.LNX.4.61.0412171818090.793@scrub.home>
Content-Type: text/plain
Message-Id: <1103320106.7864.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 17 Dec 2004 13:48:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here's my example:

Take include/asm-i386/mmzone.h and make pfn_to_page() a static inline

  CC      arch/i386/kernel/asm-offsets.s
In file included from include/linux/mmzone.h:389,
                 from include/linux/gfp.h:4,
                 from include/linux/slab.h:15,
                 from include/linux/percpu.h:4,
                 from include/linux/sched.h:34,
                 from arch/i386/kernel/asm-offsets.c:7:
include/asm/mmzone.h: In function `pfn_to_page':
include/asm/mmzone.h:109: arithmetic on pointer to an incomplete type
include/asm/mmzone.h:109: dereferencing pointer to incomplete type
include/asm/mmzone.h:110: warning: control reaches end of non-void function
You say, oh, it doesn't have a proper 'struct page' definition.  I had
better include the place where it is defined.  You go add
"#include <linux/mm.h>"
to the top of the file.  Compile again...

  CC      arch/i386/kernel/asm-offsets.s
In file included from include/asm/mmzone.h:10,
                 from include/linux/mmzone.h:389,
                 from include/linux/gfp.h:4,
                 from include/linux/slab.h:15,
                 from include/linux/percpu.h:4,
                 from include/linux/sched.h:34,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/mm.h: In function `page_zonenum':
include/linux/mm.h:417: `MAX_NODES_SHIFT' undeclared (first use in this function)
include/linux/mm.h:417: (Each undeclared identifier is reported only once
include/linux/mm.h:417: for each function it appears in.)
On Fri, 2004-12-17 at 12:27, Roman Zippel wrote: 
> On Fri, 17 Dec 2004, Dave Hansen wrote:
> > That said, it doesn't appear that asm/page.h is a header that causes any
> > real problems.  In any case, when there are variables that need to be
> > created based on Kconfig parameters, I believe the "correct" thing to do
> > is make a Kconfig variable.  But, that is a separate conversation. :)
> 
> Well, that's ok (but maybe give it a better name, e.g. 
> CONFIG_PAGE_VIRTUAL_PTR?)
That's fine.  I was just copying the current name for now, but I don't
have a real problem changing it.

> > > 2) Does every structure really needs its own header?
> > 
> > No.  But, I do think that most of the very basic VM structures do, as it
> > stands.  That's limited to struct page, zone, and pgdat as I see it
> > now.  
> 
> Why do you want to put these into separate headers?

It enables you do do static inlines accessing struct page members
anywhere you want, such as in asm/mmzone.h, like in my example. 

> These would be AFAICT 
> good candidates to pull into a single header. Via linux/gfp.h they are 
> all pulled into a lot of files, so it doesn't make sense to split them 
> because they may have different users.

They can still all be pulled in by the same original header.   I think
we're disconnecting a bit on this point.  

Making users of structures (driver writers, etc...) include 15 different
headers is silly.  But, I'm not really talking about those users, I'm
trying to fix the problems that people who write new *headers* are
running into.

> > One thing I'd like to point out is that I don't necessarily think that
> > the normal foo.c user should see any change.  They can still include
> > mmzone.h for the same stuff, but *inside* the headers, there's some more
> > organization.  Here's an example from a new header that I'm working on
> > after shifting the headers around.
> > 
> > #include <asm/page-consts.h>      /* for PAGE_SHIFT */
> > #include <asm/addr-convert.h>     /* for __pa() */
> > #include <linux/structpage.h>     /* for struct page */
> > #include <linux/sparse-consts.h>  /* for NR_MEM_SECTIONS... */
> > #include <linux/sparse-structs.h> /* for mem_section[] */
> 
> Why do you want to separate constants and structures?

In that code, there is a lot of intermingling between the different
constants.  The sparsemem code uses extra space in page->flags to store
some extra information.  So, it has dependencies on page-flags.h, as
well as the gfp masks.  These are used to define the sizes of structures
that are used for the pfn<->page, page<->zone, page<->nid, and
__{p,v}a() conversions.

These get really complicated, until you realize that all of the
constants have no dependencies other than linux/config.h and some other
really simple headers like types.h.

So, in effect, you do all of the constants' evaluation and *then* get to
move on to all of the structures.  Separating it out in different
headers makes it very explicit what is going on, and which constants are
needed for defining which operations.

> There only relatively few users of mmzone.h, so fixing them is easy and 
> the main problem with mmzone.h are the macros in asm/mmzone.h, which 
> should be pulled into a different header and the few remaining definitions 
> could be also merged with other definitions

I think you're right here.  Making mmzone.h a much simpler header with
fewer macros declared would help.

> (is there really a good 
> reason for a separate asm/numnodes.h or linux/numa.h?). 

I think linux/numa.h is the empty header for an architecture (or config
setup) that doesn't have NUMA.  So, it needs to be separate from the
asm/ files.  

> > The dependencies aren't very twisted at all.  In fact, I don't think any
> > of those are deeper than two.  More importantly, I never have to cope
> > with 'struct page;' keeping me from doing arithmetic. 
> 
> You may be surprised. :)
> Play around with "mkdir test; echo 'obj-y = test.o' > test/Makefile; echo 
> '#include <linux/foo.h>' > test/test.c; make test/test.i 
> CFLAGS_test.o=--trace-includes".

I'm not sure what you're getting at.

	make: *** No rule to make target `test/test.i'.  Stop.

> > I agree that I'm probably getting a bit carried away.  But, I don't
> > really see the harm in having both high-level headers and more finely
> > grained ones.  You could even think of the finely grained ones as
> > internal only.
> 
> Well, I don't really like lots of mini header files. I think it's more 
> important to collect related information and only strictly separate 
> between definitions and users, when a header gets to large we can still 
> split it.

Is the problem that I described above something that you think is at the
point where splitting is required?

-- Dave

