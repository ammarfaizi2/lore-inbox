Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTFJJ55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 05:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTFJJ47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 05:56:59 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:39648 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261624AbTFJJ4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 05:56:39 -0400
Date: Tue, 10 Jun 2003 15:43:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misc 2.5 Fixes: cp-user-mdc800
Message-ID: <20030610101318.GH2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100527.GA2194@in.ibm.com> <20030610100643.GB2194@in.ibm.com> <20030610100746.GC2194@in.ibm.com> <20030610100905.GD2194@in.ibm.com> <20030610100950.GE2194@in.ibm.com> <20030610101035.GF2194@in.ibm.com> <20030610101121.GG2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610101121.GG2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use copy_to_user/get_char with user buffers.


 drivers/usb/image/mdc800.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff -puN drivers/usb/image/mdc800.c~cp-user-mdc800 drivers/usb/image/mdc800.c
--- linux-2.5.70-ds/drivers/usb/image/mdc800.c~cp-user-mdc800	2003-06-08 03:13:41.000000000 +0530
+++ linux-2.5.70-ds-dipankar/drivers/usb/image/mdc800.c	2003-06-08 03:21:18.000000000 +0530
@@ -748,8 +748,10 @@ static ssize_t mdc800_device_read (struc
 		}
 		else
 		{
-			/* memcpy Bytes */
-			memcpy (ptr, &mdc800->out [mdc800->out_ptr], sts);
+			/* Copy Bytes */
+			if (copy_to_user(ptr, 
+				&mdc800->out [mdc800->out_ptr], sts))
+				return -EFAULT;
 			ptr+=sts;
 			left-=sts;
 			mdc800->out_ptr+=sts;
@@ -786,14 +788,21 @@ static ssize_t mdc800_device_write (stru
 
 	while (i<len)
 	{
+		unsigned char c;
 		if (signal_pending (current)) 
 		{
 			up (&mdc800->io_lock);
 			return -EINTR;
 		}
+		
+		if(get_user(c, buf+i))
+		{
+			up(&mdc800->io_lock);
+			return -EFAULT;
+		}
 
 		/* check for command start */
-		if (buf [i] == (char) 0x55)
+		if (c == 0x55)
 		{
 			mdc800->in_count=0;
 			mdc800->out_count=0;
@@ -804,12 +813,11 @@ static ssize_t mdc800_device_write (stru
 		/* save command byte */
 		if (mdc800->in_count < 8)
 		{
-			mdc800->in[mdc800->in_count]=buf[i];
+			mdc800->in[mdc800->in_count] = c;
 			mdc800->in_count++;
 		}
 		else
 		{
-			err ("Command is too long !\n");
 			up (&mdc800->io_lock);
 			return -EIO;
 		}
@@ -884,8 +892,8 @@ static ssize_t mdc800_device_write (stru
 							return -EIO;
 						}
 
-						/* Write dummy data, (this is ugly but part of the USB Protokoll */
-						/* if you use endpoint 1 as bulk and not as irq */
+						/* Write dummy data, (this is ugly but part of the USB Protocol */
+						/* if you use endpoint 1 as bulk and not as irq) */
 						memcpy (mdc800->out, mdc800->camera_response,8);
 
 						/* This is the interpreted answer */

_
