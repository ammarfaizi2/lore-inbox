Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUBOVxi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 16:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbUBOVxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 16:53:35 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.120]:63392 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S265212AbUBOVxc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 16:53:32 -0500
Message-ID: <402FEAD4.8020602@myrealbox.com>
Date: Sun, 15 Feb 2004 13:55:32 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BUG] usblp_write spins forever after an error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently cancelled a print job with the printer's cancel function, and the 
CUPS backend got stuck in usblp_write (using 100% CPU and not responding to 
signals).

The printer is a Kyocera Mita FS-1900 (which has some other problems with the 
linux USB code: usblp_check_status often times out, even though the printer is 
bidirectional -- but that's a whole different issue).

It looks like the problem is that the write failed, so wcomplete got set
to 1 and the status is nonzero.  This case appears to be mishandled in usblp.c:

         while (writecount < count) {
                 if (!usblp->wcomplete) {
			[... not reaching this code]
                 }

                 down (&usblp->sem);
                 if (!usblp->present) {
                         up (&usblp->sem);
                         return -ENODEV;
                 }
                 if (usblp->writeurb->status != 0) {

			[ check status? ]

                         schedule ();
                         continue; <-- problem
                 }

After the write fails, the current code keeps checking the same status, and 
never checks for signals or fails.  I'm not sure what the right fix is, but it 
might be something like this:

--- ./usblp.c.orig      2004-02-15 06:27:29.176169752 -0800
+++ ./usblp.c   2004-02-15 06:29:40.137260640 -0800
@@ -645,13 +645,11 @@
                                 err = usblp->writeurb->status;
                         } else
                                 err = usblp_check_status(usblp, err);
-                       up (&usblp->sem);

-                       /* if the fault was due to disconnect, let khubd's
-                        * call to usblp_disconnect() grab usblp->sem ...
-                        */
-                       schedule ();
-                       continue;
+                       writecount += usblp->writeurb->transfer_buffer_length;
+                       up (&usblp->sem);
+                       count = writecount ? writecount : err;
+                       break;
                 }

                 writecount += usblp->writeurb->transfer_buffer_length;


--Andy

Please CC me -- I'm not subscribed.
