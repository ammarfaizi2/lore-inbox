Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVCTVZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVCTVZf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 16:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVCTVZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 16:25:35 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:52674 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261267AbVCTVZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 16:25:27 -0500
Date: Sun, 20 Mar 2005 22:29:58 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11.2][0/2] printk with anti-cluttering-feature
In-Reply-To: <Pine.LNX.4.58.0503201425080.2886@be1.lrz>
Message-ID: <Pine.LNX.4.58.0503202151360.2869@be1.lrz>
References: <Pine.LNX.4.58.0503200528520.2804@be1.lrz> <423D6353.5010603@tls.msk.ru>
 <Pine.LNX.4.58.0503201425080.2886@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches address the issue of dmesg being slowly spammed with 
repeated warnings.

Some parts of the kernel want to notify the user about deprecated or 
invalid calls or parameters. These messages will slowly fill dmesg and 
hinder you from seing the boot messages.

Examples are:
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
 (I'm using a keyboard switch and a IBM PS/2 keyboard)

program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
 (I'll use the latest version as soon as I need to)

tuner: TV freq (0.00) out of range (44-958)
 (I'll update zapping later)

This is prevented by introducing printk_nospam(), which takes an
additional magic value to identify the last one who printk-ed something.
If the current magic matches the one of the last successfull caller,
nothing will be printed. The normal printk will reset the magic to 0,
which ensures that if a messages indicating a current problem won't be
hidden just because it occured before.

Additionally, all these messages will be rate-limited, since they are
usurally triggered by userspace and thereby a way to DoS the machine.
Without the rate-limit, the user could repeatedly call two functions that
cause a printk in order to spam the log.

(The rate limit alone is not sufficient to prevent repeated warnings, 
since they would be allowed by the burst limit or by being slow.)

This patch uses an uint, which can be read and written atomically by most
architectures. On architectures not supporting atomic reads to ints, the
message may be dropped or printed twice. I think it's OK, since dropping
for being racy is unlikely (especially compared to hitting the rate
limit), and a double line won't hurt.



The first patch will introduce the printk_nospam function.
The second patch will update the three printks causing my examples.

Since the TV freq message can be triggered by UID != 0, I'll send a hotfix
patch for the 2.6.11.x line, too. This patch is only compile-tested.
