Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbUJZFF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbUJZFF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUJZFA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 01:00:59 -0400
Received: from fmr05.intel.com ([134.134.136.6]:30179 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262108AbUJZE6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 00:58:08 -0400
Subject: [Proposal]Another way to save/restore PCI config space for
	suspend/resume
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, greg@kroah.com,
       Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Message-Id: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 26 Oct 2004 12:50:57 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
We suffer from PCI config space issue for a long time, which causes many
system can't correctly resume. Current Linux mechanism isn't sufficient.
Here is a another idea: 
Record all PCI writes in Linux kernel, and redo all the write after
resume in order. The idea assumes Firmware will restore all PCI config
space to the boot time state, which is true at least for IA32.

Reason:
1. Current PCI save/restore routines only cover first 64 bytes
2. No PCI bridge driver currently.
3. Some special devices can't or are difficult to save/restore config
space with current model. Such as PCI link device, it's a sysdev, but
its resume code can't be invoked with irq disabled.
4. ACPI possibly changes special devices' config space, such as host
bridge or LPC bridge. The special devices generally are vender specific,
and possibly will not have a driver forever.

Possibly we must consider other factors:
1.tracking writes alone will not be enough. Some PCI devices may have
restrictions such as something has to be written after it is read and
the like. Still we should be able to do this if we can trace all pci
reads and writes and repeat it at restore.
2. For support hotplug, add a callback for hotplug PCI remove. When a
device is removed, all records about it are removed.
What's your opinions?

Thanks,
Shaohua

