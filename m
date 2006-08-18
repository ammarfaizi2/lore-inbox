Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWHRHHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWHRHHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 03:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWHRHHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 03:07:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50828 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750781AbWHRHHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 03:07:24 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 18 Aug 2006 17:07:16 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17637.26404.554243.202503@cse.unsw.edu.au>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
 writeback.
In-Reply-To: message from Andrew Morton on Thursday August 17
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<20060815230050.GB51703024@melbourne.sgi.com>
	<17635.60378.733953.956807@cse.unsw.edu.au>
	<20060816231448.cc71fde7.akpm@osdl.org>
	<20060818001102.GW51703024@melbourne.sgi.com>
	<20060817232942.c35b1371.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 17, akpm@osdl.org wrote:
> 
> btw, Neil, has the Pagewriteback windup actually been demonstrated?  If so,
> how?

Yes.
On large machines (e.g. 16G) just writing to large files (I think.  I
don't have precise details of the application, but I think in one case
it was just iozone).  By "large files" I mean larger than memory.

This has happened on both SLES9 (2.6.5 based) and SLES10 (2.6.16
based).  We do have an extra patch in balance_dirty_pages which I
haven't tracked down the reason for yet.  It has the effect of
breaking out of the loop once nr_dirty hits 0, which makes the problem
hard to recover from.  It may even be making it occur more quickly -
I'm not sure.

What we see is Pagewriteback at about 10G out of 16G, and Dirty at 0.
The whole machine pretty much slows to a halt.  There is little free
memory so lots of processes end up in 'reclaim' walking the inactive
list looking for pages to free up.  Most of what they find are in
Writeback and so they just skip over them.  skipping 2.6 million pages
seems to take a little while.

And there is a kmalloc call in the NFS writeout path (it is actually a
mempool_alloc so it will succeed, but (partly) as mempool uses the
reserve last instead of first it always looks for free memory first.

So Pagewriteback is at 60%, memory is tight, nfs write is progressing
very slowly and (because of our SuSE specific patch)
balance_dirty_pages isn't throttling anymore so as soon as nfs does
manage to write out a page another appears to replace it.  I suspect
it is making forward progress, but not very much.

We have a fairly hackish patch in place limit the NFS writeback on a
per-file basis (sysctl tunable) but I want trying to understand the
real problem so that a real solution could be found.


NeilBrown
