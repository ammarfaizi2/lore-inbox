Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966846AbWKONSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966846AbWKONSN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 08:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966847AbWKONSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 08:18:13 -0500
Received: from mx2.netapp.com ([216.240.18.37]:63818 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S966846AbWKONSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 08:18:12 -0500
X-IronPort-AV: i="4.09,424,1157353200"; 
   d="scan'208"; a="2695509:sNHT22112664"
Subject: Re: Yet another borken page_count() check in
	invalidate_inode_pages2()....
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Charles Edward Lever <chucklever@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1163568819.5645.8.camel@lade.trondhjem.org>
References: <1163568819.5645.8.camel@lade.trondhjem.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Wed, 15 Nov 2006 08:18:09 -0500
Message-Id: <1163596689.5691.40.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 15 Nov 2006 13:18:41.0261 (UTC) FILETIME=[9191E1D0:01C708B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 00:33 -0500, Trond Myklebust wrote:
> I'm once again getting bogus errors from invalidate_inode_pages2() due
> to a VM bug. See the third line of remove_mapping().

Argh... Never try debugging past midnight: the above was a red herring.
I've been hitting the WARN_ON in invalidate_inode_pages2() reliably when
running NetApp's simulated i/o tool on the NFS client. It looks as if
I'm hitting a race in which writeback starts on the page after the call
to wait_on_page_writeback(), probably as a consequence of
unmap_mapping_range().

Anyhow, when we call try_to_release_page() with the GFP_WAIT argument,
it seems unnecessary that it should fail immediately if the page is
under writeback. How about something like the following patch?

Cheers,
 Trond
------------------------------------------------------------------
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Wed, 15 Nov 2006 08:02:30 -0500
MM: Fix a loophole in try_to_release_page()

The following patch allows try_to_release_page() to wait on page writeback
instead of failing if the user specified __GFP_WAIT.

The reason is that when running NetApp's simulated I/O tool (sio_ntap) on
the NFS client, I can currently reliably trigger the WARN_ON() in
invalidate_inode_pages2().
Whereas we do wait on page_writeback in invalidate_inode_pages2_range(), we
do so before we unmap the page. There is still a race which will cause the
call to try_to_release_page() to fail the test for PageWriteback(page).

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 mm/filemap.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7b84dc8..d37f77b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2445,7 +2445,9 @@ int try_to_release_page(struct page *pag
 	struct address_space * const mapping = page->mapping;
 
 	BUG_ON(!PageLocked(page));
-	if (PageWriteback(page))
+	if (gfp_mask & __GFP_WAIT)
+		wait_on_page_writeback(page);
+	else if (PageWriteback(page))
 		return 0;
 
 	if (mapping && mapping->a_ops->releasepage)
