Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264990AbTFLUbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264992AbTFLUbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:31:20 -0400
Received: from mbox2.netikka.net ([213.250.81.203]:61342 "EHLO
	mbox2.netikka.net") by vger.kernel.org with ESMTP id S264990AbTFLUaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:30:11 -0400
From: Thomas Backlund <tmb@iki.fi>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 2.4.21-rc8 vesafb memory remapping...
Date: Thu, 12 Jun 2003 23:43:49 +0300
User-Agent: KMail/1.5.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306122343.49563.tmb@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the vesafb still remaps memory according to a calculation 
done in bits, even if should be done in bytes...
This will remap more memory than old cards actually have...

An example:
My laptop has 8192 KB of videoram
I use it with videomode 1024x768x16

With current vesafb that will translate to 12288 KB remapping

So here is my suggestion,
either grab the complete "fix" from rc7-ac1 (wich calculates in bytes),
or If you dont like that, my second suggestion is to use the
old vesafb code to take care of old cards like this:

----- cut -----
#diff -u rc8/drivers/video/vesafb.c rc8/drivers/video/vesafb.c.new
--- rc8/drivers/video/vesafb.c  2003-06-12 23:13:29.000000000 +0300
+++ rc8/drivers/video/vesafb.c.new      2003-06-12 23:18:03.000000000 +0300
@@ -521,6 +521,11 @@
        video_height        = screen_info.lfb_height;
        video_linelength    = screen_info.lfb_linelength;
        video_size          = screen_info.lfb_width *   
screen_info.lfb_height * video_bpp;
+
+       /* check that we don't remap more memory than old cards have */
+       if (video_size > screen_info.lfb_size * 65536)
+               video_size = screen_info.lfb_size * 65536;
+
        video_visual = (video_bpp == 8) ?
                FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;

----- cut -----

Like this we would keep both old and new systems happy AFAIK...


-- 
Regards

Thomas Backlund

http://www.iki.fi/tmb/
tmb@iki.fi

