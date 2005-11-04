Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbVKDDVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbVKDDVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 22:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbVKDDVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 22:21:37 -0500
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:6547 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030529AbVKDDVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 22:21:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=YeWdmCbETJuvjDUsvB+okD2iMqsSOkQlOR6hwGRoXdqTZbEioPWOq9CXTMFVTBHjAv/N7CXZErKBLPiPwIm1kSw9M4i3xxhYFGqLrZl+stxUwWOGy4OSsfQWXiNHc5m3AkY2eIkwYH/fbjgF5zJS/qwo3bjLAw1eYMlspmQZYQU=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Fri, 4 Nov 2005 04:26:45 +0100
User-Agent: KMail/1.8.3
Cc: Rob Landley <rob@landley.net>, Jeff Dike <jdike@addtoit.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Mel Gorman <mel@csn.ul.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
References: <1130917338.14475.133.camel@localhost> <20051103052649.GA16508@ccure.user-mode-linux.org> <200511022341.50524.rob@landley.net>
In-Reply-To: <200511022341.50524.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511040426.47043.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 November 2005 06:41, Rob Landley wrote:
> On Wednesday 02 November 2005 23:26, Jeff Dike wrote:
> > On Wed, Nov 02, 2005 at 05:28:35PM -0600, Rob Landley wrote:
> > > With fragmentation reduction and prezeroing, UML suddenly gains the
> > > option of calling madvise(DONT_NEED) on sufficiently large blocks as A)
> > > a fast way of prezeroing, B) a way of giving memory back to the host OS
> > > when it's not in use.

> > DONT_NEED is insufficient.  It doesn't discard the data in dirty
> > file-backed pages.

> I thought DONT_NEED would discard the page cache, and punch was only needed
> to free up the disk space.
This is correct, but...

> I was hoping that since the file was deleted from disk and is already
> getting _some_ special treatment (since it's a longstanding "poor man's
> shared memory" hack), that madvise wouldn't flush the data to disk, but
> would just zero it out.  A bit optimistic on my part, I know. :)

I read at some time that this optimization existed but was deemed obsolete and 
removed.

Why obsolete? Because... we have tmpfs! And that's the point. With DONTNEED, 
we detach references from page tables, but the content is still pinned: it 
_is_ the "disk"! (And you have TMPDIR on tmpfs, right?)

> > Badari Pulavarty has a test patch (google for madvise(MADV_REMOVE))
> > which does do the trick, and I have a UML patch which adds memory
> > hotplug.  This combination does free memory back to the host.

> I saw it wander by, and am all for it.  If it goes in, it's obviously the
> right thing to use.
Btw, on this side of the picture, I think fragmentation avoidance is not 
needed for that.

I guess you refer to using frag. avoidance on the guest (if it matters for the 
host, let me know). When it will be present using it will be nice, but 
currently we'd do madvise() on a page-per-page basis, and we'd do it on 
non-consecutive pages (basically, free pages we either find or free or 
purpose).

> You may remember I asked about this two years ago: 
> http://seclists.org/lists/linux-kernel/2003/Dec/0919.html

> And a reply indicated that SVr4 had it, but we don't.  I assume the "naming
> discussion" mentioned in the recent thread already scrubbed through this
> old thread to determine that the SVr4 API was icky.
> http://seclists.org/lists/linux-kernel/2003/Dec/0955.html

I assume not everybody did (even if somebody pointed out the existance of the 
SVr4 API), but there was the need, in at least one usage, for a virtual 
address-based API rather than a file offset based one, like the SVr4 one - 
that user would need implementing backward mapping in userspace only for this 
purpose, while we already have it in the kernel.

Anyway, the sys_punch() API will follow later - customers need mainly 
madvise() for now.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
