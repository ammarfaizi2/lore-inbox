Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWBOTIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWBOTIA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 14:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWBOTIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 14:08:00 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:9647 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751262AbWBOTH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 14:07:59 -0500
Subject: [PATCH] 2.6.16-rc3-mm1 - restore zeroing of packet_command struct
	in sr_ioctl.c
From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Reply-To: lee.schermerhorn@hp.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: LOSL, Nashua
Date: Wed, 15 Feb 2006 14:07:37 -0500
Message-Id: <1140030457.6619.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 'git-scsi-misc' patch removed 2 calls to memset() to zero out
a struct packet_command before passing it to sr_do_ioctl().  This
causes sr_do_ioctl() to use the uninitialized 'sense' member as a
pointer, instead of allocating a new request_sense struct.  On my
system, this results in an Oops that kills off hald and others.

This patch restores the 2 memset calls.

Signed-off-by:  Lee Schermerhorn <lee.schermerhorn@hp.com>

Index: linux-2.6.16-rc3-mm1/drivers/scsi/sr_ioctl.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/drivers/scsi/sr_ioctl.c	2006-02-15 13:06:08.000000000 -0500
+++ linux-2.6.16-rc3-mm1/drivers/scsi/sr_ioctl.c	2006-02-15 13:08:56.000000000 -0500
@@ -48,6 +48,7 @@ static int sr_read_tochdr(struct cdrom_d
 	if (!buffer)
 		return -ENOMEM;
 
+	memset(&cgc, 0, sizeof(struct packet_command));
 	cgc.timeout = IOCTL_TIMEOUT;
 	cgc.cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
 	cgc.cmd[8] = 12;		/* LSB of length */
@@ -77,6 +78,7 @@ static int sr_read_tocentry(struct cdrom
 	if (!buffer)
 		return -ENOMEM;
 
+	memset(&cgc, 0, sizeof(struct packet_command));
 	cgc.timeout = IOCTL_TIMEOUT;
 	cgc.cmd[0] = GPCMD_READ_TOC_PMA_ATIP;
 	cgc.cmd[1] |= (tocentry->cdte_format == CDROM_MSF) ? 0x02 : 0;


