Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVELK0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVELK0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 06:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVELK0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 06:26:30 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:33804 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261395AbVELK0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 06:26:04 -0400
Message-ID: <42832F33.1020709@sw.ru>
Date: Thu, 12 May 2005 14:25:55 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix of dcache race leading to busy inodes on umount
References: <42822A2A.6000909@sw.ru> <20050511193352.2c9a9201.akpm@osdl.org>
In-Reply-To: <20050511193352.2c9a9201.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kirill Korotaev <dev@sw.ru> wrote:
> 
>>This patch fixes dcache race between shrink_dcache_XXX functions
>>and dput().
>>
>>Example race scenario:
>>
>>	CPU 0				CPU 1
>>umount /dev/sda1
>>generic_shutdown_super          shrink_dcache_memory()
>>shrink_dcache_parent            dput dentry
>>select_parent                   prune_one_dentry()
>>                                 <<<< child is dead, locks are released,
>>                                   but parent is still referenced!!! >>>>
>>
>>skip dentry->parent,
>>since it's d_count > 0
>>
>>message: BUSY inodes after umount...
>>                                 <<< parent is left on dentry_unused
>>				   list, referencing freed super block
>>
>>We faced these messages about busy inodes constantly after some stress 
>>testing with mount/umount operations parrallel with some other activity.
>>This patch helped the problem.
>>
>>The patch was heavilly tested on 2.6.8 during 2 months,
>>this forward-ported version boots and works ok as well.
>>
> 
> 
> You've provided no description of how the patch solves the problem.
below

>>/* dcache_lock protects shrinker's list */
>>static void shrink_dcache_racecheck(struct dentry *parent, int *racecheck)
>>{
>>	struct super_block *sb;
>>	struct dcache_shrinker *ds;
>>
>>	sb = parent->d_sb;
>>	list_for_each_entry(ds, &sb->s_dshrinkers, list) {
>>		/* is one of dcache shrinkers working on the dentry? */
>>		if (ds->dentry == parent) {
>>			*racecheck = 1;
>>			break;
>>		}
>>	}
>>}
>>
>>
> 
> 
> This all looks awfully hacky.  Why is it done this way, and is there no
> cleaner solution?

Additional patch info:

This patch solves the race mentioned above via introducing per super 
block list of dentries which are being held indirectly by it's child 
which is going away. This usually happens when a child is dput()'ed last 
time and is holding it's parent reference though it is not in any lists 
already and can't be found anywhere. To make sure that 
shrink_dcache_parent() can't shrink dcache tree because of a real 
reference and not such indirect one we check a race condition by looking 
through dcache_shrinker list. If the current dentry is found on 
dcache_shrinker list than it is being referenced indirectly as described 
above and should be waited for, otherwise we really can't shrink the tree.

Why is it so hacky? We tried to develop a solution which minimally 
influences perfomance, not slowdowning a fast path and not introducing 
lock contention via widening existing locks. I'll be happy if someone 
fixes it more efficiently.

Kirill

