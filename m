Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263199AbUDYS3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUDYS3u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 14:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbUDYS3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 14:29:50 -0400
Received: from hell.org.pl ([212.244.218.42]:65290 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S263199AbUDYS3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 14:29:48 -0400
Date: Sun, 25 Apr 2004 20:29:49 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: linux-kernel@vger.kernel.org
Cc: swsusp-devel@lists.sourceforge.net
Subject: [AGP] intel_845_configure() at resume
Message-ID: <20040425182949.GA8151@hell.org.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	swsusp-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've been trying to nail down the AGP problems most swsusp[12]/pmdisk users
are experiencing (deadlocks or reboots around the phase of copying the
original kernel back).

I have an i845MP chipset, which has its resume callback present in the
driver (the intel_845_configure()). I did the testing using 2.6.5+swsusp2, 
but the outcome for the other implementations should be the same. The new
radeonfb code is compiled in. MCE is not compiled, as it tends to
interfere.

The video adapter is a Radeon M7, using XFree86-4.4 native drivers and
kernel DRM modules, DRI is on. This configuration is rock solid with 2.4
if suspend / resume is concerned.

The standard behaviour for my system is as follows:
1) Provided intel-agp.ko has not been loaded, it suspends and resumes
   fairly stable.

2) Once the module has been loaded, but no X has been run, the system will
   hang in intel_845_configure(), exactly at
#v+ drivers/char/agp/intel-agp.c +1481
	/* clear any possible error conditions */
	pci_write_config_word(agp_bridge->dev, INTEL_I845_ERRSTS, 0x001c);
#v-
   Commenting the line out leads to a successful resume.

3) If X is started, and suspend is done from another (text) VT, the system 
   hangs a bit earlier, exactly at:
#v+ drivers/char/agp/intel-agp.c +1475
	/* agpctrl */
	pci_write_config_dword(agp_bridge->dev, INTEL_AGPCTRL, 0x0000); 
#v-
   Commenting this (and all the following) line allows the system to
   resume, but switching back to the X VT produces garbled screen (colour
   distorted, etc.) and hangs the system (though SysRq works).

4) Apparently, if X is started and loads the module itself, and no 
   additional VT switching occurs, the first resume attempt succeeds.

Also, I'm curious as to whether the whole mechanism is correct -- it seems
to send bytes back and forth during resume, intead of reading (and saving)
them at suspend and writing back at resume.
Can anyone comment on that?
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
