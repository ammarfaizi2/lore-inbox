Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268449AbTCCIu0>; Mon, 3 Mar 2003 03:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268452AbTCCIu0>; Mon, 3 Mar 2003 03:50:26 -0500
Received: from srv1.mail.cv.net ([167.206.112.40]:47262 "EHLO srv1.mail.cv.net")
	by vger.kernel.org with ESMTP id <S268449AbTCCIuZ>;
	Mon, 3 Mar 2003 03:50:25 -0500
Date: Mon, 03 Mar 2003 04:00:54 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] mkdep patch in 2.4.21-pre4-ac7 breaks pci/drivers
In-reply-to: <200303020213.h222DM7O003304@eeyore.valparaiso.cl>
X-X-Sender: proski@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>
Message-id: <Pine.LNX.4.51.0303030347020.26129@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <200303020213.h222DM7O003304@eeyore.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch works for me and doesn't require any changes in mkdep.  I
believe it's the right thing to do.  The rule for names.o already exists
in the Makefile.  The only problem with it is that it's misplaced - it
should precede the generated dependencies.

GNU make just concatenates the lists of dependencies and tries to create
the dependencies in the order is which they appear in the makefile.  If
devlist.h without path is first, then make will create it because there is
a rule for that.  Thn make will see that devlist.h with path is already
up-to-date.

On the other hand, if devlist.h with path is first, then make won't know
how to create it and will abort rather than go to the next target.

This patch has been tested and works for me.  How to test:

make oldconfig
make clean
make depend
make bzImage
make depend
make clean
make bzImage

It works fine now.  Patch:

==============================
--- linux.orig/drivers/pci/Makefile
+++ linux/drivers/pci/Makefile
@@ -35,10 +35,10 @@
 obj-y += syscall.o
 endif

-include $(TOPDIR)/Rules.make
-
 names.o: names.c devlist.h classlist.h

+include $(TOPDIR)/Rules.make
+
 devlist.h classlist.h: pci.ids gen-devlist
 	./gen-devlist <pci.ids

==============================

The patch fixes the problem in Alan's 2.4 series, but it can be safely
applied to the Marcelo's 2.4 branch as well.

-- 
Regards,
Pavel Roskin
