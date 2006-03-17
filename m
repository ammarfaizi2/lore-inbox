Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932745AbWCQONM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbWCQONM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932747AbWCQONL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:13:11 -0500
Received: from mail.parknet.jp ([210.171.160.80]:62224 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932745AbWCQONK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:13:10 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix a race condition between ->i_mapping and iput()
References: <87hd65geeh.fsf@duaron.myhome.or.jp>
	<20060316144906.3e646f7e.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 17 Mar 2006 23:13:02 +0900
In-Reply-To: <20060316144906.3e646f7e.akpm@osdl.org> (Andrew Morton's message of "Thu, 16 Mar 2006 14:49:06 -0800")
Message-ID: <87fylhgnwx.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>> This patch takes ref-count of bdev's inode for fs's inode before
>> setting a ->i_mapping, and the clear_inode() of fs's inode does iput().
>> So, if fs's inode is still living, bdev's inode shouldn't be freed.
>> 
>
> OK, so to rephrase:
>
> Whenever /dev/sda's inode->i_mapping points at a kernel-internal blockdev
> inode's i_data, we will hold a ref on that blockdev inode, to pin its
> i_data.  That sounds sane.

Yes, thanks.

This approach may have one issue. If user is using a on-memory fs as
/dev (i.e. udev), the inode is never freed, so blockdev's inode is
also never freed.

And if user is creating the many block special file, blockdev's inode
is also pinned additionally.

Probably we can call a igrab() for ->i_mapping instead of this approach,
however it's "run-time overhead vs memory space" trade-off.

>> diff -puN fs/block_dev.c~i_mapping-race-fix-2 fs/block_dev.c
>> --- linux-2.6/fs/block_dev.c~i_mapping-race-fix-2	2006-03-11 16:19:07.000000000 +0900
>> +++ linux-2.6-hirofumi/fs/block_dev.c	2006-03-11 17:52:11.000000000 +0900
>> @@ -418,21 +418,31 @@ EXPORT_SYMBOL(bdput);
>>  static struct block_device *bd_acquire(struct inode *inode)
>>  {
>>  	struct block_device *bdev;
>> +
>>  	spin_lock(&bdev_lock);
>>  	bdev = inode->i_bdev;
>> -	if (bdev && igrab(bdev->bd_inode)) {
>> +	if (bdev) {
>> +		atomic_inc(&bdev->bd_inode->i_count);
>
> No longer checking (I_FREEING|I_WILL_FREE).  Why was this change included?

With this patch, inode->i_bdev is freed in clear_inode() after the
inode became the I_FREEING.

The caller is holding a inode's ref, and if the inode->i_bdev != NULL,
->i_bdev->bd_inode never have the I_FREEING/I_WILL_FREE.  So we don't
need to check I_FREEING/I_WILL_FREE anymore.

>> -		if (inode->i_bdev)
>> -			__bd_forget(inode);
>> -		inode->i_bdev = bdev;
>> -		inode->i_mapping = bdev->bd_inode->i_mapping;
>> -		list_add(&inode->i_devices, &bdev->bd_inodes);
>> +		if (!inode->i_bdev) {
>> +			/*
>> +			 * We take an additional bd_inode->i_count for inode,
>> +			 * and it's released in clear_inode() of inode.
>> +			 * So, we can access it via ->i_mapping always
>> +			 * without igrab().
>> +			 */
>> +			atomic_inc(&bdev->bd_inode->i_count);
>> +			inode->i_bdev = bdev;
>> +			inode->i_mapping = bdev->bd_inode->i_mapping;
>> +			list_add(&inode->i_devices, &bdev->bd_inodes);
>> +		}
>
> And why this change?  The removal of the __bd_forget() and the changed
> behaviour if (inode->i_bdev != NULL)?

With the above change, we don't need to care the case of igrab()
returns NULL anymore. Since inode->i_bdev->bd_inode never has the
I_FREEING, we don't need to call __bd_forget() for that case.

I think we need to address an only following simple race here.

              cpu0                                    cpu1
-----------------------------------+-----------------------------------------
bdev = bdget(inode->i_rdev);       
if (bdev) {                        
				   	bdev = bdget(inode->i_rdev);
				   	if (bdev) {
						spin_lock(&bdev_lock);
						if (!inode->i_bdev) {
							[...]
							inode->i_bdev = bdev;
	spin_lock(&bdev_lock);

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
