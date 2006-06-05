Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751323AbWFETeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWFETeD (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 15:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWFETeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 15:34:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24507 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751323AbWFETeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 15:34:00 -0400
Date: Mon, 5 Jun 2006 21:35:52 +0200
From: Jan Kara <jack@suse.cz>
To: Valdis.Kletnieks@vt.edu
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm3-lockdep - locking error in quotaon
Message-ID: <20060605193552.GB24342@atrey.karlin.mff.cuni.cz>
References: <200606051700.k55H015q004029@turing-police.cc.vt.edu> <1149528339.3111.114.camel@laptopd505.fenrus.org> <200606051920.k55JKQGx003031@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606051920.k55JKQGx003031@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 05 Jun 2006 19:25:39 +0200, Arjan van de Ven said:
> 
> > The quota code nests 3 mutexes but releases them in a totally different
> > order; mark this as such in the code.
> 
> > ===================================================================
> > --- linux-2.6.17-rc5-mm3.orig/fs/dquot.c
> > +++ linux-2.6.17-rc5-mm3/fs/dquot.c
> > @@ -1475,7 +1475,7 @@ static int vfs_quota_on_inode(struct ino
> >  		goto out_file_init;
> >  	}
> >  	mutex_unlock(&dqopt->dqio_mutex);
> > -	mutex_unlock(&inode->i_mutex);
> > +	mutex_unlock_non_nested(&inode->i_mutex);
> >  	set_enable_flags(dqopt, type);
> >  
> >  	add_dquot_ref(sb, type);
> 
> Obviously, there be bigger and nastier dragons lurking in the quota code.
> 
> This one made it past quotaon, but not as far as the swapon command in the
> Fedora /etc/rc.sysinit.  There's a bunch of rm all over the place in that
> section of the script, and I'm not sure at all which one triggered it.
  I have not analyzed the backtraces to much in detail but I guess the
following confuses the code (and I agree that it's kind of ugly from
quota code to do that):
  i_mutex of inode containing quota file is acquired after all other
quota locks. i_mutex of all other inodes is acquired before quota locks.
Quota code makes sure (by resetting inode operations and setting special
flag on inode) that noone tries to enter quota code while holding
i_mutex on a quota file...
  Anyways it's nice checker that it caches this kind of things ;) None
of the previous ones did.

								Honza
