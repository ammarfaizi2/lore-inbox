Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264750AbUGGABi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbUGGABi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 20:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUGGABi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 20:01:38 -0400
Received: from palrel12.hp.com ([156.153.255.237]:5320 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264750AbUGGABg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 20:01:36 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16619.15708.487344.93894@napali.hpl.hp.com>
Date: Tue, 6 Jul 2004 17:01:32 -0700
To: Jack Steiner <steiner@sgi.com>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce TLB flushing during process migration
In-Reply-To: <20040702173905.GA18884@sgi.com>
References: <20040623143844.GA15670@sgi.com>
	<20040623143318.07932255.akpm@osdl.org>
	<16605.1322.355489.223220@napali.hpl.hp.com>
	<20040702173905.GA18884@sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 2 Jul 2004 12:39:05 -0500, Jack Steiner <steiner@sgi.com> said:

  >> Also, my preference would be for tlb_migrate_finish() to be a true no-op
  >> (not a call to a no-op function) when compiling for a platform that
  >> doesn't need this hook.  Could you look into this?

  Jack> For platforms that dont define their own tlb_migrate_finish,
  Jack> it is defined as :

  Jack> #define tlb_migrate_finish(mm) do {} while (0)

  Jack> I'm not sure if I understood your point above. This is
  Jack> consistent with other noop definitions (at least some of them)
  Jack> & should not generate any code.

Well, then it's not a true no-op.  The other no-ops are all for
init-type stuff, so they're not at all performance critical.  Even
when compiling a non-generic kernel, those no-op functions will be
called.  This is really a limitation in the current machvec-scheme.  I
think what we need is a way to explicitly declare a no-op callback,
such that it can be optimized away completely for platforms that don't
need it.  Perhaps there could be something along the lines of:

#ifdef CONFIG_IA64_GENERIC
# define machvec_noop(noop_function)	noop_function
#else
# define machvec_noop(noop_function)	/* empty */
#endif

Then you could do:

# define platform_tlb_migrate_finish machvec_noop(machvec_mm_noop)

I _think_ this should work, provided that callbacks that expand into
true no-ops never have their address taken.

(This reminds me: in the no-op dummy routines in machvec.c should be
 named based on the type-signature they use, since it's possible to
 share no-op handlers for callbacks with the same type-signature; this
 is why I called the no-op machvec_mm_noop in the example above rather
 than machvec_tlb_migrate_finish as was the case in your patch).

	--david
