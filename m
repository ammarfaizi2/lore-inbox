Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWABAI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWABAI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 19:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWABAI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 19:08:58 -0500
Received: from smtpout.e.telefonica.net ([213.4.134.162]:41546 "EHLO
	ZE3SMTPOUT010.e.telefonica.net") by vger.kernel.org with ESMTP
	id S932293AbWABAI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 19:08:57 -0500
Date: Mon, 2 Jan 2006 01:08:57 +0100
From: Eric Van Buggenhaut <ericvb@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [hw_random] device not detected/patch
Message-ID: <20060102000856.GA11491@alterna.homelinux.org>
Reply-To: Eric Van Buggenhaut <ericvb@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Echelon: FBI WTC NSA Handgun Anthrax Afgahnistan Bomb Heroin Laden
X-message-flag: Microsoft discourages the use of Outlook.
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 01 Jan 2006 23:54:31.0368 (UTC) FILETIME=[B571BC80:01C60F2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run a TP42 with 2.6.14.2

One of the pci device is

0000:00:1e.0 0604: 8086:2448 (rev 81)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=08, sec-latency=64
        I/O behind bridge: 00004000-00008fff
        Memory behind bridge: c0200000-cfffffff
        Prefetchable memory behind bridge: e8000000-efffffff


discover sees it as a hw_random device

# grep 80862448 /lib/discover/pci.lst 
        80862448        bridge  i810_rng        82801 Mobile PCI Bridge


and tries to load i810_rng module when support is really in hw_random:

# cat drivers/char/hw_random.c
[...]
static struct pci_device_id rng_pci_tbl[] = {
        { 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
        { 0x1022, 0x746b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },

        { 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
        { 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
        { 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
        { 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
        { 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },

        { 0, }, /* terminate list */
};


device isn't detected though:

# modprobe hw_random
FATAL: Error inserting hw_random (/lib/modules/2.6.14.2n/kernel/drivers/char/hw_random.ko): No such device

hw_random: RNG not detected

Why wouldn't module detect the device ?


OTOH, pci.lst also lists device 80862430 as another RNG

# grep 80862430 /lib/discover/pci.lst 
        80862430        bridge  i810_rng        82801AB PCI Bridge

but it's not listed in rng_pci_tbl[]

Does

--- drivers/char/hw_random.c.orig       2005-12-22 19:36:00.000000000 +0100
+++ drivers/char/hw_random.c    2005-12-22 19:36:16.000000000 +0100
@@ -155,6 +155,7 @@
 
        { 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
        { 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+       { 0x8086, 0x2430, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
        { 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
        { 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
        { 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },

seem reasonable ?

Please CC me on reply

-- 
Eric VAN BUGGENHAUT
ericvb@debian.org
