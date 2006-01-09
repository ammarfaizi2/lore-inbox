Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWAIVnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWAIVnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWAIVna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:43:30 -0500
Received: from mgw-ext04.nokia.com ([131.228.20.96]:62053 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1750765AbWAIVn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:43:29 -0500
Message-ID: <43C2D7E2.1090905@indt.org.br>
Date: Mon, 09 Jan 2006 17:38:42 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>
CC: linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 0/5] Add MMC password protection (lock/unlock) support V3
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2006 21:37:03.0453 (UTC) FILETIME=[D49BC8D0:01C61564]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

New in this version:

- Block size calculation functions replaced by a native kernel function.
- Added a flag (pwd_disabled) to mmc_host structure for disabling password
protection support on the hosts that cannot handle this feature (such as
mmci driver).
- Common code included in the mmc_key_instantiate() and mmc_key_update()
was reorganized into a single function.
- Added more verbose debugging messages.

This series of patches add support for MultiMediaCard (MMC) password
protection, as described in the MMC Specification v4.1. This feature is
supported by all compliant MMC cards, and used by some devices such as
Symbian OS cell phones to optionally protect MMC cards with a password.

By default, a MMC card with no password assigned is always in "unlocked"
state. After password assignment, in the next power cycle the card
switches to a "locked" state where only the "basic" and "lock card"
command classes are accepted by the card. Only after unlocking it with
the correct password the card can be normally used for operations like
block I/O.

Password management and caching is done through the "Kernel Key
Retention Service" mechanism and the sysfs filesystem. The Key Retention
Service is used for (1) unlocking the card, (2) assigning a password to
an unlocked card and
(3) change a card's password. To remove the password and check
locked/unlocked status, a new sysfs attribute was added to the MMC driver.

A sample text-mode reference UI written in shell script (using the
keyctl command from the keyutils package), can be found at:

http://www.indt.org.br/10le/mmc_pwd/mmc_reference_ui-20051215.tar.gz
<http://www.indt.org.br/10le/mmc_pwd/mmc_reference_ui-20051215.tar.gz>


TODO:

- Password caching: when inserting a locked card, the driver should try
to unlock it with the currently stored password (if any), and if it
fails, revoke the key containing it and fallback to the normal "no
password present" situation.

- Currently, some host drivers assume the block length will always be a
power of 2. This is not true for the MMC_LOCK_UNLOCK command, which is a
block command that accepts arbitratry block lengths. We have made the
necessary changes to the omap.c driver (present on the linux-omap tree),
but the same needs to be done for other hosts' drivers.

Known Issue:

- Some cards have an incorrect behaviour (hardware bug?) regarding
password acceptance: if an affected card has password <pwd>, it accepts
<pwd><xxx> as the correct password too, where <xxx> is any sequence of
characters, of any length. In other words, on these cards only the first
<password length> bytes need to match the correct password.

Observation:

We would like to ask you to test these patches. We believe they are
ready to be included on the kernel source.

Comments and suggestions are welcome.

---
Anderson Briglia,
Anderson Lizardo,
Carlos Eduardo Aguiar
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
