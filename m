Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132884AbRAQL2v>; Wed, 17 Jan 2001 06:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132787AbRAQL2l>; Wed, 17 Jan 2001 06:28:41 -0500
Received: from sunny.pacific.net.au ([210.23.129.40]:5375 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S131103AbRAQL2g>; Wed, 17 Jan 2001 06:28:36 -0500
Date: Wed, 17 Jan 2001 22:28:21 +1100
From: David Luyer <david_luyer@pacific.net.au>
Message-Id: <200101171128.f0HBSLx31234@typhaon.pacific.net.au>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Patch: Pass parameters to xirc2ps_cs via kernel command line
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Looking forward to your talk tomorrow at linux.conf.au.

Here's an addition for drivers/net/pcmcia/xirc2ps_cs.c dedicated to all the
guys who were playing flood-ping-the-broadcast in the networking room
downstairs at linux.conf.au, so that I can specify lockup_hack = 1 in my fully
non-modular kernel and not have my ethernet lock up under extreme load :-)

(relative to: 2.4.0-ac9)

--- orig/linux/drivers/net/pcmcia/xirc2ps_cs.c	Fri Oct 27 10:52:16 2000
+++ linux/drivers/net/pcmcia/xirc2ps_cs.c	Wed Jan 17 22:13:03 2001
@@ -2058,3 +2058,28 @@
 module_init(init_xirc2ps_cs);
 module_exit(exit_xirc2ps_cs);
 
+#ifndef MODULE
+static int __init setup_xirc2ps_cs(char *str)
+{
+	/* irq, irq_mask, if_port, full_duplex, do_sound, lockup_hack
+	 * [,irq2 [,irq3 [,irq4]]]
+	 */
+	int ints[10] = { -1 };
+
+	str = get_options(str, 9, ints);
+
+#define MAYBE_SET(X,Y) if (ints[0] >= Y && ints[Y] != -1) { X = ints[Y]; }
+	MAYBE_SET(irq_list[0], 1);
+	MAYBE_SET(irq_mask, 2);
+	MAYBE_SET(if_port, 3);
+	MAYBE_SET(full_duplex, 4);
+	MAYBE_SET(do_sound, 5);
+	MAYBE_SET(lockup_hack, 6);
+	MAYBE_SET(irq_list[1], 7);
+	MAYBE_SET(irq_list[2], 8);
+	MAYBE_SET(irq_list[3], 9);
+#undef  MAYBE_SET(X,Y)
+}
+
+__setup("xirc2ps_cs=", setup_xirc2ps_cs);
+#endif


It occurs to me it would appear relatively trivial to write a "default" __setup
function for anything with module parameters (viz, xirc2ps_cs.lockup_hack=1).
Would a patch to that effect be likely to be accepted?

David.
--
David Luyer                                        Phone:   +61 3 9674 7525
Senior Network Engineer        P A C I F I C       Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T      Mobile:  +61 4 1111 2983
http://www.pacific.net.au/                         NASDAQ:  PCNTF
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
