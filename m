Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbUKPQob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbUKPQob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUKPQlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:41:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:24799 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262042AbUKPQlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:41:03 -0500
Date: Tue, 16 Nov 2004 08:40:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: fork pagesize patch 
In-Reply-To: <23880.1100621506@redhat.com>
Message-ID: <Pine.LNX.4.58.0411160834220.2222@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411160800060.2222@ppc970.osdl.org> 
 <20968.1100619491@redhat.com>  <23880.1100621506@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Nov 2004, David Howells wrote:
> 
> > > Please don't do that. What you've done causes a divide-by-zero error to be
> > > emitted by the compiler if PAGE_SIZE > THREAD_SIZE. That's why I used the
> > > preprocessor in the first place.
> > 
> > What kind of broken compiler are _you_ using? Fix your compiler.
> 
> Sorry... I meant warning not error. It doesn't actually stop it building a
> working kernel, but gcc _does_ complain, and not unreasonably, I think.

I think it _is_ unreasonable. It's like doing

	if (a)
		x /= a;

and the compiler complaining that "a" can be zero. The above is perfectly
reasonable code and may well have a constant zero as part of inlining or
macro expansion. A compiler that does that is being silly. It's being
_especially_ silly since it evaluates to

	if (0)
		..

at compile time in this case. Yeah, yeah, sparse gets it wrong too, but 
only if the left-hand side is zero as well.

But yes, at least the compiler isn't totally buggy if it's just a warning. 
After all, you can warn about anything you like ;)

Anyway, to make it not warn, why not change it to

	max_threads = mempages / (8*THREAD_SIZE/PAGE_SIZE);

instead, and be done with it? If the thread size is _that_ small that we 
still divide by zero, color me impressed.

		Linus
