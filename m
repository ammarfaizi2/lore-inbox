Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTHYUDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 16:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbTHYUDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 16:03:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32976 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262198AbTHYUDk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 16:03:40 -0400
Date: Mon, 25 Aug 2003 21:03:32 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Samphan Raruenrom <samphan@nectec.or.th>
Cc: Jens Axboe <axboe@image.dk>, linux-kernel@vger.kernel.org,
       Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
Message-ID: <20030825200332.GJ454@parcelfarce.linux.theplanet.co.uk>
References: <3F4A53ED.60801@nectec.or.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4A53ED.60801@nectec.or.th>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 01:22:37AM +0700, Samphan Raruenrom wrote:
> Hi,
> 
> This patch add a new ioctl MOUNT_STATUS to the 2.4 kernel's cdrom
> device. It'll be used as an API to query the mount status of a
> cdrom :-
> 
> CDROM_MOUNT_STATUS
> Return :-
> 0 = not mount.
> 1 = mounted, but not in-use. It is ok to umount.
> 2 = busy. Umount will result in getting EBUSY.
> <0 = error.

Huh?   And what, pray tell, makes cdrom special?  Not to mention
the use of ioctl, the inherent raciness of the interface and the fact
that yes,
 
> This same functionality can be done in user-space,

... which should be the end of it.

> +	case CDROM_MOUNT_STATUS: {
> +		struct super_block *sb = get_super(dev);
> +		if (sb == NULL) return -EINVAL;
> +		down_read(&current->namespace->sem);
> +		struct vfsmount *mnt = NULL;
> +		struct list_head *p;
> +		list_for_each(p, &current->namespace->list) {
> +			struct vfsmount *m = list_entry(p, struct vfsmount, 
> mnt_list);
> +			if (sb == m->mnt_sb) {
> +				mnt = m; break;
> +			}
> +		}
> +		up_read(&current->namespace->sem);		

And what about other namespaces?

> +		drop_super(sb);		
> +		int mstat = 0; /* 0 not mounted, 1 umount ok, 2 umount EBUSY 
> */
> +		if (mnt) mstat = 1 + (atomic_read(&mnt->mnt_count) > 1);

Or the possibility that
	* mnt might've been freed by that point.
	* we might have the damn thing mounted in several places, some
busy, some not.
	* cdrom had been used not by mount.
	* cdrom had been mounted just as we had decided to tell that it's
not busy.
