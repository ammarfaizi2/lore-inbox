Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264646AbUDVUb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264646AbUDVUb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264657AbUDVUb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:31:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22202 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264646AbUDVUbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:31:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       arjanv@redhat.com, Dave Jones <davej@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, viro@parcelfarce.linux.theplanet.co.uk,
       bfennema@falcon.csc.calpoly.edu
Subject: Re: Fix UDF-FS potentially dereferencing null
References: <20040416214104.GT20937@redhat.com>
	<Pine.LNX.4.58.0404161720450.3947@ppc970.osdl.org>
	<1082195458.4691.1.camel@laptop.fenrus.com>
	<200404171313.02784.ioe-lkml@rameria.de>
	<Pine.LNX.4.58.0404171009320.3947@ppc970.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 22 Apr 2004 17:29:42 -0300
In-Reply-To: <Pine.LNX.4.58.0404171009320.3947@ppc970.osdl.org>
Message-ID: <or3c6vhi2x.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 17, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> On Sat, 17 Apr 2004, Ingo Oeser wrote:
>> 
>> Or even call the attribute "nonnull", because this is a very obvious
>> naming, even to non-native English readers.

> I did that at first, but decided that what I really wanted was "safe".

> "nonnull" is nice for avoiding the NULL check, but it's useless for 
> anything else.

> "safe" to my mind means that not only is it not NULL, it's also safe to 
> dereference early (ie "prefetchable"), which has a lot of meaning for the 
> back-end.

And how far back can this go?

Consider, for example:

inline int foo(int *safe p) {
  return *p;
}

int bar(int *p) {
  if (p)
    return foo(p);
  return -1;
}

I suppose you'd like a compiler to remember the point at which the
pointer became safe, and avoid prefetching it before the test.  So
it's not exactly total freedom to reschedule the load.

Still, this sounds like something that might be useful, especially on
platforms that don't support (non-trapping) prefetching.

GCC's nonnull attribute is indeed useless for these purposes.  Even
though the docs say it could be used to optimize away a NULL test, its
syntax is far too cumbersome, since you apply the nonnull attribute to
the function, not to its argument, which makes it unusable for
non-argument variables.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
