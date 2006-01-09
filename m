Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWAIF6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWAIF6O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 00:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWAIF6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 00:58:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41113 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932444AbWAIF6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 00:58:12 -0500
Date: Sun, 8 Jan 2006 21:57:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: torvalds@osdl.org, Kai.Makisara@kolumbus.fi, James.Bottomley@SteelEye.com,
       hugh@veritas.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-Id: <20060108215754.3369bd76.akpm@osdl.org>
In-Reply-To: <20060109054537.GE283@tau.solarneutrino.net>
References: <1134705703.3906.1.camel@mulgrave>
	<20051226234238.GA28037@tau.solarneutrino.net>
	<Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
	<20060104172727.GA320@tau.solarneutrino.net>
	<Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
	<20060105201249.GB1795@tau.solarneutrino.net>
	<Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
	<20060109033149.GC283@tau.solarneutrino.net>
	<Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
	<20060108211321.49a78679.akpm@osdl.org>
	<20060109054537.GE283@tau.solarneutrino.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Richter <ryan@tau.solarneutrino.net> wrote:
>
> On Sun, Jan 08, 2006 at 09:13:21PM -0800, Andrew Morton wrote:
> > It should be using set_page_dirty_lock().  As should st_unmap_user_pages().
> >  I doubt if this would explain a refcounting problem though.
> > 
> > Ryan, It might be worth poisoning the thing, see if the completion is being
> > called twice:
> > 
> > 
> > diff -puN drivers/scsi/st.c~a drivers/scsi/st.c
> > --- devel/drivers/scsi/st.c~a	2006-01-08 21:11:47.000000000 -0800
> > +++ devel-akpm/drivers/scsi/st.c	2006-01-08 21:12:13.000000000 -0800
> > @@ -4482,11 +4482,12 @@ static int sgl_unmap_user_pages(struct s
> >  		struct page *page = sgl[i].page;
> >  
> >  		if (dirtied)
> > -			SetPageDirty(page);
> > +			set_page_dirty_lock(page);
> >  		/* FIXME: cache flush missing for rw==READ
> >  		 * FIXME: call the correct reference counting function
> >  		 */
> >  		page_cache_release(page);
> > +		sgl[i].page = NULL;
> >  	}
> >  
> >  	return 0;
> > _
> > 
> 
> Which version does this patch apply to?
> 

Oh, I see we've already tried the poisoning thing.

So you just want to change the one line:

--- devel/drivers/scsi/st.c~a	2006-01-08 21:57:25.000000000 -0800
+++ devel-akpm/drivers/scsi/st.c	2006-01-08 21:57:38.000000000 -0800
@@ -4509,7 +4509,7 @@ static int sgl_unmap_user_pages(struct s
 		struct page *page = sgl[i].page;
 
 		if (dirtied)
-			SetPageDirty(page);
+			set_page_dirty_lock(page);
 		/* FIXME: cache flush missing for rw==READ
 		 * FIXME: call the correct reference counting function
 		 */
_

