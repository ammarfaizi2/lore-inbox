Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWFNV4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWFNV4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 17:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWFNV4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 17:56:41 -0400
Received: from pat.uio.no ([129.240.10.4]:18425 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932380AbWFNV4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 17:56:40 -0400
Subject: Re: 2.6.16-rc6-mm2
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christoph Lameter <clameter@sgi.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606121723480.22389@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	 <448DA5DD.203@fr.ibm.com>
	 <Pine.LNX.4.64.0606121511090.21172@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0606121723480.22389@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 17:56:25 -0400
Message-Id: <1150322185.18449.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5, required 12,
	autolearn=disabled, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 17:24 -0700, Christoph Lameter wrote:
> I guess this is correct. nfs_clear_page_writeback also ignores the page 
> if req->wb_page == NULL. Trond?

Sorry I'm late in responding. I'm currently on vacation in Iceland.

This is most probably an issue with nfs_cancel_requests(). We shouldn't
be calling nfs_clear_page_writeback() without _first_ decrementing
NR_UNSTABLE. I'll have a look, but I may be a bit unresponsive until I
get to a new place with an internet connection.

Cheers,
  Trond

> On Mon, 12 Jun 2006, Christoph Lameter wrote:
> 
> > On Mon, 12 Jun 2006, Cedric Le Goater wrote:
> > 
> > > Unable to handle kernel NULL pointer dereference at 0000000000000007 RIP:
> > >  [<ffffffff8025b017>] dec_zone_page_state+0x1/0x5b
> > 
> > Seems that req->wb_page may be NULL.
> > 
> > This patch may fix it but we may miss an unstable page then. We may 
> > have to move the decrement of NR_UNSTABLE to a different location when
> > wb_page is still valid.
> > 
> > Index: linux-2.6.17-rc6-cl/fs/nfs/write.c
> > ===================================================================
> > --- linux-2.6.17-rc6-cl.orig/fs/nfs/write.c	2006-06-12 13:37:47.321243148 -0700
> > +++ linux-2.6.17-rc6-cl/fs/nfs/write.c	2006-06-12 15:13:48.020908204 -0700
> > @@ -1419,7 +1419,8 @@ static void nfs_commit_done(struct rpc_t
> >  		nfs_mark_request_dirty(req);
> >  	next:
> >  		nfs_clear_page_writeback(req);
> > -		dec_zone_page_state(req->wb_page, NR_UNSTABLE);
> > +		if (req->wb_page)
> > +			dec_zone_page_state(req->wb_page, NR_UNSTABLE);
> >  	}
> >  }
> >  
> > 
> > 

