Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265028AbTFMCCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 22:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbTFMCCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 22:02:54 -0400
Received: from palrel12.hp.com ([156.153.255.237]:10156 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265028AbTFMCCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 22:02:53 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16105.13317.608868.581471@napali.hpl.hp.com>
Date: Thu, 12 Jun 2003 19:16:37 -0700
To: Roland McGrath <roland@redhat.com>
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: FIXMAP-related change to mm/memory.c
In-Reply-To: <200306130207.h5D27eH22519@magilla.sf.frob.com>
References: <200306130124.h5D1O2DT025311@napali.hpl.hp.com>
	<200306130207.h5D27eH22519@magilla.sf.frob.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 12 Jun 2003 19:07:40 -0700, Roland McGrath <roland@redhat.com> said:

  Roland> The pte_user predicate was added just for this purpose.  It
  Roland> seems reasonable to me to replace its use with a new pair of
  Roland> predicates, pte_user_read and pte_user_write, whose meaning
  Roland> is clearly specified for precisely this purpose.  That is,
  Roland> those predicates check whether a user process should be
  Roland> allowed to read/write the page via something like ptrace.

  Roland> That's the obvious idea to me.  But I have no special
  Roland> opinions about this stuff myself.  The current code is as it
  Roland> is because that's what Linus wanted.

I considered a pte_user_read()/pte_user_write()-like approach, but
rejected it.  First of all, it doesn't really help with execute-only
pages.  Of course, we could add a pte_user_exec() and treat those
pages as readable, but that's not a good solution: just because we
want to make the gate page readable via ptrace() doesn't mean that we
want _all_ execute-only pages to be readable (it wouldn't make a
difference today, but I'm worried about someone adding other
execute-only pages further down the road, not being aware that
ptrace() would cause a potential security problem).

For ia64, I think we really want to say: if it's accessing the gate
page, allow reads.  There is just no way we can infer that from
looking at the PTE itself.

Is there really a point in allowing other FIXMAP pages to be read via
ptrace() on x86?

	--david
