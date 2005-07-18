Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVGRLIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVGRLIp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 07:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVGRLIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 07:08:42 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:9744 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261644AbVGRLHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 07:07:38 -0400
To: linuxram@us.ibm.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       mike@waychison.com, bfields@fieldses.org
In-reply-to: <1121304437.5288.32.camel@localhost> (message from Ram on Wed, 13
	Jul 2005 18:27:17 -0700)
Subject: shared subtrees implementation writeup
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120817463.30164.43.camel@localhost>
	 <E1Dqttu-0004kx-00@dorka.pomaz.szeredi.hu>
	 <1120839568.30164.88.camel@localhost>
	 <E1Dqw4W-0004sT-00@dorka.pomaz.szeredi.hu>
	 <1120845120.30164.139.camel@localhost>
	 <E1DqyqO-00057C-00@dorka.pomaz.szeredi.hu> <1121304437.5288.32.camel@localhost>
Message-Id: <E1DuTSd-0007TC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 18 Jul 2005 13:06:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the writeup, it helps to understand things a bit better.
However I still don't understand a few things:


> Section 1. mount:
> 
> 	to begin with we have a the following mount tree 
> 
> 		         root
> 		      /	/  \  \ \
> 		     /	t1  t2 \  \ 
> 		   t0		t3 \
> 				    t4
> 
> 	note: 
> 	t0, t1, t2, t3, t4 all contain mounts.
> 	t1 t2 t3 are the slave of t0. 
> 	t4 is the slave of t2.
> 	t4 and t3 is marked as shared.
> 
> 	The corresponding propagation tree will be:
> 
> 			p0
> 		      /   \
> 		     p1   p2
> 		     /     
> 	 	     p3	   
> 
> 
> 	***************************************************************
> 	      p0 contains the mount t0, and contains the slave mount t1
> 	      p1 contains the mount t2
> 	      p3 contains the mount t4
> 	      p2 contains the mount t3
> 
> 	  NOTE: you may need to look at this multiple time as you try to
> 	  	understand the various scenarios.
> 	***************************************************************

Why you have p2 and p3?  They contain a single mount only, which could
directly be slaves to p0 and p1 respectively.  Does it have something
to do with being shared?

BTW, is there a reason not to include the pnode info in 'struct
vfsmount'?  That would simplify a lot of allocation error cases.

> 	The key point to be noted in the above set of operations is:
> 	each pnode does three different operations corresponding to each stage.
> 
> 	A. when the pnode is encountered the first time, it has to create
> 		a new pnode for its child mounts.
> 	B. when the pnode is encountered again after it has traversed down
> 	   each slave pnode, it has to associate the slave pnode's newly created
> 	   pnode with the pnode's newly created pnode.
> 	C. when the pnode is encountered finally after having traversed through
> 		all its slave pnodes, it has to create new child mounts
> 		for each of its member mounts.

Now why is this needed?  Couldn't each of these be done in a single step?

I still can't see the reason for having these things done at different
stages of the traversal.

Thanks,
Miklos
