Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbUJZFXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbUJZFXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbUJZFTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 01:19:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:33187 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261925AbUJZFLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 01:11:09 -0400
Date: Tue, 26 Oct 2004 07:11:00 +0200
From: Andi Kleen <ak@suse.de>
To: Li Shaohua <shaohua.li@intel.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       greg@kroah.com, Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] [Proposal]Another way to save/restore PCI config space for suspend/resume
Message-ID: <20041026051100.GA5844@wotan.suse.de>
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 12:50:57PM +0800, Li Shaohua wrote:
> Hi,
> We suffer from PCI config space issue for a long time, which causes many
> system can't correctly resume. Current Linux mechanism isn't sufficient.
> Here is a another idea: 
> Record all PCI writes in Linux kernel, and redo all the write after
> resume in order. The idea assumes Firmware will restore all PCI config

This won't work very well for some cases. e.g. on AMD x86-64 the 
IOMMU is flushed by setting/clearing a bit in PCI config space.
AGP implementations work similar. You really don't want to track
all these flushes, it would be far too costly.

> space to the boot time state, which is true at least for IA32.
> 
> Reason:
> 1. Current PCI save/restore routines only cover first 64 bytes

The driver could set a flag if it wants more.

> 2. No PCI bridge driver currently.

That could be fixed I guess? 

> 3. Some special devices can't or are difficult to save/restore config
> space with current model. Such as PCI link device, it's a sysdev, but
> its resume code can't be invoked with irq disabled.

In this case it would be IMHO better to have specialized suspend/resume
functions in the drivers for these oddball devices.

Most likely they will require some special handling anyways
(like special delays etc.) that can't be done by the generic code 

> 4. ACPI possibly changes special devices' config space, such as host
> bridge or LPC bridge. The special devices generally are vender specific,
> and possibly will not have a driver forever.

I didn't get that one.

-Andi
