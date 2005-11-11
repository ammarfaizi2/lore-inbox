Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVKKXcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVKKXcV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVKKXcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:32:21 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:42774 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751315AbVKKXcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:32:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=umNdnBJwTlx+Q5lsGAUyhdK11FOPQ9EWVS3jj9MHuGuL2RKcl1GjDzuEkbGGGQeT5SW4CH0H5+gfm+WnZ9DD9PG+3FD1JJLb1uaE3uXegyRqBxjE4B+ob3nR2F6U+KI0R3vL+yw3x9gufeiC7KCxN4vNYty6aFpwcQD46sgmvBU=
Message-ID: <4375291F.3040508@gmail.com>
Date: Sat, 12 Nov 2005 07:28:31 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@pol.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] nvidiafb: Fix bug in nvidiafb_pan_display
References: <20051110203544.027e992c.akpm@osdl.org>	<6bffcb0e0511111432m771dcda2y@mail.gmail.com> <20051111150108.265b2d3f.akpm@osdl.org>
In-Reply-To: <20051111150108.265b2d3f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nvidiafb_pan_display() is incorrectly using the fields in
info->var instead of var passed to the function.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Andrew Morton wrote:
> Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>> Hi,
>>
>> On 11/11/05, Andrew Morton <akpm@osdl.org> wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/
>>>
>> Something is broken with nvidia framebuffer. When I try to login on
>> tty1 "Password: " doesn't appear. It appear when I switch Alt+F2 to
>> tty2 and then back to tty1.
>>
> 
> Yup, thanks.  Yesterday Ben reported:
> 
>> not 100% sure what's up, but current -git has funny breakage with
>> nvidiafb on an iMac G5 I have here. The mode seems correct but the
>> console uses one line too much of text.
>>
>> That is, the total height of the screen isn't a multiple of the height
>> of a line of text. It seems that fbcon is rounding up instead of down,
>> thus the "last" line is basically going offscreen (about 2 or 3 pixels
>> visible, the rest is offscreen).
>>
> 

Looks like a bug in nvidiafb_pan_display() which was revealed when I
changed the semantics of update_var/update_start.

Try this patch.

Tony

 nvidia.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 0b40a2a..bee09c6 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1301,7 +1301,7 @@ static int nvidiafb_pan_display(struct f
 	struct nvidia_par *par = info->par;
 	u32 total;
 
-	total = info->var.yoffset * info->fix.line_length + info->var.xoffset;
+	total = var->yoffset * info->fix.line_length + var->xoffset;
 
 	NVSetStartAddress(par, total);
 

