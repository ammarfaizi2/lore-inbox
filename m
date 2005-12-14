Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVLNN31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVLNN31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVLNN31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:29:27 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:7021 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932509AbVLNN30 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:29:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K7+bzVMB1mIPYhD+mwUKVWFHKm/OOXYgQGijd9JD6TnPQtVGhUzCtkWCUbz+0hA7mmoGknzFUyfwY68bUJfo+Pqdw1SfzpPaSbvLlS2ri0RK8ODqYgFqb/536AncWABto1CzDsB9dS4yIFqrcYD67gYCSWU9nvCQz0lnKWbBhns=
Message-ID: <e55525570512140529v8aafdd4m1290cf2c2069a7c8@mail.gmail.com>
Date: Wed, 14 Dec 2005 09:29:25 -0400
From: Anderson Briglia <briglia.anderson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 0/5] [RFC] Add MMC password protection (lock/unlock) support
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
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
