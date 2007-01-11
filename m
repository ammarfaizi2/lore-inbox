Return-Path: <linux-kernel-owner+w=401wt.eu-S1751454AbXAKTtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbXAKTtw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXAKTtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:49:52 -0500
Received: from pat.uio.no ([129.240.10.15]:33453 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbXAKTtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:49:51 -0500
Subject: Re: O_DIRECT question
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
In-Reply-To: <Pine.LNX.4.64.0701111054500.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	 <Pine.LNX.4.64.0701101910110.3594@woody.osdl.org>
	 <45A5D4A7.7020202@yahoo.com.au>
	 <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org>
	 <1168534362.7365.3.camel@bip.parateam.prv>
	 <Pine.LNX.4.64.0701110900090.3594@woody.osdl.org>
	 <1168540875.6170.46.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0701111054500.3594@woody.osdl.org>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 14:49:25 -0500
Message-Id: <1168544965.6170.76.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 572B67D09163E099037A4AF864B0B439D3D480D2
X-UiO-SPAM-Test: 141.211.133.154 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-11 at 11:00 -0800, Linus Torvalds wrote:
> 
> On Thu, 11 Jan 2007, Trond Myklebust wrote:
> > 
> > For NFS, the main feature of interest when it comes to O_DIRECT is
> > strictly uncached I/O. Replacing it with POSIX_FADV_NOREUSE won't help
> > because it can't guarantee that the page will be thrown out of the page
> > cache before some second process tries to read it. That is particularly
> > true if some dopey third party process has mmapped the file.
> 
> You'd still be MUCH better off using the page cache, and just forcing the 
> IO (but _with_ all the page cache synchronization still active). Which is 
> trivial to do on the filesystem level, especially for something like NFS.
> 
> If you bypass the page cache, you just make that "dopey third party 
> process" problem worse. You now _guarantee_ that there are aliases with 
> different data.

Quite, but that is sometimes an admissible state of affairs.

One of the things that was infuriating when we were trying to do shared
databases over the page cache was that someone would start some
unsynchronised process that had nothing to do with the database itself
(it would typically be a process that was backing up the rest of the
disk or something like that). Said process would end up pinning pages in
memory, and prevented the database itself from getting updated data from
the server.

IOW: the problem was not that of unsynchronised I/O per se. It was
rather that of allowing the application to set up its own
synchronisation barriers and to ensure that no pages are cached across
these barriers. POSIX_FADV_NOREUSE can't offer that guarantee.

> Of course, with NFS, the _server_ will resolve any aliases anyway, so at 
> least you don't get file corruption, but you can get some really strange 
> things (like the write of one process actually happening before, but being 
> flushed _after_ and overriding the later write of the O_DIRECT process).

Writes are not the real problem here since shared databases typically do
implement sufficient synchronisation, and NFS can guarantee that only
the dirty data will be written out. However reading back the data is
problematic when you have insufficient control over the page cache.

The other issue is, of course, that databases don't _want_ to cache the
data in this situation, so the extra copy to the page cache is just a
bother. As you pointed out, that becomes less of an issue as processor
caches and memory speeds increase, but it is still apparently a
measurable effect.

Cheers
  Trond

