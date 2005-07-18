Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVGRRSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVGRRSl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 13:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVGRRSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 13:18:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:61326 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261241AbVGRRS1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 13:18:27 -0400
Subject: Re: shared subtrees implementation writeup
From: Ram Pai <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       mike@waychison.com, bfields@fieldses.org
In-Reply-To: <E1DuTSd-0007TC-00@dorka.pomaz.szeredi.hu>
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120817463.30164.43.camel@localhost>
	 <E1Dqttu-0004kx-00@dorka.pomaz.szeredi.hu>
	 <1120839568.30164.88.camel@localhost>
	 <E1Dqw4W-0004sT-00@dorka.pomaz.szeredi.hu>
	 <1120845120.30164.139.camel@localhost>
	 <E1DqyqO-00057C-00@dorka.pomaz.szeredi.hu>
	 <1121304437.5288.32.camel@localhost>
	 <E1DuTSd-0007TC-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1121707102.5197.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 18 Jul 2005 10:18:22 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-18 at 04:06, Miklos Szeredi wrote:
> Thanks for the writeup, it helps to understand things a bit better.
> However I still don't understand a few things:
> 
> 
> > Section 1. mount:
> > 
> > 	to begin with we have a the following mount tree 
> > 
> > 		         root
> > 		      /	/  \  \ \
> > 		     /	t1  t2 \  \ 
> > 		   t0		t3 \
> > 				    t4
> > 
> > 	note: 
> > 	t0, t1, t2, t3, t4 all contain mounts.
> > 	t1 t2 t3 are the slave of t0. 
> > 	t4 is the slave of t2.
> > 	t4 and t3 is marked as shared.
> > 
> > 	The corresponding propagation tree will be:
> > 
> > 			p0
> > 		      /   \
> > 		     p1   p2
> > 		     /     
> > 	 	     p3	   
> > 
> > 
> > 	***************************************************************
> > 	      p0 contains the mount t0, and contains the slave mount t1
> > 	      p1 contains the mount t2
> > 	      p3 contains the mount t4
> > 	      p2 contains the mount t3
> > 
> > 	  NOTE: you may need to look at this multiple time as you try to
> > 	  	understand the various scenarios.
> > 	***************************************************************
> 
> Why you have p2 and p3?  They contain a single mount only, which could
> directly be slaves to p0 and p1 respectively.  Does it have something
> to do with being shared?

Yes. If the mounts were just slave than they could be a slave member of
their corresponding master pnode, i.e p0 and p1 respectively. But 
in my example above they are also shared. And a shared mount could be
bind mounted with propagation set in either direction. Hence they
deserve a separate pnode.  If it was just a slave mount then binding to
it would not set any propagation and hence there need not be a separate
pnodes to track the propagation.

Just for clarification:
1. a slave mount is represented as a slave member of a pnode.
2. a shared mount is represented as a member of a  pnode.
3. a slave as well as a shared mount is represented a member of
	separate pnode, which in itself is a slave pnode.
4. a private mount is not part of any pnode.
5. a unclone mount is also not part of any pnode.


> 
> BTW, is there a reason not to include the pnode info in 'struct
> vfsmount'?  That would simplify a lot of allocation error cases.
> 
> > 	The key point to be noted in the above set of operations is:
> > 	each pnode does three different operations corresponding to each stage.
> > 
> > 	A. when the pnode is encountered the first time, it has to create
> > 		a new pnode for its child mounts.
> > 	B. when the pnode is encountered again after it has traversed down
> > 	   each slave pnode, it has to associate the slave pnode's newly created
> > 	   pnode with the pnode's newly created pnode.
> > 	C. when the pnode is encountered finally after having traversed through
> > 		all its slave pnodes, it has to create new child mounts
> > 		for each of its member mounts.
> 
> Now why is this needed?  Couldn't each of these be done in a single step?
> 
> I still can't see the reason for having these things done at different
> stages of the traversal.

Yes. This can be done in a single step. And in fact in my latest patches
that I sent yesterday I did exactly that. It works. All that messy
PNODE_UP,PNODE_DOWN,PNODE_MID is all gone. Code has become
much simpler.

The reason this was there earlier was that I was thinking we may need
all these phases for some operations like umount, make_mounted.. 
But as I understand the operations better I am convinced that it is not
required, and you reconfirm that point :)

Thanks,
RP
> 
> Thanks,
> Miklos

