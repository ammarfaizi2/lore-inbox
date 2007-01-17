Return-Path: <linux-kernel-owner+w=401wt.eu-S932436AbXAQOcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbXAQOcl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 09:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbXAQOck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 09:32:40 -0500
Received: from [213.46.243.15] ([213.46.243.15]:46314 "EHLO
	amsfep12-int.chello.nl" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932436AbXAQOck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 09:32:40 -0500
Subject: Re: [PATCH] nfs: fix congestion control
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <1169041814.6102.3.camel@lade.trondhjem.org>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116135325.3441f62b.akpm@osdl.org>  <1168985323.5975.53.camel@lappy>
	 <1168986466.6056.52.camel@lade.trondhjem.org>
	 <1169001692.22935.84.camel@twins>
	 <1169014515.6065.5.camel@lade.trondhjem.org>
	 <1169023798.22935.96.camel@twins>
	 <1169041814.6102.3.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 15:29:46 +0100
Message-Id: <1169044186.22935.122.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-17 at 08:50 -0500, Trond Myklebust wrote:
> On Wed, 2007-01-17 at 09:49 +0100, Peter Zijlstra wrote: 
> > > They are certainly _not_ dirty pages. They are pages that have been
> > > written to the server but are not yet guaranteed to have hit the disk
> > > (they were only written to the server's page cache). We don't care if
> > > they are paged in or swapped out on the local client.
> > > 
> > > \All the COMMIT does, is to ask the server to write the data from its
> > > page cache onto disk. Once that has been done, we can release the pages.
> > > If the commit fails, then we iterate through the whole writepage()
> > > process again. The commit itself does, however, not even look at the
> > > page data.
> > 
> > Thou art correct from an NFS point of view, however for the VM they are
> > (still) just dirty pages and we need shed them.
> > 
> > You talk of swapping them out, they are filecache pages not swapcache
> > pages. The writepage() process needs to complete and that entails
> > committing them.
> 
> My point is that we can and should collect as many of the little buggers
> as we can and treat them with ONE commit call. We don't look at the
> data, we don't lock the pages, we don't care what the VM is doing with
> them. Throttling is not only unnecessary, it is actually a bad idea
> since it slows up the rate at which we can free up the pages.

Ah, OK.

I was thinking that since the server needs to actually sync the page a
commit might be quite expensive (timewise), hence I didn't want to flush
too much, and interleave them with writing out some real pages to
utilise bandwidth.

But if you think I should just bulk commit I can do that.

