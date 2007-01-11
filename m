Return-Path: <linux-kernel-owner+w=401wt.eu-S1750953AbXAKTBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbXAKTBH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbXAKTBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:01:07 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55159 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbXAKTBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:01:05 -0500
Date: Thu, 11 Jan 2007 11:00:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Xavier Bestel <xavier.bestel@free.fr>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
In-Reply-To: <1168540875.6170.46.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0701111054500.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> 
 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> 
 <Pine.LNX.4.64.0701101910110.3594@woody.osdl.org>  <45A5D4A7.7020202@yahoo.com.au>
  <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org>  <1168534362.7365.3.camel@bip.parateam.prv>
  <Pine.LNX.4.64.0701110900090.3594@woody.osdl.org> <1168540875.6170.46.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jan 2007, Trond Myklebust wrote:
> 
> For NFS, the main feature of interest when it comes to O_DIRECT is
> strictly uncached I/O. Replacing it with POSIX_FADV_NOREUSE won't help
> because it can't guarantee that the page will be thrown out of the page
> cache before some second process tries to read it. That is particularly
> true if some dopey third party process has mmapped the file.

You'd still be MUCH better off using the page cache, and just forcing the 
IO (but _with_ all the page cache synchronization still active). Which is 
trivial to do on the filesystem level, especially for something like NFS.

If you bypass the page cache, you just make that "dopey third party 
process" problem worse. You now _guarantee_ that there are aliases with 
different data.

Of course, with NFS, the _server_ will resolve any aliases anyway, so at 
least you don't get file corruption, but you can get some really strange 
things (like the write of one process actually happening before, but being 
flushed _after_ and overriding the later write of the O_DIRECT process).

And sure, the filesystem can have its own alias avoidance too (by just 
probing the page cache all the time), but the fundamental fact remains: 
the problem is that O_DIRECT as a page-cache-bypassing mechanism is 
BROKEN.

If you have issues with caching (but still have to allow it for other 
things), the way to fix them is not to make uncached accesses, it's to 
force the cache to be serialized. That's very fundamentally true.

		Linus
