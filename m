Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757957AbWKZUPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757957AbWKZUPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 15:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757958AbWKZUPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 15:15:31 -0500
Received: from smtp.osdl.org ([65.172.181.25]:2452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757957AbWKZUPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 15:15:30 -0500
Date: Sun, 26 Nov 2006 12:11:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Roland Dreier <rdreier@cisco.com>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       tom@opengridcomputing.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
In-Reply-To: <20061126111703.33247a84.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611261208550.3483@woody.osdl.org>
References: <adazmag5bk1.fsf@cisco.com> <20061124.220746.57445336.davem@davemloft.net>
 <adaodqv5e5l.fsf@cisco.com> <20061125.150500.14841768.davem@davemloft.net>
 <adak61j5djh.fsf@cisco.com> <20061125164118.de53d1cf.akpm@osdl.org>
 <ada64d23ty8.fsf@cisco.com> <20061126111703.33247a84.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Nov 2006, Andrew Morton wrote:
> 
> I'd be inclined to merge it for 2.6.19.  Is everyone OK with it?

I'd _much_ rather make it more readable while at it. Something like this 
instead, which has just _one_ "typeof" cast, and at least to me makes it a 
lot more obvious what is going on (aka "to align something, use a mask 
that is of the same type as the thing to be aligned..").

Maybe it's just me, but I prefer to separate out the actual "action" from 
the "type fluff" around it.

		Linus

---
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 24b6111..b9b5e4b 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -30,8 +30,10 @@ extern const char linux_banner[];
 
 #define STACK_MAGIC	0xdeadbeef
 
+#define ALIGN(x,a)		__ALIGN_MASK(x,(typeof(x))(a)-1)
+#define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))
+
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#define ALIGN(x,a) (((x)+(a)-1UL)&~((a)-1UL))
 #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
 #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
 #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
