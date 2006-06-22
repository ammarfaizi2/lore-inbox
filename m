Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbWFVArd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbWFVArd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 20:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbWFVArd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:47:33 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:58301 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932164AbWFVArc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:47:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tVK7qMy6ZPxFEc4GLC9TYKl3Ff6IjU8gdYoJkULG/FPA2hDtR3iWPG7a+HIg9Cy2glpMQhvTg2Z7i5d5eB9ce2IsbP+aELTmGi9QbaDZw6k4rp/vph3nmshYLWWQOVP/N9txYpqOw0wjSkCuwb910fLfr77x/v9Go6HNfNgSp/k=
Message-ID: <4499E89F.6030509@gmail.com>
Date: Thu, 22 Jun 2006 08:47:27 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_VGACON_SOFT_SCROLLBACK crashes 2.6.17
References: <200606211715.58773.a1426z@gawab.com> <44996332.5090408@gmail.com> <200606220005.32446.a1426z@gawab.com>
In-Reply-To: <200606220005.32446.a1426z@gawab.com>
Content-Type: text/plain; charset=windows-1256
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Antonino A. Daplas wrote:
>> Al Boldi wrote:
>>> Enabling CONFIG_VGACON_SOFT_SCROLLBACK causes random fatal system
>>> freezes.
>>>
>>> Especially, ping 10.1 -A easily causes a complete system hang during
>>> scroll.
>>>
>>> Is there an easy way to fix this, other than disabling the option?
>> I can't duplicate your problem. Did it ever work before?
> 
> This option did not exist before 2.6.17.

I meant if you tried any of the -rc kernels. 

Anyway, can you try the patch below.  It's a debugging patch and
it will slow down the console.

If the system hang disappears, remove the line

    while (i--);

in include/linux/vt_buffer.h.  This line is introduced by
the patch below.

Let me know at what point it worked, or whether it worked at all.

> 
>> Can you send me you kernel config?
> 
> Attached below.
> 
> BTW, is there any chance to patch your savagefb to support VIA/S3 UniChrome?
> 

If someone posts a patch to lkml or fbdev-devel, why not?  But a separate
driver is probably better as the 2 are very different.

Tony

diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
index 057db7d..e9b6064 100644
--- a/include/linux/vt_buffer.h
+++ b/include/linux/vt_buffer.h
@@ -20,11 +20,21 @@ #endif
 
 #ifndef VT_BUF_HAVE_RW
 #define scr_writew(val, addr) (*(addr) = (val))
-#define scr_readw(addr) (*(addr))
-#define scr_memcpyw(d, s, c) memcpy(d, s, c)
-#define scr_memmovew(d, s, c) memmove(d, s, c)
-#define VT_BUF_HAVE_MEMCPYW
-#define VT_BUF_HAVE_MEMMOVEW
+//#define scr_readw(addr) (*(addr))
+
+static inline u16 scr_readw(volatile const u16 *addr)
+{
+    int i = 10000;
+    u16 val = *addr;
+
+    while (i--);
+    return val;
+}
+    
+//#define scr_memcpyw(d, s, c) memcpy(d, s, c)
+//#define scr_memmovew(d, s, c) memmove(d, s, c)
+#undef VT_BUF_HAVE_MEMCPYW
+#undef VT_BUF_HAVE_MEMMOVEW
 #endif
 
 #ifndef VT_BUF_HAVE_MEMSETW
