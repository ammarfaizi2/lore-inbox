Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWHRJP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWHRJP0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWHRJP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:15:26 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:4265 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751051AbWHRJPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:15:25 -0400
To: esandeen@redhat.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH] fix ext3 mounts at 16T
Message-Id: <20060818181516sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Fri, 18 Aug 2006 18:15:16 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>I figure before we get too fired up about 48 bits and ext4 let's fix 32 bits on ext3 :)
>
>I need to do some actual IO testing now, but this gets things mounting for a 16T ext3 
>filesystem.
>(patched up e2fsprogs is needed too, I'll send that off the kernel list)
>
>This patch fixes these issues in the kernel:
> 
> o sbi->s_groups_count overflows in ext3_fill_super()
> 
> sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
>        le32_to_cpu(es->s_first_data_block) +
>        EXT3_BLOCKS_PER_GROUP(sb) - 1) /
>       EXT3_BLOCKS_PER_GROUP(sb);
> 
> at 16T, s_blocks_count is already maxed out; adding EXT3_BLOCKS_PER_GROUP(sb) overflows it and 
> groups_count comes out to 0.  Not really what we want, and causes a failed mount.
> 
> Feel free to check my math (actually, please do!), but changing it this way should work & 
> avoid the overflow:
> 
> (A + B - 1)/B changed to: ((A - 1)/B) + 1
> 
> o ext3_check_descriptors() overflows range checks

I had done the same work for both ext3 and ext2,
and sent the patches to ext2-devel three months ago.
If you need, you can get them from the following URL.

The introduction for my patch set:
http://marc.theaimsgroup.com/?l=ext2-devel&m=114856080926308&w=2

The patch which fixes overflow problem on ext3:
http://marc.theaimsgroup.com/?l=ext2-devel&m=114856129220863&w=2

The patch which fixes overflow problem on ext2:
http://marc.theaimsgroup.com/?l=ext2-devel&m=114856135120693&w=2

I have reviewed your patch and found other place which might
cause overflow as below.  If group_first_block is the first block of
the last group, overflow will occur.  This has already been fixed
in my patch.

o ext3_try_to_allocate_with_rsv() in fs/ext3/balloc.c
	if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
		    || (my_rsv->rsv_end < group_first_block))
			BUG();

Cheers, Takashi
