Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265596AbUBPPQa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265598AbUBPPQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:16:30 -0500
Received: from [195.23.16.24] ([195.23.16.24]:39884 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S265596AbUBPPQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:16:27 -0500
Message-ID: <4030DEC5.2060609@grupopie.com>
Date: Mon, 16 Feb 2004 15:16:21 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andy Lutomirski <luto@myrealbox.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BUG] usblp_write spins forever after an error
References: <402FEAD4.8020602@myrealbox.com> <20040216035834.GA4089@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------040401040602040403060102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040401040602040403060102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

> On Sun, Feb 15, 2004 at 01:55:32PM -0800, Andy Lutomirski wrote:
> 
>>I recently cancelled a print job with the printer's cancel function, and 
>>the CUPS backend got stuck in usblp_write (using 100% CPU and not 
>>responding to signals).
>>

I wrote a patch some time ago to correct a bug exactly at usblp_write. It is 
still not in the main kernel, but you can give it a try and see if it helps. It 
applies cleanly against 2.6.2-rc2, but I guess it should apply to 2.6.2-rc3.

This patch corrected a problem for me, that happened when a printer presents an 
out-of-paper status while printing a document. The driver would send endless 
garbage to the printer.

I hope this helps,

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

--------------040401040602040403060102
Content-Type: text/plain;
 name="usblp_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usblp_patch"

--- drivers/usb/class/usblp.c.orig	2004-02-09 14:46:27.000000000 +0000
+++ drivers/usb/class/usblp.c	2004-02-09 15:03:32.281551096 +0000
@@ -603,7 +603,7 @@ static ssize_t usblp_write(struct file *
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct usblp *usblp = file->private_data;
-	int timeout, err = 0;
+	int timeout, err = 0, transfer_length;
 	size_t writecount = 0;
 
 	while (writecount < count) {
@@ -654,19 +654,13 @@ static ssize_t usblp_write(struct file *
 			continue;
 		}
 
-		writecount += usblp->writeurb->transfer_buffer_length;
-		usblp->writeurb->transfer_buffer_length = 0;
+		transfer_length=(count - writecount);
+		if (transfer_length > USBLP_BUF_SIZE)
+			transfer_length = USBLP_BUF_SIZE;
 
-		if (writecount == count) {
-			up (&usblp->sem);
-			break;
-		}
+		usblp->writeurb->transfer_buffer_length = transfer_length;
 
-		usblp->writeurb->transfer_buffer_length = (count - writecount) < USBLP_BUF_SIZE ?
-							  (count - writecount) : USBLP_BUF_SIZE;
-
-		if (copy_from_user(usblp->writeurb->transfer_buffer, buffer + writecount,
-				usblp->writeurb->transfer_buffer_length)) {
+		if (copy_from_user(usblp->writeurb->transfer_buffer, buffer + writecount, transfer_length)) {
 			up(&usblp->sem);
 			return writecount ? writecount : -EFAULT;
 		}
@@ -683,6 +677,8 @@ static ssize_t usblp_write(struct file *
 			break;
 		}
 		up (&usblp->sem);
+
+		writecount += transfer_length;
 	}
 
 	return count;

--------------040401040602040403060102--

