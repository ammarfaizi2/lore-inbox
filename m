Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271414AbTHMHLF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 03:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271420AbTHMHLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 03:11:05 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:56069
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S271414AbTHMHLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 03:11:03 -0400
Subject: Re: [PATCH] revert zap_other_threads breakage, disallow
	CLONE_THREAD without CLONE_DETACHED
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Matt Wilson <msw@redhat.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
In-Reply-To: <200308120752.h7C7qQT20085@magilla.sf.frob.com>
References: <200308120752.h7C7qQT20085@magilla.sf.frob.com>
Content-Type: text/plain
Message-Id: <1060758660.18727.17.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 13 Aug 2003 00:11:00 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-12 at 00:52, Roland McGrath wrote:
> Please apply this patch to get us back out of this useless quagmire and
> disallow the problematic case that noone wants to try to use any more.

It seems to me there's a couple of problems with this patch:

One is that it prevents any single piece of code using
clone(CLONE_THREAD) from working on both 2.4 and 2.6.  While clone() is
mostly hidden under libpthread.so, there are some applications which use
it directly for various good reasons.  I've implemented two versions of
my clone/wait stuff in Valgrind to cope with this, but not everyone will
have yet.  Perhaps I'm the only person in the world to use CLONE_THREAD,
but it seems unlikely.  After all, clone() is a public interface.

The other reason is that this seems to be covering over an actual
conceptual problem rather than fixing it.  I can't say I really
understand this piece of the kernel (which isn't too surprising that it
is very complicated because it represents 30 years of Unix history
packed into a dense mass), but one niggling concern I have is that even
when you're using CLONE_DETACHED, if you've attached with ptrace(), you
effectively become a parent who can wait on the detached clone.  If you
can wait via ptrace, then doesn't it mean that all the wait-related
problems are still visible?  I've tried to reproduce some of the
problems I've been seeing with non-detached threads in the case where
they are detached traced threads, but so far it seems OK.  But that may
be because I haven't hit it properly yet.

I guess my concern is that I'm not convinced we really understand what's
going wrong here, and so I'm not convinced that this patch really fixes
things.

	J

