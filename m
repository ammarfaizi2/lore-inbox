Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTJOXQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 19:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTJOXQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 19:16:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:9386 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262575AbTJOXQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 19:16:55 -0400
Date: Wed, 15 Oct 2003 16:17:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Chris Heath <chris@heathens.co.nz>
Subject: Re: FBDEV 2.6.0-test7 updates.
Message-Id: <20031015161705.221a579b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@infradead.org> wrote:
>
> Here is the latest fbdev patches. Please test!!! Many new enhancements. 
> Several fixes. The patch is against 2.6.0-test7
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Cool.  I've had the below fix floating about for a while.  Is it still
relevant?



From: Chris Heath <chris@heathens.co.nz>

I am still seeing a lot of cursors being left behind.  It is not a race
condition or anything -- in the TTY line editor, it happens about 50% of
the time when you press backspace.

What appears to be happening is the cursor is flashing twice as slowly
as the driver thinks it is, so of course it's wrong half the time when
it comes to erase the cursor.

The patch below fixes it for me.



 drivers/video/softcursor.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN drivers/video/softcursor.c~cursor-flashing-fix drivers/video/softcursor.c
--- 25/drivers/video/softcursor.c~cursor-flashing-fix	2003-08-16 14:01:15.000000000 -0700
+++ 25-akpm/drivers/video/softcursor.c	2003-08-16 14:01:15.000000000 -0700
@@ -74,6 +74,12 @@ int soft_cursor(struct fb_info *info, st
 
 	if (info->cursor.image.data)
 		info->fbops->fb_imageblit(info, &info->cursor.image);
+
+	if (!info->cursor.enable) {
+		for (i = 0; i < size; i++)
+			dst[i] ^= info->cursor.mask[i];
+	}
+
 	return 0;
 }
 

_

