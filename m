Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263670AbUEEIEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263670AbUEEIEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 04:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUEEIEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 04:04:38 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:39623 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263670AbUEEIEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 04:04:32 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 5 May 2004 09:50:17 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel List <linux-kernel@vger.kernel.org>, degerrit@web.de
Subject: [patch] Re: V4L bug report - oops: video_register_device (ksymoops, objdump)
Message-ID: <20040505075017.GA2375@bytesex.org>
References: <40983350.4020403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40983350.4020403@web.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 02:20:32AM +0200, degerrit@web.de wrote:
> I caused an oops in unusual circumstances by accidentally "forcing" a
> video device number which was too high or already taken (don't know
> which). I assume this probably shouldn't give an oops (though it was my
> fault), so here's a bugreport...

Fixed by adding a range check for the number passed in by the driver.
The fix applies to 2.4 kernels as well.

  Gerd

--- linux-2.6.6-rc2/drivers/media/video/videodev.c~	2004-04-21 15:05:10.000000000 +0200
+++ linux-2.6.6-rc2/drivers/media/video/videodev.c	2004-05-05 09:38:20.032625621 +0200
@@ -316,7 +316,14 @@
 
 	/* pick a minor number */
 	down(&videodev_lock);
-	if (-1 == nr) {
+	if (nr >= 0  &&  nr < end-base) {
+		/* use the one the driver asked for */
+		i = base+nr;
+		if (NULL != video_device[i]) {
+			up(&videodev_lock);
+			return -ENFILE;
+		}
+	} else {
 		/* use first free */
 		for(i=base;i<end;i++)
 			if (NULL == video_device[i])
@@ -325,13 +332,6 @@
 			up(&videodev_lock);
 			return -ENFILE;
 		}
-	} else {
-		/* use the one the driver asked for */
-		i = base+nr;
-		if (NULL != video_device[i]) {
-			up(&videodev_lock);
-			return -ENFILE;
-		}
 	}
 	video_device[i]=vfd;
 	vfd->minor=i;
