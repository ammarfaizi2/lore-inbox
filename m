Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSFIQGS>; Sun, 9 Jun 2002 12:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSFIQGR>; Sun, 9 Jun 2002 12:06:17 -0400
Received: from thoth.sbs.de ([192.35.17.2]:42371 "EHLO thoth.sbs.de")
	by vger.kernel.org with ESMTP id <S310190AbSFIQGN> convert rfc822-to-8bit;
	Sun, 9 Jun 2002 12:06:13 -0400
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel list <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org, Juan Quintela <quintela@mandrakesoft.com>
Subject: Re: 2.4.18-pre9, Iomega Jaz, PPA - endless loop in SCSI recovery
	thread
In-Reply-To: <UTC200206082250.g58ModI20444.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5-3mdk 
Date: 09 Jun 2002 20:04:09 +0400
Message-Id: <1023638656.3261.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

В Вск, 09.06.2002, в 02:50, Andries.Brouwer@cwi.nl написал:
>     From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
> 
>     It looks like a media went corrupted so one expects some reasonable
>     error message. What happens is I get endless loop in SCSI error recovery
>     thread. The only way to clear up situation is to reboot
> 
> That is the normal situation. I have never seen the SCSI error handler
> do anything else but bring down the system. Commenting it out
> really increases the stability of Linux (on my hardware).
> 

MAINTAINERS:

SCSI SUBSYSTEM
L:      linux-scsi@vger.kernel.org
S:      Unmaintained

Oh, well ...


> Hmm. It is clear what happens.
> You are in scsi_error.c:scsi_send_eh_cmnd() and send a command,
> the return status is NEEDS_RETRY, and the same command is sent again. Etc.
> 
> Now retrying is evil, and trying more than three times almost always
> stupid, so if you add in this function
> 
> 	int retry_count = 0;
> 
> and
> 
>     retry:
> 	if (++retry_count > 3) {
> 		SCpnt->eh_state = FAILED;
> 		return;
> 	}
> 
> that would surely be an improvement locally.
> Globally one wonders: there is a retry count already - why isn't it
> honoured by everybody involved? (But it isnt - it is only used in
> scsi_decide_disposition().)
>

Which actually looks like an oversight ... and comments in unjam_host
loop even indicate this must be used.

Anyway, returning FAILED does not look right here. As long as I
understand what happens, FAILED means hard error (like failing to
communicate with device) while here we have more or less "soft" error.
So I decided to copy relevant bits from scsi_decide_disposition into
scsi_eh_completed_normally which resulted in pretty nice overall error
handling:

