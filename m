Return-Path: <linux-kernel-owner+w=401wt.eu-S1750725AbXAQGPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbXAQGPf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 01:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXAQGPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 01:15:35 -0500
Received: from pat.uio.no ([129.240.10.15]:48728 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbXAQGPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 01:15:34 -0500
Subject: Re: [PATCH] nfs: fix congestion control
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <1169001692.22935.84.camel@twins>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116135325.3441f62b.akpm@osdl.org>  <1168985323.5975.53.camel@lappy>
	 <1168986466.6056.52.camel@lade.trondhjem.org>
	 <1169001692.22935.84.camel@twins>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 01:15:15 -0500
Message-Id: <1169014515.6065.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Resend: resent
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.5, required=12.0, autolearn=disabled, AWL=-2.500)
X-UiO-Scanned: 958ECDA21537018D63A669BEF324C5BFB442ED4A
X-UiO-SPAM-Test: 129.240.10.9 spam_score -24 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-17 at 03:41 +0100, Peter Zijlstra wrote:
> On Tue, 2007-01-16 at 17:27 -0500, Trond Myklebust wrote:
> > On Tue, 2007-01-16 at 23:08 +0100, Peter Zijlstra wrote:
> > > Subject: nfs: fix congestion control
> > > 
> > > The current NFS client congestion logic is severely broken, it marks the
> > > backing device congested during each nfs_writepages() call and implements
> > > its own waitqueue.
> > > 
> > > Replace this by a more regular congestion implementation that puts a cap
> > > on the number of active writeback pages and uses the bdi congestion waitqueue.
> > > 
> > > NFSv[34] commit pages are allowed to go unchecked as long as we are under 
> > > the dirty page limit and not in direct reclaim.
> 
> > 
> > What on earth is the point of adding congestion control to COMMIT?
> > Strongly NACKed.
> 
> They are dirty pages, how are we getting rid of them when we reached the
> dirty limit?

They are certainly _not_ dirty pages. They are pages that have been
written to the server but are not yet guaranteed to have hit the disk
(they were only written to the server's page cache). We don't care if
they are paged in or swapped out on the local client.

\All the COMMIT does, is to ask the server to write the data from its
page cache onto disk. Once that has been done, we can release the pages.
If the commit fails, then we iterate through the whole writepage()
process again. The commit itself does, however, not even look at the
page data.

> > Why 16MB of on-the-wire data? Why not 32, or 128, or ...
> 
> Andrew always promotes a fixed number for congestion control, I pulled
> one from a dark place. I have no problem with a more dynamic solution.
> 
> > Solaris already allows you to send 2MB of write data in a single RPC
> > request, and the RPC engine has for some time allowed you to tune the
> > number of simultaneous RPC requests you have on the wire: Chuck has
> > already shown that read/write performance is greatly improved by upping
> > that value to 64 or more in the case of RPC over TCP. Why are we then
> > suddenly telling people that they are limited to 8 simultaneous writes?
> 
> min(max RPC size * max concurrent RPC reqs, dirty threshold) then?

That would be far preferable. For instance, it allows those who have
long latency fat pipes to actually use the bandwidth optimally when
writing out the data.

Trond

