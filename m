Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWCQOvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWCQOvM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWCQOvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:51:12 -0500
Received: from pproxy.gmail.com ([64.233.166.177]:10540 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750711AbWCQOvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:51:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=CJyVYFlzQwg8mAFgf4PmB+DoWVWJctD5/yzOb9ZQZTk8ApmZjLl5FxUejP4HdKJiS68+jCHokYU1oqn0IksxTT5pncqDtPW1bpBdeBOvlvT35Y+RphCDgtCW6G6epWyfn1+WxH5NCSDnPRbITTQmtJRQove0j40znZJVacmv+t0=
Message-ID: <441ACCD5.6070404@pol.net>
Date: Fri, 17 Mar 2006 22:51:01 +0800
From: "Antonino A. Daplas" <adaplas@pol.net>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org
Subject: Re: i810 framebuffer - BUG: sleeping function called from invalid
 context
References: <44186D30.4040603@imap.cc> <20060317031410.2479d8e1.akpm@osdl.org>
In-Reply-To: <20060317031410.2479d8e1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The console cursor can be called in atomic context.  Change memory
allocation to use the GFP_ATOMIC flag in i810fb_cursor().

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
Andrew Morton wrote:
> Tilman Schmidt <tilman@imap.cc> wrote:
>> Thought I'd finally report this, seeing it still around with 2.6.16-rc6-mm1.
>>
>>  With every 2.6.16-rc-mm version I can remember (sorry, no precise records)
>>  my development machine (a Dell OptiPlex GX110, Intel P3/933, Intel chipset)
>>  has been producing the following three BUG messages while booting:
>>
>>  <6>[   36.528181] md: Autodetecting RAID arrays.
>>  <3>[   36.528263] BUG: sleeping function called from invalid context at mm/slab.c:2758
>>  <4>[   36.528270] in_atomic():1, irqs_disabled():

This one, most probably.

Tony

 i810_main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index d8467c0..788297e 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -1508,7 +1508,7 @@ static int i810fb_cursor(struct fb_info 
 		int size = ((cursor->image.width + 7) >> 3) *
 			cursor->image.height;
 		int i;
-		u8 *data = kmalloc(64 * 8, GFP_KERNEL);
+		u8 *data = kmalloc(64 * 8, GFP_ATOMIC);
 
 		if (data == NULL)
 			return -ENOMEM;
