Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422911AbWAMTye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422911AbWAMTye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWAMTvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:51:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422911AbWAMTvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:51:40 -0500
Date: Fri, 13 Jan 2006 11:51:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Evgeniy <dushistov@mail.ru>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2.6.15] ufs cleanup
In-Reply-To: <20060113190524.GA31715@rain.homenetwork>
Message-ID: <Pine.LNX.4.64.0601131144520.13339@g5.osdl.org>
References: <20060113005450.GA7971@mipter.zuzino.mipt.ru>
 <Pine.LNX.4.64.0601121700041.3535@g5.osdl.org> <20060113102136.GA7868@mipter.zuzino.mipt.ru>
 <Pine.LNX.4.64.0601130739540.3535@g5.osdl.org> <20060113190524.GA31715@rain.homenetwork>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Jan 2006, Evgeniy wrote:
> +static inline struct ufs_super_block_second *
> +ubh_get_usb_second(struct ufs_sb_private_info *uspi)
> +{
> +	char *res=uspi->s_ubh.bh[UFS_SECTOR_SIZE >> uspi->s_fshift]->b_data + 
> +		(UFS_SECTOR_SIZE & ~uspi->s_fmask);
> +	return (struct ufs_super_block_second *)res;
> +}

I was thinking of something even more abstracted:

	static inline void *get_usb_offset(struct ufs_sb_private_info *uspi,
		unsigned int offset)
	{
		unsigned int index;

		index = offset >> uspi->s_fshift;
		offset &= ~uspi->s_fmask;
		return uspi->s_ubh.bh[index]->b_data + offset;
	}

and then just doing

	#define ubs_get_usb_first(uspi) \
		((struct ufs_super_block_first *)get_usb_offset(uspi, 0))

	#define ubh_get_usb_second(uspi) \
		((struct ufs_super_block_second *)get_usb_offset(uspi, UFS_SECTOR_SIZE))

	#define ubh_get_usb_third(uspi) \
		((struct ufs_super_block_third *)get_usb_offset(uspi, 2*UFS_SECTOR_SIZE))

or something similar. Which seems a hell of a lot more readable to me, and 
assuming it passes testing (ie I didn't screw up), I think it's more 
likely to stay correct in the future and just generally be maintainable.

Hmm?

		Linus
