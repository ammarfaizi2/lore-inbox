Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVHLP4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVHLP4R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 11:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVHLP4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 11:56:16 -0400
Received: from hastings.mumak.ee ([194.204.22.4]:30611 "EHLO hastings.mumak.ee")
	by vger.kernel.org with ESMTP id S1750831AbVHLP4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 11:56:16 -0400
Subject: Re: BUG: reiserfs+acl+quota deadlock
From: Tarmo =?ISO-8859-1?Q?T=E4nav?= <tarmo@itech.ee>
To: Jeff Mahoney <jeffm@suse.com>
Cc: "Vladimir V. Saveliev" <vs@namesys.com>, Jan Kara <jack@suse.cz>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, mason@suse.com,
       grev@namesys.com
In-Reply-To: <42FCBC00.2040903@suse.com>
References: <1123643111.27819.23.camel@localhost>
	 <20050810130009.GE22112@atrey.karlin.mff.cuni.cz>
	 <1123684298.14562.4.camel@localhost>
	 <20050810144024.GA18584@atrey.karlin.mff.cuni.cz>
	 <42FCB873.8070900@namesys.com>  <42FCBC00.2040903@suse.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 12 Aug 2005 18:56:00 +0300
Message-Id: <1123862161.14093.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir V. Saveliev wrote:
>  
> > It looks like the problem is that reiserfs_new_inode can be called
> > either having xattrs locked or not.
> > It does unlocking/locking xattrs on error handling path, but has no idea
> > about whether
> > xattrs are locked of not.
> > The attached patch seems to fix the problem.
> > I am not sure whether it is correct way to fix this problem, though.

I tested the patch, it did not fix the problem. Is there any way that I
could help diagnose the problem? (so far I have not tried reiserfs or
kernel debug options, could those help?)


On R, 2005-08-12 at 11:10 -0400, Jeff Mahoney wrote:
> 
> Does this patch actually fix it? It shouldn't.
> 
> The logic is like this: If a default ACL is associated with the parent
> when the inode is created, xattrs will be locked so that the ACL can be
> inherited. Since reiserfs_new_inode is called from the VFS layer with
> inode->i_sem downed, {set,remove}xattr is locked out. The default ACL
> can't be removed/added/changed while reiserfs_new_inode is running.
> Therefore, if there is a default ACL, xattrs must be locked.

I don't know if you read my report on this bug, but note that it had
no requirement for any ACL's to be used (even default ACL's), there was
only need for acl support to be enabled when mounting the partition.



-- 
Tarmo Tänav <tarmo@itech.ee>

