Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTIUCqk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 22:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTIUCqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 22:46:40 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:17031
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261731AbTIUCqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 22:46:37 -0400
Date: Sun, 21 Sep 2003 04:46:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: A couple of 2.4.23-pre4 VM nits
Message-ID: <20030921024649.GB16294@velociraptor.random>
References: <20030830050111.GD640@wind.cocodriloo.com> <20030920133930.17399.qmail@web12811.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030920133930.17399.qmail@web12811.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shantanu,

On Sat, Sep 20, 2003 at 06:39:30AM -0700, Shantanu Goel wrote:
> Hi Andrea,
> 
> The VM fixes perform rather well in my testing
> (thanks!), but I noticed a couple of glitches that the
> attached patch addresses.
> 
> 1. max_scan is never decremented in shrink_cache().  I
> am assuming this is a typo.

this is an huge half-merging error, no surprise Andi run into vm
troubles with pre4. My tree looks like this for years:

		if (unlikely(!page_count(page)))
			continue;

		only_metadata = 0;
		if (!memclass(page_zone(page), classzone)) {
			/*
			 * Hack to address an issue found by Rik. The
			 * problem is that
			 * highmem pages can hold buffer headers
			 * allocated
			 * from the slab on lowmem, and so if we are
			 * working
			 * on the NORMAL classzone here, it is correct
			 * not to
			 * try to free the highmem pages themself (that
			 * would be useless)
			 * but we must make sure to drop any lowmem
			 * metadata related to those
			 * highmem pages.
			 */
			if (page->buffers && page->mapping) { /* fast
path racy check */
				if (unlikely(TryLockPage(page)))
					continue;
				if (page->buffers && page->mapping &&
memclass_related_bhs(page, classzone)) { /* non racy check */
					only_metadata = 1;
					goto free_bhs;
				}
				UnlockPage(page);
			}
			continue;
		}

		max_scan--;

max_scan-- should happen only after the memclass check to ensure not
failing too early on GFP_KERNEL/DMA allocations (i.e. no highmem)

This is the right fix:

--- 2.4.23pre4/mm/vmscan.c.~1~	2003-09-13 00:08:04.000000000 +0200
+++ 2.4.23pre4/mm/vmscan.c	2003-09-21 04:40:12.000000000 +0200
@@ -401,6 +401,8 @@ static int shrink_cache(int nr_pages, zo
 		if (!memclass(page_zone(page), classzone))
 			continue;
 
+		max_scan--;
+
 		/* Racy check to avoid trylocking when not worthwhile */
 		if (!page->buffers && (page_count(page) != 1 || !page->mapping))
 			goto page_mapped;

so your fix is slightly wrong in non-highmem terms (also for scheduling
terms, you would decrease it even when there's a schedule). We need to
finish the merge ASAP with Marcelo. I didn't send specific patches to
Marcelo myself yet, I only pointed out the url and list of them plus
I described the details he wanted to know. I understand he merged what
he found most interesting so I didn't notice this half merge problem yet
but I will start looking into this with the highest prio on Monday (I
was going to look into pre4 very soon for -aa that now will reject
bigtime, and the watermarks too but I had some trouble with the ram and
the scheduler in my fast amd64 this week that kept me busy, the
scheduler fix will be in next -aa and improves ppc as well 11%, on some
of my workloads it's a 99% improvement [this isn't relevant for mainline
though and apparently it was already fixed in 2.6] ;).

> 2. The second part of the patch makes sure that
> inode/dentry caches are shrunk at least once every 5
> secs.  On a machine with a heavy inode stat/directory
> lookup load (e.g. NFS server), most of the memory
> winds up sitting idle in unused inodes/dentry.  The
> present code only reclaims these when a swap_out()
> happens or shrink_caches() fails.  This can take a
> while on a machine will very few mapped pages such as
> an NFS server.

For lots of workloads this will nuke dcache way too fast and rebuilding
it with the fs and buffercache is costly.  However if you make the delay
a sysctl set to MAX_SCHEDULE_TIMEOUT, I would be definitely fine in
merging it. That way it won't make any difference by default and it can
help in the corner cases where hacks like this may provide benefits as
you noted.

thanks!

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
