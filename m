Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbUCESNS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 13:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbUCESNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 13:13:18 -0500
Received: from [195.23.16.24] ([195.23.16.24]:27085 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262666AbUCESNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:13:09 -0500
Message-ID: <4048C2E7.8050907@grupopie.com>
Date: Fri, 05 Mar 2004 18:11:51 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Andy Lutomirski <luto@myrealbox.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Oliver Neukum <oliver@neukum.org>
Subject: [PATCH] usblp.c (Was: usblp_write spins forever after an error)
References: <402FEAD4.8020602@myrealbox.com>	 <20040216035834.GA4089@kroah.com>  <4030DEC5.2060609@grupopie.com>	 <1078399532.4619.129.camel@hades.cambridge.redhat.com>	 <4047221E.9050500@grupopie.com> <1078479692.12176.32.camel@imladris.demon.co.uk> <40488E45.7070901@grupopie.com>
Content-Type: multipart/mixed;
 boundary="------------050402060600020103000902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050402060600020103000902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Paulo Marques wrote:

> David Woodhouse wrote:
> 
>> On Thu, 2004-03-04 at 12:33 +0000, Paulo Marques wrote:
>>
>>> Yes, unfortunately it did went into 2.6.4-rc1. However it is already 
>>> corrected in 2.6.4-rc2. Luckily it didn't went into any "non-rc" 
>>> official release.
>>>
>>> Please try 2.6.4-rc2, and check to see if the bug went away...
>>>
>>
>> Seems to work; thanks. Does this need backporting to 2.4 too?
>>
> 
> 
> Unfortunately this isn't over yet.
> 
> I got suspicious about this bug fix, because I *did* test my patch 
> before submitting it and the kernel that didn't work before, worked fine 
> with my patch.
> 
> But now it seems that it is the other way around. After a few digging I 
> found out the problem:
> 
> The application that I was testing with uses the usblp handle with 
> non-blocking I/O .
> 
> So my patch does work for non-blocking I/O uses of the port, but wrecks 
> the normal blocking mode.
> 
> I've already produced a version that works for both cases. I'll just 
> clean it up a bit and submit it to 2.4 and 2.6 kernels.


Here it is.

The patch is only one line for 2.6.4-rc2. (I also did a little formatting 
adjustment to better comply with CodingStyle)

For the 2.4.26-pre1 kernel, I also backported the return codes correction patch 
from Oliver Neukum.


The problem with the write function was that, in non-blocking mode, after 
submitting the first urb, the function would return with -EAGAIN, not reporting 
to the application that in fact it had already sent "transfer_length" bytes. 
This way the application would have to send the data *again* causing lots of 
errors.

It did return the correct amount with my first patch, because the writecount was 
being updated on the end of the loop. However this was wrong for blocking I/O.

The "transfer_length" local variable is still needed because if we used the 
transfer_buffer_length field from the urb, then on a second call to write, if 
the urb was still pending (in non-blocking mode), the write would return an 
incorrect amount of data written.

Anyway, this time I tested it using blocking and non-blocking I/O and it works 
for both cases. Even better, this patch only changes the behaviour for 
non-blocking I/O, and keeps the same behaviour for the more usual blocking I/O 
(at least on kernel 2.6).

Please apply,

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

--------------050402060600020103000902
Content-Type: text/plain;
 name="usblp_patch_26"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usblp_patch_26"

--- drivers/usb/class/usblp.c.orig	2004-03-05 17:09:00.412189056 +0000
+++ drivers/usb/class/usblp.c	2004-03-05 17:10:30.121551160 +0000
@@ -609,8 +609,10 @@ static ssize_t usblp_write(struct file *
 	while (writecount < count) {
 		if (!usblp->wcomplete) {
 			barrier();
-			if (file->f_flags & O_NONBLOCK)
+			if (file->f_flags & O_NONBLOCK) {
+				writecount += transfer_length;
 				return writecount ? writecount : -EAGAIN;
+			}
 
 			timeout = USBLP_WRITE_TIMEOUT;
 			add_wait_queue(&usblp->wait, &wait);
@@ -670,7 +672,8 @@ static ssize_t usblp_write(struct file *
 
 		usblp->writeurb->transfer_buffer_length = transfer_length;
 
-		if (copy_from_user(usblp->writeurb->transfer_buffer, buffer + writecount, transfer_length)) {
+		if (copy_from_user(usblp->writeurb->transfer_buffer, 
+				   buffer + writecount, transfer_length)) {
 			up(&usblp->sem);
 			return writecount ? writecount : -EFAULT;
 		}

--------------050402060600020103000902
Content-Type: text/plain;
 name="printer_patch_24"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="printer_patch_24"

--- drivers/usb/printer.c.orig	2004-03-05 17:29:50.238186624 +0000
+++ drivers/usb/printer.c	2004-03-05 17:35:05.346282912 +0000
@@ -604,14 +604,16 @@ static ssize_t usblp_write(struct file *
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct usblp *usblp = file->private_data;
-	int timeout, err = 0;
+	int timeout, err = 0, transfer_length = 0;
 	size_t writecount = 0;
 
 	while (writecount < count) {
 		if (!usblp->wcomplete) {
 			barrier();
-			if (file->f_flags & O_NONBLOCK)
-				return -EAGAIN;
+			if (file->f_flags & O_NONBLOCK) {
+				writecount += transfer_length;
+				return writecount ? writecount : -EAGAIN;
+			}
 
 			timeout = USBLP_WRITE_TIMEOUT;
 			add_wait_queue(&usblp->wait, &wait);
@@ -655,27 +657,36 @@ static ssize_t usblp_write(struct file *
 			continue;
 		}
 
-		writecount += usblp->writeurb->transfer_buffer_length;
-		usblp->writeurb->transfer_buffer_length = 0;
-
+		/* We must increment writecount here, and not at the
+		 * end of the loop. Otherwise, the final loop iteration may
+		 * be skipped, leading to incomplete printer output.
+		 */
+		writecount += transfer_length;
 		if (writecount == count) {
 			up (&usblp->sem);
 			break;
 		}
 
-		usblp->writeurb->transfer_buffer_length = (count - writecount) < USBLP_BUF_SIZE ?
-							  (count - writecount) : USBLP_BUF_SIZE;
+		transfer_length = count - writecount;
+		if(transfer_length > USBLP_BUF_SIZE) 
+			transfer_length = USBLP_BUF_SIZE;
+		
+		usblp->writeurb->transfer_buffer_length = transfer_length;
 
-		if (copy_from_user(usblp->writeurb->transfer_buffer, buffer + writecount,
-				usblp->writeurb->transfer_buffer_length)) {
+		if (copy_from_user(usblp->writeurb->transfer_buffer, 
+				   buffer + writecount, transfer_length)) {
 			up(&usblp->sem);
 			return writecount ? writecount : -EFAULT;
 		}
 
 		usblp->writeurb->dev = usblp->dev;
 		usblp->wcomplete = 0;
-		if (usb_submit_urb(usblp->writeurb)) {
-			count = -EIO;
+		err = usb_submit_urb(usblp->writeurb);
+		if (err) {
+			if (err != -ENOMEM)
+				count = -EIO;
+			else
+				count = writecount ? writecount : -ENOMEM;
 			up (&usblp->sem);
 			break;
 		}

--------------050402060600020103000902--

