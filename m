Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWA2WTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWA2WTz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 17:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWA2WTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 17:19:54 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:13015 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751197AbWA2WTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 17:19:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZN/R1XNwP6YF2dSlwW5hdnh/1qbRpcIf3opN6m58ii4SV9TqYDJZvCcik5EUWGdGhGpop4VHewul5rRAj4XRp+K3KLBElgtsXnWpZPgF5O3UYEMYsPArYTXLW50Hn37PcwcJkH9MIxQs6w1FmqXeNBNdC2Ry/7yX/Qlx/koSNIo=
Message-ID: <43DD3F77.5090306@gmail.com>
Date: Mon, 30 Jan 2006 06:19:35 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       linux-kernel@hansmi.ch
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: Fix usage of blank value passed
 to fb_blank
References: <20060127231314.GA28324@hansmi.ch> <20060127.204645.96477793.davem@davemloft.net> <43DB0839.6010703@gmail.com> <200601282106.21664.ioe-lkml@rameria.de> <43DC25EB.1040005@gmail.com> <20060129144228.GA22425@sci.fi>
In-Reply-To: <20060129144228.GA22425@sci.fi>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Syrjälä wrote:
> On Sun, Jan 29, 2006 at 10:18:19AM +0800, Antonino A. Daplas wrote:
>> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
>> index d2dede6..5bed0fb 100644
>> --- a/drivers/video/fbmem.c
>> +++ b/drivers/video/fbmem.c
>> @@ -843,6 +843,19 @@ fb_blank(struct fb_info *info, int blank
>>  {	
>>   	int ret = -EINVAL;
>>  
>> +	/*
>> +	 * The framebuffer core supports 5 blanking levels (FB_BLANK), whereas
>> +	 * VESA defined only 4.  The extra level, FB_BLANK_NORMAL, is a
>> +	 * console invention and is not related to power management.
>> +	 * Unfortunately, fb_blank callers, especially X, pass VESA constants
>> +	 * leading to undefined behavior.
> 
> Since when? X.Org uses numbers 0,2,3,4 which match the FB_BLANK 
> constants not the VESA constants.
> 

Hmm, you're correct... But I do remember that particular error before,
about FBIOBLANK returning -EINVAL. I think it may be coming from 
this particular code


Bool
fbdevHWSaveScreen(ScreenPtr pScreen, int mode)
{
	ScrnInfoPtr pScrn = xf86Screens[pScreen->myNum];
	fbdevHWPtr fPtr = FBDEVHWPTR(pScrn);
	unsigned long unblank;

	TRACE_ENTER("HWSaveScreen");
	if (!pScrn->vtSema)
		return TRUE;

	unblank = xf86IsUnblank(mode);

	if (-1 == ioctl(fPtr->fd, FBIOBLANK, (void *)(1-unblank))) {
		xf86DrvMsg(pScrn->scrnIndex, X_ERROR,
			   "FBIOBLANK: %s\n", strerror(errno));
		return FALSE;
	}

	return TRUE;
}

The FBIOBLANK ioctl call passes only 2 possible values, 0 and 1
(1-unblank).

Andrew, 

I think you should drop this patch, Xorg/XFree86's fbdevhw DPMS support
does the correct thing. It's only the above that may be producing the
particular error as reported by David. I'm not sure how to fix that
(kernel or X side).


Tony
