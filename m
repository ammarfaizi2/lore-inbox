Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313818AbSDJVAZ>; Wed, 10 Apr 2002 17:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313832AbSDJVAY>; Wed, 10 Apr 2002 17:00:24 -0400
Received: from holomorphy.com ([66.224.33.161]:57311 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S313818AbSDJVAY>;
	Wed, 10 Apr 2002 17:00:24 -0400
Date: Wed, 10 Apr 2002 13:59:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Art Haas <ahaas@neosoft.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] radix-tree pagecache for 2.4.19-pre5-ac3
Message-ID: <20020410205947.GG21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Art Haas <ahaas@neosoft.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
In-Reply-To: <20020407164439.GA5662@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 11:44:39AM -0500, Art Haas wrote:
> Once again the patch has been re-diffed for the latest -ac
> kernel. It's running on my machine now. Enjoy!
> I'm interested in hearing back from anyone using this
> patch - I'd like to be sure that it applies cleanly (I
> believe it does), and that the kernel built with the
> patch runs well. The -ac kernels with rmap and the O(1)
> scheduler are working well for me, and I'm hoping that
> this patch adds to those kernels. At some point I'm hoping
> the patch is included in to the -ac patchset, and the
> eventual inclusion into the standard kernel release.
> My thanks to everyone working on the kernel.

Thank you! This has saved me some effort.

Burning question:
What are the hunks changing arch/i386/kernel/setup.c there for?
Also, there appears to be a livelock in add_to_swap(), (yes, this
has killed my boxen dead) something to help with this follows.
(It at least turned up a different problem I'm still working on.)


Cheers,
Bill


diff -urN linux-virgin/mm/swap_state.c linux/mm/swap_state.c
--- linux-virgin/mm/swap_state.c	Tue Apr  9 18:50:48 2002
+++ linux/mm/swap_state.c	Tue Apr  9 21:28:15 2002
@@ -104,6 +104,7 @@
  */
 int add_to_swap(struct page * page)
 {
+	int error;
 	swp_entry_t entry;
 
 	if (!PageLocked(page))
@@ -118,11 +119,15 @@
 		 * (adding to the page cache will clear the dirty
 		 * and uptodate bits, so we need to do it again)
 		 */
-		if (add_to_swap_cache(page, entry) == 0) {
+		error = add_to_swap_cache(page, entry);
+		if (!error) {
 			SetPageUptodate(page);
 			set_page_dirty(page);
 			swap_free(entry);
 			return 1;
+		} else if (error = -ENOMEM) {
+			swap_free(entry);
+			return 0;
 		}
 		/* Raced with "speculative" read_swap_cache_async */
 		swap_free(entry);
