Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752079AbWCGHQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbWCGHQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 02:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbWCGHQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 02:16:57 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:27272 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1752079AbWCGHQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 02:16:57 -0500
Message-ID: <440D3475.4040603@sw.ru>
Date: Tue, 07 Mar 2006 10:21:25 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Neil Brown <neilb@suse.de>, Balbir Singh <bsingharora@gmail.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olh@suse.de>, Jan Blunck <jblunck@suse.de>,
       Kirill Korotaev <dev@openvz.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
References: <17414.38749.886125.282255@cse.unsw.edu.au> <17419.53761.295044.78549@cse.unsw.edu.au> <661de9470603052332s63fd9b2crd60346324af27fbf@mail.gmail.com> <17420.59580.915759.44913@cse.unsw.edu.au> <440D2536.60005@sw.ru> <20060307070301.GA12165@in.ibm.com>
In-Reply-To: <20060307070301.GA12165@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>No, it looks as it is not :(
>>Have you noticed my comment about "count" argument to prune_dcache()?
>>For example, prune_dcache() is called from shrink_dcache_parent() which 
>>is called in many places and not all of them have PF_MEMALLOC or 
>>s_umount semaphore for write. But prune_dcache() doesn't care for super 
>>blocks etc. It simply shrinks N dentries which are found _first_.
>>
>>So the condition:
>>+		if ((current->flags & PF_MEMALLOC) &&
>>+			!(ret = down_read_trylock(&s->s_umount))) {
>>is not always true when the race occurs, as PF_MEMALLOC is not always set.
> 
> 
> I understand your comment about shrink_dcache_parent() being called
> from several places. prune_one_dentry() would eventually dput the parent,
> but unmount would go ahead and unmount the filesystem before the
> dput of the parent could happen.
exactly.

> Given that background, I thought our main concern was with respect to
> unmount. The race was between shrink_dcache_parent() (called from unmount)
> and shrink_dcache_memory() (called from the allocator), hence the fix
> for the race condition.
Partial fix doesn't make much sense from my point of view.

> I just noticied that 2.6.16-rc* now seems to have drop_slab() where
> PF_MEMALLOC is not set. So, we can still race with my fix if there
> if /proc/sys/vm/drop_caches is written to and unmount is done in parallel.
> 
> A simple hack would be to set PF_MEMALLOC in drop_slab(), but I do not
> think it is a good idea.
Yeah, playing with PF_MEMALLOC can be not so good idea :/
And as it doesn't help in other cases it looks unpromising...

>>>Have you had any other feedback on this?
>>here it is :)
> Thanks for your detailed feedback
Sorry, that I did it too late :/

Thanks,
Kirill


