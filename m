Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130156AbQKJOFW>; Fri, 10 Nov 2000 09:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130295AbQKJOFM>; Fri, 10 Nov 2000 09:05:12 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:35588 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP
	id <S130156AbQKJOFF>; Fri, 10 Nov 2000 09:05:05 -0500
Date: Fri, 10 Nov 2000 15:04:44 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Frank Davis <fdavis112@juno.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: [PATCH] Re: [test11-pre2] rrunner.c compiler error
In-Reply-To: <E13u4Yp-0001p0-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0011101458350.5675-100000@tricky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, Alan Cox wrote:
> > rrunner.c : In function 'rr_ioctl'
> > rrunner.c:1558: label 'out' used but not defined
> > make[2]: *** [rrunner.o] Error 1
> 
> My fault. Swap that 1158 line pair 
> 
> 		error = -EPERM;
> 		goto out;
> 
> with 
> 		return -EPERM
> 

There is also line 1566 with "goto out;" (out of memory case).
Complete bugfix:

--- linux-240t11p2/drivers/net/rrunner.c	Fri Nov 10 14:28:43 2000
+++ linux/drivers/net/rrunner.c	Fri Nov 10 14:50:37 2000
@@ -1554,16 +1554,14 @@
 	switch(cmd){
 	case SIOCRRGFW:
 		if (!capable(CAP_SYS_RAWIO)){
-			error = -EPERM;
-			goto out;
+			return -EPERM;
 		}
 
 		image = kmalloc(EEPROM_WORDS * sizeof(u32), GFP_KERNEL);
 		if (!image){
 			printk(KERN_ERR "%s: Unable to allocate memory "
 			       "for EEPROM image\n", dev->name);
-			error = -ENOMEM;
-			goto out;
+			return -ENOMEM;
 		}
 		
 		spin_lock(&rrpriv->lock);

--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
