Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131004AbRAAGFk>; Mon, 1 Jan 2001 01:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131585AbRAAGFa>; Mon, 1 Jan 2001 01:05:30 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:51622 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S131004AbRAAGF0>; Mon, 1 Jan 2001 01:05:26 -0500
Date: Sun, 31 Dec 2000 21:34:59 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH: __bad_udelay fixes(?) for linux-2.4.0-prerelease
Message-ID: <20001231213459.A17636@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

        linux-2.4.0-prerelease changes the udelay() macro defined
in linux/include/asm-i386/delay.h to reference the undefined symbol
__bad_udelay if udelay is called with a constant exceeding 20000
(that is, 20 milliseconds).  I guess the purpose of this change is
to tell driver maintainers to either take a harder look at whether they
really need to do a busy sleep for that long (you can still do it with
a loop) or have them give up the CPU during the sleep (although I do not see
a simple helper routine in the kernel to do this).  This change prevents
four modules in 2.4.0-prerelease from linking.  I have attached a patch
allowing them to link, but I would appreciate feedback on whether my
patches are the best approach.  Here is a summary:

drivers/net/tokenring/smctr.c   - I think this is the only file that had
				  a real bug.  The comments say it is
			          delaying for 2ms in two places, but the
				  code actually asks for a delay of 200ms
                                  in each place.  I have changed it to
				  really only delay 2ms in each place.
				  I would like to know if it still drives
				  the hardware correctly.  PLEASE TEST.

drivers/net/irda/tohoboe.c      - The code already has a FIXME and it
                                  currently does 10 iterations of 100ms
                                  delays, checking a register at each loop.
				  I have changed it to do 1000 iterations of
				  1ms.  It is the same maximum delay, but
				  it will exit faster once the event that
				  it is looking for occurs.  Is there a
				  better fix?

drivers/video/atyfb.c           - An intentional 50ms delay.
drivers/video/clgenfb.c	        - An intentional 100ms delay.
				  I've changed both files to keep the
				  delays by using mdelay instead of udelay.
				  Perhaps somebody could check the
				  approaprirate documentation and test
				  on real hardware to determine if the
				  delays really need to be this long.

	Anyhow, I think we should try to resolve the __bad_udelay
problems somehow by, say, linux-2.4.0-prerelease79. :-)

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="udelay.diffs"

--- linux-2.4.0-prerelease/drivers/net/tokenring/smctr.c	Mon Oct 16 12:58:51 2000
+++ linux/drivers/net/tokenring/smctr.c	Sun Dec 31 21:23:07 2000
@@ -4445,10 +4445,10 @@
         int ioaddr = dev->base_addr;
 
         /* Reseting the NIC will put it in a halted and un-initialized state. */        smctr_set_trc_reset(ioaddr);
-        udelay(200000); /* ~2 ms */
+        udelay(2000); /* ~2 ms */
 
         smctr_clear_trc_reset(ioaddr);
-        udelay(200000); /* ~2 ms */
+        udelay(2000); /* ~2 ms */
 
         /* Remove any latched interrupts that occured prior to reseting the
          * adapter or possibily caused by line glitches due to the reset.
--- linux-2.4.0-prerelease/drivers/net/irda/toshoboe.c	Sun Nov 12 20:43:11 2000
+++ linux/drivers/net/irda/toshoboe.c	Sun Dec 31 21:23:07 2000
@@ -881,7 +892,7 @@
 static void 
 toshoboe_gotosleep (struct toshoboe_cb *self)
 {
-  int i = 10;
+  int i = 1000;
 
   printk (KERN_WARNING "ToshOboe: suspending\n");
 
@@ -896,7 +907,7 @@
 /*FIXME: can't sleep here wait one second */
 
   while ((i--) && (self->txpending))
-    udelay (100000);
+    udelay (1000);
 
   toshoboe_stopchip (self);
   toshoboe_disablebm (self);
--- linux-2.4.0-prerelease/drivers/video/atyfb.c	Sun Dec  3 17:45:23 2000
+++ linux/drivers/video/atyfb.c	Sun Dec 31 21:23:07 2000
@@ -1754,7 +1797,7 @@
     aty_st_8(CLOCK_CNTL + info->clk_wr_offset, old_clock_cntl | CLOCK_STROBE,
 	     info);
 
-    udelay(50000); /* delay for 50 (15) ms */
+    mdelay(50); /* delay for 50 (15) ms */
     aty_st_8(CLOCK_CNTL + info->clk_wr_offset,
 	     ((pll->locationAddr & 0x0F) | CLOCK_STROBE), info);
 
--- linux-2.4.0-prerelease/drivers/video/clgenfb.c	Tue Nov  7 10:59:43 2000
+++ linux/drivers/video/clgenfb.c	Sun Dec 31 21:23:07 2000
@@ -1899,7 +1926,7 @@
 		break;
 	case BT_PICASSO4:
 		vga_wcrt (fb_info->regs, CL_CRT51, 0x00);	/* disable flickerfixer */
-		udelay (100000);
+		mdelay (100);
 		vga_wgfx (fb_info->regs, CL_GR2F, 0x00);	/* from Klaus' NetBSD driver: */
 		vga_wgfx (fb_info->regs, CL_GR33, 0x00);	/* put blitter into 542x compat */
 		vga_wgfx (fb_info->regs, CL_GR31, 0x00);	/* mode */

--X1bOJ3K7DJ5YkBrT--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
