Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWCMXMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWCMXMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 18:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWCMXMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 18:12:08 -0500
Received: from cantor.suse.de ([195.135.220.2]:50384 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932410AbWCMXMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 18:12:06 -0500
From: Neil Brown <neilb@suse.de>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Date: Tue, 14 Mar 2006 10:10:50 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17429.64506.967102.246581@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 004 of 4] Make address_space_operations->invalidatepage
	return void
In-Reply-To: message from Dave Kleikamp on Monday March 13
References: <20060313104910.15881.patches@notabene>
	<1060312235331.15985@suse.de>
	<1142267531.9971.5.camel@kleikamp.austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 13, shaggy@austin.ibm.com wrote:
> On Mon, 2006-03-13 at 10:53 +1100, NeilBrown wrote:
> > diff ./fs/jfs/jfs_metapage.c~current~ ./fs/jfs/jfs_metapage.c
> > --- ./fs/jfs/jfs_metapage.c~current~    2006-03-09 17:29:35.000000000
> > +1100
> > +++ ./fs/jfs/jfs_metapage.c     2006-03-13 10:46:55.000000000 +1100
> > @@ -578,14 +578,13 @@ static int metapage_releasepage(struct p
> >         return 0;
> >  }
> >  
> > -static int metapage_invalidatepage(struct page *page, unsigned long
> > offset)
> > +static void metapage_invalidatepage(struct page *page, unsigned long
> > offset)
> >  {
> >         BUG_ON(offset);
> >  
> > -       if (PageWriteback(page))
> > -               return 0;
> > +       BUG_ON(PageWriteback(page));
> 
> I'm a little concerned about adding a BUG_ON for something this function
> used to allow, but it looks like the BUG_ON is valid.  I'm asking myself
> why did I add the test for PageWriteback in the first place.

Yes.... as far as I can tell, ->invalidatepage is only called with
the page locked, and with Writeback clear, so PageWriteback can never
be true.  So the BUG_ON should be a no-op.

> 
> >  
> > -       return metapage_releasepage(page, 0);
> > +       metapage_releasepage(page, 0);
> >  }
> >  
> >  struct address_space_operations jfs_metapage_aops = { 
> 
> I'll try to stress test jfs with these patches to see if I can trigger
> the an oops here.

Thanks.  I'd be very interested if you do.
I got on oops with a similar bug_on in the new nfs_invalidatepage and
it turned out to be a bug in radixtree (which I had already found and
fixed, but not in that source tree).

NeilBrown
