Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751834AbWCILYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbWCILYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbWCILYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:24:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16317 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751834AbWCILYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:24:04 -0500
Date: Thu, 9 Mar 2006 03:21:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Blunck <jblunck@suse.de>
Cc: balbir@in.ibm.com, viro@zeniv.linux.org.uk, olh@suse.de, neilb@suse.de,
       dev@openvz.org, bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against
 shrink_dcache_memory() race (updated patch)
Message-Id: <20060309032157.0592153e.akpm@osdl.org>
In-Reply-To: <20060309110025.GE4243@hasse.suse.de>
References: <20060308145105.GA4243@hasse.suse.de>
	<20060309063330.GA23256@in.ibm.com>
	<20060309110025.GE4243@hasse.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck <jblunck@suse.de> wrote:
>
> > This change might conflict with the NFS patches in -mm.
>  > 
> 
>  Hmm, right. Andrew, if you want a rediff against -mm just tell me. I'm
>  actually diff'ing against lates linux-2.6.git.

I'll work it out.

Are we all happy with this patch now?

<looks at it>

Cosmetically, I don't think wait_on_prunes() should be concerned about
whether or not it "slept".  That action is not significant and preemptible
kernels can "sleep" at just about any stage.  So I think the concept of
"slept" in there should be replaced with, say, "prunes_remaining" or
something like that.  Consequently the all-important comment over
wait_on_prunes() should be updated to provide a bit more information about
the significance of its return value, please.

Also I think there should be some explanation somewhere which describes why
we can continue to assume that there aren't any prunes left to do after
wait_on_prunes() has dropped dcache_lock.  I mean, once you've dropped the
lock it's usually the case that anything which you examined while holding
that lock now becomes out-of-date and invalid.  I assume the thinking is
that because there's an unmount in progress, nothing can come in and add
new dentries?

IOW: why isn't there a race between wait_on_prunes() and prune_one_dentry()?
