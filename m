Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVGDVPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVGDVPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 17:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVGDVPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 17:15:19 -0400
Received: from dsl081-242-086.sfo1.dsl.speakeasy.net ([64.81.242.86]:2248 "EHLO
	lapdance.christiehouse.net") by vger.kernel.org with ESMTP
	id S261679AbVGDVOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 17:14:51 -0400
Message-ID: <42C9A69A.5050905@waychison.com>
Date: Mon, 04 Jul 2005 17:14:02 -0400
From: Mike Waychison <mike@waychison.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Dmitry Torokhov <dtor@mail.ru>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: ALPS psmouse_reset on reconnect confusing Tecra M2
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I just upgrade my Tecra M2 this weekend to the latest GIT tree and
noticed that my mouse pointer/touchpad is now broken on resume.

Investigating, it appears that mouse device gets confused due to the
introduced psmouse_reset(psmouse) during reconnect:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f3a5c73d5ecb40909db662c4d2ace497b25c5940

Before resume, this is the output I get:

Jul  3 01:25:11 lapdance kernel: alps.c: E6 report: 00 00 64
Jul  3 01:25:11 lapdance kernel: alps.c: E7 report: 22 02 14
Jul  3 01:25:11 lapdance kernel: alps.c: E6 report: 00 00 64
Jul  3 01:25:11 lapdance kernel: alps.c: E7 report: 22 02 14
Jul  3 01:25:12 lapdance kernel: alps.c: Status: 05 01 0a
Jul  3 01:25:12 lapdance kernel: alps.c: Enabling hardware tapping
Jul  3 01:25:12 lapdance kernel: alps.c: Status: 05 01 0a
Jul  3 01:25:12 lapdance kernel: input: DualPoint Stick on isa0060/serio1
Jul  3 01:25:12 lapdance kernel: input: AlpsPS/2 ALPS DualPoint TouchPad
on isa0060/serio1

If I then suspend and resume:

Jul  3 01:26:13 lapdance kernel: alps.c: E6 report: 00 00 64
Jul  3 01:26:13 lapdance kernel: alps.c: E7 report: 73 02 0a
Jul  3 01:26:14 lapdance kernel: alps.c: E6 report: 00 00 64
Jul  3 01:26:14 lapdance kernel: alps.c: E7 report: 73 02 0a
Jul  3 01:26:14 lapdance kernel: alps.c: Status: 15 01 0a
Jul  3 01:26:14 lapdance kernel: alps.c: Enabling hardware tapping
Jul  3 01:26:14 lapdance kernel: alps.c: Status: 15 01 0a
Jul  3 01:26:14 lapdance kernel: input: PS/2 Mouse on isa0060/serio1
Jul  3 01:26:14 lapdance kernel: input: AlpsPS/2 ALPS GlidePoint on
isa0060/serio1

The pointer is confused, and a hard shutdown and boot is required to
restore it.  A reboot alone won't do the trick.

FWIW, I was using the regular IMPS/2 X mouse driver, though I later
tried using the synaptics X driver and that didn't work either.

Other things I've tried include trying psmouse_reset until it returns
successfully, though sometimes it did, and other times it didn't, even
after 100 retries.  In either case the pointer didn't come back.

Removing the psmouse_reset makes the pointer come back properly 100% of
the time.

Are you sure that the psmouse_reset is really the right thing to do?

(worked fine in 2.6.11-rc2).

Thanks,

Mike Waychison
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCyaaadQs4kOxk3/MRAqvBAKCeaYgsMFPrubb+7p8Se/Z6BwEmcwCfXPOB
yVQkUCORLUKyGGO5ttnfjIs=
=B1O/
-----END PGP SIGNATURE-----