Jun  9 19:30:45 localhost kernel: Activating command for device 4 (1)
Jun  9 19:30:45 localhost kernel: Doing sd request, dev = 0x804, block = 944448
Jun  9 19:30:45 localhost kernel: sda : real dev = /dev/0, block = 944480
Jun  9 19:30:45 localhost kernel: sda : reading 8/8 512 byte blocks.
Jun  9 19:30:45 localhost kernel: Adding timer for command cfe5a000 at 6000 (d2a13964)
Jun  9 19:30:45 localhost kernel: scsi_dispatch_cmnd (host = 0, channel = 0, target = 4, command = cfe5a058, buffer = ca4d4000, 
Jun  9 19:30:45 localhost kernel: bufflen = 4096, done = d2813b84)
Jun  9 19:30:45 localhost kernel: queuecommand : routine at d2a38292
Jun  9 19:30:45 localhost kernel: leaving scsi_dispatch_cmnd()
Jun  9 19:30:47 localhost kernel: Clearing timer for command cfe5a000 1
Jun  9 19:30:47 localhost kernel: Command failed cfe5a000 2 active=1 busy=1 failed=0
Jun  9 19:30:47 localhost kernel: bh08:04: old sense key None
Jun  9 19:30:47 localhost kernel: Non-extended sense class 0 code 0x0
Jun  9 19:30:47 localhost kernel: Waking error handler thread (-1)
Jun  9 19:30:47 localhost kernel: Error handler waking up
Jun  9 19:30:47 localhost kernel: scsi_unjam_host: Checking to see if we need to request sense
Jun  9 19:30:47 localhost kernel: scsi_unjam_host: Requesting sense for 4
Jun  9 19:30:47 localhost kernel: Adding timer for command cfe5a000 at 1000 (d2a13af8)
Jun  9 19:30:47 localhost kernel: In eh_done cfe5a000 result:0
Jun  9 19:30:47 localhost kernel: send_eh_cmnd: cfe5a000 eh_state:2002
Jun  9 19:30:47 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2002
Jun  9 19:30:47 localhost kernel: Sense requested for cfe5a000 - result 2
Jun  9 19:30:47 localhost kernel: Info fld=0xe6960, Current bh08:04: sense key Medium Error
Jun  9 19:30:47 localhost kernel: Additional sense indicates Address mark not found for data field
Jun  9 19:30:47 localhost kernel: Adding timer for command cfe5a000 at 6000 (d2a13af8)
Jun  9 19:30:49 localhost kernel: In eh_done cfe5a000 result:2
Jun  9 19:30:49 localhost kernel: send_eh_cmnd: cfe5a000 eh_state:2002
Jun  9 19:30:49 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
Jun  9 19:30:49 localhost kernel: Adding timer for command cfe5a000 at 6000 (d2a13af8)
Jun  9 19:30:51 localhost kernel: In eh_done cfe5a000 result:2
Jun  9 19:30:51 localhost kernel: send_eh_cmnd: cfe5a000 eh_state:2002
Jun  9 19:30:51 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
Jun  9 19:30:51 localhost kernel: Adding timer for command cfe5a000 at 6000 (d2a13af8)
Jun  9 19:30:53 localhost kernel: In eh_done cfe5a000 result:2
Jun  9 19:30:53 localhost kernel: send_eh_cmnd: cfe5a000 eh_state:2002
Jun  9 19:30:53 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2001
Jun  9 19:30:53 localhost kernel: Adding timer for command cfe5a000 at 6000 (d2a13af8)
Jun  9 19:30:55 localhost kernel: In eh_done cfe5a000 result:2
Jun  9 19:30:55 localhost kernel: send_eh_cmnd: cfe5a000 eh_state:2002
Jun  9 19:30:55 localhost kernel: scsi_send_eh_cmnd: scsi_eh_completed_normally 2002
Jun  9 19:30:55 localhost kernel: Total of 0+0 commands on 0 devices require eh work
Jun  9 19:30:55 localhost kernel: Adding timer for command cfe5a000 at 100 (d2a13af8)
Jun  9 19:30:55 localhost kernel: Clearing timer for command cfe5a000 1
Jun  9 19:30:55 localhost kernel: scsi_error.c: Waking up host to restart
Jun  9 19:30:55 localhost kernel: Error handler sleeping
Jun  9 19:30:55 localhost kernel: Command finished 1 0 0x2
Jun  9 19:30:55 localhost kernel: Notifying upper driver of completion for device 4 8000002
Jun  9 19:30:55 localhost kernel: sda : rw_intr(0, 8000002 [f0 3])
Jun  9 19:30:55 localhost kernel: scsi0: ERROR on channel 0, id 4, lun 0, CDB: Read (10) 00 00 0e 69 60 00 00 08 00 
Jun  9 19:30:55 localhost kernel: Info fld=0xe6960, Current sd08:04: sense key Medium Error
Jun  9 19:30:55 localhost kernel: Additional sense indicates Address mark not found for data field
Jun  9 19:30:55 localhost kernel: I/O error: dev 08:04, sector 944448
Jun  9 19:30:55 localhost kernel: Deactivating command for device 4 (active=0, failed=0)
Jun  9 19:30:55 localhost kernel: Open returning 1
Jun  9 19:30:55 localhost kernel: Trying ioctl with scsi command 30
Jun  9 19:30:55 localhost kernel: scsi_do_req (host = 0, channel = 0 target = 4, buffer =00000000, bufflen = 0, done = d2a0f088, timeout = 1000, retries = 5)
Jun  9 19:30:55 localhost kernel: command : 1e  00  00  00  00  00  
Jun  9 19:30:55 localhost kernel: Activating command for device 4 (1)
Jun  9 19:30:55 localhost kernel: Leaving scsi_init_cmd_from_req()
Jun  9 19:30:55 localhost kernel: Adding timer for command cfe5a000 at 1000 (d2a13964)
Jun  9 19:30:55 localhost kernel: scsi_dispatch_cmnd (host = 0, channel = 0, target = 4, command = cfe5a058, buffer = 00000000, 
Jun  9 19:30:55 localhost kernel: bufflen = 0, done = d2a0f088)
Jun  9 19:30:55 localhost kernel: queuecommand : routine at d2a38292
Jun  9 19:30:55 localhost kernel: leaving scsi_dispatch_cmnd()
Jun  9 19:30:55 localhost kernel: Leaving scsi_do_req()
Jun  9 19:30:55 localhost kernel: Clearing timer for command cfe5a000 1
Jun  9 19:30:55 localhost kernel: Command finished 1 0 0x0
Jun  9 19:30:55 localhost kernel: Notifying upper driver of completion for device 4 0
Jun  9 19:30:55 localhost kernel: Deactivating command for device 4 (active=0, failed=0)
Jun  9 19:30:55 localhost kernel: Ioctl returned  0x0
Jun  9 19:30:55 localhost kernel: IOCTL Releasing command

 
> Where did we get this NEEDS_RETRY in the first place?
> Well, scsi_check_sense() will return NEEDS_RETRY for MEDIUM_ERROR.
> (Bad: the hardware also did retry many times already; it is usually very
> counterproductive to keep on hitting the same bad spot on the media.)
>

