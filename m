Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267713AbRHBIlF>; Thu, 2 Aug 2001 04:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268715AbRHBIk4>; Thu, 2 Aug 2001 04:40:56 -0400
Received: from ns.caldera.de ([212.34.180.1]:27341 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S267713AbRHBIku>;
	Thu, 2 Aug 2001 04:40:50 -0400
Date: Thu, 2 Aug 2001 10:40:47 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill unneeded code from mm/memory.c
Message-ID: <20010802104047.A5767@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <mailman.996710160.18802.linux-kernel2news@redhat.com> <200108020154.f721sKR04927@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108020154.f721sKR04927@devserv.devel.redhat.com>; from zaitcev@redhat.com on Wed, Aug 01, 2001 at 09:54:20PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2001 at 09:54:20PM -0400, Pete Zaitcev wrote:
> > diff -uNr ../master/linux-2.4.7-ac3/mm/memory.c linux/mm/memory.c
> > --- ../master/linux-2.4.7-ac3/mm/memory.c	Thu Aug  2 01:48:23 2001
> > +++ linux/mm/memory.c	Thu Aug  2 01:50:12 2001
> > @@ -1041,17 +1041,10 @@
> >  		}
> >  	}
> >  	inode->i_size = offset;
> > -	if (inode->i_op && inode->i_op->truncate)
> > -	{
> > -		/* This doesnt scale but it is meant to be a 2.4 invariant */
> > -		lock_kernel();
> > -		inode->i_op->truncate(inode);
> > -		unlock_kernel();
> > -	}
> > -	return 0;
> > -	
> > +
> >  out_truncate:
> >  	if (inode->i_op && inode->i_op->truncate) {
> > +		/* This doesnt scale but it is meant to be a 2.4 invariant */
> >  		lock_kernel();
> >   		inode->i_op->truncate(inode);
> >  		unlock_kernel();
> 
> I disagree. It is the style to have a function trip exceptions
> by doing goto out_something. Those exceptions are stacked
> in the fall through fashion, but the success case IS NOT.
> By implemention this factorization you save several bytes
> and make just everyone to wonder if there is a bug or mispatch
> with missing "return 0" case here.

Well, out_truncate is a sucessfull exit, too.
Maybe the patch was missing a few lines of context to make the situation
completly clear:

  out_unlock:
  	spin_unlock(&mapping->i_shared_lock);
  	truncate_inode_pages(mapping, offset);
  	goto out_truncate;

  do_expand:
  	if (offset > inode->i_sb->s_maxbytes)
  		goto out;
  	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
  	if (limit != RLIM_INFINITY) {
  		if (inode->i_size >= limit) {
  			send_sig(SIGXFSZ, current, 0);
  			goto out;
  		}
  		if (offset > limit) {
  			send_sig(SIGXFSZ, current, 0);
  			offset = limit;
  		}
  	}
 	inode->i_size = offset;
-	if (inode->i_op && inode->i_op->truncate)
-	{
-		/* This doesnt scale but it is meant to be a 2.4 invariant */
-		lock_kernel();
-		inode->i_op->truncate(inode);
-		unlock_kernel();
-	}
-	return 0;
-	
+
 out_truncate:
 	if (inode->i_op && inode->i_op->truncate) {
+		/* This doesnt scale but it is meant to be a 2.4 invariant */
 		lock_kernel();
  		inode->i_op->truncate(inode);
 		unlock_kernel();
	}
	return 0;
  out:
	return -EFBIG;
  }
