Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136394AbREIM6f>; Wed, 9 May 2001 08:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136398AbREIM60>; Wed, 9 May 2001 08:58:26 -0400
Received: from ns.heidelberg.com ([193.158.227.197]:1758 "EHLO
	wiens011.heidelberg.com") by vger.kernel.org with ESMTP
	id <S136394AbREIM6P>; Wed, 9 May 2001 08:58:15 -0400
Date: Wed, 9 May 2001 14:58:13 +0200 (CEST)
From: Roman Fietze <fietze@swec.muh.de.heidelberg.com>
Reply-To: Roman Fietze <roman.fietze@de.heidelberg.com>
To: Avery Pennarun <apenwarr@worldvisions.ca>, <linux-kernel@vger.kernel.org>
cc: Javier Lipiz DDF-T SWEC ESW <Javier.Lipiz@de.heidelberg.com>
Subject: Arcnet, com20020, com20020-pci in 2.4.4 (and earlier)
Message-ID: <Pine.LNX.4.33.0105091411500.27996-100000@kagcpd05.muh.de.heidelberg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We had problems getting a Contemporary Controls PCI22 Arcnet Device to
work. In the case of compilation as modules check_region returned "already
in use" and in neither case the driver worked (arc0 never showed up).

We did some source code reading and came up with the changes below. The
first change (com20020.c) was to test the return value of request_region
properly, and this routine returns 0 on failure. The second change is to
leave out the check_region call in the pci version (com20020-pci.c). Here
we still do not know why this does not work. Some enlightenment from
others would be fine.

Please use and test with care, as usual :)


--- ./linux-2.4.4/drivers/net/arcnet/com20020.c Tue Feb 13 22:15:05 2001
+++ ./linux-2.4.4-updated/drivers/net/arcnet/com20020.c Wed May  9
13:55:38 2001
@@ -202,7 +202,7 @@
                return -ENODEV;
        }
        /* reserve the I/O region */
-       if (request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (COM20020)")) {
+       if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (COM20020)")) {
                free_irq(dev->irq, dev);
                return -EBUSY;
        }


--- ./linux-2.4.4/drivers/net/arcnet/com20020-pci.c     Wed Apr 18
23:40:05 2001
+++ ./linux-2.4.4-updated/drivers/net/arcnet/com20020-pci.c     Wed May  9
13:55:11 2001
@@ -97,12 +97,15 @@
        lp->timeout = timeout;
        lp->hw.open_close_ll = com20020pci_open_close;

+       /*
        if (check_region(ioaddr, ARCNET_TOTAL_SIZE)) {
                BUGMSG(D_INIT, "IO region %xh-%xh already allocated.\n",
                       ioaddr, ioaddr + ARCNET_TOTAL_SIZE - 1);
                err = -EBUSY;
                goto out_priv;
        }
+       */
+
        if (ASTATUS() == 0xFF) {
                BUGMSG(D_NORMAL, "IO address %Xh was reported by PCI BIOS, "
                       "but seems empty!\n", ioaddr);




Roman

-- 
Roman Fietze (Mail Code 6)     roman.fietze@de.heidelberg.com
Heidelberg Digital Finishing GmbH, Germany     DDF-T SWEC ESW







