Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbUKCW2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUKCW2O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbUKCW0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:26:11 -0500
Received: from gprs214-112.eurotel.cz ([160.218.214.112]:25475 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261930AbUKCWPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:15:06 -0500
Date: Wed, 3 Nov 2004 23:14:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Type-checking for pci layer
Message-ID: <20041103221440.GG1574@elf.ucw.cz>
References: <20041103214711.GA1885@elf.ucw.cz> <20041103215130.GA30621@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103215130.GA30621@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This adds type-checking to PCI layer. u32 has been replaced with
> > defines, so it is no longer easy to confuse it with system suspend
> > level. Patrick included it in his power tree, but I guess direct
> > merging to you (Andrew) is faster/easier way to go? Please apply,
> > 
> > 								Pavel
> > 
> > Acked-by: Greg KH <greg@kroah.com>
> 
> Woah, I've never acked this patch.  Let me push it through my pci trees,
> or if Pat's already taken it, I'll get it from him through that path.

Did I misunderstandd email exchange? [I have full version with all
headers, too...]. [I hope I sent same patch as last time... Hmm, only
files were transposed]

Or did you just say that you agree with Patrick, nothing about
original patch?


From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: [linux-pm] Typechecking for pci layer

--===============94806148714041028==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Does this look like a way to go? I created special type for pci power
state, because otherwise it is too tempting to pass system power level
(or something completely unrelated :) to pci_ functions.

I'm not sure if PCI_D3cold should be included like
this. pci_enable_wake at least ignores it...

								Pavel

--- clean/drivers/pci/pci.c	2004-10-01 00:30:16.000000000 +0200
+++ linux/drivers/pci/pci.c	2004-10-25 23:24:37.000000000 +0200
@@ -242,7 +242,7 @@
  */
 
 int
-pci_set_power_state(struct pci_dev *dev, int state)
+pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	int pm;
 	u16 pmcsr;
@@ -422,7 +422,7 @@
  * 0 if operation is successful.
  * 
  */
-int pci_enable_wake(struct pci_dev *dev, u32 state, int enable)
+int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
 {
 	int pm;
 	u16 value;
--- clean/include/linux/pci.h	2004-10-01 00:30:30.000000000 +0200
+++ linux/include/linux/pci.h	2004-10-25 23:25:41.000000000 +0200
@@ -480,6 +480,14 @@
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 
+typedef int __bitwise pci_power_t;
+
+#define PCI_D0	((pci_power_t __force) 0)
+#define PCI_D1	((pci_power_t __force) 1)
+#define PCI_D2	((pci_power_t __force) 2)
+#define PCI_D3hot	((pci_power_t __force) 3)
+#define PCI_D3cold	((pci_power_t __force) 4)
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
@@ -508,7 +516,7 @@
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
 
-	u32             current_state;  /* Current operating state. In ACPI-speak,
+	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
 
@@ -645,7 +653,7 @@
 	struct pci_dynids dynids;
 };
 
-#define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)
+#define	to_pci_driver(drv) container_of(drv, struct pci_driver, driver)
 
 /**
  * PCI_DEVICE - macro used to describe a specific pci device
@@ -781,8 +789,8 @@
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev, u32 *buffer);
 int pci_restore_state(struct pci_dev *dev, u32 *buffer);
-int pci_set_power_state(struct pci_dev *dev, int state);
-int pci_enable_wake(struct pci_dev *dev, u32 state, int enable);
+int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 void pci_bus_assign_resources(struct pci_bus *bus);

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

From: Patrick Mochel <mochel@digitalimplant.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] Typechecking for pci layer

On Tue, 26 Oct 2004, Pavel Machek wrote:

> Hi!
>
> Does this look like a way to go? I created special type for pci power
> state, because otherwise it is too tempting to pass system power level
> (or something completely unrelated :) to pci_ functions.
>
> I'm not sure if PCI_D3cold should be included like
> this. pci_enable_wake at least ignores it...

It's not a real state that devices can enter; IIRC it just describes the
state devices are in when the system is initially turned on. I don't know
why some drivers use it, but it doesn't seem right. (It's been a while
since I read the spec, though, so I could be wrong.)

If Greg ACKs it, I'll add it to my tree and push it upwards.


	Pat

From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@ucw.cz>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] Typechecking for pci layer

On Thu, Oct 28, 2004 at 08:43:55AM -0700, Patrick Mochel wrote:
> 
> On Tue, 26 Oct 2004, Pavel Machek wrote:
> 
> > Hi!
> >
> > Does this look like a way to go? I created special type for pci power
> > state, because otherwise it is too tempting to pass system power level
> > (or something completely unrelated :) to pci_ functions.
> >
> > I'm not sure if PCI_D3cold should be included like
> > this. pci_enable_wake at least ignores it...
> 
> It's not a real state that devices can enter; IIRC it just describes the
> state devices are in when the system is initially turned on. I don't know
> why some drivers use it, but it doesn't seem right. (It's been a while
> since I read the spec, though, so I could be wrong.)
> 
> If Greg ACKs it, I'll add it to my tree and push it upwards.

ACK.

heh, reminds me of bill the cat...

greg k-h


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
