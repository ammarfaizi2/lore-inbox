Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbUCIAIr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 19:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbUCIAIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 19:08:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:50629 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261413AbUCIAIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 19:08:45 -0500
Date: Mon, 8 Mar 2004 16:10:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in
 <=16G machines)
Message-Id: <20040308161046.04270108.akpm@osdl.org>
In-Reply-To: <20040308234014.GG12612@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random>
	<Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org>
	<20040308132305.3c35e90a.akpm@osdl.org>
	<20040308230247.GC12612@dualathlon.random>
	<20040308152126.54f4f681.akpm@osdl.org>
	<20040308234014.GG12612@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > btw, mincore() has always been broken with nonlinear vma's.  If you could
> > fix that up some time using that pagetable walker it would be nice.  It's
> > not very important though.
> 
> Ok! I'm still late at this though, I wish I would be working on the
> nonlinear stuff by now ;), I'm still stuck at the anon_vma_chain...

As I say, broken mincore() on nonlinear mappings isn't a showstopper ;)

> If I understand well, vmtruncate will also need the pagetable walker to
> nuke all mappings of the last pages of the files before we free them
> from the pagecache. So it should be a library call that mincore can use
> too then, I don't see problems.

If we want to bother with the traditional truncate-causes-SIGBUS semantics
on nonlinear mappings, yes.  I guess it would be best to do that if
possible.

> 
> btw (for completeness), about the cpu consumption concerns about objrmap
> w.r.t. security (that was Ingo's only argument against objrmap),
> whatever malicious waste of cpu that could happen during paging, can be
> already triggered in any kernel out there by using truncate on the same
> mappings instead of swapping them out.

Yes, malicious apps can DoS the machine in many ways.  I'm more concerned
about non-malicious ones getting hurt by the new search activity.  Say, a
single-threaded app which uses a huge number of vma's to map discontiguous
parts of a file.  The 2.4-style virtual scan would handle that OK, and the
2.6-style pte_chain walk would handle it OK too.  People do weird things.

(objrmap could perhaps terminate the vma walk after it sees the page->count
fall to a value which means there are no more pte's mapping the page - that
would halve the search cost on average).
