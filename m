Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbRBUKaW>; Wed, 21 Feb 2001 05:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129611AbRBUKaM>; Wed, 21 Feb 2001 05:30:12 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:51984 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129227AbRBUKaI>; Wed, 21 Feb 2001 05:30:08 -0500
Date: Wed, 21 Feb 2001 10:24:25 +0000
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.2.18: Remove bogus "Wrong buffer length" warnings from aha1542
Message-ID: <20010221102425.A5153@alfie.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just installed an AHA1542 SCSI card, and when performing a backup,
I'm finding the kernel is spewing out the following message:

    Wrong buffer length supplied for request sense (256)

This is because the sense_buffer is 16 bytes, but the buffer supplied
is 256 bytes.

Looking at the 2.4 version of the driver, I see that this message has
been disabled, because scsi_request_sense() provides a buffer of size 256.

The following is a version of the 2.4 patch applied to 2.2.  Please apply.

I did notice that aha1740.c also has the same bogus check on the buffer,
but I haven't provided a patch, as this is still present in 2.4, and a
patch for that should also be included.

--- linux-2.2/drivers/scsi/aha1542.c~	Wed Feb 21 10:13:02 2001
+++ linux-2.2/drivers/scsi/aha1542.c	Wed Feb 21 10:15:51 2001
@@ -560,7 +560,9 @@
       done(SCpnt); return 0;});
     
     if(*cmd == REQUEST_SENSE){
-#ifndef DEBUG
+#if 0
+      /* scsi_request_sense() provides a buffer of size 256,
+         so there is no reason to expect equality */
       if (bufflen != sizeof(SCpnt->sense_buffer)) {
 	printk("Wrong buffer length supplied for request sense (%d)\n",bufflen);
       };

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
