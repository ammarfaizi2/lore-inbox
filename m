Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWDOAN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWDOAN1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 20:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWDOAN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 20:13:27 -0400
Received: from tim.rpsys.net ([194.106.48.114]:18101 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751423AbWDOAN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 20:13:26 -0400
Subject: Re: [Linux-fbdev-devel] Behaviour change of /dev/fb0?
From: Richard Purdie <rpurdie@rpsys.net>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <44403068.3020909@gmail.com>
References: <1145009768.6179.7.camel@localhost.localdomain>
	 <44403068.3020909@gmail.com>
Content-Type: text/plain
Date: Sat, 15 Apr 2006 01:13:14 +0100
Message-Id: <1145059994.6179.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-15 at 07:29 +0800, Antonino A. Daplas wrote:
> Richard Purdie wrote:
> > Ignoring whether this is a good idea or not, under 2.6.15 you could run
> > 
> > dd if=/dev/zero of=/dev/fb0
> > 
> > which would clear the framebuffer. It would end up saying "dd: /dev/fb0:
> > No space left on device".
> > 
> > Under 2.6.16 (and a recent git kernel), the same command clears the
> > screen but then hangs. Was the change in behaviour intentional? 
> > 
> > I've noticed this on a couple of ARM based Zaurus handhelds under both
> > w100fb and pxafb.
> > 
> 
> There is a change in behavior of fb_read and fb_write committed Jan 2006.
> They return the number of bytes read or written if the requested size
> is bigger than the remaining space.  Previously, they returned -ENOSPC.
> 
> But I haven't experienced hangs...

The change in question is:

@@ -661,19 +664,19 @@ fb_write(struct file *file, const char _
 		return info->fbops->fb_write(file, buf, count, ppos);
 	
 	total_size = info->screen_size;
+
 	if (total_size == 0)
 		total_size = info->fix.smem_len;
 
 	if (p > total_size)
-	    return -ENOSPC;
+		return 0;
+
 	if (count >= total_size)
-	    count = total_size;
-	err = 0;
-	if (count + p > total_size) {
-	    count = total_size - p;
-	    err = -ENOSPC;
-	}
-	cnt = 0;
+		count = total_size;
+
+	if (count + p > total_size)
+		count = total_size - p;
+
 	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
 			 GFP_KERNEL);
 	if (!buffer)

I agree with the latter part of this but not the change for the "if (p >
total_size)" case. If we return zero here, the writer will just keep
retrying to write to the device indefinitely and therefore hang. Would
it make sense to revert that part of the change?:



If we reach the end of the framebuffer, we should return an out of space
error, not zero. Returning zero implies we might be able to write
further bytes at some future time which isn't true.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: git/drivers/video/fbmem.c
===================================================================
--- git.orig/drivers/video/fbmem.c	2006-04-13 00:22:28.000000000 +0100
+++ git/drivers/video/fbmem.c	2006-04-15 01:04:37.000000000 +0100
@@ -674,7 +674,7 @@
 		total_size = info->fix.smem_len;
 
 	if (p > total_size)
-		return 0;
+		return -ENOSPC;
 
 	if (count >= total_size)
 		count = total_size;





