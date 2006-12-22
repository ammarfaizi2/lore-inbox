Return-Path: <linux-kernel-owner+w=401wt.eu-S1750939AbWLVRJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWLVRJX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 12:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWLVRJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 12:09:23 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4150 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbWLVRJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 12:09:22 -0500
Date: Fri, 22 Dec 2006 17:09:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: jkosina@suse.cz, linux-input@atrey.karlin.mff.cuni.cz
Subject: [PATCH] Fix some ARM builds due to HID brokenness
Message-ID: <20061222170916.GA3320@dyn-67.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	jkosina@suse.cz, linux-input@atrey.karlin.mff.cuni.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new location for HID is extremely annoying:

1. the help text implies that you need to enable it for any
   keyboard or mouse attached to the system.  This is not
   correct.

2. it defaults to 'y'.  When you have input deselected, this
   causes the kernel to fail to link:

drivers/built-in.o: In function `usb_hidinput_input_event':
hid-input.c:(.text+0x55054): undefined reference to `input_ff_event'
drivers/built-in.o: In function `hidinput_hid_event':
hid-input.c:(.text+0x6446c): undefined reference to `input_event'
hid-input.c:(.text+0x644f8): undefined reference to `input_event'
hid-input.c:(.text+0x64550): undefined reference to `input_event'
hid-input.c:(.text+0x64590): undefined reference to `input_event'
hid-input.c:(.text+0x645b8): undefined reference to `input_event'
drivers/built-in.o: In function `hidinput_disconnect':
hid-input.c:(.text+0x64624): undefined reference to `input_unregister_device'
drivers/built-in.o: In function `hidinput_report_event':
hid-input.c:(.text+0x64670): undefined reference to `input_event'
drivers/built-in.o: In function `hidinput_connect':
hid-input.c:(.text+0x64824): undefined reference to `input_allocate_device'
hid-input.c:(.text+0x675e0): undefined reference to `input_register_device'
hid-input.c:(.text+0x67698): undefined reference to `input_free_device'
hid-input.c:(.text+0x676b8): undefined reference to `input_register_device'
make: *** [.tmp_vmlinux1] Error 1

Fix the second problem by making it depend on INPUT.  The first
problem is left as an exercise for the HID maintainers to solve.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 96d4a0b..1ccc222 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -6,6 +6,7 @@ menu "HID Devices"
 
 config HID
 	tristate "Generic HID support"
+	depends on INPUT
 	default y
 	---help---
 	  Say Y here if you want generic HID support to connect keyboards,
