Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVAUGmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVAUGmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVAUGmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:42:24 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:23384
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262283AbVAUGlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:41:51 -0500
Date: Fri, 21 Jan 2005 07:41:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, npiggin@novell.com,
       Rik van Riel <riel@redhat.com>
Subject: Re: writeback-highmem
Message-ID: <20050121064147.GC17050@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random> <20050121054916.GB12647@dualathlon.random> <20050121054945.GC12647@dualathlon.random> <20050121055004.GD12647@dualathlon.random> <20050121055043.GE12647@dualathlon.random> <20050121060135.GF12647@dualathlon.random> <20050120222630.6168a4cb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120222630.6168a4cb.akpm@osdl.org>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 10:26:30PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > This needed highmem fix from Rik is still missing too, so please apply
> >  along the other 5 (it's orthogonal so you can apply this one in any
> >  order you want).
> > 
> >  From: Rik van Riel <riel@redhat.com>
> >  Subject: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
> 
> I've held off on this one because the recent throttling fix should have
> helped this problem.  Has anyone confirmed that this patch still actually
> fixes something?  If so, what was the scenario?

Without this fix write throttling is completely broken for a blkdev and
it won't start _at_all_ and it'll just keep hanging in the allocation
routines. I agree it won't explain oom (with the other fixes the VM
should writeback synchronously instead of running oom) but it may make
the box completely unusable under a cp /dev/zero /dev/somedevice.

There is a reason why we start write throttling before 100% of ram is
being locked by dirty pages in the pagecache path.

The beauty of this fix is that Rik allowed the pagecache not to have the
limit (in 2.4 pagecache had the limit too). Probably async writeback
won't start but at least the write throttling will and that's all we
need to keep the box running other apps at the same time of the write.

If the system goes unresponsive for 10 minutes and swaps during backups
or workloads working on the blkdev, they'll file bugreports and they'd
be correct.

In short I agree this shouldn't be applied for oom, but it's still
definitely a correct and needed fix (and I rate it a bit more than just
an optimization).
