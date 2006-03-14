Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752105AbWCNCc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbWCNCc0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 21:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbWCNCc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 21:32:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11491 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752105AbWCNCcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 21:32:25 -0500
Date: Mon, 13 Mar 2006 18:29:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: agk@redhat.com, gregkh@suse.de, neilb@suse.de, lmb@suse.de,
       dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dm/md dependency tree in sysfs: bd_claim_by_disk
Message-Id: <20060313182943.437c0d43.akpm@osdl.org>
In-Reply-To: <4415EF35.2010402@ce.jp.nec.com>
References: <4415EC4B.4010003@ce.jp.nec.com>
	<4415EF35.2010402@ce.jp.nec.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jun'ichi Nomura" <j-nomura@ce.jp.nec.com> wrote:
>
>  Variants of bd_claim_by_kobject which takes gendisk instead
>  of kobject and do kobject_{get,put}(&gendisk->slave_dir).
> 
>  Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> 
>   include/linux/genhd.h |   13 +++++++++++++
>   1 files changed, 13 insertions(+)
> 
>  --- linux-2.6.16-rc6.orig/include/linux/genhd.h	2006-03-11 17:12:55.000000000 -0500
>  +++ linux-2.6.16-rc6/include/linux/genhd.h	2006-03-13 11:24:13.000000000 -0500
>  @@ -421,6 +424,19 @@ static inline struct block_device *bdget
>   	return bdget(MKDEV(disk->major, disk->first_minor) + index);
>   }
>   
>  +static inline int bd_claim_by_disk(struct block_device *bdev,
>  +					void *holder, struct gendisk *disk)
>  +{
>  +	return bd_claim_by_kobject(bdev, holder, kobject_get(disk->slave_dir));
>  +}
>  +
>  +static inline void bd_release_from_disk(struct block_device *bdev,
>  +					struct gendisk *disk)
>  +{
>  +	bd_release_from_kobject(bdev, disk->slave_dir);
>  +	kobject_put(disk->slave_dir);
>  +}
>  +

genhd.h doesn't include kobject.h, so this only compiles due to luck.

An alternative to adding possibly risky nested header inclusions would be
to uninline these functions.

