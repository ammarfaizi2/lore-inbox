Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTDVOkj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTDVOkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:40:39 -0400
Received: from mail-5.tiscali.it ([195.130.225.151]:11709 "EHLO
	mail-5.tiscali.it") by vger.kernel.org with ESMTP id S263171AbTDVOki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:40:38 -0400
Date: Tue, 22 Apr 2003 16:52:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@redhat.com>,
       Andrew Morton <akpm@digeo.com>, mbligh@aracnet.com, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030422145208.GI23320@dualathlon.random>
References: <20030405143138.27003289.akpm@digeo.com> <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.com> <20030422123719.GH23320@dualathlon.random> <20030422132013.GF8931@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422132013.GF8931@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 06:20:13AM -0700, William Lee Irwin III wrote:
> On Tue, Apr 22, 2003 at 07:00:05AM -0400, Ingo Molnar wrote:
> >> If the O(N^2) can be optimized away then i'm all for it. If not, then i
> >> dont really understand how the same people who call sys_remap_file_pages()
> >> a 'hack' [i believe they are not understanding the current state of the
> 
> On Tue, Apr 22, 2003 at 02:37:19PM +0200, Andrea Arcangeli wrote:
> > it's an hack primarly because you're mixing linear with non linear,
> > incidentally that as well breaks truncate. In the current state truncate
> > is malfunctioning. To make truncate working in the current state you
> > would need to check all pages->indexes for every page pointed by the
> > pagetables belonging to each vma linked in the objrmap.
> > I don't think anybody wants to slowdown truncate like that (I mean, with
> > partial truncates and huge vmas).
> > Fixing it so truncate works still at a the current speed (when you don't
> > use sys_remap_file_pages) means changing the API to be sane and at the
> > very least to stop mixing linaer with nonlinaer vmas.
> 
> The truncate() issues are a relatively major outstanding issue in -mm,
> and IIRC hugh was the first to raise them.

yes.

> On Tue, Apr 22, 2003 at 02:37:19PM +0200, Andrea Arcangeli wrote:
> > I'm not against making mmap faster or whatever, but sys_remap_file_pages
> > makes sense to me only as a VM bypass, something that will always be
> > faster than the regular mmap or whatever by bypassing the VM. If you
> > don't bypass the VM you should make mmap run as fast as
> > sys_remap_file_pages instead IMHO.
> 
> Well, AFAICT the question wrt. sys_remap_file_pages() is not speed, but
> space. Speeding up mmap() is of course worthy of merging given the
> usual mergeability criteria.

I completely agree. The major cost is the mangling of the pagetables
that makes the ~32G case worthwhile only with largepages (better drop
some ram and use largepages than add more ram w/o largepages). I just
fixed my tree to allow up to 64G in largepages in a single file because
16G was a too low limit now. So sys_remap_file_pages should provide few
performance advantages, and its main benefit is in avoiding all the ram
waste with the vmas (and the rmap waste if rmap is used in the VM) which
contraddicts the "generic" usage with VM knowledge that may add overhead
(I mean the partial object over the remap-file-pages).

If we can get sys_remap_file_pages running at zero space overhead with
vm knowledge that's ok, but at least from my part I much prefer being
able to mix multiple files in the same mmap(VM_NONLINEAR) than to have
vm knowledge on the VM bypass.

Andrea
