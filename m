Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUCLNnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 08:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUCLNnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 08:43:25 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:43270 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262106AbUCLNnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 08:43:22 -0500
Date: Fri, 12 Mar 2004 13:43:23 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040312122127.GQ30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403121309000.4898-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for pointing us to your (last night's) patches, Andrea.

On Fri, 12 Mar 2004, Andrea Arcangeli wrote:
> On Thu, Mar 11, 2004 at 10:28:42PM -0500, Rik van Riel wrote:
> 
> It's not that I didn't read anonmm patches from Hugh, I spent lots of
> time on those, they just were flawed and they couldn't handle mremap,
> he very well knows, see anobjrmap-5 for istance.

Flawed in what way?  They handled mremap fine, but yes, used pte_chains
for that extraordinary case, just as pte_chains were used for nonlinear.
With pte_chains gone (hurrah! though nonlinear handling yet to come),
as you know, I've already suggested a better way to handle that case
(use tmpfs-style backing object).

> the vma merging isn't a problem, we need to rework the code anyways to
> allow the file merging in both mprotect and mremap (currently only mmap
> is capable of merging files, and in turn it's also the only one capable
> of merging anon_vmas). Any merging code that is currently capable of
> merging files is easy to teach about anon_vmas too, it's basically the
> same problem at merging.

You're paying too much attention to the (almost optional, though it can
have a devastating effect on vma usage, yes) issue of vma merging, but
what about the (mandatory) vma splitting?  I see no sign of the tiresome
code I said you'd need for anonvma rather than anonmm, walking the pages
updating as.vma whenever vma changes e.g. when mprotecting or munmapping
some pages in the middle of a vma.  Surely move_vma_start is not enough?

That's what led me to choose anonmm, which seems a lot simpler: the real
argument for anonvma is that it saves a find_vma per pte in try_to_unmap
(page_referenced doesn't need it): a good saving, but is it worth the
complication of the faster paths?

Hugh

