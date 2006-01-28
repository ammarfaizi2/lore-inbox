Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422811AbWA1CWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422811AbWA1CWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422807AbWA1CWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:22:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:36538 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422806AbWA1CWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:22:30 -0500
Date: Fri, 27 Jan 2006 18:20:57 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dushistov@mail.ru, adobriyan@gmail.com
Subject: [patch 05/12] Fix oops in ufs_fill_super at mount time
Message-ID: <20060128022057.GF17001@kroah.com>
References: <20060128020629.908825000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-oops-in-ufs_fill_super-at-mount-time.patch"
In-Reply-To: <20060128022023.GA17001@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15.2 -stable review patch.  If anyone has any objections, please let 
us know.

------------------

From: Evgeniy <dushistov@mail.ru>

There's a lack of parenthesis in fs/ufs/utils.h, so instead of the 512th
byte of buffer, the usb2 pointer will point to the nth structure of type
ufs_super_block_second.

This can cause a mount-time oops if you're unlucky (especially with
DEBUG_PAGEALLOC, which is how Alexey Dobriyan saw this problem)

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>
Acked-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/ufs/util.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15.1.orig/fs/ufs/util.h
+++ linux-2.6.15.1/fs/ufs/util.h
@@ -255,8 +255,8 @@ extern void _ubh_memcpyubh_(struct ufs_s
 	((struct ufs_super_block_first *)((ubh)->bh[0]->b_data))
 
 #define ubh_get_usb_second(ubh) \
-	((struct ufs_super_block_second *)(ubh)-> \
-	bh[UFS_SECTOR_SIZE >> uspi->s_fshift]->b_data + (UFS_SECTOR_SIZE & ~uspi->s_fmask))
+	((struct ufs_super_block_second *)((ubh)->\
+	bh[UFS_SECTOR_SIZE >> uspi->s_fshift]->b_data + (UFS_SECTOR_SIZE & ~uspi->s_fmask)))
 
 #define ubh_get_usb_third(ubh) \
 	((struct ufs_super_block_third *)((ubh)-> \

--
