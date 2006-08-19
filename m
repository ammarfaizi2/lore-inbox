Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWHSTTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWHSTTx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 15:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWHSTTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 15:19:53 -0400
Received: from mail.gmx.de ([213.165.64.20]:48011 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751303AbWHSTTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 15:19:52 -0400
X-Authenticated: #704063
Subject: [Patch] Signdness issue in drivers/scsi/osst.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: osst@riede.org
Content-Type: text/plain
Date: Sat, 19 Aug 2006 21:19:48 +0200
Message-Id: <1156015188.19657.7.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

another signdness warning from gcc 4.1

drivers/scsi/osst.c:5154: warning: comparison of unsigned expression < 0 is always false

The problem is that blk is defined as unsigned, but all usages of it
are normal int cases. osst_get_frame_position() and osst_get_sector()
return ints and can return negative values. If blk stays an unsigned int,
the error check is useless.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-rc4/drivers/scsi/osst.c.orig	2006-08-19 21:16:48.000000000 +0200
+++ linux-2.6.18-rc4/drivers/scsi/osst.c	2006-08-19 21:16:56.000000000 +0200
@@ -4843,8 +4843,7 @@ static int os_scsi_tape_close(struct ino
 static int osst_ioctl(struct inode * inode,struct file * file,
 	 unsigned int cmd_in, unsigned long arg)
 {
-	int		      i, cmd_nr, cmd_type, retval = 0;
-	unsigned int	      blk;
+	int		      i, cmd_nr, cmd_type, blk, retval = 0;
 	struct st_modedef   * STm;
 	struct st_partstat  * STps;
 	struct osst_request * SRpnt = NULL;


