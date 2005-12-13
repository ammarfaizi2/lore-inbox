Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbVLMW1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbVLMW1G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbVLMW1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:27:06 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:59054 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP
	id S1030268AbVLMW1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:27:04 -0500
Message-ID: <439F4AD6.9090203@indt.org.br>
Date: Tue, 13 Dec 2005 18:27:34 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@indt.org.br>
CC: linux-omap-open-source@linux.omap.com,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
References: <20051213213208.303580000@localhost.localdomain>
In-Reply-To: <20051213213208.303580000@localhost.localdomain>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Dec 2005 22:26:22.0669 (UTC) FILETIME=[3F490FD0:01C60034]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resending summary because our first attempt failed]

Hi,

These series of patches add support for MultiMediaCard (MMC) password
protection, as described in the MMC Specification v4.1. This feature is
supported by all compliant MMC cards, and used by some devices such as Symbian
OS cell phones to optionally protect MMC cards with a password. Password length
is limited to 16 bytes.

By default, a MMC card with no password assigned is always in "unlocked" state.
After password assignement, in the next power cycle the card switches to a
"locked" state where only the "basic" and "lock card" command classes are
accepted by the card. Only after unlocking it with the correct password the
card can be normally used for operations like block I/O.

Password management and caching is done through the "Kernel Key Retention
Service" mechanism and the sysfs filesystem. The Key Retention Service is used
for (1) unlocking the card, (2) assigning a password to an unlocked card and
(3) change a card's password. To remove the password and check locked/unlocked
status, a new sysfs attribute was added to the MMC driver.

Along with this thread will be sent a script that tests all possible user
scenarios described above. Also will be attached a tarball containing a simple
text-only reference UI to demonstrate how to manipulate the password.

TODO:

- MMC hotplugging needs to be extended to properly call probe() for the
  different MMC drivers (currently only mmc_block). Currently, the block driver
  is not notified in any way that the card was unlocked.

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

Comments or suggestions are welcome.

--
Anderson Briglia,
Anderson Lizardo,
Carlos Eduardo Aguiar

Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil

