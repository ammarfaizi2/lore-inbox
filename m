Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262863AbVAQUeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbVAQUeg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVAQUeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:34:36 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:6418 "EHLO tron.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S262863AbVAQUea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:34:30 -0500
Message-ID: <41EC214D.6060607@stud.feec.vutbr.cz>
Date: Mon, 17 Jan 2005 21:34:21 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix verify_command to allow burning more than 1 DVD
Content-Type: multipart/mixed;
 boundary="------------060007070805030109060200"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0014]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060007070805030109060200
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I use K3B with growisofs to burn DVDs. After boot I can burn a DVD as a 
normal user. But only the first one. When I want to burn another one, 
K3B complains that it is unable to prevent media removal. Then only root 
can burn DVDs.
The bug is in the kernel in the function verify_command.
When a process opens the DVD recorder with O_RDONLY and issues a command 
which is marked safe_for_write, this function is supposed to just return 
-EPERM and do nothing more. However, there is a bug that causes the 
command to be marked as CMD_WARNED. From now on no non-privileged 
process is able to issue this command even if it correctly opens the 
device with O_RDWR - because the command is no longer marked as 
CMD_WRITE_SAFE.
A patch is attached.

Michal

--------------060007070805030109060200
Content-Type: text/x-patch;
 name="verify_command.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="verify_command.patch"

--- linux-2.6.11-mm1/drivers/block/scsi_ioctl.c.orig	2005-01-17 20:42:40.000000000 +0100
+++ linux-2.6.11-mm1/drivers/block/scsi_ioctl.c	2005-01-17 20:43:14.000000000 +0100
@@ -197,9 +197,7 @@ static int verify_command(struct file *f
 	if (type & CMD_WRITE_SAFE) {
 		if (file->f_mode & FMODE_WRITE)
 			return 0;
-	}
-
-	if (!(type & CMD_WARNED)) {
+	} else if (!(type & CMD_WARNED)) {
 		cmd_type[cmd[0]] = CMD_WARNED;
 		printk(KERN_WARNING "scsi: unknown opcode 0x%02x\n", cmd[0]);
 	}

--------------060007070805030109060200--
