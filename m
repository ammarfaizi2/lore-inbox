Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263245AbREaVjY>; Thu, 31 May 2001 17:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263244AbREaVjN>; Thu, 31 May 2001 17:39:13 -0400
Received: from pille1.addcom.de ([62.96.128.35]:20749 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S263241AbREaVjI>;
	Thu, 31 May 2001 17:39:08 -0400
Date: Thu, 31 May 2001 23:38:43 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: <linux-kernel@vger.kernel.org>, <mc@cs.Stanford.EDU>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [CHECKER] 2.4.5-ac4 non-init functions calling init functions
In-Reply-To: <200105302008.NAA07710@csl.Stanford.EDU>
Message-ID: <Pine.LNX.4.33.0105312325250.4527-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Dawson Engler wrote:

> Here are *uninspected* 2.4.5-ac4 results of a checker that warns when a
> non-__init function calls an __init function (suggested by
> jlundell@lobitos.net).  There seem to be two cases:

> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/avm_pci.c:746:AVM_card_msg: ERROR:INIT: non-init fn 'AVM_card_msg' calling init fn 'inithdlc'
> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/avm_pci.c:745:AVM_card_msg: ERROR:INIT: non-init fn 'AVM_card_msg' calling init fn 'clear_pending_hdlc_ints'
> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/hfc_pci.c:1665:hfcpci_card_msg: ERROR:INIT: non-init fn 'hfcpci_card_msg' calling init fn 'inithfcpci'
> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/w6692.c:950:w6692_card_msg: ERROR:INIT: non-init fn 'w6692_card_msg' calling init fn 'initW6692'

These are actually false positives. The offending __init functions are
only called, when the _card_msg function is called with "CARD_INIT". This
only happens from __devinit code in config.c.

Now, calling __init from __devinit would a bug, too. However, the driver
doesn't support hotplug PCI, but the affected cards are PCI, so no problem
there, either.

> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/gazel.c:565:setup_gazelpci: ERROR:INIT: non-init fn 'setup_gazelpci' using init data 'dev_tel'
> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/gazel.c:568:setup_gazelpci: ERROR:INIT: non-init fn 'setup_gazelpci' using init data 'dev_tel'
> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/gazel.c:570:setup_gazelpci: ERROR:INIT: non-init fn 'setup_gazelpci' using init data 'dev_tel'
> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/gazel.c:569:setup_gazelpci: ERROR:INIT: non-init fn 'setup_gazelpci' using init data 'dev_tel'

These are actual (performance) bugs.
Patch is appended.

BTW: I don't if you did so already, but if you extended the checker to
find functions which are only called from __init functions, but not
marked __init themselves, you'd most likely find lots more performance
bugs of this kind.

Thank you,
--Kai

Index: linux_2_4/drivers/isdn/hisax//gazel.c
===================================================================
RCS file: /scratch/kai/cvsroot/linux_2_4/drivers/isdn/hisax/gazel.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 gazel.c
--- linux_2_4/drivers/isdn/hisax//gazel.c	2001/04/23 22:51:01	1.1.1.2
+++ linux_2_4/drivers/isdn/hisax//gazel.c	2001/05/31 21:35:39
@@ -1,4 +1,4 @@
-/* $Id: gazel.c,v 2.11.6.4 2001/02/16 16:43:26 kai Exp $
+/* $Id: gazel.c,v 2.11.6.5 2001/05/31 21:34:36 kai Exp $
  *
  * gazel.c     low level stuff for Gazel isdn cards
  *
@@ -19,7 +19,7 @@
 #include <linux/pci.h>

 extern const char *CardType[];
-const char *gazel_revision = "$Revision: 2.11.6.4 $";
+const char *gazel_revision = "$Revision: 2.11.6.5 $";

 #define R647      1
 #define R685      2
@@ -497,7 +497,7 @@
 	return 1;
 }

-static int
+static int __init
 setup_gazelisa(struct IsdnCard *card, struct IsdnCardState *cs)
 {
 	printk(KERN_INFO "Gazel: ISA PnP card automatic recognition\n");
@@ -546,7 +546,7 @@

 static struct pci_dev *dev_tel __initdata = NULL;

-static int
+static int __init
 setup_gazelpci(struct IsdnCardState *cs)
 {
 	u_int pci_ioaddr0 = 0, pci_ioaddr1 = 0;

