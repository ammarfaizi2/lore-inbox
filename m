Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVIJWfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVIJWfu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVIJWeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:23 -0400
Received: from styx.suse.cz ([82.119.242.94]:41380 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932366AbVIJWdw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:52 -0400
Subject: [PATCH 24/26] HIDDEV - make HIDIOCSREPORT wait IO completion
In-Reply-To: <1126391654374@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:14 +0200
Message-Id: <11263916543880@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: HIDDEV - make HIDIOCSREPORT wait IO completion
From: Stefan Nickl <Stefan.Nickl@kontron.com>
Date: 1125903466 -0500

When trying to make the hiddev driver issue several Set_Report control
transfers to a custom device with 2.6.13-rc6, only the first transfer in a
row is carried out, while others immediately following it are silently
dropped.

This happens where hid_submit_report() (in hid-core.c) tests for
HID_CTRL_RUNNING, which seems to be still set because the first transfer is
not finished yet.

As a workaround, inserting a delay between the two calls to
ioctl(HIDIOCSREPORT) in userspace "solves" the problem.  The
straightforward fix is to add a call to hid_wait_io() to the implementation
of HIDIOCSREPORT (in hiddev.c), just like for HIDIOCGREPORT.  Works fine
for me.

Apparently, this issue has some history:
http://marc.theaimsgroup.com/?l=linux-usb-users&m=111100670105558&w=2

Signed-off-by: Stefan Nickl <Stefan.Nickl@kontron.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/usb/input/hiddev.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

010988e888a0abbe7118635c1b33d049caae6b29
diff --git a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c
+++ b/drivers/usb/input/hiddev.c
@@ -507,6 +507,7 @@ static int hiddev_ioctl(struct inode *in
 			return -EINVAL;
 
 		hid_submit_report(hid, report, USB_DIR_OUT);
+		hid_wait_io(hid);
 
 		return 0;
 

