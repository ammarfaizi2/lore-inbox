Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIJbF>; Tue, 9 Jan 2001 04:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130188AbRAIJaz>; Tue, 9 Jan 2001 04:30:55 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:65415 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S129324AbRAIJai>; Tue, 9 Jan 2001 04:30:38 -0500
To: linux-kernel@vger.kernel.org,
        kai@thphy.uni-duesseldorf.de (Kai Germaschewski)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] hisax/sportster dependency error
In-Reply-To: <E14FKlk-00037v-00@the-village.bc.nu>
Reply-To: Daniel Stodden <stodden@in.tum.de>
From: Daniel Stodden <stodden@informatik.tu-muenchen.de>
In-Reply-To: Alan Cox's message of "Sun, 7 Jan 2001 19:40:57 +0000"
Message-ID: <874rz9t6om.fsf@bitch.localnet>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 9 Jan 2001 10:30:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi.

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > > according to sportster.c:get_io_range, this appears to be perfectly
> > > intentional, request_regioning 64x8 byte from 0x268 in 1024byte-steps.
> > 
> > AFAIK, this is because the hardware is stupid and does decode the higher
> > address lines. Therefore, the IO ports are mirrored every 1024 bytes and
> > should be reserved to avoid potential conflicts with other devices.
> 
> Almost every 10bit decode ISA card is like that. You don't need to do the
> work. The PCI alloc rules already cover it.

so, if i understand this correctly, since all offsets actually in use
are 1024B multiples the following would be sufficient, or more elegant..?

or should 
#define	 SPORTSTER_ISAC		0xC000
#define	 SPORTSTER_HSCXA	0x0000
#define	 SPORTSTER_HSCXB	0x4000
#define	 SPORTSTER_RES_IRQ	0x8000
still get requested explicitly in such cases?


--- linux-2.4/drivers/isdn/hisax/sportster.c.orig       Tue Jan  9 09:31:36 2001
+++ linux-2.4/drivers/isdn/hisax/sportster.c    Tue Jan  9 09:54:18 2001
@@ -133,13 +133,10 @@
 void
 release_io_sportster(struct IsdnCardState *cs)
 {
-       int i, adr;
 
        byteout(cs->hw.spt.cfg_reg + SPORTSTER_RES_IRQ, 0);
-       for (i=0; i<64; i++) {
-               adr = cs->hw.spt.cfg_reg + i *1024;
-               release_region(adr, 8);
-       }
+
+       release_region(cs->hw.spt.cfg_reg, 8);
 }
 
 void
@@ -185,27 +182,18 @@
 static int __init
 get_io_range(struct IsdnCardState *cs)
 {
-       int i, j, adr;
+       int adr = cs->hw.spt.cfg_reg;
+
+       if ( check_region(adr, 8) ) {
+               printk(KERN_WARNING
+                      "HiSax: %s config port %x-%x already in use\n",
+                      CardType[cs->typ], adr, adr + 8);
+               return 0;
+       } 
        
-       for (i=0;i<64;i++) {
-               adr = cs->hw.spt.cfg_reg + i *1024;
-               if (check_region(adr, 8)) {
-                       printk(KERN_WARNING
-                               "HiSax: %s config port %x-%x already in use\n",
-                               CardType[cs->typ], adr, adr + 8);
-                       break;
-               } else
-                       request_region(adr, 8, "sportster");
-       }
-       if (i==64)
-               return(1);
-       else {
-               for (j=0; j<i; j++) {
-                       adr = cs->hw.spt.cfg_reg + j *1024;
-                       release_region(adr, 8);
-               }
-               return(0);
-       }
+       request_region(adr, 8, "sportster");
+
+       return 1;
 }
 
 int __init


best regards,
dns

-- 
___________________________________________________________________________
 mailto:stodden@in.tum.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
