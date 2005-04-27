Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVD0RRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVD0RRd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVD0RRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:17:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:14022 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261809AbVD0RRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:17:23 -0400
Date: Wed, 27 Apr 2005 10:16:49 -0700
From: Greg KH <gregkh@suse.de>
To: James.Bottomley@SteelEye.com, Kai.Makisara@kolumbus.fi,
       linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [06/07] [PATCH] SCSI tape security: require CAP_ADMIN for SG_IO etc.
Message-ID: <20050427171649.GG3195@kroah.com>
References: <20050427171446.GA3195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427171446.GA3195@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------

The kernel currently allows any user permitted to access the tape device file
to send the tape drive commands that may either make the tape drivers internal
state inconsistent or to change the drive parameters so that other users find
the drive to be unusable. This patch changes ioctl handling so that SG_IO,
SCSI_IOCTL_COMMAND, etc. require CAP_ADMIN. This solves the consistency
problems for SCSI tapes. The st driver provides user-accessible commands to
change the drive parameters that users may need to access.

The SCSI command permissions were discussed widely on the linux lists but this
did not result in any useful refinement of the permissions. It may very well
be that the tape drives are the only devices that users are sometimes given
permissions to access and that have security problems with the current command
filtering. This patch solves the problem for tapes and no more elaborate
patches are needed.

Signed-off-by: Kai Makisara <kai.makisara@kolumbus.fi>
Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


diff -Naru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	2005-04-27 09:50:24 -07:00
+++ b/drivers/scsi/st.c	2005-04-27 09:50:24 -07:00
@@ -3461,11 +3461,17 @@
 		case SCSI_IOCTL_GET_BUS_NUMBER:
 			break;
 		default:
-			i = scsi_cmd_ioctl(file, STp->disk, cmd_in, p);
+			if (!capable(CAP_SYS_ADMIN))
+				i = -EPERM;
+			else
+				i = scsi_cmd_ioctl(file, STp->disk, cmd_in, p);
 			if (i != -ENOTTY)
 				return i;
 			break;
 	}
+	if (!capable(CAP_SYS_ADMIN) &&
+	    (cmd_in == SCSI_IOCTL_START_UNIT || cmd_in == SCSI_IOCTL_STOP_UNIT))
+		return -EPERM;
 	return scsi_ioctl(STp->device, cmd_in, p);
 
  out:
