Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318210AbSIJW6v>; Tue, 10 Sep 2002 18:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318209AbSIJW6v>; Tue, 10 Sep 2002 18:58:51 -0400
Received: from CPE-203-51-30-83.nsw.bigpond.net.au ([203.51.30.83]:12534 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S318215AbSIJW6u>; Tue, 10 Sep 2002 18:58:50 -0400
Message-ID: <3D7E7A37.ADDD2293@eyal.emu.id.au>
Date: Wed, 11 Sep 2002 09:03:19 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "list, linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre6: compile fixes
References: <Pine.LNX.4.44.0209101501200.16518-100000@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------D5E9F1C63B0BCA296FEA0E61"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D5E9F1C63B0BCA296FEA0E61
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

drivers/net/irda/irtty.c
========================
irtty.c: In function `irtty_set_dtr_rts':
irtty.c:761: `TIOCM_MODEM_BITS' undeclared (first use in this function)

A quick check shows that TIOCM_MODEM_BITS is defined only in
	./include/asm-parisc/termios.h
as
	#define TIOCM_MODEM_BITS	(TIOCM_OUT2 | TIOCM_OUT1)
Now, TIOCM_OUT1/2 are defined for all archs, with identical values,
in the low level asm-*/termios.h. One wonders why it is repeated
in this way.

I am not sure how people want to fix this - I just added a #define
to irtty.c as a quick compile fix.


drivers/net/pcmcia/wavelan_cs.c
===============================
Still does not compile, same as in -pre5 (include issue).


drivers/usb/brlvger.c
=====================
Still does not compile, same as in -pre5 (old gcc issue).


--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------D5E9F1C63B0BCA296FEA0E61
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre6-irtty.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre6-irtty.patch"

--- linux/drivers/net/irda/irtty.c.orig	Wed Sep 11 08:33:21 2002
+++ linux/drivers/net/irda/irtty.c	Wed Sep 11 08:33:59 2002
@@ -758,6 +758,7 @@
 	struct irtty_cb *self;
 	struct tty_struct *tty;
 	mm_segment_t fs;
+#define TIOCM_MODEM_BITS	(TIOCM_OUT2 | TIOCM_OUT1)
 	int arg = TIOCM_MODEM_BITS;
 
 	self = (struct irtty_cb *) dev->priv;

--------------D5E9F1C63B0BCA296FEA0E61
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre6-wavelan_cs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre6-wavelan_cs.patch"

--- linux/drivers/net/pcmcia/wavelan_cs.c.orig	Thu Aug 29 10:10:15 2002
+++ linux/drivers/net/pcmcia/wavelan_cs.c	Thu Aug 29 10:21:39 2002
@@ -63,9 +63,9 @@
  *
  */
 
+#include "wavelan_cs.h"		/* Private header */
 #include <linux/ethtool.h>
 #include <asm/uaccess.h>
-#include "wavelan_cs.h"		/* Private header */
 
 /************************* MISC SUBROUTINES **************************/
 /*

--------------D5E9F1C63B0BCA296FEA0E61
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre6-brlvger.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre6-brlvger.patch"

--- linux/drivers/usb/brlvger.c.orig	Thu Aug 29 10:30:50 2002
+++ linux/drivers/usb/brlvger.c	Thu Aug 29 10:31:02 2002
@@ -209,7 +209,7 @@
     ({ printk(KERN_ERR "Voyager: " args); \
        printk("\n"); })
 #define dbgprint(fmt, args...) \
-    ({ printk(KERN_DEBUG "Voyager: %s: " fmt, __FUNCTION__, ##args); \
+    ({ printk(KERN_DEBUG "Voyager: %s: " fmt, __FUNCTION__ , ##args); \
        printk("\n"); })
 #define dbg(args...) \
     ({ if(debug >= 1) dbgprint(args); })

--------------D5E9F1C63B0BCA296FEA0E61--

