Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbRHAKDI>; Wed, 1 Aug 2001 06:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266381AbRHAKC7>; Wed, 1 Aug 2001 06:02:59 -0400
Received: from mail.teraport.de ([195.143.8.72]:4484 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S266377AbRHAKCs>;
	Wed, 1 Aug 2001 06:02:48 -0400
Message-ID: <3B67D3CB.DFF4E178@TeraPort.de>
Date: Wed, 01 Aug 2001 12:02:51 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Martin.Knoblauch@TeraPort.de
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kai@tp1.ruhr-uni-bochum.de
Subject: [PATCH] Re: eepro100 2.4.7-ac3 problems (apm related)
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/01/2001 12:02:05 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/01/2001 12:02:12 PM,
	Serialize complete at 08/01/2001 12:02:12 PM
Content-Type: multipart/mixed;
 boundary="------------F88DA3875376034181F1495E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F88DA3875376034181F1495E
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

> Re: eepro100 2.4.7-ac3 problems (apm related)
> 
> 
> Kai Germaschewski wrote:
> >
> >
> > Martin, if you want to spend some work on your problem, you could try to
> > collect some more data an your problem, particularly what about using
> > another state (D1/D3) when the interface is down. D3 will probably mean
> > that you have to save/restore PCI config space, so it's a bit more
> > tedious. Also, is there anything which makes your card work again after it
> > was in state D2? Like suspend/resume, or putting it into D3 and back into
> > D0? Does a warm reboot suffice, or do you need to power cycle.
> >
> 
>  Hmm. I am kind of lost now. I just redid the tests I did with 2.4.6-ac2
> under 2.4.7-ac3 and my eepro100 merrily survives any number of
> D0->D2->D0 transitions. The only difference besides the kernels is the
> ambient temperature. It is quite hot right now - and we don't have AC.
> 

 very interesting. After cooling down the whole pile of junk I can
reproduce the transition problems with both D2 and D1 as the sleep
state. With D2 it is 100% reproducible, with D1 I had rare cases where
the adaptor survived the transition. Apparently something is very weird
with my notebook.

 Removing the module does not help in *most* of the cases. Meaning - I
had one case where removing the module helped.

 In order to play with the problem I have modified my initial "patch". I
have introduced an option "apm_sleep" that can take values between 0 and
3, with a default of 2, representing the levles D0-D3. Applies against
2.4.7-ac3. Adding the line:

option eepro100 apm_sleep=0

to /etc/modules.conf solves my problem. Without the line the default
behaviour is used. I do some sanity checking on the value of apm_sleep.
0-2 are tested, 3 most likely needs some work wrt. saving/restoring
device state.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------F88DA3875376034181F1495E
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii;
 name="eepro100-apm_sleep.txt"
Content-Disposition: inline;
 filename="eepro100-apm_sleep.txt"

--- linux-2.4.7-ac3/drivers/net/eepro100.c-ac3-orig	Tue Jul 31 11:20:56 2001
+++ linux-2.4.7-ac3/drivers/net/eepro100.c	Wed Aug  1 10:54:12 2001
@@ -55,6 +55,9 @@
 /* Maximum number of multicast addresses to filter (vs. rx-all-multicast) */
 static int multicast_filter_limit = 64;
 
+/* Defines apm power saving mode. Set to 0 for some flaky adapters. MKN */
+static int apm_sleep = 2;
+
 /* 'options' is used to pass a transceiver override or full-duplex flag
    e.g. "options=16" for FD, "options=32" for 100mbps-only. */
 static int full_duplex[] = {-1, -1, -1, -1, -1, -1, -1, -1};
@@ -125,6 +128,7 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(multicast_filter_limit, "i");
+MODULE_PARM(apm_sleep, "i");
 MODULE_PARM_DESC(debug, "eepro100 debug level (0-6)");
 MODULE_PARM_DESC(options, "eepro100: Bits 0-3: tranceiver type, bit 4: full duplex, bit 5: 100Mbps");
 MODULE_PARM_DESC(full_duplex, "eepro100 full duplex setting(s) (1)");
@@ -136,6 +140,7 @@
 MODULE_PARM_DESC(rx_copybreak, "eepro100 copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(max_interrupt_work, "eepro100 maximum events handled per interrupt");
 MODULE_PARM_DESC(multicast_filter_limit, "eepro100 maximum number of filtered multicast addresses");
+MODULE_PARM_DESC(apm_sleep, "eepro100 power save mode (0-3,[2])");
 
 #define RUN_AT(x) (jiffies + (x))
 
@@ -778,7 +783,14 @@
 	udelay(10);
 
 	/* Put chip into power state D2 until we open() it. */
-	pci_set_power_state(pdev, 2);
+	/* For some flaky adaptors use value of apm_sleep instead of D2. MKN */
+	if ((apm_sleep < 0) || (apm_sleep > 3)) {
+         apm_sleep = 2;
+         printk(KERN_INFO "  apm_sleep option outside range. Defaulted to 2.\n");
+        }
+	else if (apm_sleep != 2)
+	  printk(KERN_INFO "  Nondefault apm_sleep = %d.\n",apm_sleep);
+	pci_set_power_state(pdev, apm_sleep);
 
 	pci_set_drvdata (pdev, dev);
 
@@ -1833,7 +1845,7 @@
 	if (speedo_debug > 0)
 		printk(KERN_DEBUG "%s: %d multicast blocks dropped.\n", dev->name, i);
 
-	pci_set_power_state(sp->pdev, 2);
+	pci_set_power_state(sp->pdev, apm_sleep);
 
 	MOD_DEC_USE_COUNT;
 

--------------F88DA3875376034181F1495E--

