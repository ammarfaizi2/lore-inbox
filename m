Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129239AbQKHLpP>; Wed, 8 Nov 2000 06:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129838AbQKHLpF>; Wed, 8 Nov 2000 06:45:05 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:46324 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129239AbQKHLoz>; Wed, 8 Nov 2000 06:44:55 -0500
Date: Wed, 8 Nov 2000 12:44:46 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
Cc: Keith Owens <kaos@ocs.com.au>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 Oops
Message-ID: <20001108124446.M7204@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20001106230344.C992@iapetus.localdomain> <9731.973567145@ocs3.ocs-net> <20001107210050.A883@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001107210050.A883@iapetus.localdomain>; from F.vanMaarseveen@inter.NL.net on Tue, Nov 07, 2000 at 09:00:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 09:00:50PM +0100, Frank van Maarseveen wrote:
> >>EIP; c68385ab <[3c509].text.start+54b/6e8>   <=====
> Trace; ffff0499 <END_OF_CODE+397a0da2/????>
> Trace; c683935b <[3c509]init_module+57/74>
[...]
> 3c509                   7408   1  (initializing)

I think this is a known problem and has been fixed by Jeff
Garzik. Either try test11-pre1 or apply this patch:

Index: linux_2_4/drivers/net/3c509.c
diff -c linux_2_4/drivers/net/3c509.c:1.1.1.5 linux_2_4/drivers/net/3c509.c:1.1.1.5.2.1
*** linux_2_4/drivers/net/3c509.c:1.1.1.5 Tue Oct 31 13:21:47 2000
--- linux_2_4/drivers/net/3c509.c   Fri Nov  3 23:08:17 2000
***************
*** 434,439 ****
--- 434,446 ----
   /* Free the interrupt so that some other card can use it. */
   outw(0x0f00, ioaddr + WN0_IRQ);
   found:
+  if (dev == NULL) {
+     dev = init_etherdev(dev, sizeof(struct el3_private));
+     if (dev == NULL) {
+        release_region(ioaddr, EL3_IO_EXTENT);
+        return -ENOMEM;
+     }
+  }
   memcpy(dev->dev_addr, phys_addr, sizeof(phys_addr));
   dev->base_addr = ioaddr;
   dev->irq = irq;

Regards

Ingo Oeser
-- 
To the systems programmer, users and applications
serve only to provide a test load.
<esc>:x
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
