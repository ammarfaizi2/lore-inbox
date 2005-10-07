Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030525AbVJGR2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525AbVJGR2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbVJGR2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:28:47 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:5642 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1030526AbVJGR2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:28:46 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1128702227.8583.69.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Fri, 07 Oct 2005 12:23:47 -0400)
Subject: Re: [RFC] atomic create+open
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
	 <1128620528.16534.26.camel@lade.trondhjem.org>
	 <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
	 <1128623899.31797.14.camel@lade.trondhjem.org>
	 <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu>
	 <1128626258.31797.34.camel@lade.trondhjem.org>
	 <E1ENcAr-0003jz-00@dorka.pomaz.szeredi.hu>
	 <1128633138.31797.52.camel@lade.trondhjem.org>
	 <E1ENlI2-0004Gt-00@dorka.pomaz.szeredi.hu>
	 <1128692289.8519.75.camel@lade.trondhjem.org>
	 <E1ENslH-00057W-00@dorka.pomaz.szeredi.hu>
	 <1128698035.8583.36.camel@lade.trondhjem.org>
	 <E1ENu8h-0005Kd-00@dorka.pomaz.szeredi.hu> <1128702227.8583.69.camel@lade.trondhjem.org>
Message-Id: <E1ENvzx-0005VT-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 07 Oct 2005 19:27:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > Which may return yet another result for the dentry and another race.
> > > There is no guarantee that you will ever make progress if someone is
> > > doing something like.
> > > 
> > > while true
> > > do
> > >   echo "1" > foo
> > >   echo "2" > foo
> > > done
> > > 
> > > on the server.
> > 
> > Not good example. This won't change the file, only the contents.
> > Something with rename would be better.
> 
> Sorry, yes. This tweak should demonstrate what I meant
> 
> while true
> do
>   echo "1" > foo
>   echo "2" > bar
>   mv bar foo
> done
> 
> > We are still pitting two different races against each other.  I can't
> > see such a big difference in ugliness...
> 
> No we're not. I telling you that your open_create is not a solution for
> the problems we have with open in NFSv4.

OK, I think I see the problem better now.

> If it doesn't do atomic lookup+open, then I have an unfixable race. Any
> "solution" that requires NFS to assume that the dcache will remain
> consistent with the server namespace across more than one RPC operation
> is prone to races.
> 
> OTOH mount/umount races are fixable since they involve only the local
> namespace. Just add locking.

You _could_ take the namespace semaphore across lookup_hash() and
follow_mount(), but I'm not sure everybody would like that.

Are you planning to post a patch?  Atomic open+create is something
that FUSE wants as well, so it would be nice to get a proper solution
into the kernel.

I'll think a bit more about solving the mount thing properly.

Miklos
