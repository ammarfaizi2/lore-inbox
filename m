Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSFHWuk>; Sat, 8 Jun 2002 18:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317466AbSFHWuk>; Sat, 8 Jun 2002 18:50:40 -0400
Received: from hera.cwi.nl ([192.16.191.8]:49815 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317463AbSFHWui>;
	Sat, 8 Jun 2002 18:50:38 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 9 Jun 2002 00:50:39 +0200 (MEST)
Message-Id: <UTC200206082250.g58ModI20444.aeb@smtp.cwi.nl>
To: Andrej.Borsenkow@mow.siemens.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-pre9, Iomega Jaz, PPA - endless loop in SCSI recovery thread
Cc: linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>

    It looks like a media went corrupted so one expects some reasonable
    error message. What happens is I get endless loop in SCSI error recovery
    thread. The only way to clear up situation is to reboot

That is the normal situation. I have never seen the SCSI error handler
do anything else but bring down the system. Commenting it out
really increases the stability of Linux (on my hardware).

    the kernel is 2.4.18-18mdk based on 2.4.1-pre9.

    Jun  8 20:50:03 localhost: In eh_done cd8b1e00 result:2
    Jun  8 20:50:03 localhost: send_eh_cmnd: cd8b1e00 eh_state:2002
    Jun  8 20:50:03 localhost: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
    Jun  8 20:50:03 localhost: Adding timer for command cd8b1e00 at 6000 (d2a12a28)
    Jun  8 20:50:06 localhost: In eh_done cd8b1e00 result:2
    Jun  8 20:50:06 localhost: send_eh_cmnd: cd8b1e00 eh_state:2002
    Jun  8 20:50:06 localhost: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
    Jun  8 20:50:06 localhost: Adding timer for command cd8b1e00 at 6000 (d2a12a28)
    Jun  8 20:50:09 localhost: In eh_done cd8b1e00 result:2
    Jun  8 20:50:09 localhost: send_eh_cmnd: cd8b1e00 eh_state:2002
    Jun  8 20:50:09 localhost: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
    Jun  8 20:50:09 localhost: Adding timer for command cd8b1e00 at 6000 (d2a12a28)

Hmm. It is clear what happens.
You are in scsi_error.c:scsi_send_eh_cmnd() and send a command,
the return status is NEEDS_RETRY, and the same command is sent again. Etc.

Now retrying is evil, and trying more than three times almost always
stupid, so if you add in this function

	int retry_count = 0;

and

    retry:
	if (++retry_count > 3) {
		SCpnt->eh_state = FAILED;
		return;
	}

that would surely be an improvement locally.
Globally one wonders: there is a retry count already - why isn't it
honoured by everybody involved? (But it isnt - it is only used in
scsi_decide_disposition().)

Where did we get this NEEDS_RETRY in the first place?
Well, scsi_check_sense() will return NEEDS_RETRY for MEDIUM_ERROR.
(Bad: the hardware also did retry many times already; it is usually very
counterproductive to keep on hitting the same bad spot on the media.)

There are also other code paths that will loop, but this one
looks most likely here.

Andries
