Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSFJHFw>; Mon, 10 Jun 2002 03:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSFJHFv>; Mon, 10 Jun 2002 03:05:51 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:37780 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S316712AbSFJHFu>;
	Mon, 10 Jun 2002 03:05:50 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200206100705.AAA19208@csl.Stanford.EDU>
Subject: Re: [CHECKER] 54 missing null pointer checks in 2.4.17
To: adilger@clusterfs.com (Andreas Dilger)
Date: Mon, 10 Jun 2002 00:05:48 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <20020610063510.GG20388@turbolinux.com> from "Andreas Dilger" at Jun 10, 2002 12:35:10 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, but the checker is still (subtly) wrong in this case.  The difference
> is that "jbd_kmalloc()" (a macro calling __jbd_kmalloc in the 5 functions
> which check the return code) depends on the "journal_oom_retry" variable
> to determine whether or not it is "allowed" to return NULL.  In contrast,
> the one call to "jbd_rep_kmalloc()" flagged above is a macro which
> calls __jbd_kmalloc() with "retry = 1" so it is never allowed to fail
> and return NULL.

Ah.  Got it.  Yeah, we're not doing much inter-procedural false path
pruning.  Hopefully within a month or so --- Andy Chou and Yichen Xie
are building an analysis pass that uses a SAT solver to suppress such
things.  It discovers some pretty crazy relationships and is actually
pretty fast.

> in most cases the checker is correct.  

To be fair, it's the checker + our inspection that is mostly correct
;-) Though the uninspected false pos rate is pretty low.

> Have you thought about supporting
> "checker meta comments" (like lint did) to allow one to flag a piece of
> code as being "correct" for a certain check so that it doesn't always
> show up on your test runs?

I wasn't that optimistic that people would be willing to annotate their
code.  It is pretty easy to add such annotations with distinguished
function calls.  E.g.,
	/* shut up checker null pointer warnings */
	mc_no_null_bug(p);
where p is a pointer var --- it can be #define'd to nothing when the
checker isn't being used.  Also, the checker can turn the annot into
a sort of checkable comment by warning when the annotation is not
needed.

Instead we use a history-based approach: both false positives and bugs
are stuffed into a file which subsequent runs use to relabel messages
as old false positives or unfixed bugs.  The messages are canonicalized
so that most source edits don't make them invalid.  E.g., we keep file,
function, variable names and such but strip line numbers and other
things.  The advantage is that you don't have to modify your source for
checkers to go over it.  Which is good, given the current patch
process.

If you're interested, there are a bunch of papers on this and other things
at
	www.stanford.edu/~engler

Thanks for your feedback!
Dawson
