Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265564AbUFCPOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265564AbUFCPOu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUFCPNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:13:37 -0400
Received: from snickers.hotpop.com ([38.113.3.51]:45443 "EHLO
	snickers.hotpop.com") by vger.kernel.org with ESMTP id S265543AbUFCPHY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:07:24 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: David Eger <eger@havoc.gtf.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fb accel capabilities (resend against 2.6.7-rc2)
Date: Thu, 3 Jun 2004 23:07:13 +0800
User-Agent: KMail/1.5.4
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040603023653.GA20951@havoc.gtf.org>
In-Reply-To: <20040603023653.GA20951@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406032307.13121.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 10:36, David Eger wrote:

I haven't tested the patch, but here's a few comments:

So, 

1. SCROLL_ACCEL = no panning + copyarea;
2. SCROLL_REDRAW = no panning + imageblit;
3. SCROLL_PAN/SCROLL_WRAP = pan/wrap + copyarea;

Are these correct?

Assuming the above is correct, then the logic in update_scrollmode() may not 
be optimal.

>  static __inline__ void updatescrollmode(struct display *p, struct fb_info
> *info, struct vc_data *vc) {
> -	int m;
> +	int cap = info->flags;
>
> -	if (p->scrollmode & __SCROLL_YFIXED)
> -		return;
> -	if (divides(info->fix.ywrapstep, vc->vc_font.height) &&
> -	    divides(vc->vc_font.height, info->var.yres_virtual))
> -		m = __SCROLL_YWRAP;
> -	else if (divides(info->fix.ypanstep, vc->vc_font.height) &&
> +	if ((cap & FBINFO_HWACCEL_COPYAREA) && !(cap & FBINFO_HWACCEL_DISABLED))
> +		p->scrollmode = SCROLL_ACCEL;

We should also check if the hardware is capable of panning/wrapping.  If it 
is, then the scrolling mode should be SCROLL_PAN/WRAP. An accelerated drawing 
function combined with panning/wrapping is extremely fast.

> +	else if ((cap & FBINFO_HWACCEL_YWRAP) &&
> +		 divides(info->fix.ywrapstep, vc->vc_font.height) &&
> +		 divides(vc->vc_font.height, info->var.yres_virtual))
> +		p->scrollmode = SCROLL_WRAP;
> +	else if ((cap & FBINFO_HWACCEL_YPAN) &&
> +		 divides(info->fix.ypanstep, vc->vc_font.height) &&

In the above case, we should also check if accelerated copyarea is availble or 
if fb reading is fast.  Because if fb reading is slow and accel copyarea is 
not available,  the resulting scrolling action will not be smooth. In this 
case, SCROLL_REDRAW may be a better scrolling mode even if it's slower than 
SCROLL_PAN/WRAP.

>  		 info->var.yres_virtual >= info->var.yres + vc->vc_font.height)
> -		m = __SCROLL_YPAN;
> -	else if (p->scrollmode & __SCROLL_YNOMOVE)
> -		m = __SCROLL_YREDRAW;
> +		p->scrollmode = SCROLL_PAN;
> +	else if (cap & FBINFO_READS_FAST)
> +		/* okay, we'll use software version of accel funcs... */
> +		p->scrollmode = SCROLL_ACCEL;

This is similar with the above.  If panning/wrapping is available and fb 
reading is very fast, then SCROLL_PAN/WRAP is probably preferrable than just 
SCROLL_ACCEL.

>  	else
> -		m = __SCROLL_YMOVE;
> -	p->scrollmode = (p->scrollmode & ~__SCROLL_YMASK) | m;
> +		p->scrollmode = SCROLL_REDRAW;

Ditto.

Personally, the pseudocode below might be better.

If (pan/wrap is available) {
	if (fb reading is fast || accel copyarea is available)
		SCROLL_PAN/WRAP;	
	else 
		SCROLL_REDRAW; /* since SCROLL_PAN/WRAP_REDRAW not available */
} else {
	if (fb_reading is fast || accel copyarea is available)
		SCROLL_ACCEL;
	else
		SCROLL_REDRAW;
}
 
Tony


