Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVA0Qrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVA0Qrm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVA0Qrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:47:41 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:10482 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262658AbVA0Qrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:47:36 -0500
Date: Thu, 27 Jan 2005 17:47:34 +0100
From: Michael Gernoth <simigern@stud.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Subject: AT-Keyboard probing too strict in current bk?
Message-ID: <20050127164734.GA12899@cip.informatik.uni-erlangen.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since the introduction of libps2 in the mainline 2.6 kernel I had the
issue that my keyboard[1] was no longer recognized.
The cause of this is that my "keyboard" responds to all commands with
an acknowledgement (0xFA), even if the command is not implemented. One
of those not implemented commands is 0xF2 (ATKBD_GETID_CMD).

In drivers/input/keyboard/atkbd.c ATKBD_GETID_CMD is used to probe
for the keyboard, and if this fails, another method of detecting
the keyboard is used. It seems that in 2.6.10 atkbd_command
indicated that my keyboard did not successfully execute the command,
but in the current bk-version ps2_command is used, which indicates
a successfull execution, leaving behind invalid keyboard-ids.
This leads to the kernel ignoring my keyboard.

I fixed the problem in my keyboard-converter, but I don't know if
the checking in keyboard-probing shouldn't be changed to catch that
case, too. I have included a patch which does that.

Regards,
  Michael

[1] SUN Type 5 keyboard connected to a self-built sun->ps2 adapter


--- 1.73/drivers/input/keyboard/atkbd.c	2005-01-06 17:42:09 +01:00
+++ edited/drivers/input/keyboard/atkbd.c	2005-01-27 17:27:03 +01:00
@@ -512,7 +512,8 @@
  */
 
 	param[0] = param[1] = 0xa5;	/* initialize with invalid values */
-	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
+	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID) ||
+	    (param[0] == 0xa5 && param[1] == 0xa5)) {
 
 /*
  * If the get ID command failed, we check if we can at least set the LEDs on
