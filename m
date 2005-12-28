Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbVL1SzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbVL1SzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 13:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbVL1SzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 13:55:14 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:14691 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP id S964871AbVL1SzM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 13:55:12 -0500
Message-Id: <20051228184014.571997000@localhost.localdomain>
Date: Wed, 28 Dec 2005 14:40:14 -0400
From: Anderson Lizardo <anderson.lizardo@indt.org.br>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
       David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       Anderson Lizardo <anderson.lizardo@indt.org.br>,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Subject: [patch 0/5] Add MMC password protection (lock/unlock) support V2
X-OriginalArrivalTime: 28 Dec 2005 18:53:50.0970 (UTC) FILETIME=[0AE075A0:01C60BE0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These series of patches add support for MultiMediaCard (MMC) password
protection, as described in the MMC Specification v4.1. This feature is
supported by all compliant MMC cards, and used by some devices such as Symbian
OS cell phones to optionally protect MMC cards with a password.

By default, a MMC card with no password assigned is always in "unlocked" state.
After password assignment, in the next power cycle the card switches to a
"locked" state where only the "basic" and "lock card" command classes are
accepted by the card. Only after unlocking it with the correct password the
card can be normally used for operations like block I/O.

Password management and caching is done through the "Kernel Key Retention
Service" mechanism and the sysfs filesystem. The Key Retention Service is used
for (1) unlocking the card, (2) assigning a password to an unlocked card and
(3) change a card's password. To remove the password and check locked/unlocked
status, a new sysfs attribute was added to the MMC driver.

A sample text-mode reference UI written in shell script (using the keyctl
command from the keyutils package), can be found at:

http://www.indt.org.br/10le/mmc_pwd/mmc_reference_ui-20051215.tar.gz

New in this version:

- Removed unnecessary #include directive
- Fixed comment formatting issues.
- Added code to force the block driver to re-probe() the card after unlocking
  it.

TODO:

- Password caching: when inserting a locked card, the driver should try to
 unlock it with the currently stored password (if any), and if it fails,
 revoke the key containing it and fallback to the normal "no password present"
 situation.

- Currently, some host drivers assume the block length will always be a power
 of 2. This is not true for the MMC_LOCK_UNLOCK command, which is a block
 command that accepts arbitratry block lengths. We have made the necessary
 changes to the omap.c driver (present on the linux-omap tree), but the same
 needs to be done for other hosts' drivers.

Known Issue:

- Some cards have an incorrect behaviour (hardware bug?) regarding password
 acceptance: if an affected card has password <pwd>, it accepts <pwd><xxx> as
 the correct password too, where <xxx> is any sequence of characters, of any
 length. In other words, on these cards only the first <password length> bytes
 need to match the correct password.

Comments, suggestions are welcome.
--
Anderson Briglia,
Anderson Lizardo,
Carlos Eduardo Aguiar
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
