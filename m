Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTDENrr (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 08:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbTDENrr (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 08:47:47 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:16097 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262228AbTDENrp (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 08:47:45 -0500
Date: Sat, 5 Apr 2003 15:59:11 +0200 (MEST)
Message-Id: <200304051359.h35DxBLD015292@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: marcelo@conectiva.com.br
Subject: [PATCH][2.4.21-pre7] fix genksyms core dump in drivers/char/joystick
Cc: adam@os.inf.tu-dresden.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For a long time now, building a 2.4 kernel with MODVERSIONS=y
has left a core dump from genksyms in drivers/char/joystick/.
Last Tuesday, Adam Lackorzynski reported that this was due to a
#define in pci_gameport.h: When a config option is disabled, two
functions are #defined as stubs. This causes the pre-processed
C source code containing the non-stub versions of these functions
to have serious syntax errors, which in turn causes genksyms to
dump core.

This patch fixes this problem by using inline functions for the
stubs instead of #defines.

/Mikael

--- linux-2.4.21-pre7/include/linux/pci_gameport.h.~1~	2002-11-30 17:12:31.000000000 +0100
+++ linux-2.4.21-pre7/include/linux/pci_gameport.h	2003-04-05 14:31:20.000000000 +0200
@@ -32,8 +32,11 @@
 extern struct pcigame *pcigame_attach(struct pci_dev *dev, int type);
 extern void pcigame_detach(struct pcigame *game);
 #else
-#define pcigame_attach(a,b)	NULL
-#define pcigame_detach(a)
+static inline struct pcigame *pcigame_attach(struct pci_dev *dev, int type)
+{
+	return NULL;
+}
+static inline void pcigame_detach(struct pcigame *game) { }
 #endif
 
 #endif
