Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWAWIKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWAWIKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 03:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWAWIKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 03:10:50 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:11818 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750997AbWAWIKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 03:10:50 -0500
Message-ID: <43D48FD8.1000503@sw.ru>
Date: Mon, 23 Jan 2006 11:12:08 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jan Blunck <jblunck@suse.de>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
References: <20060120203645.GF24401@hasse.suse.de> <20060122212243.20ce26c5.akpm@osdl.org>
In-Reply-To: <20060122212243.20ce26c5.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Kirill Korotaev <dev@sw.ru> discovered a race between shrink_dcache_parent()
>>and shrink_dcache_memory(). That one is based on dput() is calling
>>dentry_iput() too early and therefore is giving up the dcache_lock. This leads
>>to the situation that the parent dentry might be still referenced although all
>>childs are already dead. This parent is ignore by a concurrent select_parent()
>>call which might be the reason for busy inode after umount failures.
>>
>>This is from Kirill's original patch:
>>
>>CPU 1                    CPU 2
>>~~~~~                    ~~~~~
>>umount /dev/sda1
>>generic_shutdown_super   shrink_dcache_memory
>>shrink_dcache_parent     prune_one_dentry
>>select_parent            dput     <<<< child is dead, locks are released,
>>                                       but parent is still referenced!!! >>>>
>>skip dentry->parent,
>>since it's d_count > 0
>>
>>message: BUSY inodes after umount...
>>                                  <<< parent is left on dentry_unused list,
>>                                      referencing freed super block >>>
>>
>>This patch is introducing dput_locked() which is doing all the dput work
>>except of freeing up the dentry's inode and memory itself. Therefore, when the
>>dcache_lock is given up, all the reference counts of the parents are correct.
>>prune_one_dentry() must also use the dput_locked version and free up the
>>inodes and the memory of the parents later. Otherwise we have an incorrect
>>reference count on the parents of the dentry to prune.
>>
>>...
> 
> 
>>-void dput(struct dentry *dentry)
>>+static void dput_locked(struct dentry *dentry, struct list_head *list)
>> {
>> 	if (!dentry)
>> 		return;
>> 
>>-repeat:
>>-	if (atomic_read(&dentry->d_count) == 1)
>>-		might_sleep();
>>-	if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
>>+	if (!atomic_dec_and_test(&dentry->d_count))
>> 		return;
>> 
>>+
>>
>>...
>>
>>+void dput(struct dentry *dentry)
>>+{
>>+	LIST_HEAD(free_list);
>>+
>>+	if (!dentry)
>>+		return;
>>+
>>+	if (atomic_add_unless(&dentry->d_count, -1, 1))
>>+		return;
>>+
>>+	spin_lock(&dcache_lock);
>>+	dput_locked(dentry, &free_list);
>>+	spin_unlock(&dcache_lock);
> 
> 
> This seems to be an open-coded copy of atomic_dec_and_lock()?

Yeah, this is what I also didn't like...
Why do it this way, when it's _really_ _possible_ to use old-good 
atomic_dec_and_test() keeping logic more clear?

Kirill

