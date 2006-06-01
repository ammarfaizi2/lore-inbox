Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWFAVmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWFAVmD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWFAVmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:42:02 -0400
Received: from cantor2.suse.de ([195.135.220.15]:33201 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750775AbWFAVmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:42:00 -0400
Date: Thu, 1 Jun 2006 23:41:58 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-ID: <20060601214158.GA438@suse.de>
References: <20060529214011.GA417@suse.de> <20060530182453.GA8701@suse.de> <20060601184938.GA31376@suse.de> <20060601121200.457c0335.akpm@osdl.org> <20060601201050.GA32221@suse.de> <20060601142400.1352f903.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060601142400.1352f903.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Jun 01, Andrew Morton wrote:

> Olaf Hering <olh@suse.de> wrote:
> >
> > 
> >  
> > +/* return a page in PageUptodate state, BLKFLSBUF may have flushed the page */
> > +static struct page *cramfs_read_cache_page(struct address_space *m, unsigned int n)
> > +{
> > +	struct page *page;
> > +	int readagain = 5;
> > +retry:
> > +	page = read_cache_page(m, n, (filler_t *)m->a_ops->readpage, NULL);
> > +	if (IS_ERR(page))
> > +		return NULL;
> > +	lock_page(page);
> > +	if (PageUptodate(page))
> > +		return page;
> > +	unlock_page(page);
> > +	page_cache_release(page);
> > +	if (readagain--)
> > +		goto retry;
> > +	return NULL;
> > +}
> 
> Better, but it's still awful, isn't it?  The things you were discussing
> with Chris look more promising.  PG_Dirty would be a bit of a hack, but at
> least it'd be a 100% reliable hack, whereas the above is a
> whatever-the-previous-failure-rate-was-to-the-fifth hack.

Do you want it like that?

lock_page(page);
if (PageUptodate(page)) {
        SetPageDirty(page);
        mb();
        return page;
}

and perhaps a ClearPageDirty() after memcpy.
