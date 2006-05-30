Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWE3BhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWE3BhF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWE3Bgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:36:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932102AbWE3BbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:31:09 -0400
Date: Mon, 29 May 2006 18:35:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 34/61] lock validator: special locking: bdev
Message-Id: <20060529183523.0985b537.akpm@osdl.org>
In-Reply-To: <20060529212554.GH3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212554.GH3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:25:54 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> teach special (recursive) locking code to the lock validator. Has no
> effect on non-lockdep kernels.
> 

There's no description here of the problem which is being worked around. 
This leaves everyone in the dark.

> +static int
> +blkdev_get_whole(struct block_device *bdev, mode_t mode, unsigned flags)
> +{
> +	/*
> +	 * This crockload is due to bad choice of ->open() type.
> +	 * It will go away.
> +	 * For now, block device ->open() routine must _not_
> +	 * examine anything in 'inode' argument except ->i_rdev.
> +	 */
> +	struct file fake_file = {};
> +	struct dentry fake_dentry = {};
> +	fake_file.f_mode = mode;
> +	fake_file.f_flags = flags;
> +	fake_file.f_dentry = &fake_dentry;
> +	fake_dentry.d_inode = bdev->bd_inode;
> +
> +	return do_open(bdev, &fake_file, BD_MUTEX_WHOLE);
> +}

"crock" is a decent description ;)

How long will this live, and what will the fix look like?

(This is all a bit of a pain - carrying these patches in -mm will require
some effort, and they're not ready to go yet, which will lengthen the pain
arbitrarily).

