Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTHYSun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTHYSun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:50:43 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:62482 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262070AbTHYSul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:50:41 -0400
Date: Mon, 25 Aug 2003 19:50:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Samphan Raruenrom <samphan@nectec.or.th>
Cc: Jens Axboe <axboe@image.dk>, linux-kernel@vger.kernel.org,
       Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
Message-ID: <20030825195026.A10305@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Samphan Raruenrom <samphan@nectec.or.th>,
	Jens Axboe <axboe@image.dk>, linux-kernel@vger.kernel.org,
	Linux TLE Team <rdi1@opentle.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <3F4A53ED.60801@nectec.or.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F4A53ED.60801@nectec.or.th>; from samphan@nectec.or.th on Tue, Aug 26, 2003 at 01:22:37AM +0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 01:22:37AM +0700, Samphan Raruenrom wrote:
>   #include <linux/sysctl.h>
>   #include <linux/proc_fs.h>
>   #include <linux/init.h>
> +#include <linux/namespace.h>
> +#include <linux/mount.h>

your mailer is screwed.

> 
> +	case CDROM_MOUNT_STATUS: {
> +		struct super_block *sb = get_super(dev);
> +		if (sb == NULL) return -EINVAL;
> +		down_read(&current->namespace->sem);
> +		struct vfsmount *mnt = NULL;
> +		struct list_head *p;
> +		list_for_each(p, &current->namespace->list) {
> +			struct vfsmount *m = list_entry(p, struct vfsmount, mnt_list);
> +			if (sb == m->mnt_sb) {
> +				mnt = m; break;
> +			}
> +		}
> +		up_read(&current->namespace->sem);		
> +		drop_super(sb);		
> +		int mstat = 0; /* 0 not mounted, 1 umount ok, 2 umount EBUSY */
> +		if (mnt) mstat = 1 + (atomic_read(&mnt->mnt_count) > 1);
> +		cdinfo(CD_DO_IOCTL, "mount status(%s) = %d\n", mnt->mnt_devname, mstat);
> +		return mstat;

WTF?  This is not only a layering violation but also totally racy.

Rejected.

