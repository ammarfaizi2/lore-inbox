Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVL2B3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVL2B3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 20:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVL2B3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 20:29:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24804 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964952AbVL2B3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 20:29:20 -0500
Date: Wed, 28 Dec 2005 20:29:15 -0500
From: Dave Jones <davej@redhat.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Message-ID: <20051229012915.GB3286@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <43A91C57.20102@cosmosbay.com> <200512281032.15460.vda@ilport.com.ua> <200512281054.26703.vda@ilport.com.ua> <3186311.1135792635763.SLOX.WebMail.wwwrun@imap-dhs.suse.de> <20051228210124.GB1639@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228210124.GB1639@waste.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > Something like this:
 > 
 > http://lwn.net/Articles/124374/

One thing that really sticks out like a sore thumb is soft_cursor()
That thing gets called a *lot*, and every time it does a kmalloc/free
pair that 99.9% of the time is going to be the same size alloc as
it was the last time.  This patch makes that alloc persistent
(and does a realloc if the size changes).
The only time it should change is if the font/resolution changes I think.

Boot tested with vesafb & fbconsole, which had the desired effect.
With this patch, it almost falls off the profile.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/drivers/video/console/softcursor.c~	2005-12-28 18:40:08.000000000 -0500
+++ linux-2.6.14/drivers/video/console/softcursor.c	2005-12-28 18:45:50.000000000 -0500
@@ -23,7 +23,9 @@ int soft_cursor(struct fb_info *info, st
 	unsigned int buf_align = info->pixmap.buf_align - 1;
 	unsigned int i, size, dsize, s_pitch, d_pitch;
 	struct fb_image *image;
-	u8 *dst, *src;
+	u8 *dst;
+	static u8 *src=NULL;
+	static int allocsize=0;
 
 	if (info->state != FBINFO_STATE_RUNNING)
 		return 0;
@@ -31,9 +33,15 @@ int soft_cursor(struct fb_info *info, st
 	s_pitch = (cursor->image.width + 7) >> 3;
 	dsize = s_pitch * cursor->image.height;
 
-	src = kmalloc(dsize + sizeof(struct fb_image), GFP_ATOMIC);
-	if (!src)
-		return -ENOMEM;
+	if (dsize + sizeof(struct fb_image) != allocsize) {
+		if (src != NULL)
+			kfree(src);
+		allocsize = dsize + sizeof(struct fb_image);
+
+		src = kmalloc(allocsize, GFP_ATOMIC);
+		if (!src)
+			return -ENOMEM;
+	}
 
 	image = (struct fb_image *) (src + dsize);
 	*image = cursor->image;
@@ -61,7 +69,6 @@ int soft_cursor(struct fb_info *info, st
 	fb_pad_aligned_buffer(dst, d_pitch, src, s_pitch, image->height);
 	image->data = dst;
 	info->fbops->fb_imageblit(info, image);
-	kfree(src);
 	return 0;
 }
 
