Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVA1D71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVA1D71 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 22:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVA1D71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 22:59:27 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:23730 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261432AbVA1D7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 22:59:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Michael Gernoth <simigern@stud.uni-erlangen.de>
Subject: Re: AT-Keyboard probing too strict in current bk?
Date: Thu, 27 Jan 2005 22:59:20 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050127164734.GA12899@cip.informatik.uni-erlangen.de>
In-Reply-To: <20050127164734.GA12899@cip.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501272259.21091.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 January 2005 11:47, Michael Gernoth wrote:
> Hi,
> 
> since the introduction of libps2 in the mainline 2.6 kernel I had the
> issue that my keyboard[1] was no longer recognized.
> The cause of this is that my "keyboard" responds to all commands with
> an acknowledgement (0xFA), even if the command is not implemented. One
> of those not implemented commands is 0xF2 (ATKBD_GETID_CMD).
> 
> In drivers/input/keyboard/atkbd.c ATKBD_GETID_CMD is used to probe
> for the keyboard, and if this fails, another method of detecting
> the keyboard is used. It seems that in 2.6.10 atkbd_command
> indicated that my keyboard did not successfully execute the command,
> but in the current bk-version ps2_command is used, which indicates
> a successfull execution, leaving behind invalid keyboard-ids.
> This leads to the kernel ignoring my keyboard.
> 

Hi, 

Thanks for noticing this. The following patch should fix timeout
handling in libps2 and restore previous behavior:


===== drivers/input/serio/libps2.c 1.4 vs edited =====
--- 1.4/drivers/input/serio/libps2.c	2005-01-27 02:13:43 -05:00
+++ edited/drivers/input/serio/libps2.c	2005-01-27 22:52:36 -05:00
@@ -115,8 +115,8 @@
 	 */
 	timeout = msecs_to_jiffies(command == PS2_CMD_RESET_BAT ? 4000 : 500);
 
-	wait_event_interruptible_timeout(ps2dev->wait,
-		!(ps2dev->flags & PS2_FLAG_CMD1), timeout);
+	timeout = wait_event_interruptible_timeout(ps2dev->wait,
+				!(ps2dev->flags & PS2_FLAG_CMD1), timeout);
 
 	if (ps2dev->cmdcnt && timeout > 0) {
 


-- 
Dmitry
