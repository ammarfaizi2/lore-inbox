Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268309AbTBMWz5>; Thu, 13 Feb 2003 17:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268311AbTBMWz4>; Thu, 13 Feb 2003 17:55:56 -0500
Received: from mail.scram.de ([195.226.127.117]:34502 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S268309AbTBMWzy>;
	Thu, 13 Feb 2003 17:55:54 -0500
Date: Fri, 14 Feb 2003 00:05:24 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Jeff Garzik <jgarzik@pobox.com>,
       <mike_phillips@urscorp.com>, <phillim2@comcast.net>
Subject: Re: [BUG] smctr.c changes in latest BK 
In-Reply-To: <Pine.LNX.4.44.0302132335540.28838-100000@gfrw1044.bocc.de>
Message-ID: <Pine.LNX.4.44.0302140001160.28838-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 13 Feb 2003, Jochen Friedrich wrote:

> Hi,
>
> ===== smctr.c 1.15 vs 1.16 =====
> --- 1.15/drivers/net/tokenring/smctr.c  Thu Nov 21 23:06:12 2002
> +++ 1.16/drivers/net/tokenring/smctr.c  Thu Feb 13 07:23:32 2003
> @@ -3064,7 +3064,7 @@
>          __u8 r;
>
>          /* Check if node address has been specified by user. (non-0) */
> -        for(i = 0; ((i < 6) && (dev->dev_addr[i] == 0)); i++);
> +        for(i = 0; ((i < 6) && (dev->dev_addr[i] == 0)); i++)
>          {
>                  if(i != 6)
>                  {
>
> Please revert this one as it is just wrong. As already mentioned here in
> LKML (IIRC it was Alan), the semicolon is really intended here.
>
> The above loop just runs until a non-zero byte is found in the MAC
> address or all 6 bytes have been checked. A value of i=6 will then
> indicate an all-zero MAC address.

After taking a second look, i just recognized that both cases (MAC adress
all-zero or not) are handled exactly the same (by duplicated code), so the
whole stuff is unnecessary.

The whole function just reduces to a simple copy loop:

===== smctr.c 1.17 vs edited =====
--- 1.17/drivers/net/tokenring/smctr.c  Thu Feb 13 22:47:11 2003
+++ edited/smctr.c      Fri Feb 14 00:07:33 2003
@@ -3057,28 +3057,12 @@
         unsigned int i;
         __u8 r;

-        /* Check if node address has been specified by user. (non-0) */
-        for(i = 0; ((i < 6) && (dev->dev_addr[i] == 0)); i++)
+        for(i = 0; i < 6; i++)
         {
-                if(i != 6)
-                {
-                        for(i = 0; i < 6; i++)
-                        {
-                                r = inb(ioaddr + LAR0 + i);
-                                dev->dev_addr[i] = (char)r;
-                        }
-                        dev->addr_len = 6;
-                }
-                else    /* Node addr. not given by user, read it from board. */
-                {
-                        for(i = 0; i < 6; i++)
-                        {
-                                r = inb(ioaddr + LAR0 + i);
-                                dev->dev_addr[i] = (char)r;
-                        }
-                        dev->addr_len = 6;
-                }
+                r = inb(ioaddr + LAR0 + i);
+                dev->dev_addr[i] = (char)r;
         }
+        dev->addr_len = 6;

         return (0);
 }

Thanks,
--jochen

