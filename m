Return-Path: <linux-kernel-owner+w=401wt.eu-S1751577AbXAQCeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbXAQCeU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 21:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbXAQCeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 21:34:20 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36359 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbXAQCeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 21:34:19 -0500
Date: Tue, 16 Jan 2007 18:34:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: menage@google.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, pj@sgi.com, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
Message-Id: <20070116183406.ed777440.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701161709490.4455@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	<20070116135325.3441f62b.akpm@osdl.org>
	<Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
	<20070116154054.e655f75c.akpm@osdl.org>
	<Pine.LNX.4.64.0701161602480.4263@schroedinger.engr.sgi.com>
	<20070116170734.947264f2.akpm@osdl.org>
	<Pine.LNX.4.64.0701161709490.4455@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 16 Jan 2007 17:30:26 -0800 (PST) Christoph Lameter <clameter@sgi.com> wrote:
> > Nope.  You've completely omitted the little fact that we'll do writeback in
> > the offending zone off the LRU.  Slower, maybe.  But it should work and the
> > system should recover.  If it's not doing that (it isn't) then we should
> > fix it rather than avoiding it (by punting writeback over to pdflush).
> 
> pdflush is not running *at* all nor is dirty throttling working. That is 
> correct behavior? We could do background writeback but we choose not to do 
> so? Instead we wait until we hit reclaim and then block (well it seems 
> that we do not block the blocking there also fails since we again check 
> global ratios)?

I agree that it is a worthy objective to be able to constrain a cpuset's
dirty memory levels.  But as a performance optimisation and NOT as a
correctness fix.

Consider: non-exclusive cpuset A consists of mems 0-15, non-exclusive
cpuset B consists of mems 0-3.  A task running in cpuset A can freely dirty
all of cpuset B's memory.  A task running in cpuset B gets oomkilled.

Consider: a 32-node machine has nodes 0-3 full of dirty memory.  I create a
cpuset containing nodes 0-2 and start using it.  I get oomkilled.

There may be other scenarios.


IOW, we have a correctness problem, and we have a probable,
not-yet-demonstrated-and-quantified performance problem.  Fixing the latter
(in the proposed fashion) will *not* fix the former.

So what I suggest we do is to fix the NFS bug, then move on to considering
the performance problems.



On reflection, I agree that your proposed changes are sensible-looking for
addressing the probable, not-yet-demonstrated-and-quantified performance
problem.  The per-inode (should be per-address_space, maybe it is?) node
map is unfortunate.  Need to think about that a bit more.  For a start, it
should be dynamically allocated (from a new, purpose-created slab cache):
most in-core inodes don't have any dirty pages and don't need this
additional storage.

Also, I worry about the worst-case performance of that linear search across
the inodes.

But this is unrelated to the NFS bug ;)

