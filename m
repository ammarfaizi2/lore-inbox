Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264875AbTFLQMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbTFLQMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:12:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17891 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264875AbTFLQMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:12:42 -0400
Date: Thu, 12 Jun 2003 17:26:27 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] First casuality of hlist poisoning in 2.5.70
Message-ID: <20030612162627.GJ6754@parcelfarce.linux.theplanet.co.uk>
References: <16103.48257.400430.785367@charged.uio.no> <Pine.LNX.4.44.0306112206430.29133-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306112206430.29133-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 10:22:25PM -0700, Linus Torvalds wrote:

> HOWEVER, I actually suspect that the target really _cannot_ be unhashed, 
> and that the test makes no sense, and the sequence should just be
> 
> 	/* Rehash the dentry onto the same hash as the target */
> 	hlist_del_rcu(&dentry->d_hash);
> 	hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
> 	dentry->d_vfs_flags &= ~DCACHE_UNHASHED;
 
> But I suspect that neither dentry nor target should really ever be
> unhashed by the time we call d_move(). That's reinforced by the fact that
> it looks like a unhashed dentry in d_move() would have been a silent bug
> previously - staying unhashed if it just shared the bucket.

> Al, I'll be really happy having you go over this code too. And whatever we 
> decide is right (enforcing hashedness or whatever), we should assert it, 
> because clearly d_move() has been a bit too subtle for us so far.

Sigh...  The real problem is not in d_move(), but in the way NFS drops
dentries.  That, and the fact that we are eating the consequences of
RCU use in dcache - it had predictably made the entire thing _far_ too
subtle.

We probably should accept that both d_move() arguments can be unhashed.
After the move hashed status of source should remain as it is and
victim^Wtarget should get unhashed.

We _do_ need to sort out the situation with unhashing stuff in NFS - in
particular, the way it deals with mountpoints and with directories is
a mess.  I'm looking through that code, but it's bloody slow analysis
due to RCU.  Premature optimizations and all such...
