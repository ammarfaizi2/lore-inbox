Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWA2CTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWA2CTL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 21:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWA2CTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 21:19:11 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:21323 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750812AbWA2CTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 21:19:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IPRztcA5SDnqbMjj3if7woSxHu3qJTWxRUgEOoxy3iNZYM1BXiURuqemGOhKSd8lJy+npZmP2/ETWGZu892T1hx/dirfbEJNMPrOcTXHdcCUtHWiDduZjEmN4z7BvmXmGNA9D1XWEJVMZHcMzI8OuX6EYf3c06DV4omtE5IK3TY=
Message-ID: <43DC25EB.1040005@gmail.com>
Date: Sun, 29 Jan 2006 10:18:19 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
CC: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       linux-kernel@hansmi.ch
Subject: [PATCH] fbdev: Fix usage of blank value passed to fb_blank
References: <20060127231314.GA28324@hansmi.ch> <20060127.204645.96477793.davem@davemloft.net> <43DB0839.6010703@gmail.com> <200601282106.21664.ioe-lkml@rameria.de>
In-Reply-To: <200601282106.21664.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fb_blank() hook accepts 5 blanking levels which include 1 level designed
for console use only.  Userspace is only aware of 4 levels. Thus, it's
possible for userspace to request VESA_VSYNC_SUSPEND which, in turn, is
interpreted by the fb driver as a request for FB_BLANK_NORMAL. A few drivers
return -EINVAL for this, confusing userspace apps that the driver may not
have VESA blanking support.

Fix by incrementing the blank value by one if the request originated from
userspace.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Ingo Oeser wrote:
> > May I suggest to hide this implementation detail?
> > 

Yes.  The change will be invisible to drivers.

Unfortunately, this may cause some userland breakage.  X should work.
However, some apps may have been developed that uses the FB_BLANK constants
(DirectFB?).  In these cases, they'll get a deeper blank level instead, so it
probably won't affect them significantly.  A follow up patch that hides the 
FB_BLANK constants may be worthwhile.

 drivers/video/fbmem.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index d2dede6..5bed0fb 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -843,6 +843,19 @@ fb_blank(struct fb_info *info, int blank
 {	
  	int ret = -EINVAL;
 
+	/*
+	 * The framebuffer core supports 5 blanking levels (FB_BLANK), whereas
+	 * VESA defined only 4.  The extra level, FB_BLANK_NORMAL, is a
+	 * console invention and is not related to power management.
+	 * Unfortunately, fb_blank callers, especially X, pass VESA constants
+	 * leading to undefined behavior.
+	 *
+	 * To avoid confusion, fb_blank will assume VESA constants if coming
+	 * from userspace, and FB_BLANK constants if coming from the kernel.
+	 */
+	if (info->flags & FBINFO_MISC_USEREVENT && blank)
+		blank++;
+
  	if (blank > FB_BLANK_POWERDOWN)
  		blank = FB_BLANK_POWERDOWN;
 

