Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWDOAx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWDOAx6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 20:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWDOAx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 20:53:58 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:35994 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751452AbWDOAx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 20:53:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cK5PNSSci4NwcWFa8jPqlwpDTS7hotzh7hYElKdEqy4odul9P4YcHMmxpTTKMO3bBwDCaYFndtf2b8GWAgt1L5ELwlq2riTm+k8OaZNI1KbyT6nbamPvQPUUZ2d9ylLEVQ2ZNm6l/RQVlHlmw02GPwhQmNpNN7UvQBnpkbqryqU=
Message-ID: <44404401.3030702@gmail.com>
Date: Sat, 15 Apr 2006 08:53:21 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [Linux-fbdev-devel] Behaviour change of /dev/fb0?
References: <1145009768.6179.7.camel@localhost.localdomain>
In-Reply-To: <1145009768.6179.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
> Ignoring whether this is a good idea or not, under 2.6.15 you could run
> 
> dd if=/dev/zero of=/dev/fb0
> 
> which would clear the framebuffer. It would end up saying "dd: /dev/fb0:
> No space left on device".
> 
> Under 2.6.16 (and a recent git kernel), the same command clears the
> screen but then hangs. Was the change in behaviour intentional? 
> 
> I've noticed this on a couple of ARM based Zaurus handhelds under both
> w100fb and pxafb.
> 

After reading 'man 2 read' more thoroughly, I've adjusted fb_write()'s
return codes  appropriately.  Can you try this patch and let me know if it
fixes your problem.

Tony

fbdev: Fix return error of fb_write()

- return -EFBIG if file offset is past the maximum allowable offset
- return -EFBIG and write to end of framebuffer if size is bigger than the
  framebuffer length
- return -ENOSPC and write to end of framebuffer if size is bigger than the
  framebuffer length - file offset

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbmem.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 944855b..8a643bf 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -669,13 +669,19 @@ fb_write(struct file *file, const char _
 		total_size = info->fix.smem_len;
 
 	if (p > total_size)
-		return 0;
+		return -EFBIG;
 
-	if (count >= total_size)
+	if (count >= total_size) {
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
