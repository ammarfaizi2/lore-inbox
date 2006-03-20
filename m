Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWCTQNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWCTQNs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbWCTQNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:13:47 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:45187 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964862AbWCTQNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:13:45 -0500
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Dave Miller <davem@redhat.com>, axboe@suse.de, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, mattjreimer@gmail.com,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <20060222082732.GA24320@htj.dyndns.org>
References: <11371658562541-git-send-email-htejun@gmail.com>
	 <1137167419.3365.5.camel@mulgrave>
	 <20060113182035.GC25849@flint.arm.linux.org.uk>
	 <1137177324.3365.67.camel@mulgrave>
	 <20060113190613.GD25849@flint.arm.linux.org.uk>
	 <20060222082732.GA24320@htj.dyndns.org>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 10:12:51 -0600
Message-Id: <1142871172.3283.17.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 17:27 +0900, Tejun Heo wrote:
> \This thread has been dead for quite some time mainly because I didn't
> know what to do.  As it is a real outstanding bug bugging people and
> Matt Reimer thankfully reminded me[1], I'm giving another shot at
> resolving this.
> 
> People seem to agree that it is the responsibility of the driver to
> make sure read data gets to the page cache page (or whatever kernel
> page).  Only driver knows how and when.
> 
> The objection raised by James Bottomley is that although syncing the
> kernel page is the responsbility of the driver, syncing user page is
> not; thus, use of flush_dcache_page() is excessive.  James suggested
> use of flush_kernel_dcache_page().
> 
> I also asked similar question[2] on lkml and Russell replied that
> depending on arch implementation it shouldn't be much of a problem[3].
> Another thing to consider is that all other drivers which currently
> manage cache coherency use flush_dcache_page().
> 
> So, the questions are...
> 
> q1. James, besides from the use of flush_dcache_page(), do you agree
>     with the block layer kmap/kunmap API?
> 
> 2. Is flush_kernel_dcache_page() the correct one?
> 
> Whether or not flush_kernel_dcache_page() is the one or not, I think
> we should first go with flush_dcache_page() as that's what drivers
> have been doing upto this point.  Switching from flush_dcache_page()
> to flush_kernel_dcache_page() is very easy and should be done in a
> separate patch anyway.  No?
> 
> Another thing mind is that this problem is not limited block drivers.
> All the codes that perform writes to kmap'ed pages take care of
> synchronization themselves and the popular choice seems to be
> flush_dcache_page().
> 
> IMHO, kmap API should have a flag or something to tell it how the page
> is being used such that kmap API can take care of synchronization like
> dma mapping API does rather than scattering sync code all over the
> kernel.  And if that's the right thing to do, some of blk kmap
> wrappers can/should be removed.
> 
> What do you guys think?

Here's my proposal to break this logjam.

I'm proposing introducing a new memory coherency API:

flush_kernel_dcache_page()

Which would be tasked with bringing cache coherency back to the kernel's
image of a user page after the kernel has modified it.  On parisc this
will be a simple flush through the kernel cache.

I think on arm this should be implemented as

__cpuc_flush_dcache_page(page_address(page))

but you can implement this as flush_dcache_page() if you wish (I warn
you now that you have the same flush_dcache_mmap_lock problem that we
have on parisc, so if you do this, you'll return from
flush_dcache_page() with interrupts enabled, but at least this will no
longer be a parisc problem).

If everyone's happy with this approach, I'll take it over to linux-arch.

James

diff --git a/Documentation/cachetlb.txt b/Documentation/cachetlb.txt
index 4ae4188..6232dd7 100644
--- a/Documentation/cachetlb.txt
+++ b/Documentation/cachetlb.txt
@@ -362,6 +362,15 @@ maps this page at its virtual address.
 	likely that you will need to flush the instruction cache
 	for copy_to_user_page().
 
+  void flush_kernel_dcache_page(struct page *page)
+	When the kernel needs to modify a user page is has obtained
+	with kmap, it calls this function after all modifications are
+	complete (but before kunmapping it) to bring the underlying
+	page up to date.  It is assumed here that the user has no
+	incoherent cached copies (i.e. the original page was obtained
+	from a mechanism like get_user_pages())
+
+
   void flush_icache_range(unsigned long start, unsigned long end)
   	When the kernel stores into addresses that it will execute
 	out of (eg when loading modules), this function is called.
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6bece92..157bd2f 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -7,6 +7,12 @@
 
 #include <asm/cacheflush.h>
 
+#ifndef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+static inline void flush_kernel_dcache_page(struct page *page)
+{
+}
+#endif
+
 #ifdef CONFIG_HIGHMEM
 
 #include <asm/highmem.h>


