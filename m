Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbUAFVGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 16:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbUAFVGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 16:06:23 -0500
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:16775
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S265334AbUAFVGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 16:06:21 -0500
To: torvalds@osdl.org
Cc: rth@redhat.com, davidm@mostang.com, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
References: <16PqK-8eK-1@gated-at.bofh.it> <16RiU-2kO-1@gated-at.bofh.it> <16S5h-3no-5@gated-at.bofh.it>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: 06 Jan 2004 13:06:19 -0800
In-Reply-To: <16S5h-3no-5@gated-at.bofh.it>
Message-ID: <ug3casyegk.fsf@panda.mostang.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 26 Dec 2003 05:50:07 +0100, Linus Torvalds <torvalds@osdl.org> said:
  Linus> The cast/conditional expression as lvalue are _particularly_
  Linus> ugly extensions, since there is absolutely zero point to
  Linus> them.

I'd love to agree with that...

  Linus> They are very much against what C is all about, and writing
  Linus> something like this:

  Linus> 	a ? b : c = d;

  Linus> is something that only a high-level language person could
  Linus> have come up with. The _real_ way to do this in C is to just
  Linus> do

  Linus> 	*(a ? &b : &c) = d;

  Linus> which is portable C, does the same thing, and has no strange
  Linus> semantics.

This works provided you can take the address of the lvalue, which
ain't true for bitfields.  Example:

 #define bit_field(var, bit, width) \
	(((struct { long : bit; long _f : width; } *) &(var))->_f)

 long l;

 bit_field(l, 0, 4) = 13;
 bit_field(l, 8, 12) = 42;

I wish I was making this up, but I know of at least one legacy app
where disabling GCC's ability to treat statement-expressions as
l-values will cause a major headache.

I'd love to know a way of doing this in ANSI C99 without requiring
changes to to uses of this kind of (atrocious) macro...

	--david

--
David Mosberger; 35706 Runckel Lane; Fremont, CA 94536; David.Mosberger@acm.org
