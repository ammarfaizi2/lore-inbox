Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWI2Mw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWI2Mw5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 08:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWI2Mw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 08:52:57 -0400
Received: from ns2.suse.de ([195.135.220.15]:5515 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964886AbWI2Mw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 08:52:56 -0400
From: Neil Brown <neilb@suse.de>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Fri, 29 Sep 2006 22:52:41 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17693.5913.393686.223172@cse.unsw.edu.au>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: md deadlock (was Re: 2.6.18-mm2)
In-Reply-To: message from Peter Zijlstra on Friday September 29
References: <20060928014623.ccc9b885.akpm@osdl.org>
	<6bffcb0e0609280454n34d40c0la8786e1eba6dcdf3@mail.gmail.com>
	<1159531923.28131.80.camel@taijtu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday September 29, a.p.zijlstra@chello.nl wrote:
> On Thu, 2006-09-28 at 13:54 +0200, Michal Piotrowski wrote:
> 
> Looks like a real deadlock here. It seems to me #2 is the easiest to
> break.

I guess it could deadlock if you tried to add /dev/md0 as a component
of /dev/md0.  I should probably check for that somewhere.
In other cases the array->member ordering ensures there is no
deadlock.

> 
> static int md_open(struct inode *inode, struct file *file)
> {
> 	/*
> 	 * Succeed if we can lock the mddev, which confirms that
> 	 * it isn't being stopped right now.
> 	 */
> 	mddev_t *mddev = inode->i_bdev->bd_disk->private_data;
> 	int err;
> 
> 	if ((err = mddev_lock(mddev)))
> 		goto out;
> 
> 	err = 0;
> 	mddev_get(mddev);
> 	mddev_unlock(mddev);
> 
> 	check_disk_change(inode->i_bdev);
>  out:
> 	return err;
> }
> 
> mddev_get() is a simple atomic_inc(), and I fail to see how waiting for
> the lock makes any difference.

Hmm... I"m pretty sure I do want some sort of locking there - to make
sure that the
		if (atomic_read(&mddev->active)>2) {
test in do_md_stop actually means something.  However it does seem
that the locking I have doesn't really guarantee anything much.

But I really think that this locking order should be allowed.  md
should ensure that there are never any loops in the array->member
ordering, and somehow that needs to be communicated to lockdep.

One of the items on my todo list is to sort out the lifetime rules of
md devices (once accessed, they currently never disappear).  Getting
this locking right should be part of that.

NeilBrown
