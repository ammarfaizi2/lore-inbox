Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTFFNOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 09:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTFFNOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 09:14:44 -0400
Received: from mail0.lsil.com ([147.145.40.20]:8958 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261428AbTFFNOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 09:14:40 -0400
Message-Id: <0E3FA95632D6D047BA649F95DAB60E570185F234@EXA-ATLANTA.se.lsil.com>
From: "Mukker, Atul" <atulm@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       Mark Haverkamp <markh@osdl.org>
Cc: "Mukker, Atul" <Atulm@lsil.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH] megaraid driver fix for 2.5.70
Date: Fri, 6 Jun 2003 09:28:04 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In the memset cases, what fixed the panic was that the size of the
> > raw_mbox automatic was set to 16 and the memset was using
> > sizeof(mbox_t).  I just increased the size of the raw_mbox so it
> > wouldn't be overflowed.  It sounds like, from what you are 
> saying, that
> > the size of raw_mbox should have been left at 16 and the 
> memset changed
> > to fill 16 bytes and not the sizeof(mbox_t).
> 
> Ah, that's what I couldn't find in the source, thanks.

This is correct. Driver sets up first 16 bytes and firmware sets up rest.
Busy bit is special, driver sets it and firmware clears it.


> I was also separately worried about the memcpy in the issue_scb..()
> routines which looks like it will set the mbox->busy parameter
> (controlled by the driver) to zero.  So I copied Atul to see 
> if this is
> a genuine problem or not.

This is ok. Driver has to set it to busy anyway.

Coming back to main issue, declaring complete mailbox would be superfluous
since driver uses 16 bytes at most. The following patch should fix the panic

--- /usr/src/linux-2.5.70/drivers/scsi/megaraid.c	2003-05-26
21:00:20.000000000 -0400
+++ megaraid.c	2003-06-06 09:14:24.000000000 -0400
@@ -4664,7 +4664,7 @@
 
 	mbox = (mbox_t *)raw_mbox;
 
-	memset(mbox, 0, sizeof(*mbox));
+	memset(mbox, 0, 16);
 
 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
 
@@ -4697,7 +4697,7 @@
 
 	mbox = (mbox_t *)raw_mbox;
 
-	memset(mbox, 0, sizeof(*mbox));
+	memset(mbox, 0, 16);
 
 	/*
 	 * issue command to find out what channels are raid/scsi
@@ -4813,12 +4813,9 @@
 mega_support_random_del(adapter_t *adapter)
 {
 	unsigned char raw_mbox[16];
-	mbox_t *mbox;
 	int rval;
 
-	mbox = (mbox_t *)raw_mbox;
-
-	memset(mbox, 0, sizeof(*mbox));
+	memset(raw_mbox, 0, 16);
 
 	/*
 	 * issue command
@@ -4842,12 +4839,9 @@
 mega_support_ext_cdb(adapter_t *adapter)
 {
 	unsigned char raw_mbox[16];
-	mbox_t *mbox;
 	int rval;
 
-	mbox = (mbox_t *)raw_mbox;
-
-	memset(mbox, 0, sizeof(*mbox));
+	memset(raw_mbox, 0, 16);
 	/*
 	 * issue command to find out if controller supports extended CDBs.
 	 */

