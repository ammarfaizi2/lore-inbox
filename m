Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUE0FBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUE0FBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 01:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUE0FBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 01:01:48 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:11203 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261358AbUE0FBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 01:01:47 -0400
Date: Thu, 27 May 2004 15:58:29 +1000
From: Nathan Scott <nathans@sgi.com>
To: dag@bakke.com
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: xfsdump hangs - 2.6.6 && 2.6.7-rc1-bk3
Message-ID: <20040527055829.GA8981@frodo>
References: <20040526091315.17983.h012.c000.wm@mail.bakke.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526091315.17983.h012.c000.wm@mail.bakke.com.criticalpath.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 09:13:14AM -0700, dag@bakke.com wrote:
> 
> I experience hangs with xfsdump, when dumping my rootfs to a USB 2.0
> ...
> http://thaifood.homeip.net/xfsdumphang/xfsdump.dmesg.txt 
> ...

The xfsdump stack trace in there is the important one.
Can you try this patch and let me know how it goes?

thanks.

-- 
Nathan


--- fs/xfs/linux/xfs_buf.c.orig	2004-05-27 14:06:59.992936144 +1000
+++ fs/xfs/linux/xfs_buf.c	2004-05-27 14:08:21.548537808 +1000
@@ -370,8 +370,12 @@
 	      retry:
 		page = find_or_create_page(mapping, first + i, gfp_mask);
 		if (unlikely(page == NULL)) {
-			if (flags & PBF_READ_AHEAD)
+			if (flags & PBF_READ_AHEAD) {
+				for (--i; i >= 0; i--)
+					page_cache_release(bp->pb_pages[i]);
+				_pagebuf_free_pages(bp);
 				return -ENOMEM;
+			}
 
 			/*
 			 * This could deadlock.
