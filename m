Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTFJL5r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 07:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTFJL5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 07:57:46 -0400
Received: from holomorphy.com ([66.224.33.161]:58070 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262493AbTFJL5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 07:57:45 -0400
Date: Tue, 10 Jun 2003 05:11:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: pgcl-2.5.70-bk15-1
Message-ID: <20030610121124.GO20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The terrifying series of patches against pgcl-2.5.70-bk13-1 rediffed vs.
2.5.70-bk15. Attempts to utilize more than one piece of pages anonymized
via COW faults were merged.

Outstanding bugs will hopefully be fixed ASAP. But I figured, "Why be
grossly inefficiently buggy when one can merely be slightly less than
grossly inefficiently buggy?" The intra-vma PTE vectoring is far less
effective than one would suspect. Logs seem to indicate that with
PAGE_MMUCOUNT == 8 things average (rough estimate from watching logs)
around 3/8 ptes in a vector filled from within a single vma. This of
course means there's more complexity in the future, and we need to
actually run off and do the things we all knew would be needed from the
start (i.e. searching across vma's and pagetable pages), but that my
vague punting on the fault handlers' performance for a long stretch of
time may have inspired some false hope for avoiding.

It's also less of a step forward than one would suspect, since it's really
only an abstracting out of pieces of the fault handlers to prepare for
unifying the handling of faults that instantiate anonymous pages, and it
doesn't actually do much code sharing between the two apart from filling
in the pte vectors, which as one may have noticed was sorely lacking from
do_wp_page() and probably wasted at least 3 times as much RAM as this
ineffective method I've got going as an intermediate phase.

I chased down and fixed a memory stomper in reconstitute_ptes() in
pgcl-2.5.70-bk14-2. It added lots of debugging noise, which was later
removed in pgcl-2.5.70-bk14-3. The cleanup of debugging cruft was
separated out due to its size; shifting around that much code could
potentially destabilize things. And it did: the patches after
pgcl-2.5.70-bk14-2 were all badly generated, so things were painful
to merge and forward port and so on and so forth.

pgcl-2.5.70-bk14-4 removed buttloads of miscellaneous debugging crap
that's noisier than it should be. I also gave up and merged the sysenter
workaround since whatever I did to sysenter isn't going to get fixed in
a timely fashion.

As usual, available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/

-- wli
