Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVGZRdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVGZRdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVGZRbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:31:17 -0400
Received: from mail.dvmed.net ([216.237.124.58]:44986 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261900AbVGZR2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:28:42 -0400
Message-ID: <42E672C1.4000502@pobox.com>
Date: Tue, 26 Jul 2005 13:28:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, lkosewsk@gmail.com
Subject: [info] Silicon Image device hotplug debounce
Content-Type: multipart/mixed;
 boundary="------------040909080902040107030100"
X-Spam-Score: 0.5 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  This is some info that Silicon Image provided, for use
	in developing SATA hotplug. This info is public and not NDA as of the
	publishing of the SiI 311x hardware documentation at
	http://gkernel.sourceforge.net/specs/sii/ [...] 
	Content analysis details:   (0.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 TO_ADDRESS_EQ_REAL     To: repeats address as real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040909080902040107030100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


This is some info that Silicon Image provided, for use in developing 
SATA hotplug.  This info is public and not NDA as of the publishing of 
the SiI 311x hardware documentation at

	http://gkernel.sourceforge.net/specs/sii/

Kudos again to SiI for opening their 311x and CMD680 [PATA] docs.

	Jeff




--------------040909080902040107030100
Content-Type: text/plain;
 name="sata-hotplug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata-hotplug.txt"


Here are some writeups for our 3112/3152 hot plug/unplug handling.  Hope it will
 help in your open source development.

For the 3114 controller, the sequence is essentially the same as the 3112 except
 that the PHYRDY change handler does not need to reset the channel and of course
 obvious changes to handle the two additional channels of the 3114.

Best regards,
[silicon image person]

During driver initialization:
   Write 0xFFFF0000 to both SERROR registers (BAR 5 offsets 0x108 and 0x188)
   to clear any pre-existing serial error bits.

   Enable the PHYRDY change interrupt (bit 16) of the SIEN registers
   (BAR 5 offsets 0x148 and 0x1C8)

Interrupt handler:
   Read PCI Bus Master2 - IDE0 register (BAR 5 offset 0x10) and examine
   bits 4 and 6.  If either bit is set then read the appropriate SERROR
   register and look at bit 16.  If this bit is set a PHYRDY change
   (hot plug/unplug event) has occurred and the PHYRDY change handler
   should be called.

PHYRDY change handler:
   If PHYRDY debounce timer is currently running, stop it.

   Read the appropriate SSTATUS register (BAR 5 offsets 0x104 or 0x184)
   and examine bits 0 and 1.  If both of these bits are not set then the
   device has been unplugged so perform a hard reset on the channel to
   cause the ATA status register to be reset to 0x7F to facilitate device
   detection later on if a device plugged back in.

   Restart the PHYRDY debounce timer (recommended timer period of ~500ms.)

PHYRDY debounce timer handler:
   Read the appropriate SSTATUS register (BAR 5 offsets 0x104 or 0x184)
   and examine bits 0 and 1.

   If both bits are set a device has been plugged in and the driver should
   run its normal device detection/configuration code to make the device
   ready for use.

   If both bits are not set then the device has been unplugged and the
   driver should clean-up any outstanding commands to the removed device.



--------------040909080902040107030100--
