Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWAEVT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWAEVT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWAEVT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:19:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932136AbWAEVT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:19:26 -0500
Date: Thu, 5 Jan 2006 13:18:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: Kai Makisara <Kai.Makisara@kolumbus.fi>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <20060105201249.GB1795@tau.solarneutrino.net>
Message-ID: <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
References: <Pine.LNX.4.64.0512120928110.15597@g5.osdl.org>
 <1134409531.9994.13.camel@mulgrave> <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org>
 <1134411882.9994.18.camel@mulgrave> <20051215190930.GA20156@tau.solarneutrino.net>
 <1134705703.3906.1.camel@mulgrave> <20051226234238.GA28037@tau.solarneutrino.net>
 <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, Ryan Richter wrote:
> 
> Another one.  I can't keep running this kernel - nearly all of our
> backup tapes are erased now.  If a drive were to fail today, we would
> lose hundreds of GB of irreplacible data.  I'm going back to 2.6.11.3
> until we have a full set of backups again.

Yeah, don't trash your backups.

If/when you try something again, how about these two trivial one-liners?

I'm not 100% sure the mapcount sanity check is strictly speaking right (no 
locking between mapcount/pagecount comparison), but the page count really 
should never fall below the mapcount, so aside from races that I don't 
think can be triggered in practice, this might be very useful to find 
where those pesky page counts suddenly disappear..

Right now we get the oops "too late" - something has decremented the page
count way too far, but we don't know what it was, and the actual function 
that triggers it _seems_ to be harmless.

The other part of the patch is to clear "page" when it's being free'd, in 
case somebody tries to free the same thing twice. I don't see how that 
could happen either, but...

The patch is untested in every way. No guarantees.

		Linus

---
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index c4aade8..18e60e1 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4481,6 +4481,7 @@ static int sgl_unmap_user_pages(struct s
 	for (i=0; i < nr_pages; i++) {
 		struct page *page = sgl[i].page;
 
+		sgl[i].page = NULL;
 		if (dirtied)
 			SetPageDirty(page);
 		/* FIXME: cache flush missing for rw==READ
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a06a84d..daf504d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -299,6 +299,7 @@ struct page {
 #define put_page_testzero(p)				\
 	({						\
 		BUG_ON(page_count(p) == 0);		\
+		BUG_ON(page_count(p) <= page_mapcount(p));	\
 		atomic_add_negative(-1, &(p)->_count);	\
 	})
 
