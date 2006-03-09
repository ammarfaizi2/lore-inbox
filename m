Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751870AbWCIL6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbWCIL6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWCIL6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:58:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:54415 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751870AbWCIL6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:58:32 -0500
Date: Thu, 9 Mar 2006 12:58:27 +0100
From: Jan Blunck <jblunck@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: balbir@in.ibm.com, viro@zeniv.linux.org.uk, olh@suse.de, neilb@suse.de,
       dev@openvz.org, bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (updated patch)
Message-ID: <20060309115827.GF4243@hasse.suse.de>
References: <20060308145105.GA4243@hasse.suse.de> <20060309063330.GA23256@in.ibm.com> <20060309110025.GE4243@hasse.suse.de> <20060309032157.0592153e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060309032157.0592153e.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, Andrew Morton wrote:

> >  Hmm, right. Andrew, if you want a rediff against -mm just tell me. I'm
> >  actually diff'ing against lates linux-2.6.git.
> 
> I'll work it out.
> 

Ok, so I'll just send an updated patch against linux-2.6.git adressing your
issues later.

> Cosmetically, I don't think wait_on_prunes() should be concerned about
> whether or not it "slept".  That action is not significant and preemptible
> kernels can "sleep" at just about any stage.  So I think the concept of
> "slept" in there should be replaced with, say, "prunes_remaining" or
> something like that.  Consequently the all-important comment over
> wait_on_prunes() should be updated to provide a bit more information about
> the significance of its return value, please.

Ok, will do.

> Also I think there should be some explanation somewhere which describes why
> we can continue to assume that there aren't any prunes left to do after
> wait_on_prunes() has dropped dcache_lock.  I mean, once you've dropped the
> lock it's usually the case that anything which you examined while holding
> that lock now becomes out-of-date and invalid.  I assume the thinking is
> that because there's an unmount in progress, nothing can come in and add
> new dentries?
> 
> IOW: why isn't there a race between wait_on_prunes() and prune_one_dentry()?

Because outside dcache_lock, either the refcount on the parent dentry is wrong
(therefore select_parent() might return 0) and sb_prunes != 0 or the refcount
is correct and the sb_prunes == 0. Since sb_root == NULL when unmounting the
filesystem there are no new dentries coming in.

> Are we all happy with this patch now?

I'll update the comments and come back to you with an updated patch. Then I'm
fine with the patch.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
