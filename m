Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbVKIP4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbVKIP4j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 10:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVKIP4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 10:56:39 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:15296 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751362AbVKIP4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 10:56:38 -0500
Date: Wed, 9 Nov 2005 15:56:34 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linuxram@us.ibm.com
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
Message-ID: <20051109155634.GY7992@ftp.linux.org.uk>
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <E1EZnbA-000190-00@dorka.pomaz.szeredi.hu> <20051109143107.GV7992@ftp.linux.org.uk> <E1EZrmJ-0001dI-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EZrmJ-0001dI-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 04:22:23PM +0100, Miklos Szeredi wrote:
> > On Wed, Nov 09, 2005 at 11:54:36AM +0100, Miklos Szeredi wrote:
> > > Shouldn't this check go before copy_tree()?  Not much point in copying
> > > the tree if we are sure it won't be used.
> > 
> > Incorrect.  Propagation nodes further down the tree can very well be
> > mountable.
> 
> Can you please give an example.  I'm feeling thick.
> 
> What I see in the code is that the the mount tree is copied, then put
> on the tmp_list, and at the end the newly copied tree is freed with
> umount_tree().

Before it gets freed it may end up being copied.  Example: vfsmounts
A and B are peers, C is a slave of that peer group.  It happens to be
on slave list of B.  B has root deeper than A, which, in turn is deeper
than that of C (e.g. A and B had been created by binding subtrees of
C, which had been made slave afterwards).  We bind on something in A,
outside of the subtree mapped by B.

Alternatively, have A -> (B, D) -> C, with C on slave list of B.  Mountpoint
is within subtrees for A, C and D, but not B.  And no, we can't say "skip B,
just make a slave of tree on A and slap it on C" - correct result is to
have T_A -> T_D -> T_C (i.e. tree on C gets propagation from tree on D).
Which kills the variants with not creating that copy and making subsequent
ones directly from the original tree.
