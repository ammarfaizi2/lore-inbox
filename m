Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbULQBOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbULQBOV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 20:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbULQBOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 20:14:21 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:6542 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262699AbULQBOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 20:14:15 -0500
Subject: Re: [patch] [RFC] make WANT_PAGE_VIRTUAL a config option
From: Dave Hansen <haveblue@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       geert@linux-m68k.org, ralf@linux-mips.org,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.61.0412170150080.793@scrub.home>
References: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com>
	 <Pine.LNX.4.61.0412170133560.793@scrub.home>
	 <1103244171.13614.2525.camel@localhost>
	 <Pine.LNX.4.61.0412170150080.793@scrub.home>
Content-Type: text/plain
Message-Id: <1103246050.13614.2571.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 16 Dec 2004 17:14:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 16:51, Roman Zippel wrote:
> Could you explain a bit more, what exactly the problem is?

The symptom is that you'll add some new function to a header, say
mmzone.h.  You get some kind of compile error that a structure that you
need is not fully defined (usually because it is predeclared "struct
foo;").  This happens when you do either a structure dereference on a
pointer, or do some other kind of pointer arithmetic on it outside of a
macro.

Your first instinct is usually to go find where that structure is
declared and make sure that the header in which it's declared is
included in the header in which you're working.  Doing this gets rid of
your immediate problem, but usually causes another.  This is because
something in the other header needs something that's defined in the
header that *you're* working on, and needs the reverse order of
includes.

So, what always happens now is that someone just makes a #define.  Since
these aren't evaluated until they're actually used in the code, they get
put after all of the headers naturally and everything compiles.  

Here's a prime example of what you get from include/asm-i386/mmzone.h:

#define pfn_to_page(pfn)                                                \
({                                                                      \
        unsigned long __pfn = pfn;                                      \
        int __node  = pfn_to_nid(__pfn);                                \
        &node_mem_map(__node)[node_localnr(__pfn,__node)];              \
})

Not that this is horrible, but it sure does get annoying, and tends to
be more type-unsafe than your standard static inline.

What I want to do is make sure that, when you include a header, you get
what you need, and only what you need.  Doing this pervasively presents
the possibility of actually understanding the header dependencies, and
being able to avoid almost all of the hackery that goes along with
avoiding them when you *don't* fully understand.

Remember, *structures* can never have truly circular dependencies. I'm
just trying to start expressing that in the header layout.  

-- Dave

