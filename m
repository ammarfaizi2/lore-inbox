Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUEEANR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUEEANR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 20:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUEEANR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 20:13:17 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:31872 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261832AbUEEANK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 20:13:10 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: viro@parcelfarce.linux.theplanet.co.uk
Date: Wed, 5 May 2004 10:11:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16536.12585.131697.818909@cse.unsw.edu.au>
Cc: Greg Banks <gnb@melbourne.sgi.com>, Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trond myklebust <trondmy@trondhjem.org>
Subject: Re: d_splice_alias() problem.
In-Reply-To: message from viro@parcelfarce.linux.theplanet.co.uk on Tuesday May 4
References: <16521.5104.489490.617269@laputa.namesys.com>
	<16529.56343.764629.37296@cse.unsw.edu.au>
	<409634B9.8D9484DA@melbourne.sgi.com>
	<16534.54704.792101.617408@cse.unsw.edu.au>
	<40973F7F.A9FA4F1@melbourne.sgi.com>
	<20040504094642.GL17014@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 4, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, May 04, 2004 at 05:00:15PM +1000, Greg Banks wrote:
>  
> > Ok, how about this...it's portable, and not racy, but may perturb the
> > logic slightly by also taking dentries off the unused list in the case
> > where they already had d_count>=1.  I'm not sure how significant that is.
> > In any case this also passes my tests.
>  
> a) ask RCU folks to review - the current logics in dcache.c is extremely
> brittle as it is.
> 
> b) after rereading that code, I _really_ don't like the crap with "hashed
> but disconnected" nfsd is pulling off.  Neil, care to give detailed reasons
> why you are doing that?

As a quick answer, below is a copy of an email from Christoph Hellwig
from 18 months ago where says how glad he is to see it and wants to
know if it will stay.  Basically, without hashing the dentry, it will
get allocated and deallocated very frequently which has negative
consequences.  It would actually be nice to hold a "file" around
instead of just a "dentry", but a dentry is better than nothing.

NeilBrown


From: Neil Brown <neilb@cse.unsw.edu.au>
To: Christoph Hellwig <hch@sgi.com>
Cc:    linux-fsdevel@vger.kernel.org
Subject: Re: keeping nfsd dentries on unused_list
Date: Tue, 22 Oct 2002 09:15:54 +1000
Content-Type: text/plain; charset=us-ascii

On Monday October 21, hch@sgi.com wrote:
> Hi Neil,
> 
> since your export changes in 2.5.<early> always have a non-empty
> ->d_hash (linked into sb->s_anon) and thus are put on the unused
> list by dput instead of directly reclaiming it.
> 
> Is this behaviour intentional and will stay during 2.6?  Keeping
> those dentries alive will allow me to remove lots of code in XFS
> to keep inodes that are written to by nfsd in cache as the final
> iput will flush all delayed allocated space and thus decrease
> nfs write performance massively - but as long as the dentry is
> on the unused list after dput we still have an inode reference
> and thus the delalloc block don't need to be converted.

Yes.  That behaviour is intentional and will stay.

NeilBrown

