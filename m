Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291610AbSBAISv>; Fri, 1 Feb 2002 03:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291612AbSBAISl>; Fri, 1 Feb 2002 03:18:41 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:29930 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S291610AbSBAISa>; Fri, 1 Feb 2002 03:18:30 -0500
Date: Fri, 1 Feb 2002 09:16:10 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Brett <brett@bad-sports.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch] Re: Compile failure with 2.5.3-dj1
In-Reply-To: <Pine.LNX.4.44.0202011607270.6953-100000@bad-sports.com>
Message-ID: <Pine.NEB.4.44.0202010824350.6273-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002, Brett wrote:

> Hey,

Hi Brett,

>...
> arch/i386/kernel/kernel.o: In function `fix_broken_hp_bios_irq9':
> arch/i386/kernel/kernel.o(.text.init+0x32c1): undefined reference to
> `broken_hp_bios_irq9'
> arch/i386/kernel/kernel.o(.text.init+0x32d6): undefined reference to
> `broken_hp_bios_irq9'
>...
> # CONFIG_PCI is not set
>...

>From arch/i386/kernel/dmi_scan.c:

<--  snip  -->

static __init int fix_broken_hp_bios_irq9(struct dmi_blacklist *d)
{
        extern int broken_hp_bios_irq9;

<--  snip  -->

broken_hp_bios_irq9 is in pci-irq.o that only gets included when
CONFIG_PCI is set. The following patch fixes the build error:


--- arch/i386/kernel/dmi_scan.c.old	Fri Feb  1 08:25:24 2002
+++ arch/i386/kernel/dmi_scan.c	Fri Feb  1 09:14:36 2002
@@ -301,12 +301,14 @@
  */
 static __init int fix_broken_hp_bios_irq9(struct dmi_blacklist *d)
 {
+#ifdef CONFIG_PCI
 	extern int broken_hp_bios_irq9;
 	if (broken_hp_bios_irq9 == 0)
 	{
 		broken_hp_bios_irq9 = 1;
 		printk(KERN_INFO "%s detected - fixing broken IRQ routing\n", d->ident);
 	}
+#endif
 	return 0;
 }



cu
Adrian







