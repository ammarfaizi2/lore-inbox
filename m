Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWH2KFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWH2KFr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 06:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWH2KFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 06:05:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49824 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964886AbWH2KFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 06:05:46 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <44F395DE.10804@yahoo.com.au> 
References: <44F395DE.10804@yahoo.com.au>  <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: Why Semaphore Hardware-Dependent? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 11:05:27 +0100
Message-ID: <11861.1156845927@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> I wonder if we can just start with the nice powerpc code that uses
> atomic_add_return and cmpxchg (should use atomic_cmpxchg)

Because i386 (and x86_64) can do better by using XADDL/XADDQ.

The problem with CMPXCHG is that it might fail and you might have to attempt
it again.  This may be unlikely - it depends on the circumstances.  The same
applies to LL/ST equivalents.

On i386, CMPXCHG also ties you to what registers you may use for what to some
extent.  OTOH, whilst XADD does less so, the slowpath function does instead,
though with the XADD version, we can make sure that the semaphore address is
in EAX, something we can't do with CMPXCHG.

For those archs where CMPXCHG is the best available, a better algorithm than
the XADD based one is available, though I haven't submitted it.  I may still
have the patch somewhere.

However!  If what you have is LL/ST equivalents than emulating CMPXCHG to
emulate the XADD algorithm probably isn't the most optimal way either.  Don't
get stuck on using LL/ST to emulate what other CPUs have available.

> and chuck out the "crappy" rwsem fallback implementation,

CMPXCHG is not available on all archs, and may not be implemented on all archs
through other atomic instructions.

> as well as all the arch specific code?

Using CMPXCHG is only optimal where that's the best available.

David
