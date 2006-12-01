Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759309AbWLARmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759309AbWLARmN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759308AbWLARmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:42:12 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:51625 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1759190AbWLARmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:42:11 -0500
Message-ID: <4570698C.5060502@oracle.com>
Date: Fri, 01 Dec 2006 09:42:36 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jeff Layton <jlayton@redhat.com>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ensure i_ino uniqueness in filesystems without permanent
 inode numbers (via idr)
References: <457040C4.1000002@redhat.com> <20061201085227.2463b185.randy.dunlap@oracle.com> <20061201172136.GA11669@dantu.rdu.redhat.com>
In-Reply-To: <20061201172136.GA11669@dantu.rdu.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton wrote:
> On Fri, Dec 01, 2006 at 08:52:27AM -0800, Randy Dunlap wrote:
> 
> Thanks for having a look, Randy...
> 
>> s/idr_/iunique_/
> 
> Doh! Can you tell I cut and pasted this email from earlier ones? :-)
> 
>>> - don't attempt to remove inodes with values <100
>> Please explain that one.  (May be obvious to some, but not to me.)
> 
> Actually, we probably don't need to do that now. My thought here was to add
> a low range of i_ino numbers that could be used by the filesystem code without
> needing to call iunique (in particular for things like the root inode in the
> filesystem). It's probably best to not do this though and let the filesystem
> handle it on its own.
> 
>> Better to post patches inline (for review) rather than as attachments.
> 
> Here's an updated (but untested) patch based on your suggestions. I also went
> ahead and made the exported symbols GPL-only since that seems like it would be
> appropriate here. Any further thoughts on it?

Just needs new/updated patch description.
and one "typo" fixed.

> diff --git a/fs/inode.c b/fs/inode.c
> index 26cdb11..e45cec9 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -706,6 +708,32 @@ retry:
>  
>  EXPORT_SYMBOL(iunique);
>  
> +int iunique_register(struct inode *inode, int max_reserved)
> +{
> +	int rv;
> +
> +	rv = idr_pre_get(&inode->i_sb->s_inode_ids, GFP_KERNEL);
> +	if (! rv)

No space after !, just:
	if (!rv)

> +		return -ENOMEM;
> +
> +	spin_lock(&inode->i_sb->s_inode_ids_lock);
> +	rv = idr_get_new_above(&inode->i_sb->s_inode_ids, inode,
> +		max_reserved+1, (int *) &inode->i_ino);
> +	inode->i_generation = inode->i_sb->s_generation++;
> +	spin_unlock(&inode->i_sb->s_inode_ids_lock);
> +	return rv;
> +}

Thanks.
-- 
~Randy