I do not dare to touch it. Whoever wrote the code must have some reasons
behind. Still, the obvious patch the shuts at least this code path
follows. 

-andrej

> There are also other code paths that will loop, but this one
> looks most likely here.
> 
> Andries
> 

--- linux-2.4.18-18mdk/drivers/scsi/scsi_error.c.scsi-eh-timeout	Thu May 30 16:22:37 2002
+++ linux-2.4.18-18mdk/drivers/scsi/scsi_error.c	Sun Jun  9 19:18:11 2002
@@ -1100,6 +1100,8 @@
  */
 STATIC int scsi_eh_completed_normally(Scsi_Cmnd * SCpnt)
 {
+	int rtn;
+
 	/*
 	 * First check the host byte, to see if there is anything in there
 	 * that would indicate what we need to do.
@@ -1113,14 +1115,18 @@
 			 * otherwise we just flag it as success.
 			 */
 			SCpnt->flags &= ~IS_RESETTING;
-			return NEEDS_RETRY;
+			goto maybe_retry;
 		}
 		/*
 		 * Rats.  We are already in the error handler, so we now get to try
 		 * and figure out what to do next.  If the sense is valid, we have
 		 * a pretty good idea of what to do.  If not, we mark it as failed.
 		 */
-		return scsi_check_sense(SCpnt);
+		rtn = scsi_check_sense(SCpnt);
+		if (rtn == NEEDS_RETRY) {
+			goto maybe_retry;
+		}
+		return rtn;
 	}
 	if (host_byte(SCpnt->result) != DID_OK) {
 		return FAILED;
@@ -1139,7 +1145,11 @@
 	case COMMAND_TERMINATED:
 		return SUCCESS;
 	case CHECK_CONDITION:
-		return scsi_check_sense(SCpnt);
+		rtn = scsi_check_sense(SCpnt);
+		if (rtn == NEEDS_RETRY) {
+			goto maybe_retry;
+		}
+		return rtn;
 	case CONDITION_GOOD:
 	case INTERMEDIATE_GOOD:
 	case INTERMEDIATE_C_GOOD:
@@ -1154,6 +1164,17 @@
 		return FAILED;
 	}
 	return FAILED;
+
+      maybe_retry:
+
+	if ((++SCpnt->retries) < SCpnt->allowed) {
+		return NEEDS_RETRY;
+	} else {
+                /*
+                 * No more retries - report this one back to upper level.
+                 */
+		return SUCCESS;
+	}
 }
 
 /*
