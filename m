Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132850AbRDDPsl>; Wed, 4 Apr 2001 11:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132846AbRDDPse>; Wed, 4 Apr 2001 11:48:34 -0400
Received: from betty.magenta-netlogic.com ([193.37.229.181]:47624 "EHLO
	betty.magenta-netlogic.com") by vger.kernel.org with ESMTP
	id <S132844AbRDDPsE>; Wed, 4 Apr 2001 11:48:04 -0400
Message-ID: <3ACB4204.9080108@magenta-netlogic.com>
Date: Wed, 04 Apr 2001 16:47:16 +0100
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Resend - [PATCH] Fix SMP lockup in usbdevfs
Content-Type: multipart/mixed;
 boundary="------------040503050004010208050608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040503050004010208050608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This one didn't quite make 2.4.3, this time I've CC'd to AC.

I've been using this fix for a few days now & it's cleared up a lot of 
problems - although I'm not 100% sure why it worked (the memset should 
do the same job as the spin_lock_init surely?).

Tony

-------- Original Message --------
Subject: [PATCH] Fix SMP lockup in usbdevfs
Date: Fri, 30 Mar 2001 02:36:47 +0100
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
To: linux-kernel@vger.kernel.org
CC: linux-usb-devel@lists.sourceforge.net

This fixes a lockup when calling the USBDEVFS_SUBMITURB ioctl in an SMP
kernel.

Tony

-- 
Don't click on this sig - a cyberwoozle will eat your underwear.

tmh@magenta-netlogic.com        http://www.nothing-on.tv


--------------040503050004010208050608
Content-Type: text/plain;
 name="devio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="devio.patch"

--- devio.c.old	Fri Mar 30 02:22:32 2001
+++ devio.c	Fri Mar 30 02:12:09 2001
@@ -175,6 +175,7 @@
                 return NULL;
         memset(as, 0, assize);
         as->urb.number_of_packets = numisoframes;
+        spin_lock_init(&as->urb.lock);
         return as;
 }
 
@@ -250,7 +251,7 @@
         struct dev_state *ps = as->ps;
 	struct siginfo sinfo;
 
-#if 1
+#if 0
 	printk(KERN_DEBUG "usbdevfs: async_completed: status %d errcount %d actlen %d pipe 0x%x\n", 
 	       urb->status, urb->error_count, urb->actual_length, urb->pipe);
 #endif


--------------040503050004010208050608--

