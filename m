Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269763AbRHILQl>; Thu, 9 Aug 2001 07:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269764AbRHILQb>; Thu, 9 Aug 2001 07:16:31 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:57093 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S269763AbRHILQ2>;
	Thu, 9 Aug 2001 07:16:28 -0400
Date: Thu, 9 Aug 2001 13:16:22 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Andres Salomon <dilinger@mp3revolution.net>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: [patch] Re: OOPS in 2.4.6's drivers/scsi/in2000.c
Message-ID: <20010809131622.A11250@se1.cogenit.fr>
In-Reply-To: <20010806000600.A2269@mp3revolution.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010806000600.A2269@mp3revolution.net>; from dilinger@mp3revolution.net on Mon, Aug 06, 2001 at 12:06:00AM -0400
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does readX instead of isa_readX on isa addresses.

Alan, please apply and forward. 

--- linux-2.4.7-ac9.orig/drivers/scsi/in2000.c	Thu Aug  2 09:50:33 2001
+++ linux-2.4.7-ac9/drivers/scsi/in2000.c	Thu Aug  9 13:06:25 2001
@@ -1909,10 +1909,10 @@ char *cp;
  * special macros declared in 'asm/io.h'. We use readb() and readl()
  * when reading from the card's BIOS area in in2000_detect().
  */
-static const unsigned int *bios_tab[] in2000__INITDATA = {
-   (unsigned int *)0xc8000,
-   (unsigned int *)0xd0000,
-   (unsigned int *)0xd8000,
+static u32 bios_tab[] in2000__INITDATA = {
+   0xc8000,
+   0xd0000,
+   0xd8000,
    0
    };
 
@@ -1973,13 +1973,13 @@ char buf[32];
  * for the obvious ID strings. We look for the 2 most common ones and
  * hope that they cover all the cases...
  */
-      else if (readl(bios_tab[bios]+0x04) == 0x41564f4e ||
-               readl(bios_tab[bios]+0x0c) == 0x61776c41) {
+      else if (isa_readl(bios_tab[bios]+0x10) == 0x41564f4e ||
+               isa_readl(bios_tab[bios]+0x30) == 0x61776c41) {
          printk("Found IN2000 BIOS at 0x%x ",(unsigned int)bios_tab[bios]);
 
 /* Read the switch image that's mapped into EPROM space */
 
-         switches = ~((readb(bios_tab[bios]+0x08) & 0xff));
+         switches = ~((isa_readb(bios_tab[bios]+0x20) & 0xff));
 
 /* Find out where the IO space is */
 
@@ -2073,7 +2073,7 @@ char buf[32];
 
 /* Older BIOS's had a 'sync on/off' switch - use its setting */
 
-      if (readl(bios_tab[bios]+0x04) == 0x41564f4e && (switches & SW_SYNC_DOS5))
+      if (isa_readl(bios_tab[bios]+0x10) == 0x41564f4e && (switches & SW_SYNC_DOS5))
          hostdata->sync_off = 0x00;    /* sync defaults to on */
       else
          hostdata->sync_off = 0xff;    /* sync defaults to off */
-- 
Ueimor
