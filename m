Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbULQU1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbULQU1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 15:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbULQU1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 15:27:33 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:9655 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262151AbULQU10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 15:27:26 -0500
Date: Fri, 17 Dec 2004 21:27:10 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       geert@linux-m68k.org, ralf@linux-mips.org,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [patch] [RFC] make WANT_PAGE_VIRTUAL a config option
In-Reply-To: <1103299179.13614.3551.camel@localhost>
Message-ID: <Pine.LNX.4.61.0412171818090.793@scrub.home>
References: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com> 
 <Pine.LNX.4.61.0412170133560.793@scrub.home>  <1103244171.13614.2525.camel@localhost>
  <Pine.LNX.4.61.0412170150080.793@scrub.home>  <1103246050.13614.2571.camel@localhost>
  <Pine.LNX.4.61.0412170256500.793@scrub.home>  <1103257482.13614.2817.camel@localhost>
  <Pine.LNX.4.61.0412171132560.793@scrub.home> <1103299179.13614.3551.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 17 Dec 2004, Dave Hansen wrote:

> That said, it doesn't appear that asm/page.h is a header that causes any
> real problems.  In any case, when there are variables that need to be
> created based on Kconfig parameters, I believe the "correct" thing to do
> is make a Kconfig variable.  But, that is a separate conversation. :)

Well, that's ok (but maybe give it a better name, e.g. 
CONFIG_PAGE_VIRTUAL_PTR?)

> > 2) Does every structure really needs its own header?
> 
> No.  But, I do think that most of the very basic VM structures do, as it
> stands.  That's limited to struct page, zone, and pgdat as I see it
> now.  

Why do you want to put these into separate headers? These would be AFAICT 
good candidates to pull into a single header. Via linux/gfp.h they are 
all pulled into a lot of files, so it doesn't make sense to split them 
because they may have different users.

> One thing I'd like to point out is that I don't necessarily think that
> the normal foo.c user should see any change.  They can still include
> mmzone.h for the same stuff, but *inside* the headers, there's some more
> organization.  Here's an example from a new header that I'm working on
> after shifting the headers around.
> 
> #include <asm/page-consts.h>      /* for PAGE_SHIFT */
> #include <asm/addr-convert.h>     /* for __pa() */
> #include <linux/structpage.h>     /* for struct page */
> #include <linux/sparse-consts.h>  /* for NR_MEM_SECTIONS... */
> #include <linux/sparse-structs.h> /* for mem_section[] */

Why do you want to separate constants and structures?
There only relatively few users of mmzone.h, so fixing them is easy and 
the main problem with mmzone.h are the macros in asm/mmzone.h, which 
should be pulled into a different header and the few remaining definitions 
could be also merged with other definitions (is there really a good 
reason for a separate asm/numnodes.h or linux/numa.h?). 

> The dependencies aren't very twisted at all.  In fact, I don't think any
> of those are deeper than two.  More importantly, I never have to cope
> with 'struct page;' keeping me from doing arithmetic. 

You may be surprised. :)
Play around with "mkdir test; echo 'obj-y = test.o' > test/Makefile; echo 
'#include <linux/foo.h>' > test/test.c; make test/test.i 
CFLAGS_test.o=--trace-includes".

> I agree that I'm probably getting a bit carried away.  But, I don't
> really see the harm in having both high-level headers and more finely
> grained ones.  You could even think of the finely grained ones as
> internal only.

Well, I don't really like lots of mini header files. I think it's more 
important to collect related information and only strictly separate 
between definitions and users, when a header gets to large we can still 
split it.

bye, Roman
