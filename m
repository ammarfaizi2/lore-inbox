Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVCMTOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVCMTOT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 14:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVCMTOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 14:14:18 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:14570 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261429AbVCMTOA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 14:14:00 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Sun, 13 Mar 2005 19:14:01 +0000
Message-Id: <1110741241.8136.46.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: IDE failure on ACPI resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On resume, an HP nc6220 fails during resuming of the IDE devices. In
this section of code from ide-iops.c:

                stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
                if ((stat & BUSY_STAT) == 0)
                        return 0;
                /*
                 * Assume a value of 0xff means nothing is connected to
                 * the interface and it doesn't implement the pull-down
                 * resistor on D7.
                 */
                if (stat == 0xff)
                        return -ENODEV;

0xff is read and ENODEV returned. This results in

hda: bus not ready on wakeup
hda: drive not ready on wakeup

and then the machine sits there until some later command times out. It
seems that reading anything off the IDE bus just results in 0xff being
read.

The IDE controller is an Intel ICH6. Another HP laptop with an identical
chipset works fine, which makes me suspicious of the BIOS. Is the fact
that Linux doesn't seem to run the GTF, STM or GTM methods likely to be
relevant here?

-- 
Matthew Garrett | mjg59@srcf.ucam.org

