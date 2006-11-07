Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753095AbWKGU3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbWKGU3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753100AbWKGU3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:29:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753095AbWKGU3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:29:06 -0500
Date: Tue, 7 Nov 2006 12:28:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Ingo Molnar <mingo@elte.hu>, Eric Sandeen <sandeen@sandeen.net>,
       Srinivasa DS <srinivasa@in.ibm.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-Id: <20061107122837.54828e24.akpm@osdl.org>
In-Reply-To: <20061107183459.GG6993@agk.surrey.redhat.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 18:34:59 +0000
Alasdair G Kergon <agk@redhat.com> wrote:

> From: Srinivasa Ds <srinivasa@in.ibm.com>
> 
> On debugging I found out that,"dmsetup suspend <device name>" calls
> "freeze_bdev()",which locks "bd_mount_mutex" to make sure that no new mounts
> happen on bdev until thaw_bdev() is called.  This "thaw_bdev()" is getting
> called when we resume the device through "dmsetup resume <device-name>".
> Hence we have 2 processes,one of which locks "bd_mount_mutex"(dmsetup
> suspend) and another(dmsetup resume) unlocks it.                                               

So...  what does this have to do with switching from mutex to semaphore?

Perhaps this works around the debugging code which gets offended if a mutex
is unlocked by a process which didn't do the lock?

If so, it's a bit sad to switch to semaphore just because of some errant
debugging code.  Perhaps it would be better to create a new
mutex_unlock_stfu() which suppresses the warning?


> --- linux-2.6.19-rc4.orig/fs/buffer.c	2006-11-07 17:06:20.000000000 +0000
> +++ linux-2.6.19-rc4/fs/buffer.c	2006-11-07 17:26:04.000000000 +0000
> @@ -188,7 +188,9 @@ struct super_block *freeze_bdev(struct b
>  {
>  	struct super_block *sb;
>  
> -	mutex_lock(&bdev->bd_mount_mutex);
> +	if (down_trylock(&bdev->bd_mount_sem))
> +		return -EBUSY;
> +

This is a functional change which isn't described in the changelog.  What's
happening here?

