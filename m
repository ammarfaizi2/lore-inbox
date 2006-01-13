Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161385AbWAMP0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161385AbWAMP0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161373AbWAMP0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:26:04 -0500
Received: from mx2.mail.ru ([194.67.23.122]:54137 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1161385AbWAMPZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:25:26 -0500
Date: Fri, 13 Jan 2006 18:12:15 +0300
From: Evgeniy <dushistov@mail.ru>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2.6.15] Re: Oops in ufs_fill_super at mount time
Message-ID: <20060113151215.GA25854@rain.homenetwork>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20060113005450.GA7971@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113005450.GA7971@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 03:54:50AM +0300, Alexey Dobriyan wrote:
> Version 2.6.15-43ecb9a33ba8c93ebbda81d48ca05f0d1bbf9056
> 
> Actually more or less latest -git is affected too, but
> I'm sick of recompiling right now so please wait for bisecting results.
> 
> It's random wrt one mount of UFS, but several mount/umounts in a row
> reproduce it reliably:
> 

I suppose problem in a couple of brackets in fs/ufs/utils.h,
instead of 512th byte of buffer, usb2 point to nth structure of
type ufs_super_block_second.

This patch fix problem for me, 
can you test it?

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

--- linux-2.6.15/fs/ufs/util.h.orig	2006-01-13 17:33:49.123946250 +0300
+++ linux-2.6.15/fs/ufs/util.h	2006-01-13 17:35:50.127508500 +0300
@@ -255,8 +255,8 @@ extern void _ubh_memcpyubh_(struct ufs_s
 	((struct ufs_super_block_first *)((ubh)->bh[0]->b_data))
 
 #define ubh_get_usb_second(ubh) \
-	((struct ufs_super_block_second *)(ubh)-> \
-	bh[UFS_SECTOR_SIZE >> uspi->s_fshift]->b_data + (UFS_SECTOR_SIZE & ~uspi->s_fmask))
+	((struct ufs_super_block_second *)((ubh)->\
+					   bh[UFS_SECTOR_SIZE >> uspi->s_fshift]->b_data + (UFS_SECTOR_SIZE & ~uspi->s_fmask)))
 
 #define ubh_get_usb_third(ubh) \
 	((struct ufs_super_block_third *)((ubh)-> \

-- 
/Evgeniy

