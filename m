Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286649AbRLVC5r>; Fri, 21 Dec 2001 21:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbRLVC5i>; Fri, 21 Dec 2001 21:57:38 -0500
Received: from topic-gw2.topic.com.au ([203.37.31.2]:22514 "EHLO
	mailhost.topic.com.au") by vger.kernel.org with ESMTP
	id <S286651AbRLVC5d> convert rfc822-to-8bit; Fri, 21 Dec 2001 21:57:33 -0500
Date: Sat, 22 Dec 2001 13:57:25 +1100
From: Jason Thomas <jason@topic.com.au>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] link errors with internal calls to devexit functions
Message-ID: <20011222025725.GA629@topic.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please CC me I'm not on the list.

This patch against 2.4.17 fixes internal calls to devexit functions (which
is bypasses the devexit_p wrapper) in drivers/media/video/bttv-driver.c and
drivers/usb/usb-uhci.c, they are the only two I found.

diff -ur linux-2.4.17.orig/drivers/media/video/bttv-driver.c linux-2.4.17/drivers/media/video/bttv-driver.c
--- linux-2.4.17.orig/drivers/media/video/bttv-driver.c Sat Dec 22 13:39:39 2001
+++ linux-2.4.17/drivers/media/video/bttv-driver.c      Sat Dec 22 13:46:02 2001
@@ -2992,7 +2992,9 @@
        pci_set_drvdata(dev,btv);
 
        if(init_bt848(btv) < 0) {
+#if defined(MODULE) || defined(CONFIG_HOTPLUG)
                bttv_remove(dev);
+#endif
                return -EIO;
        }
        bttv_num++;
diff -ur linux-2.4.17.orig/drivers/usb/usb-uhci.c linux-2.4.17/drivers/usb/usb-uhci.c
--- linux-2.4.17.orig/drivers/usb/usb-uhci.c    Sat Dec 22 13:39:39 2001
+++ linux-2.4.17/drivers/usb/usb-uhci.c Sat Dec 22 13:46:38 2001
@@ -3001,7 +3001,9 @@
        s->irq = irq;
 
        if(uhci_start_usb (s) < 0) {
+#if defined(MODULE) || defined(CONFIG_HOTPLUG)
                uhci_pci_remove(dev);
+#endif
                return -1;
        }

-- 
Jason Thomas
