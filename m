Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262863AbREVWJi>; Tue, 22 May 2001 18:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262864AbREVWJ2>; Tue, 22 May 2001 18:09:28 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:31751 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S262863AbREVWJL>;
	Tue, 22 May 2001 18:09:11 -0400
Date: Wed, 23 May 2001 00:09:00 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac13
Message-ID: <20010523000900.A17869@se1.cogenit.fr>
In-Reply-To: <20010522154501.A7645@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010522223048.A9649@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Tue, May 22, 2001 at 03:45:01PM +0100
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <laughing@shared-source.org> écrit :
[...]
> o	Add missing locking to stradis driver		(me)

- unbalanced returns after down();
- 1770: if the initial version isn't racy with saa7146_irq (line 534), this
  one is equivalent and shorter.

init_saa7146:2185
	if ((saa->dmadebi = kmalloc(32768 + 4096, GFP_KERNEL)) == NULL)
[...]
looks suspect if the next vmalloc fail. Btw, I don't get the author
idea behind the whole "if (foo->bar == null) { foo->bar = vmalloc(...)}"
thing (chainsaw ?).

Fine against 2.4.4-ac14.

--- linux-2.4.4-ac13.orig/drivers/media/video/stradis.c	Tue May 22 16:40:01 2001
+++ linux-2.4.4-ac13/drivers/media/video/stradis.c	Tue May 22 17:31:48 2001
@@ -1513,8 +1513,10 @@ out:			
 					 SAA7146_MC1);
 			} else {
 				if (saa->win.vidadr == 0 || saa->win.width == 0
-				    || saa->win.height == 0)
+				    || saa->win.height == 0) {
+					up(&saa->sem);
 					return -EINVAL;
+				}
 				saa->cap |= 1;
 				saawrite((SAA7146_MC1_TR_E_1 << 16) | 0xffff,
 					 SAA7146_MC1);
@@ -1770,16 +1772,18 @@ out:			
 					if (saa->endmarktail <  
 						saa->endmarkhead) {
 						if (saa->endmarkhead -
-							saa->endmarktail < 2)
+							saa->endmarktail < 2) {
+							up(&saa->sem);
 							return -ENOSPC;
-					} else if (saa->endmarkhead <=
-						saa->endmarktail) {
+						}
+					} else {
 						if (saa->endmarktail -
 							saa->endmarkhead >
-							(MAX_MARKS - 2))
+							(MAX_MARKS - 2)) {
+							up(&saa->sem);
 							return -ENOSPC;
-					} else
-						return -ENOSPC;
+						}
+					}
 					saa->endmark[saa->endmarktail] =
 						saa->audtail;
 					saa->endmarktail++;
@@ -1928,8 +1932,10 @@ static long saa_write(struct video_devic
 				saa->audtail = 0;
 			}
 			if (copy_from_user(saa->audbuf + saa->audtail, buf,
-				blocksize)) 
-				return -EFAULT;
+				blocksize)) {
+				count = -EFAULT;
+				goto out;
+			}
 			saa->audtail += blocksize;
 			todo -= blocksize;
 			buf += blocksize;


