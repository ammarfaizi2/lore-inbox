Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWDYFPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWDYFPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 01:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWDYFPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 01:15:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:13977 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751390AbWDYFPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 01:15:49 -0400
Date: Mon, 24 Apr 2006 22:09:51 -0700
From: Greg KH <greg@kroah.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 1/4] kref: warn kref_put() with unreferenced kref
Message-ID: <20060425050951.GB23373@kroah.com>
References: <20060424083333.217677000@localhost.localdomain> <20060424083341.613638000@localhost.localdomain> <20060425035128.GB18085@kroah.com> <20060425043410.GA5698@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425043410.GA5698@miraclelinux.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 12:34:10PM +0800, Akinobu Mita wrote:
> On Mon, Apr 24, 2006 at 08:51:28PM -0700, Greg KH wrote:
> > > @@ -49,6 +49,7 @@ void kref_get(struct kref *kref)
> > >   */
> > >  int kref_put(struct kref *kref, void (*release)(struct kref *kref))
> > >  {
> > > +	WARN_ON(atomic_read(&kref->refcount) < 1);
> > 
> > How can this ever be true?  If the refcount _ever_ goes below 1, the
> > object is freed.
> 
> The idea of detection kref_put() with unreferenced object was stolen
> from BUG_ON()es in blocks/ll_rw_blk.c and fs/bio.c
> 
> ll_rw_blk.c:    BUG_ON(atomic_read(&ioc->refcount) == 0);
> 
> bio.c:          BIO_BUG_ON(!atomic_read(&bio->bi_cnt));
> 
> But the kref counter usually does not become zero. Because kref is
> trying to reduce the number of atomic_dec_and_test()
> 
> So this patch also set kref counter to zero here:
> 
> > > +	if (atomic_read(&kref->refcount) == 1)
> > > +		atomic_set(&kref->refcount, 0);

But again, if this happens the memory will be freed.  So again,
CONFIG_DEBUG_SLAB will catch this kind of thing.

Is there some reason you created these patches?  Were you trying to
debug something that was tracked down to a kref issue?

thanks,

greg k-h
