Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVELIbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVELIbq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVELIbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:31:45 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:35210 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261327AbVELIbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:31:24 -0400
Message-ID: <42831459.2000008@sw.ru>
Date: Thu, 12 May 2005 12:31:21 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix of dcache race leading to busy inodes on umount
References: <42822A2A.6000909@sw.ru> <20050511192942.07614243.akpm@osdl.org>
In-Reply-To: <20050511192942.07614243.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>This patch fixes dcache race between shrink_dcache_XXX functions
>>and dput().
> 
> 
> 
>>-void dput(struct dentry *dentry)
>>+static void dput_recursive(struct dentry *dentry, struct dcache_shrinker *ds)
>> {
>>-	if (!dentry)
>>-		return;
>>-
>>-repeat:
>> 	if (atomic_read(&dentry->d_count) == 1)
>> 		might_sleep();
>> 	if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
>> 		return;
>>+	dcache_shrinker_del(ds);
>> 
>>+repeat:
>> 	spin_lock(&dentry->d_lock);
>> 	if (atomic_read(&dentry->d_count)) {
>> 		spin_unlock(&dentry->d_lock);
>>@@ -182,6 +253,7 @@ unhash_it:
>> 
>> kill_it: {
>> 		struct dentry *parent;
>>+		struct dcache_shrinker lds;
>> 
>> 		/* If dentry was on d_lru list
>> 		 * delete it from there
>>@@ -191,18 +263,43 @@ kill_it: {
>>   			dentry_stat.nr_unused--;
>>   		}
>>   		list_del(&dentry->d_child);
>>+		parent = dentry->d_parent;
>>+		dcache_shrinker_add(&lds, parent, dentry);
>> 		dentry_stat.nr_dentry--;	/* For d_free, below */
>> 		/*drops the locks, at that point nobody can reach this dentry */
>> 		dentry_iput(dentry);
>>-		parent = dentry->d_parent;
>> 		d_free(dentry);
>> 		if (dentry == parent)
> 
> 
> Aren't we leaving local variable `lds' on the global list here?
yup, my fault.
You patch solves this.

Kirill

