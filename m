Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTDUSqD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbTDUSqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:46:03 -0400
Received: from pointblue.com.pl ([62.89.73.6]:44551 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261605AbTDUSp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:45:56 -0400
Subject: Re: small patch - 2.4.21-pre7 net/core/bk
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1050950810.2738.10.camel@flat41>
References: <1050950810.2738.10.camel@flat41>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1050951477.1859.14.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Apr 2003 19:57:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-21 at 19:46, Grzegorz Jaskiewicz wrote:
> Maybe i just don't understeand this part of code, but i think we
should
> not give calling driver five chances :)
> 
of course it should be:
-----------------------------------------------------------------
--- net/core/skbuff.c.org       2003-04-21 19:42:35.000000000 +0100
+++ net/core/skbuff.c   2003-04-21 19:43:10.000000000 +0100
@@ -167,13 +167,9 @@
        u8 *data;
 
        if (in_interrupt() && (gfp_mask & __GFP_WAIT)) {
-               static int count = 0;
-               if (++count < 5) {
-                       printk(KERN_ERR "alloc_skb called nonatomically
"
-                              "from interrupt %p\n", NET_CALLER(size));
-                       BUG();
-               }
-               gfp_mask &= ~__GFP_WAIT;
+               printk(KERN_ERR "alloc_skb called nonatomically "
+                      "from interrupt %p\n", NET_CALLER(size));
+               BUG();
        }
 
        /* Get the HEAD */

-----------------------------------------------------------------

> Also, i am bit confused with this part :
>      /* Get the DATA. Size must match skb_add_mtu(). */
>         size = SKB_DATA_ALIGN(size);
>         data = kmalloc(size + sizeof(struct skb_shared_info),
gfp_mask);
>         if (data == NULL)
>                 goto nodata;
> 
>         /* XXX: does not include slab overhead */ 
>         skb->truesize = size + sizeof(struct sk_buff);
> 
> can anybody explain me please why skb->truesize gets
size+sizeof(struct
> sk_buff) (acording to XXX above it, it is incorrect).

--
Grzegorz Jaskiewicz aka Kain/K4
K4 labs

