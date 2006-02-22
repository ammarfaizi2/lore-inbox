Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbWBVWU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWBVWU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWBVWU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:20:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34180 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751535AbWBVWUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:20:55 -0500
Message-ID: <43FCE40A.1010206@ce.jp.nec.com>
Date: Wed, 22 Feb 2006 17:22:02 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH 1/3] sysfs representation of stacked devices (common)
 (rev.2)
References: <43FC8C00.5020600@ce.jp.nec.com> <43FC8D8C.1060904@ce.jp.nec.com> <20060222184853.GB13638@suse.de>
In-Reply-To: <20060222184853.GB13638@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for comments.

Greg KH wrote:
>>+/* This is a mere directory in sysfs. No methods are needed. */
>>+static struct kobj_type bd_holder_ktype = {
>>+	.release	= NULL,
>>+	.sysfs_ops	= NULL,
>>+	.default_attrs	= NULL,
>>+};
> 
> That doesn't look right.  You always need a release function.

I'll move them out to gendisk/hd_struct creation with proper
release function.

I thought it's correct because NULL release function is
just ignored in kobject_cleanup() and it let outside function
to release the whole structure.
But it seems wrong to embed these additional kobjects in
the structures which are logically separate from them.

>>+static inline void del_holder_dir(struct block_device *bdev)
>>+{
>>+	/*
>>+	 * Don't kobject_unregister to avoid memory allocation
>>+	 * in kobject_hotplug.
>>+	 */
>>+	kobject_del(&bdev->bd_holder_dir);
>>+	kobject_put(&bdev->bd_holder_dir);
>>+}
> 
> No, do it correctly please.

OK, I'll change them to kobject_unregister() and do it
when gendisk/hd_struct is removed.
Then we can avoid possible memory allocation in dm's atomic
operation, too.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.
