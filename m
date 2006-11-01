Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992787AbWKATzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992787AbWKATzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992789AbWKATzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:55:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992787AbWKATzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:55:11 -0500
Date: Wed, 1 Nov 2006 11:54:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH -mm] swsusp: Freeze filesystems during suspend (rev. 2)
Message-Id: <20061101115458.bb02f1d3.akpm@osdl.org>
In-Reply-To: <200611011853.09633.rjw@sisk.pl>
References: <200611011200.18438.rjw@sisk.pl>
	<20061101114707.GA22079@atrey.karlin.mff.cuni.cz>
	<200611011853.09633.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006 18:53:07 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> +void freeze_filesystems(void)
> +{
> +	struct super_block *sb;
> +
> +	lockdep_off();
> +	/*
> +	 * Freeze in reverse order so filesystems dependant upon others are
> +	 * frozen in the right order (eg. loopback on ext3).
> +	 */
> +	list_for_each_entry_reverse(sb, &super_blocks, s_list) {
> +		if (!sb->s_root || !sb->s_bdev ||
> +		    (sb->s_frozen == SB_FREEZE_TRANS) ||
> +		    (sb->s_flags & MS_RDONLY) ||
> +		    (sb->s_flags & MS_FROZEN))
> +			continue;
> +
> +		freeze_bdev(sb->s_bdev);
> +		sb->s_flags |= MS_FROZEN;
> +	}
> +	lockdep_on();
> +}
> +
> +/**
> + * thaw_filesystems - unlock all filesystems
> + */
> +void thaw_filesystems(void)
> +{
> +	struct super_block *sb;
> +
> +	lockdep_off();
> +
> +	list_for_each_entry(sb, &super_blocks, s_list)
> +		if (sb->s_flags & MS_FROZEN) {
> +			sb->s_flags &= ~MS_FROZEN;
> +			thaw_bdev(sb->s_bdev, sb);
> +		}
> +
> +	lockdep_on();
> +}

argh.

The uncommented, unchangelogged lockdep_off() calls are completely
mysterious right now, even before the patch is merged.  They will not
become less mysterious over time.

Please, take pity upon the readers of your code.  Add a comment.

