Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262887AbVHEGoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbVHEGoB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbVHEGoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:44:01 -0400
Received: from s243.chello.upc.cz ([62.24.84.243]:52414 "EHLO midnight.suse.cz")
	by vger.kernel.org with ESMTP id S262889AbVHEGnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:43:11 -0400
Date: Fri, 5 Aug 2005 08:43:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Krufky <mkrufky@m1k.net>
Cc: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org, frank.peters@comcast.net
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Message-ID: <20050805064314.GA13494@ucw.cz>
References: <20050624113404.198d254c.frank.peters@comcast.net> <20050804162812.29a3f2b2.akpm@osdl.org> <20050804230947.36c24139.frank.peters@comcast.net> <200508042220.27480.dtor_core@ameritech.net> <20050804205441.0a90f637.akpm@osdl.org> <42F2E61B.2000502@m1k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F2E61B.2000502@m1k.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 12:07:55AM -0400, Michael Krufky wrote:

> >Sounds like a fun thing for post-2.6.13.
> >
> >What does usb-handoff do, precisely?
> >
> I just did a series tests.  This is necessary, because the problem was 
> intermittent for me.  usb-handoff fixes all of my problems!!!
> 
> without using usb-handoff, my ps/2 mouse works 1/10 times
> using usb-handoff, my ps/2 mouse works 10/10 times
> 
> I consider the problem solved... If Dmitry wants to make usb-handoff the 
> default, he has my support :-).
 
Here is a patch from the SuSE kernel CVS. It's been in SuSE's kernels
since 9.1 I believe, and that's a long time.

[usb-handoff-default.diff]

Date: Fri Mar  4 21:53:39 CET 2005
From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Make "usb-handoff" the default, "usb-no-handoff" turns it off.

=============================================================================================

 Documentation/kernel-parameters.txt |    1 +
 drivers/pci/quirks.c                |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

=============================================================================================

diff -ur linux-2.6.12/Documentation/kernel-parameters.txt linux-2.6.12-input/Documentation/kernel-parameters.txt
--- linux-2.6.12/Documentation/kernel-parameters.txt	2005-06-24 15:56:17.000000000 +0200
+++ linux-2.6.12-input/Documentation/kernel-parameters.txt	2005-06-24 15:57:06.000000000 +0200
@@ -1456,6 +1456,7 @@
 			Format: <io>,<irq>
 
 	usb-handoff	[HW] Enable early USB BIOS -> OS handoff
+	usb-no-handoff	[HW] Disable early USB BIOS -> OS handoff
 
 	usbhid.mousepoll=
 			[USBHID] The interval which mice are to be polled at.
diff -ur linux-2.6.12/drivers/pci/quirks.c linux-2.6.12-input/drivers/pci/quirks.c
--- linux-2.6.12/drivers/pci/quirks.c	2005-06-24 15:56:17.000000000 +0200
+++ linux-2.6.12-input/drivers/pci/quirks.c	2005-06-24 15:56:42.000000000 +0200
@@ -902,13 +902,23 @@
 #define EHCI_USBLEGCTLSTS	4		/* legacy control/status */
 #define EHCI_USBLEGCTLSTS_SOOE	(1 << 13)	/* SMI on ownership change */
 
+#if defined(__i386__) || defined(__x86_64__)
+int usb_early_handoff __devinitdata = 1;	/* Do handoff by default */
+#else
 int usb_early_handoff __devinitdata = 0;
+#endif
 static int __init usb_handoff_early(char *str)
 {
 	usb_early_handoff = 1;
 	return 0;
 }
 __setup("usb-handoff", usb_handoff_early);
+static int __init usb_no_handoff_early(char *str)
+{
+	usb_early_handoff = 0;
+	return 0;
+}
+__setup("usb-no-handoff", usb_no_handoff_early);
 
 static void __devinit quirk_usb_handoff_uhci(struct pci_dev *pdev)
 {

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
