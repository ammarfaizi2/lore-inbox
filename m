Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHHYt>; Thu, 8 Feb 2001 02:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbRBHHYj>; Thu, 8 Feb 2001 02:24:39 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:8203 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129032AbRBHHYe>; Thu, 8 Feb 2001 02:24:34 -0500
Date: Wed, 7 Feb 2001 23:23:01 -0800
Message-Id: <200102080723.f187N1v17541@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: vido@ldh.org
Cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org,
        Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: [PATCH] eepro100.c, kernel 2.4.1
In-Reply-To: <20010208145355.A18627@ldh.org>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001 14:53:55 +0900, Augustin Vidovic <vido@ldh.org> wrote:

> --- linux-2.4.1/drivers/net/eepro100.c  Sun Jan 28 03:40:14 2001
> +++ linux-2.4.1-vido1/drivers/net/eepro100.c    Thu Feb  8 14:08:49 2001
> @@ -815,7 +815,7 @@
>  
>         sp->phy[0] = eeprom[6];
>         sp->phy[1] = eeprom[7];
> -       sp->rx_bug = (eeprom[3] & 0x03) == 3 ? 0 : 1;
> +       sp->rx_bug = eeprom[3] & 0x03;
>  
>         if (sp->rx_bug)
>                 printk(KERN_INFO "  Receiver lock-up workaround activated.\n");

This patch is wrong, please DON'T apply it.

It's the printk that gets it wrong, although that's harmless.
Intel's documentation states that the bug does NOT exist if the
bits 0 and 1 in eeprom[3] are 1. Thus, the workaround is correct,
the printk is wrong.

The correct patch for 2.4.1 is attached. 2.2.18 needs something
similar, the same patch can be applied with some fuzz.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
--------------------------------
--- /usr/src/local/linux-2.4.vanilla/drivers/net/eepro100.c	Wed Feb  7 15:45:16 2001
+++ linux-2.4/drivers/net/eepro100.c	Wed Feb  7 23:07:29 2001
@@ -725,7 +725,7 @@
 		/* The self-test results must be paragraph aligned. */
 		volatile s32 *self_test_results;
 		int boguscnt = 16000;	/* Timeout for set-test. */
-		if (eeprom[3] & 0x03)
+		if ((eeprom[3] & 0x03) != 0x03)
 			printk(KERN_INFO "  Receiver lock-up bug exists -- enabling"
 				   " work-around.\n");
 		printk(KERN_INFO "  Board assembly %4.4x%2.2x-%3.3d, Physical"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
