Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTEDUvr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 16:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbTEDUvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 16:51:46 -0400
Received: from [12.47.58.20] ([12.47.58.20]:6988 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261710AbTEDUvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 16:51:44 -0400
Date: Sun, 4 May 2003 14:05:37 -0700
From: Andrew Morton <akpm@digeo.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] how to fix is_local_disk()?
Message-Id: <20030504140537.50310417.akpm@digeo.com>
In-Reply-To: <20030504191013.A10659@lst.de>
References: <20030504090003.A7285@lst.de>
	<20030504003021.077e8819.akpm@digeo.com>
	<20030504010014.67352345.akpm@digeo.com>
	<20030504191013.A10659@lst.de>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 May 2003 21:04:06.0358 (UTC) FILETIME=[B2EE4760:01C31280]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> ...
> +static void do_emergency_remount(unsigned long foo)
> +{
> +	struct super_block *sb;
> +
> +	spin_lock(&sb_lock);
> +	list_for_each_entry(sb, &super_blocks, s_list) {
> +		sb->s_count++;
> +		spin_unlock(&sb_lock);
> +		down_read(&sb->s_umount);
> +		if (sb->s_bdev && !(sb->s_flags & MS_RDONLY))
> +			do_remount_sb(sb, MS_RDONLY, NULL, 1);
> +		drop_super(sb);

You might need to check sb->s_root in here after acquiring sb->s_umount. 
Otherwise the fs may have been unmounted while the semaphore was being waited
upon.

About half of the s_umount grabbers perform that check.  The others might be
buggy.  I'm not sure - it's all rather gunky in there and hard to tell what
the rules are.


