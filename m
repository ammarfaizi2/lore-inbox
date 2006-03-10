Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWCJIYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWCJIYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbWCJIYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:24:08 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:53157 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751179AbWCJIYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:24:07 -0500
Message-ID: <441138B7.9060809@sw.ru>
Date: Fri, 10 Mar 2006 11:28:39 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Kirill Korotaev <dev@openvz.org>, Jan Blunck <jblunck@suse.de>,
       akpm@osdl.org, viro@zeniv.linux.org.uk, olh@suse.de,
       bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory()
 race (3rd updated patch)]
References: <20060309165833.GK4243@hasse.suse.de>	<441060D2.6090800@openvz.org> <17425.2594.967505.22336@cse.unsw.edu.au>
In-Reply-To: <17425.2594.967505.22336@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

> On Thursday March 9, dev@openvz.org wrote:
> 
>>Andrew,
>>
>>Acked-By: Kirill Korotaev <dev@openvz.org>
> 
> 
> I'm afraid that I'm not convinced.
> 
> 
>>>+static int wait_on_prunes(struct super_block *sb)
>>>+{
>>>+	DEFINE_WAIT(wait);
>>>+	int prunes_remaining = 0;
>>>+
>>>+#ifdef DCACHE_DEBUG
>>>+	printk(KERN_DEBUG "%s: waiting for %d prunes\n", __FUNCTION__,
>>>+	       sb->s_prunes);
>>>+#endif
>>>+
>>>+	spin_lock(&dcache_lock);
>>>+	for (;;) {
>>>+		prepare_to_wait(&sb->s_wait_prunes, &wait,
>>>+				TASK_UNINTERRUPTIBLE);
>>>+		if (!sb->s_prunes)
>>>+			break;
>>>+		spin_unlock(&dcache_lock);
>>>+		schedule();
>>>+		prunes_remaining = 1;
>>>+		spin_lock(&dcache_lock);
>>>+	}
>>>+	spin_unlock(&dcache_lock);
>>>+	finish_wait(&sb->s_wait_prunes, &wait);
>>>+	return prunes_remaining;
>>>+}
> 
> 
> I don't think that a return value from wait_on_prunes is meaningful.
> All it tells us is whether a prune_one_dentry finished before or after
> wait_on_prunes takes the spin_lock.  This isn't very useful
> information as it has no significance to upper levels.
> 
> So:
> 
> 
>>>+		do {
>>>+			shrink_dcache_parent(root);
>>>+		} while(wait_on_prunes(sb));
>>>+
> 
> 
> Suppose shrink_dcache_parent misses on dentry because the inode was being
> iput.  This iput completes immediately that
> shrink_dcache_parent completes.  It decrements ->s_prunes and when
> wait_on_prunes takes dcache_lock, ->s_prunes is zero so the loop
> terminates, and the remaining dentries - the parents of the dentry
> what was undergoing iput - don't get put.
you are right... :/
And this is actually why we originally inserted check for race
in select_parent() under dcache_lock... I just lost my memory :(

> I really think that we need to stop prune_one_dentry from being called
> on dentries for a filesystem that is being unmounted.  With that code
> currently in -git, that means passing a 'struct super_block *' into
> prune_dcache so that it ignores any filesystem with ->s_root==NULL
> unless that filesystem is the filesystem that was passed.
Can try...

Thanks,
Kirill

