Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUBTGfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 01:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267786AbUBTGfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 01:35:34 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.14.91]:13452 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S267785AbUBTGfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 01:35:21 -0500
Message-ID: <4035AA75.1060109@hotmail.com>
Date: Thu, 19 Feb 2004 22:34:29 -0800
From: Andy Lutomirski <amluto@hotmail.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB update for 2.6.3
References: <fa.d7mjamc.1l40pri@ifi.uio.no>
In-Reply-To: <fa.d7mjamc.1l40pri@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> 
> Paulo Marques:
>   o USB: fix usblp.c
> 

Unless I'm missing something, this won't fix the usblp_write spinning bug I hit. 
  If it helps, I can try to reproduce it with some debugging code attached.

BTW, I'm posting from a different address, because luto@myrealbox.com seems 
unable to post to lists.sourceforge.net.  Please CC me in replies at 
luto@myrealbox.com.

--Andy

---- Original message copied for linux-usb-devel readers ----

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


