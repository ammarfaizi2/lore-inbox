Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263876AbUEMHSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbUEMHSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 03:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbUEMHQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 03:16:35 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:2863 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263865AbUEMHPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 03:15:55 -0400
Message-ID: <40A32078.FA69C47C@melbourne.sgi.com>
Date: Thu, 13 May 2004 17:15:04 +1000
From: Greg Banks <gnb@melbourne.sgi.com>
Organization: SGI Australian Software Group
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-6mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>
Subject: Re: d_splice_alias() problem.
References: <16521.5104.489490.617269@laputa.namesys.com>
		<16529.56343.764629.37296@cse.unsw.edu.au>
		<409634B9.8D9484DA@melbourne.sgi.com>
		<16534.54704.792101.617408@cse.unsw.edu.au>
		<16542.63130.911881.340894@cse.unsw.edu.au>
		<409F6741.19A29C20@melbourne.sgi.com> <16547.3723.584971.907946@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> > Of course I now have an issue with the misleading name ;-)
> 
> Maybe:   DCACHE_NOT_KNOWN_TO_BE_CONNECTED.
> Unfortunately the absence of the flags is stronger information that
> it's presence and that makes it hard to name...

;-)

> > What I'm wondering is, do we still need DCACHE_DISCONNECTED at all?
> > Perhaps the uses of it could be replaced with combinations of checks
> > of IS_ROOT() and (d == d->d_sb->s_root) ?
> 
> It is still needed.
> Suppose one thread creates a disconnected dentry, and then starts building
> the path from the bottom up.
> When it is half way up another request comes in for the same
> filehandle.  The same dentry is found.  It is now not IS_ROOT, but
> still DCACHE_DISCONNECTED.  Until it is fully connected the second
> request shouldn't proceed, and without the DCACHE_DISCONNECTED flag it
> is expensive to test for connected-ness.  !IS_ROOT certainly isn't
> enough.

Sure, IS_ROOT() only tells you whether a dentry is connected to its parent
and to tell if its connected to the fs root you need to traverse all the
parents.  But nfsd_acceptable() already does this to do permission checks
in the (default) subtree_check case.

So it seems that what the flag gives you is that when its absent and
nosubtree_check is in effect, you know you can short-circuit the connection
walk.  Fair enough.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
