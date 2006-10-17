Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423037AbWJQEh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423037AbWJQEh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 00:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423036AbWJQEh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 00:37:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37591 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1423033AbWJQEh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 00:37:27 -0400
Date: Tue, 17 Oct 2006 05:37:26 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC] typechecking for get_unaligned/put_unaligned
Message-ID: <20061017043726.GG29920@ftp.linux.org.uk>
References: <20061017005025.GF29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 06:50:54PM -0700, Linus Torvalds wrote:

> > 	c) how about gradually switching to linux/unaligned.h?
> 
> I'd prefer not to, if only because it's an unnecessary compile-time 
> overhead for nice sane architectures like x86, which don't need any of the 
> unaligned crap.
> 
> Since x86[-64] is clearly the main architecture, dis-optimizing for that 
> one sounds like a bad idea.

Hrm...  I'm not sure that I buy that argument - we have relatively few
callers of these suckers and I doubt that it will affect compile time
in a measurable way.  FWIW, that reminds me - I ought to resurrect the
patchset killing bogus dependencies; I modified sparse to collect stats
on how many times each #include actually pulls a header during build,
added those to data on dependencies (from .cmd.*) and got interesting results.

There are several #includes with very high impact; the worst happens
to be module.h -> sched.h, followed by several includes of fs.h.  These
turned out to be easy to kill (i.e. few places actually needed compensatory
#include added) and that had seriously cut down on total dependencies.
The patches will need to be redone due to bitrot, but they are not
hard to reproduce.  The really interesting observation is that such
high-impact includes exist and can be found by this technics...

As for get_unaligned() and friends...  Dunno.  The thing is, most of
the targets have them with piss-poor type safety (e.g. asm-generic
put_unaligned() starts with casting val to __u64; there goes any chance
to get any useful warnings from cc(1) *and* we get fun warnings from
sparse every bloody time we use it on __be32, etc.).

I can fix those one by one, but I still think that it would be better
to keep the typechecking in one place...

PS: while a few hundreds of callers per allmodconfig build are minor noise
in compile time, the noise from a few hundreds of bogus warnings is
quite considerable ;-)
