Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269766AbUJHLAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269766AbUJHLAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269772AbUJHLAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:00:19 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:33688 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S269766AbUJHLAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:00:13 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 8 Oct 2004 12:52:19 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Geng <linux@MichaelGeng.de>, linux-kernel@vger.kernel.org
Subject: Re: video_usercopy() enforces change of VideoText IOCTLs since 2.6.8
Message-ID: <20041008105219.GA24842@bytesex>
References: <20041007165410.GA2306@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007165410.GA2306@t-online.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 06:54:10PM +0200, Michael Geng wrote:
> from kernel 2.6.7 to 2.6.8 function video_usercopy() in 
> videodev.c was modified

> 	case _IOC_NONE:
> ===> 2.6.7:
> 		parg = (void *)arg;
> ===> 2.6.8:
> 		parg = NULL;
>         ...

Yes, that change is wrong.  It breaks all ioctls which use arg to pass
a integer value directly (i.e. not a pointer to a integer).

The patch below reverses it.  Please apply,

  Gerd

Index: linux-2.6.8/drivers/media/video/videodev.c
===================================================================
--- linux-2.6.8.orig/drivers/media/video/videodev.c	2004-10-08 11:55:08.000000000 +0200
+++ linux-2.6.8/drivers/media/video/videodev.c	2004-10-08 12:46:12.571630864 +0200
@@ -183,7 +183,7 @@ video_usercopy(struct inode *inode, stru
 	/*  Copy arguments into temp kernel buffer  */
 	switch (_IOC_DIR(cmd)) {
 	case _IOC_NONE:
-		parg = NULL;
+		parg = (void*)arg;
 		break;
 	case _IOC_READ:
 	case _IOC_WRITE:
