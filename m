Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWG0J2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWG0J2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 05:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWG0J2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 05:28:18 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:52877 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750967AbWG0J2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 05:28:17 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [BUG?] possible recursive locking detected
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, eike-kernel@sf-tec.de,
       linux-kernel@vger.kernel.org, aia21@cantab.net
In-Reply-To: <20060727015356.f01b5644.akpm@osdl.org>
References: <200607261805.26711.eike-kernel@sf-tec.de>
	 <20060726225311.f51cee6d.akpm@osdl.org> <44C86271.9030603@yahoo.com.au>
	 <1153984527.21849.2.camel@imp.csi.cam.ac.uk>
	 <20060727003806.def43f26.akpm@osdl.org>
	 <1153988398.21849.16.camel@imp.csi.cam.ac.uk>
	 <20060727015356.f01b5644.akpm@osdl.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Thu, 27 Jul 2006 10:28:04 +0100
Message-Id: <1153992484.21849.36.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 01:53 -0700, Andrew Morton wrote:
> On Thu, 27 Jul 2006 09:19:58 +0100
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> 
> > b) is impossible for ntfs.
> 
> ntfs write() is already doing GFP_HIGHUSER allocations inside i_mutex.

Yes.

> Presumably there's some reason why it isn't deadlocking at present.

NTFS always also supplies GFP_NOFS so it should never deadlock on itself
(except in cases where it has no control of memory allocations because
VFS / kernel functions do the allocation).

I would assume the likelyhood of a cross fs ab/ba deadlock is so small
that it effectively never happens...

> Could
> be that we'll end up deciding to make lockdep shut up about cross-fs
> i_mutex-takings, but that's a bit lame because if some other fs starts
> taking i_mutex in the reclaim path we're exposed to ab/ba deadlocks, and
> they won't be reported.

True but I think that will be the only solution to get rid of the
messages.  It is not the only place in the kernel where there are
theoretical problems in the code but it is considered acceptable because
it happens very seldomly.  This is such a case I feel.

An example is the potential deadlock in generic buffered file write
where we fault in a page via fault_in_pages_readable() but there is
nothing to guarantee that page will not go away between us doing this
and us using the page.

This deadlock is hit tons when using reiserfs (unmodified) and even ext3
is affected on servers that run very high i/o loads.  (Loads being
between once a day and once a week and it requires a reboot to sort out
for the unmodified reiserfs case but we have a local patch that improves
matters dramatically.)

And still the code is there and no-one complains as the real solutions
are either too horrible to contemplate or need a lot of intricate
changes to the kernel's page handling (e.g. like a "page is pinned" flag
that then needs to be honoured in all the right places)...

> But sorry, we just cannot go and require that write()'s pagecache
> allocations not be able to write dirty data, not be able to strip buffers
> from clean pages and not be able to reclaim slab.

As I said, perhaps all those code paths need to be able to take a "no"
for an answer from the FS and the fs needs to try-lock and abort if it
fails.  The problem at the moment is that the FS must succeed or
deadlock trying (or panic or silently cause errors on the file system
take your pick of what you consider the least bad).

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://www.linux-ntfs.org/ & http://www-stu.christs.cam.ac.uk/~aia21/

