Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287626AbSAIPcg>; Wed, 9 Jan 2002 10:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287681AbSAIPcU>; Wed, 9 Jan 2002 10:32:20 -0500
Received: from [200.10.161.32] ([200.10.161.32]:40367 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S287626AbSAIPcP>;
	Wed, 9 Jan 2002 10:32:15 -0500
Message-ID: <3C3C62F1.E9773931@inti.gov.ar>
Date: Wed, 09 Jan 2002 12:34:09 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andre Hedrick <andre@linux-ide.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [Patch][RFC] IDE driver for ALi M5229 (alim15x3.c) using UDMA(100) disks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.4.17
Hardware: ALi M5229 IDE controller and UDMA(100) disks.
Problem: The driver disables UDMA for UDMA>=100 disks.

I think that's an error in the code because it is masking out the UDMA(100)
disks. The code selects UDMA(100) and calls the routine that should enable
it but if this routine returns that the speed was configured for UDMA(100)
the value is interpreted as an error.
I see 2 options:
1) Take it as a success. I tried it but the /proc entry that reports
information about the driver shows ??? in the timing fields so I taked
approach 2 which looks safier.
2) Use UDMA(66) for it.

The following patch implements both things. If the FORCE_UDMA66 is defined
the option (2) takes effect.

Doubts:
1) is (2) really needed?
2) what about UDMA(133) (already available) and UDMA(166) (already
specified) disks?

Patch:

diff -ru linux-2.4.17.ori/drivers/ide/alim15x3.c
linux-2.4.17/drivers/ide/alim15x3.c
--- linux-2.4.17.ori/drivers/ide/alim15x3.c     Sun Jul 15 20:22:23 2001
+++ linux-2.4.17/drivers/ide/alim15x3.c Tue Jan  8 22:24:07 2002
@@ -28,6 +28,8 @@

 #include "ide_modes.h"

+/* Safe(?) fall back to UDMA66 when UDMA100 is available */
+#define FORCE_UDMA66
 #define DISPLAY_ALI_TIMINGS

 #if defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS)
@@ -373,7 +375,11 @@
        int  rval;

        if ((id->dma_ultra & 0x0020) && (ultra100) && (ultra66) &&
(ultra33)) {
-               speed = XFER_UDMA_5;
+#ifdef FORCE_UDMA66
+               speed = XFER_UDMA_4;
+#else
+      speed = XFER_UDMA_5;
+#endif
        } else if ((id->dma_ultra & 0x0010) && (ultra66) && (ultra33)) {
                speed = XFER_UDMA_4;
        } else if ((id->dma_ultra & 0x0008) && (ultra66) && (ultra33)) {
@@ -405,7 +411,7 @@
        if (!drive->init_speed)
                drive->init_speed = speed;

-       rval = (int)(   ((id->dma_ultra >> 11) & 3) ? ide_dma_on :
+       rval = (int)(   ((id->dma_ultra >> 11) & 0x1F) ? ide_dma_on :
                        ((id->dma_ultra >> 8) & 7) ? ide_dma_on :
                        ((id->dma_mword >> 8) & 7) ? ide_dma_on :
                        ((id->dma_1word >> 8) & 7) ? ide_dma_on :
<------------End of patch

Important note: I extended the mask to accept UDMA(133)/(166), currently not
requested by the code.

PCI information of the device:
  Bus  0, device   4, function  0:
    IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 196).
      IRQ 14.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      I/O at 0xff00 [0xff0f].

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



