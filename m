Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUHQLLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUHQLLv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268181AbUHQLLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:11:51 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:32130 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265051AbUHQLLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:11:23 -0400
From: Andreas Messer <andreas.messer@gmx.de>
Reply-To: andreas.messer@gmx.de
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Date: Tue, 17 Aug 2004 13:11:06 +0200
User-Agent: KMail/1.6.2
References: <411FD919.9030702@comcast.net> <20040816231211.76360eaa.Ballarin.Marc@gmx.de> <4121A689.8030708@bio.ifi.lmu.de>
In-Reply-To: <4121A689.8030708@bio.ifi.lmu.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408171311.06222.satura@proton>
X-ID: Sy66tuZpQeu5AfBYuzm7RwUzvi8rZdIGkmvxUqq4SXSJHRPfl3fXE3@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Steiner wrote:

> So what's the target in this process? Should users finally be able to
> write cds again without or only with suid bit set? It would be good to
> know if I should try to set all cd writing applications suid or just
> have to wait for some patches coming up that would allow users to
> write cds without suid again...

I have now reviewed my changes to allow users-cdrecording using 
the mmc4-spec 
  http://www.t10.org/ftp/t10/drafts/mmc4/mmc4r03a.pdf
Someone should check, if i set the permissions the right way. I have not used 
the infomation Marc Ballarin, as i think the spec is more recent than the 
programms. Perhaps there have some commands for old recorders to be added, 
but i'm not sure if so much people use such old recorders.
My changes also include some things for reading and playing cds. The rest of 
the commands mentioned in the mmc4-spec is already defined in the basic 
commands.

>
> If the programs must be set suid, is that safe? In the past I was
> always told that setting e.g. cdrecord suid was a possible security issue.
> But I really don't understand enough of the new security model in the
> kernel to judge if that's right or wrong...

I don't think setting an application suid is the right way. If the rules are 
changed the right way, rights for accessing devices may be set up clearer - 
eg one usergroup may use the recorder for recording and another not. If 
setting cdrecord siud root, this won't work.

>
> Can someone enlighten me? :-)
>
> cu,
> Frank

Here are my suggested changes:

-- linux-2.6.8.1/drivers/block/scsi_ioctl.c	2004-08-16 21:44:53.000000000 
+0200
+++ linux/drivers/block/scsi_ioctl.c	2004-08-17 13:04:04.000000000 +0200
@@ -156,6 +156,53 @@
 		safe_for_write(WRITE_16),
 		safe_for_write(WRITE_BUFFER),
 		safe_for_write(WRITE_LONG),
+
+
+		/* Some additional defs for recording/reading CDs */
+
+		/* 0x01 REZERO_UNIT used by k3b, but also work without */
+               
+		/* read-mode */
+		safe_for_read(GPCMD_GET_CONFIGURATION),
+		safe_for_read(GPCMD_GET_EVENT_STATUS_NOTIFICATION),
+		safe_for_read(GPCMD_GET_PERFORMANCE),
+		safe_for_read(GPCMD_MECHANISM_STATUS),
+
+		/* should this allowed for read ? */
+		safe_for_read(GPCMD_LOAD_UNLOAD),
+		safe_for_read(GPCMD_SET_SPEED),
+		safe_for_read(GPCMD_PAUSE_RESUME),   /* playing audio cd */
+		safe_for_read(SEEK_10),              /* playing audio cd */
+		safe_for_read(GPCMD_SET_READ_AHEAD),
+		safe_for_read(GPCMD_SET_STREAMING),
+		safe_for_read(GPCMD_STOP_PLAY_SCAN), /* playing audio cd */
+
+		/* k3b wont work without read - maybe bug in k3b, but 
+		   MODE_SELECT_10 seems not to be destructive */
+		safe_for_read(GPCMD_MODE_SELECT_10), 
+
+		/* write-mode */
+		safe_for_write(GPCMD_BLANK), 
+		safe_for_write(GPCMD_CLOSE_TRACK),
+		safe_for_write(0x2c),        /* ERASE_10 */ 
+		safe_for_write(GPCMD_FORMAT_UNIT),
+		safe_for_write(GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL),
+		safe_for_write(0x5c),        /* READ_BUFFER_CAPACITY */
+		safe_for_write(GPCMD_READ_FORMAT_CAPACITIES),
+		safe_for_write(GPCMD_REPAIR_RZONE_TRACK),
+		safe_for_write(GPCMD_RESERVE_RZONE_TRACK),
+		safe_for_write(0x5d),        /* SEND_CUE_SHEET */
+		safe_for_write(0xbf),        /* SEND_DVD_STRUCTURE */
+		safe_for_write(GPCMD_SEND_KEY),
+		safe_for_write(GPCMD_SEND_OPC),
+		safe_for_write(SYNCHRONIZE_CACHE),
+		safe_for_write(VERIFY),
+
+		/* Disabled, may change firmware 
+		   safe_for_write(0x3b),  WRITE_BUFFER */
+		/* Disabled due useless without WRITE_BUFFER 
+		   safe_for_write(0x3c),  READ_BUFFER */
+
 	};
 	unsigned char type = cmd_type[cmd[0]];
 
@@ -173,6 +220,14 @@
 	if (capable(CAP_SYS_RAWIO))
 		return 0;
 
+        /* Added for debugging*/
+       
+	if(file->f_mode & FMODE_WRITE)
+	  printk(KERN_WARNING "SCSI-CMD Filter: 0x%x not allowed with 
write-mode\n",cmd[0]);
+	else
+	  printk(KERN_WARNING "SCSI-CMD Filter: 0x%x not allowed with 
read-mode\n",cmd[0]);
+
+
 	/* Otherwise fail it with an "Operation not permitted" */
 	return -EPERM;
 }


regards
Andreas
-- 
gnuPG keyid: 0xE94F63B7 fingerprint: D189 D5E3 FF4B 7E24 E49D 7638 07C5 924C 
E94F 63B7
