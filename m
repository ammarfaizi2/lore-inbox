Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268654AbUHRGM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268654AbUHRGM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 02:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268660AbUHRGM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 02:12:57 -0400
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:47232 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268654AbUHRGMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 02:12:54 -0400
Date: Wed, 18 Aug 2004 08:12:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [patch] enums to clear suspend-state confusion
Message-ID: <20040818061227.GA7854@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz> <20040817212510.GA744@elf.ucw.cz> <20040817152742.17d3449d.akpm@osdl.org> <20040817223700.GA15046@elf.ucw.cz> <20040817161245.50dd6b96.akpm@osdl.org> <20040818002711.GD15046@elf.ucw.cz> <1092794687.10506.169.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092794687.10506.169.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Now, Patrick has some plans with device power managment and they
> > included something bigger being passed down to the drivers. I wanted
> > to prepare for those plans.
> > 
> > I can replace suspend_state_t with enum system_state, but it might
> > mean that enum system_state will have to be extended with things like
> > RUNTIME_PM_PCI_D0 in future... I guess that's easiest thing to do. It
> > solves all the problems we have *now*.
> 
> Better is to use a typedef then, so that enum can be turned into a
> pointer to a structure later on, and drivers using the "helper"
> function to_pci_state() would not need any change when that transition
> happen.

Yes, that's exactly what I did... Unfortunately typedef means ugly
code. So I'll just switch it back to enum system_state, and lets care
about device power managment when it hits us, okay?

--- tmp/linux/include/linux/pci.h	2004-08-15 19:15:05.000000000 +0200
+++ linux/include/linux/pci.h	2004-08-17 23:16:41.000000000 +0200
...
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
-	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
+	int  (*suspend) (struct pci_dev *dev, suspend_state_t reason);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 
--- tmp/linux/include/linux/pm.h	2004-08-15 19:15:05.000000000 +0200
+++ linux/include/linux/pm.h	2004-08-15 19:35:41.000000000 +0200
... 
+/*
+ * For now, drivers only get system state. Later, this is going to become
+ * structure or something to enable runtime power managment.
+ */
+typedef enum system_state suspend_state_t;
+
+#define SUSPEND_EQ(a, b) (a == b)
+
 enum {
 	PM_DISK_FIRMWARE = 1,
 	PM_DISK_PLATFORM,

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
