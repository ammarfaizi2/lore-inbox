Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVDTLll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVDTLll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 07:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVDTLll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 07:41:41 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:58568 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261263AbVDTLli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 07:41:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=hsHVX+24aBQXn1SwJYvzDnt4buu0u1q2jCHtDgC5sA2nHJXvNf/WnQNMnXY+eHc3zhVYe4VrYq5Wh6IMPHPrvjJ8bW8VVnbMAXREU1JRB3yYzQF1FiBO9lo3qg24PtxYE0Aky2ULJRO1ABN4eZ+miu7YPi3gLrsiWM0f9LqcyhY=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH Linux 2.6.12-rc2 00/04] blk: generic tag support fixes
Message-ID: <20050420114041.F2FA00DB@htj.dyndns.org>
Date: Wed, 20 Apr 2005 20:41:31 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.

 These are fixes to generic tag support in the blk layer.  They all
compile okay and I've proof read it, but as I don't have any HBA which
uses generic tag support, I wasn't able to test directly.  However,
all changes are fairly straight-forward.

[ Start of patch descriptions ]

01_blk_tag_map_use_find_first_zero_bit.patch
	: use find_first_zero_bit() in blk_queue_start_tag()

	blk_queue_start_tag() hand-coded searching for the first zero
	bit in the tag map.  Replace it with find_first_zero_bit().
	With this patch, blk_queue_star_tag() doesn't need to fill
	remains of tag map with 1, thus allowing it to work properly
	with the next remove_real_max_depth patch.

02_blk_tag_map_remove_real_max_depth.patch
	: remove blk_queue_tag->real_max_depth optimization

	blk_queue_tag->real_max_depth was used to optimize out
	unnecessary allocations/frees on tag resize.  However, the
	whole thing was very broken - tag_map was never allocated to
	real_max_depth resulting in access beyond the end of the map,
	bits in [max_depth..real_max_depth] were set when initializing
	a map and copied when resizing resulting in pre-occupied tags.

	As the gain of the optimization is very small, well, almost
	nill, remove the whole thing.

03_blk_tag_map_remove_BLK_TAGS_PER_LONG.patch
	: remove BLK_TAGS_{PER_LONG|MASK}

	Replace BLK_TAGS_PER_LONG with BITS_PER_LONG and remove unused
	BLK_TAGS_MASK.

04_blk_tag_map_error_handling_cleanup.patch
	: cleanup generic tag support error messages

	Add KERN_ERR and __FUNCTION__ to generic tag error messages,
	and add a comment in blk_queue_end_tag() which explains the
	silent failure path.

[ End of patch descriptions ]

 Thanks a lot. :-)

