Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVARK60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVARK60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 05:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVARK5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 05:57:50 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:8466 "EHLO tron.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S261256AbVARK4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 05:56:13 -0500
Message-ID: <41ECEB45.5040505@stud.feec.vutbr.cz>
Date: Tue, 18 Jan 2005 11:56:05 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>, Nick Sanders <sandersn@btinternet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to burn DVDs
References: <1105474144.15542.1.camel@zeus.city.tvnet.hu><1105474144.15542.1.camel@zeus.city.tvnet.hu> <200501112151.13351.sandersn@btinternet.com> <41E557BC.9010405@tmr.com>
In-Reply-To: <41E557BC.9010405@tmr.com>
Content-Type: multipart/mixed;
 boundary="------------010303000406020505050306"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (0.1 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -0.6 BAYES_01               BODY: Bayesian spam probability is 1 to 10%
                              [score: 0.0106]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010303000406020505050306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bill Davidsen wrote:
> Nick Sanders wrote:
>>For me when running growisofs  with user permissions on 2.6.10 (ide-cd) it 
>>works perfectly 1st time but 2nd time fails with the error below. It works 
>>fine when run as root.
>>
>>:-( unable to PREVENT MEDIA REMOVAL: Operation not permitted
>>
>>As an aside audio cd burning with cdrecord works as long as the '-text' option 
>>isn't used, if it is the process hangs.
> 
> 
> I reported a similar thing with cdrecord, writing a first session 
> successfully using the -multi flag, but not being able to append to it 
> or read the size with the "-msinfo" flag. I was totally blown off and 
> told I didn't have permissions on the device, even though I was able to 
> write to it.
> 
> I believe the true answer is that the SCSI command filter is blocking a 
> command needed to perform the operation, probably a command to lock the 
> door of the drive. In my case I have permissions to write the CD, just 
> not to read the info needed to write additional sessions.
> 

Hello,
Bill and Nick, could you try the attached patch that I sent to Jens 
Axboe yesterday? (You can see the mail with an explanation on
http://marc.theaimsgroup.com/?l=linux-kernel&m=110599420505734&w=2 )

Michal

--------------010303000406020505050306
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

--------------010303000406020505050306--
