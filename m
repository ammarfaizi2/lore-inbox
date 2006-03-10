Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752203AbWCJLSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbWCJLSd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 06:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbWCJLSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 06:18:33 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:55360 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1752203AbWCJLSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 06:18:32 -0500
Message-ID: <44116198.7000000@sw.ru>
Date: Fri, 10 Mar 2006 14:23:04 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jan Blunck <jblunck@suse.de>
CC: Neil Brown <neilb@suse.de>, Kirill Korotaev <dev@openvz.org>,
       akpm@osdl.org, viro@zeniv.linux.org.uk, olh@suse.de,
       bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory()
 race (3rd updated patch)]
References: <20060309165833.GK4243@hasse.suse.de> <441060D2.6090800@openvz.org> <17425.2594.967505.22336@cse.unsw.edu.au> <441138B7.9060809@sw.ru> <20060310105950.GL4243@hasse.suse.de>
In-Reply-To: <20060310105950.GL4243@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>I really think that we need to stop prune_one_dentry from being called
>>>on dentries for a filesystem that is being unmounted.  With that code
>>>currently in -git, that means passing a 'struct super_block *' into
>>>prune_dcache so that it ignores any filesystem with ->s_root==NULL
>>>unless that filesystem is the filesystem that was passed.
>>
>>Can try...
> 
> Can not ... because of down_read(s_umount) before checking s_root :(

> So what do we do now?
> 
>  1. always get the reference counting right outside of dcache_lock
> 
>  2. hack around with different paths for prune_dcache() when called from
>     shrink_dcache_memory() and shrink_dcache_parent()
3. keep the existing patch from me :))))

> I think that we should go for the first.
just an idea which came to my mind:
can't we fix it the following way:
1. fix select_parent() when called from generic_shutdown_super() to loop 
until _all_ dentries are shrinked (not only those, with d_count = 1);
this guarentees that no dentries are left.
2. no dentries are left, but iput() can be in progress.
So can't we simply make invalidate_inodes() to be in a loop with 
schedule() until no busy inodes are left?!

unregister_netdevice() for example, loops until netdev counter drops to 
zero. Why can't we do it the same way? Any objections?

Thanks,
Kirill

