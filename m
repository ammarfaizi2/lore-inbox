Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWDUEoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWDUEoc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWDUEob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:21122 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932257AbWDUEoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:21 -0400
Date: Thu, 20 Apr 2006 21:40:11 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Antonino Daplas <adaplas@pol.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 19/22] fbdev: Fix return error of fb_write
Message-ID: <20060421044011.GW12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fbdev-fix-return-error-of-fb_write.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antonino A. Daplas <adaplas@gmail.com>

[PATCH] fbdev: Fix return error of fb_write

Fix return code of fb_write():

If at least 1 byte was transferred to the device, return number of bytes,
otherwise:

    - return -EFBIG - if file offset is past the maximum allowable offset or
      size is greater than framebuffer length
    - return -ENOSPC - if size is greater than framebuffer length - offset

Signed-off-by: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/video/fbmem.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- linux-2.6.16.9.orig/drivers/video/fbmem.c
+++ linux-2.6.16.9/drivers/video/fbmem.c
@@ -669,13 +669,19 @@ fb_write(struct file *file, const char _
 		total_size = info->fix.smem_len;
 
 	if (p > total_size)
-		return 0;
+		return -EFBIG;
 
-	if (count >= total_size)
+	if (count > total_size) {
+		err = -EFBIG;
 		count = total_size;
+	}
+
+	if (count + p > total_size) {
+		if (!err)
+			err = -ENOSPC;
 
-	if (count + p > total_size)
 		count = total_size - p;
+	}
 
 	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
 			 GFP_KERNEL);
@@ -717,7 +723,7 @@ fb_write(struct file *file, const char _
 
 	kfree(buffer);
 
-	return (err) ? err : cnt;
+	return (cnt) ? cnt : err;
 }
 
 #ifdef CONFIG_KMOD

--
