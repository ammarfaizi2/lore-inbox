Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUAHB41 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbUAHB41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:56:27 -0500
Received: from av1.mm.cineca.it ([130.186.10.238]:5291 "EHLO av1.mm.cineca.it")
	by vger.kernel.org with ESMTP id S263088AbUAHB4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:56:23 -0500
Date: Thu, 8 Jan 2004 03:10:40 +0100
From: Luca Risolia <luca_ing@libero.it>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23: user/kernel pointer bugs (vicam.c, w9968cf.c)
Message-ID: <20040108021040.GC6239@posta.studio.unibo.it>
References: <1073512053.20237.89.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073512053.20237.89.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your help.

On Wed, Jan 07, 2004 at 01:47:32PM -0800, Robert T. Johnson wrote:
> I think there are exploitable user/kernel pointer bugs in vicam.c and
> w9968cf.c.  The bugs are very simple, so I think the patches speak for
> themselves.  Thanks for looking at this, and my apologies if I've made
> any mistakes.  Let me know if you have any questions.
> 
> Best,
> Rob
> 
> P.S. Both of these bugs were found using the source code verification
> tool, CQual, developed by Jeff Foster, myself, and others, and available
> from http://www.cs.umd.edu/~jfoster/cqual/.
> 
> --- drivers/usb/w9968cf.c.orig	Wed Jan  7 13:32:28 2004
> +++ drivers/usb/w9968cf.c	Wed Jan  7 13:44:44 2004
> @@ -3552,10 +3552,13 @@
>  
>  	case VIDIOCSYNC: /* wait until the capture of a frame is finished */
>  	{
> -		unsigned int f_num = *((unsigned int *) arg);
> +		unsigned int f_num;
>  		struct w9968cf_frame_t* fr;
>  		int err = 0;
>  
> +		if (copy_from_user(&f_num, arg, sizeof(f_num)))
> +			return -EFAULT;
> +
>  		if (f_num >= cam->nbuffers) {
>  			DBG(4, "Invalid frame number (%d). "
>  			       "VIDIOCMCAPTURE failed.", f_num)
> @@ -3620,7 +3623,8 @@
>  	{
>  		struct video_buffer* buffer = (struct video_buffer*)arg;
>  
> -		memset(buffer, 0, sizeof(struct video_buffer));
> +		if (clear_user(buffer, sizeof(struct video_buffer)))
> +			return -EFAULT;
>  
>  		DBG(5, "VIDIOCGFBUF successfully called.")
>  		return 0;
> 
