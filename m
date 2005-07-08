Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVGHTyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVGHTyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVGHTwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:52:14 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:46090 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262825AbVGHTuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:50:22 -0400
To: linuxram@us.ibm.com
CC: miklos@szeredi.hu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       akpm@osdl.org, mike@waychison.com, bfields@fieldses.org
In-reply-to: <1120845120.30164.139.camel@localhost> (message from Ram on Fri,
	08 Jul 2005 10:52:00 -0700)
Subject: Re: [RFC PATCH 1/8] share/private/slave a subtree
References: <1120816072.30164.10.camel@localhost>
	 <1120816229.30164.13.camel@localhost> <1120817463.30164.43.camel@localhost>
	 <E1Dqttu-0004kx-00@dorka.pomaz.szeredi.hu>
	 <1120839568.30164.88.camel@localhost>
	 <E1Dqw4W-0004sT-00@dorka.pomaz.szeredi.hu> <1120845120.30164.139.camel@localhost>
Message-Id: <E1DqyqO-00057C-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 08 Jul 2005 21:49:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason why I implemented that way, is to less confuse the user and
> provide more flexibility. With my implementation, we have the ability
> to share any part of the tree, without bothering if it is a mountpoint
> or not. The side effect of this operation is, it ends up creating 
> a vfsmount if the dentry is not a mountpoint.
> 
> so when a user says
>       mount --make-shared /tmp/abc
> the tree under /tmp/abc becomes shared. 
> With your suggestion either the user will get -EINVAL or the tree
> under / will become shared. The second behavior will be really
> confusing.

You are right.

> I am ok with -EINVAL. 

I think it should be this then.  These operations are similar to a
remount (they don't actually mount something, just change some
property of a mount).  Remount returns -EINVAL if not performed on the
root of a mount.

> Also there is another reason why I used this behavior. Lets say /mnt
> is a mountpoint and Say a user does
> 		mount make-shared /mnt 
> 
> and then does 
>                 mount --bind /mnt/abc  /mnt1
> 
> NOTE: we need propogation to be set up between /mnt/abc and /mnt1 and
> propogation can only be set up for vfsmounts.  In this case /mnt/abc 
> is not a mountpoint. I have two choices, either return -EINVAL
> or create a vfsmount at that point. But -EINVAL is not consistent
> with standard --bind behavior. So I chose the later behavior.
> 
> Now that we anyway need this behavior while doing bind mounts from
> shared trees, I kept the same behavior for --make-shared.

Well, the mount program can easily implement this behavior if wanted,
just by doing the 'bind dir dir' and then doing 'make-shared dir'.

The other way round (disabling the automatic 'bind dir dir') is much
more difficult.

> > Some notes (maybe outside the code) explaining the mechanism of the
> > propagations would be nice.  Without these it's hard to understand the
> > design decisions behind such an implementation.
> 
> Ok. I will make a small writeup on the mechanism.

That will help, thanks.

Miklos



