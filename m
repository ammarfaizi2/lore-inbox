Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266817AbSKHRWC>; Fri, 8 Nov 2002 12:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266819AbSKHRWC>; Fri, 8 Nov 2002 12:22:02 -0500
Received: from users.linvision.com ([62.58.92.114]:36474 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S266817AbSKHRWA>; Fri, 8 Nov 2002 12:22:00 -0500
Date: Fri, 8 Nov 2002 18:28:41 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: marcello@connectiva.com.br,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Urgent patch for SX. 
Message-ID: <20021108182841.A24198@bitwizard.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Marcello, 

Somone messed with the SX driver in 2.4.19. It now detects some cards
twice (both as a V1 and as a V2 card). And as there end up being no
"interlocks", the card is entered twice in the "list of cards". 

This is fixed by adding a check for Version 1 when we really are
really probing for a V1 card and the other way around.

It would be very nice if this could still be accepted into 2.4.20, as
a bunch of people are bitten by this.... 

Honesty requires me to tell you that I haven't been able to fully test
this: I don't have a Version 1 card. But it has been tested with a
Version 2 card and it fixes the double detection problem there. So,
worst case, I think we'll hose support for version 1 cards, produced
in the late nineteen-eighties, or early nineteen-nineties....


				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sxfix-2.4.20-rc1"

diff -ur linux-2.4.20-rc1.clean/drivers/char/sx.c linux-2.4.20-rc1.sxfix/drivers/char/sx.c
--- linux-2.4.20-rc1.clean/drivers/char/sx.c	Fri Nov  8 18:13:57 2002
+++ linux-2.4.20-rc1.sxfix/drivers/char/sx.c	Fri Nov  8 18:16:55 2002
@@ -2216,6 +2216,23 @@
 		}
 	}
 
+	/* Now we're pretty much convinced that there is an SI board here, 
+	   but to prevent trouble, we'd better double check that we don't
+	   have an SI1 board when we're probing for an SI2 board.... */
+
+	write_sx_byte (board, SI2_ISA_ID_BASE,0x10); 
+	if ( IS_SI1_BOARD(board)) {
+		/* This should be an SI1 board, which has this
+		   location writable... */
+		if (read_sx_byte (board, SI2_ISA_ID_BASE) != 0x10)
+			return 0; 
+	} else {
+		/* This should be an SI2 board, which has the bottom
+		   3 bits non-writable... */
+		if (read_sx_byte (board, SI2_ISA_ID_BASE) == 0x10)
+			return 0; 
+	}
+
 	printheader ();
 
 	printk (KERN_DEBUG "sx: Found an SI board at %lx\n", board->hw_base);

--EeQfGwPcQSOJBaQU--
