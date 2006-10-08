Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751840AbWJHA3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWJHA3L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 20:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWJHA3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 20:29:11 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:31216 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751840AbWJHA3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 20:29:10 -0400
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       tim.c.chen@linux.intel.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
In-Reply-To: <20061004102812.5f3b22d2.akpm@osdl.org>
References: <B41635854730A14CA71C92B36EC22AAC3F3FAD@mssmsx411>
	 <20061004102812.5f3b22d2.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 20:28:47 -0400
Message-Id: <1160267327.2368.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 10:28 -0700, Andrew Morton wrote:
> On Wed, 4 Oct 2006 20:57:57 +0400
> "Ananiev, Leonid I" <leonid.i.ananiev@intel.com> wrote:
> 
> > >Guys.  Please.  Help us out here.  None of this makes sense, and it's
> > > possible that we have an underlying problem in there which we need to
> > know
> > > about.
> >  This is explantion:
> > 
> > The static variable __warn_once was "never" read (until there is no bug)
> > before patch "Let WARN_ON/WARN_ON_ONCE return the condition"
> > http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
> > t;h=684f978347deb42d180373ac4c427f82ef963171
> >  in WARN_ON_ONCE's line 
> > - if (unlikely((condition) && __warn_once)) { \
> > because 'condition' is false. There was no cache miss as a result.
> > 
> > Cache miss for __warn_once is happened in new lines
> > + if (likely(__warn_once)) \
> > + if (WARN_ON(__ret_warn_once)) \
> > 
> 
> That's one cache miss.  One.  For the remainder of the benchmark,
> __warn_once is in cache and there are no more misses.  That's how caches
> work ;)
> 
> But it appears this isn't happening.  Why?

day-ja-vu!

Andrew, this discussion came up back when Ingo and Arjan introduced
WARN_ON_ONCE. Well, not exactly.  I'm sorry, but I missed what was wrong
with the current way of doing WARN_ON_ONCE?

Anyway, what's the advantage of testing a variable that is most likely
will be true, and that you will need to test the condition *anyway*.
Even if the __warn_once is in cache, it may be pushing something out of
a register, to read the variable and test it. And after all that we test
the condition too, with no savings.

Is this patch to get rid of the int ret=0?  Doesn't the compiler
optimize that out?

Here's my comment when I sent the patch to change the original:

  if (unlikely(__warn_once && (condition)))

to 

  if (unlikely((condition) && __warn_once)))

http://marc.theaimsgroup.com/?l=linux-kernel&m=114935833125957&w=2

That was different, since we were putting a likely condition in an
unlikely(). But I still don't see why we would ever want to test
__warn_once before the condition, since it doesn't save on anything and
just adds extra work.  I don't see the savings.

-- Steve

