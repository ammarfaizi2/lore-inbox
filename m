Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262413AbSJLJGE>; Sat, 12 Oct 2002 05:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSJLJGE>; Sat, 12 Oct 2002 05:06:04 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12488 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262413AbSJLJGC>; Sat, 12 Oct 2002 05:06:02 -0400
Date: Sat, 12 Oct 2002 11:11:47 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: Linux v2.5.42
In-Reply-To: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0210121104590.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2002, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.41 to v2.5.42
> ============================================
>...
> Christoph Hellwig <hch@lst.de>:
>   o initcalls for ATM
>...

This broke the compilation of drivers/atm/iphase.c:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/atm/.iphase.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include  -g
-DKBUILD_BASENAME=iphase   -c -o drivers/atm/iphase.o drivers/atm/iphase.c
drivers/atm/iphase.c: In function `rx_pkt':
drivers/atm/iphase.c:1167: warning: implicit declaration of function
`atm_pdu2truesize'
drivers/atm/iphase.c:1172: structure has no member named `rx_quota'
make[2]: *** [drivers/atm/iphase.o] Error 1

<--  snip  -->


The following part of the 2.5.42 patch to iphase.c shows the cause of this
problem:


<--  snip  -->

@@ -1162,10 +1157,7 @@
           goto out_free_desc;
         }

-#if LINUX_VERSION_CODE >= 0x20312
         if (!(skb = atm_alloc_charge(vcc, len, GFP_ATOMIC))) {
-#else
-        if (atm_charge(vcc, atm_pdu2truesize(len))) {
           /* lets allocate an skb for now */
           skb = alloc_skb(len, GFP_ATOMIC);
           if (!skb)
@@ -1178,7 +1170,6 @@
         }
         else {
            IF_EVENT(printk("IA: Rx over the rx_quota %ld\n", vcc->rx_quota);)
-#endif
            if (vcc->vci < 32)
               printk("Drop control packets\n");
              goto out_free_desc;

<--  snip  -->


Therefore the fix it simple:

--- linux-2.5.42-full/drivers/atm/iphase.c.old	2002-10-12 11:02:31.000000000 +0200
+++ linux-2.5.42-full/drivers/atm/iphase.c	2002-10-12 11:09:15.000000000 +0200
@@ -1158,18 +1158,6 @@
         }

         if (!(skb = atm_alloc_charge(vcc, len, GFP_ATOMIC))) {
-	   /* lets allocate an skb for now */
-	   skb = alloc_skb(len, GFP_ATOMIC);
-	   if (!skb)
-	   {
-              IF_ERR(printk("can't allocate memory for recv, drop pkt!\n");)
-              atomic_inc(&vcc->stats->rx_drop);
-              atm_return(vcc, atm_pdu2truesize(len));
-	      goto out_free_desc;
-	   }
-        }
-        else {
-           IF_EVENT(printk("IA: Rx over the rx_quota %ld\n", vcc->rx_quota);)
            if (vcc->vci < 32)
               printk("Drop control packets\n");
 	      goto out_free_desc;


cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed


