Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVBJMbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVBJMbS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 07:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVBJMbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 07:31:18 -0500
Received: from relay.muni.cz ([147.251.4.35]:1494 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262107AbVBJMbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 07:31:14 -0500
Date: Thu, 10 Feb 2005 13:31:12 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: sysfs/kobject update breaks ACPI?
Message-ID: <20050210123112.GZ18023@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

my laptop (Asus M6R, http://www.fi.muni.cz/~kas/m6r/) has problems with
ACPI with newer kernels - most of ACPI operations fail - here is the
sample of error messages printed during boot. All other error messages
contain the "AE_TIME" line as well:

Initializing Cryptographic API
    ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.SBRG.EC0_.RDC3]
(Node ddf09840), AE_TIME
    ACPI-1138: *** Error: Method execution failed [\ECIO] (Node ddf09380), AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.SBRG.EC0_.ACPS]
(Node ddf078e0), AE_TIME
    ACPI-1138: *** Error: Method execution failed [\ACPS] (Node ddf03220), AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.AC0_._PSR] (Node
ddf07160), AE_TIME
    ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.SBRG.EC0_.SMBR]
(Node ddf09540), AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.SBRG.EC0_.BIF0]
(Node ddf07c40), AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.BAT0._BIF] (Node
ddf07e20), AE_TIME

	I cannot read battery status etc. In 2.6.9 ACPI works, in 2.6.10
(and later) it doesn't. I've tried to do a binary search in order to find
an exact change which breaks ACPI for me, and found the following:
2.6.10-rc1-bk11 is OK, 2.6.10-rc1-bk12 is not. So I've diffed the -bk11
and -bk12 trees and tried to trim the patch to an absolute minimum. Now
I have a patch (http://bugme.osdl.org/attachment.cgi?id=4534&action=view)
which, when applied to 2.6.10-rc1-bk11, breaks ACPI on my laptop, and,
when subtracted from 2.6.10-rc1-bk12 (using patch -p1 -R), makes ACPI working
in 2.6.10-rc1-bk12.

	However, the patch does not touch anything related to ACPI
(I think). It is a sysfs and kobject update. So I don't see how this
can break ACPI for my laptop.

	It seems the failing methods are always
\_SB_.PCI0.SBRG.EC0_.<something>, and they all try to acquire an internal
mutex using the following code (from my DSDT):

	If (LEqual (Acquire (MUEC, 0xFFFF), 0x00))

	Do you have any idea on what is wrong here? More information,
my source and binary DSDT are attached to the following kernel bugzilla
entry:

http://bugme.osdl.org/show_bug.cgi?id=4150

Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
