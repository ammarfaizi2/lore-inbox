Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWCHDFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWCHDFO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWCHDFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:05:14 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:34503 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932387AbWCHDFL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:05:11 -0500
Date: Wed, 8 Mar 2006 08:35:00 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Neil Brown <neilb@suse.de>
Cc: Kirill Korotaev <dev@sw.ru>, Balbir Singh <bsingharora@gmail.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olh@suse.de>, Jan Blunck <jblunck@suse.de>,
       Kirill Korotaev <dev@openvz.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060308030500.GB29327@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <17414.38749.886125.282255@cse.unsw.edu.au> <17419.53761.295044.78549@cse.unsw.edu.au> <661de9470603052332s63fd9b2crd60346324af27fbf@mail.gmail.com> <17420.59580.915759.44913@cse.unsw.edu.au> <440D2536.60005@sw.ru> <17422.9555.635650.460131@cse.unsw.edu.au> <20060308021731.GA29327@in.ibm.com> <17422.17387.691138.193521@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17422.17387.691138.193521@cse.unsw.edu.au>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think that in most cases, the race doesn't matter if
> shrink_dcache_memory misses a dentry because someone else is holding a
> temporary reference, it really doesn't matter.
> Similarly most callers of shrink_dcache_parent are happy with a
> best-effort.

I agree.

> 
> I should have been more explicit that the patch was against
> 2.6.16-rc5-mm2.  This contains some dcache patches to allow nfs
> filesystem to share superblocks, and one of the patches replaces the
> calls to shrink_dcache_parent and shrink_dcache_anon with a single
> call to a new function: shrink_dcache_sb.
>

shrink_dcache_parent() has been added back to generic_shutdown_super in
-mm3 (just checked). With that being the case, I have only one concern
with your patch

wait_on_prunes() breaks out if sb->prunes == 0. What if shrink_dcache_parent()
now calls select_parent(). select_parent() could still find entries 
with d_count > 0 and skip them and shrink_dcache_memory() can still cause
the race condition to occur.

I think pushing wait_on_prunes() to after shrink_dcache_parent() will
most likely solve the race.

 
> Thanks for the feedback

Your welcome!

> 
> NeilBrown

Balbir

-- 
I'm extremely grateful that hundreds of you have taken time to read these
patches, and to detect and report errors that you've found.
Your comments have helped me improve enormously. But I must confess that
I'm also disappointed to have had absolutely no feedback so far on several of
the patches on which I worked hardest when I was preparing these patches.
Could it be that (1) you've said nothing about them because I somehow managed
to get the details perfect? Or is it that (2) you shy away and are busy, hence
you are unable to spend more than a few minutes on any particular topic?
Although I do like to think that readers like to provide feedback, I fear that
hypothesis (1) is far less likely than hypothesis (2). 

Adapted from Don Knuth's comments on feedback for his exercises

