Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUDQNrN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 09:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263982AbUDQNrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 09:47:13 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:26890 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S263980AbUDQNrH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 09:47:07 -0400
Date: Sat, 17 Apr 2004 15:47:04 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Dave Jones <davej@redhat.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-ntfs-dev@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: NTFS null dereference x2
Message-ID: <Pine.LNX.4.21.0404171505580.30107-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave Jones <davej@redhat.com> wrote:

> if vol is NULL, everything falls apart..

AFAIS, neither vol nor vol->sb can be NULL below. The !vol check, that
fooled you or an automatic checker, is bogus and probably it slipped
through the user space library, thanks.

Please note, by the patch you would introduce a real bug when you
dereference the now uninitialized sb to assign a value to block_size.

	Szaka

> --- linux-2.6.5/fs/ntfs/attrib.c~     2004-04-16 22:45:53.000000000 +0100
> +++ linux-2.6.5/fs/ntfs/attrib.c      2004-04-16 22:46:47.000000000 +0100
> @@ -1235,16 +1235,19 @@
>       u8 *al_end = al + initialized_size;
>       run_list_element *rl;
>       struct buffer_head *bh;
> -     struct super_block *sb = vol->sb;
> +     struct super_block *sb;
>       unsigned long block_size = sb->s_blocksize;
>       unsigned long block, max_block;
>       int err = 0;
> -     unsigned char block_size_bits = sb->s_blocksize_bits;
> +     unsigned char block_size_bits;
>
>       ntfs_debug("Entering.");
>       if (!vol || !run_list || !al || size <= 0 || initialized_size < 0 ||
>                       initialized_size > size)
>               return -EINVAL;
> +     sb = vol->sb;
> +     block_size_bits = sb->s_blocksize_bits;
> +
>       if (!initialized_size) {
>               memset(al, 0, size);
>               return 0;

