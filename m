Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUJHU5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUJHU5J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUJHU5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:57:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:56710 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265044AbUJHU5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:57:05 -0400
Date: Fri, 8 Oct 2004 14:00:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux@MichaelGeng.de, linux-kernel@vger.kernel.org,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: video_usercopy() enforces change of VideoText IOCTLs since
 2.6.8
Message-Id: <20041008140056.72b177d9.akpm@osdl.org>
In-Reply-To: <20041008105219.GA24842@bytesex>
References: <20041007165410.GA2306@t-online.de>
	<20041008105219.GA24842@bytesex>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@bytesex.org> wrote:
>
> Yes, that change is wrong.  It breaks all ioctls which use arg to pass
> a integer value directly (i.e. not a pointer to a integer).
> 
> The patch below reverses it.  Please apply,
> 
>   Gerd
> 
> Index: linux-2.6.8/drivers/media/video/videodev.c
> ===================================================================
> --- linux-2.6.8.orig/drivers/media/video/videodev.c	2004-10-08 11:55:08.000000000 +0200
> +++ linux-2.6.8/drivers/media/video/videodev.c	2004-10-08 12:46:12.571630864 +0200
> @@ -183,7 +183,7 @@ video_usercopy(struct inode *inode, stru
>  	/*  Copy arguments into temp kernel buffer  */
>  	switch (_IOC_DIR(cmd)) {
>  	case _IOC_NONE:
> -		parg = NULL;
> +		parg = (void*)arg;
>  		break;

(the typecast is unneeded)

Seems that with this change we are now sometimes passing a user pointer
into (*func)().  And we're sometimes passing a kernel pointer, yes?

Are all the implementations of (*func)() handling that correctly?

It all looks fishy.
