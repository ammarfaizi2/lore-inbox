Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWJXUiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWJXUiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWJXUix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:38:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54694 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965185AbWJXUiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:38:52 -0400
Date: Tue, 24 Oct 2006 21:38:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061024203840.GA14736@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	LKML <linux-kernel@vger.kernel.org>
References: <1161576735.3466.7.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161576735.3466.7.camel@nigel.suspend2.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* 
> + * Done after userspace is frozen, so there should be no danger of
> + * fses being unmounted while we're in here.
> + */
> +int freezer_make_fses_ro(void)

This should be called freeze_filesystems() or something along the line.
I also wonder whether it should be next to freeze_bdev instead of
in the suspend code.

> +{
> +	struct frozen_fs *fs;
> +	struct super_block *sb;
> +
> +	/* Generate the list */
> +	list_for_each_entry(sb, &super_blocks, s_list) {
> +		if (!sb->s_root || !sb->s_bdev ||
> +		    (sb->s_frozen == SB_FREEZE_TRANS) ||
> +		    (sb->s_flags & MS_RDONLY))
> +			continue;
> +
> +		fs = kmalloc(sizeof(struct frozen_fs), GFP_ATOMIC);
> +		if (!fs)
> +			return 1;
> +		fs->sb = sb;
> +		list_add_tail(&fs->fsb_list, &frozen_fs_list);
> +	};
> +
> +	/* Do the freezing in reverse order so filesystems dependant
> +	 * upon others are frozen in the right order. (Eg loopback
> +	 * on ext3). */
> +	list_for_each_entry_reverse(fs, &frozen_fs_list, fsb_list)
> +		freeze_bdev(fs->sb->s_bdev);

I'd rather avoid this local list and operate directly on the super_blocks
lists. To do that we'd need another flag in the superblock to flag a
filesystem as suspended by this routine, which seems just fine.

void freeze_filesystems(void)
{
	/*
	 * Freeze in reverse order so filesystems dependant
	 * upon others are frozen in the right order.
	 * (E.g. loopback on ext3).
	 */
	list_for_each_entry_reverse(fs, &super_blocks, fsb_list) {
		if (!sb->s_root || !sb->s_bdev ||
		    (sb->s_frozen == SB_FREEZE_TRANS) ||
		    (sb->s_flags & MS_RDONLY))
			continue;
		freeze_bdev(sb->s_bdev);
		sb->s_flags &= MS_SUSPENDED; // XXX find protection for s_flags
	}
}
