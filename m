Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932781AbWBUVHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbWBUVHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbWBUVHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:07:52 -0500
Received: from styx.suse.cz ([82.119.242.94]:24806 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932781AbWBUVHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:07:51 -0500
Date: Tue, 21 Feb 2006 22:08:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       stuart_hayes@dell.com
Subject: Re: Suppressing softrepeat
Message-ID: <20060221210800.GA12102@suse.cz>
References: <20060221124308.5efd4889.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221124308.5efd4889.zaitcev@redhat.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 12:43:08PM -0800, Pete Zaitcev wrote:

> Add the "nosoftrepeat" parameter. This is useful if a "dumb" keyboard
> has (unswitcheable) hardware repeat, like in Dell DRAC3.

The softrepeat code should properly ignore all autorepeated keys from a
'dumb' keyboard. It's rather common that a keyboard we can't communicate
with is in autorepeat mode, because that's the mode AT keyboards wake up
in after power on.

A much simpler workaround for the DRAC3 is to set the softrepeat delay
to at least 750ms, using kbdrate(8), which will call the proper console
ioctl, resulting in updating the softrepeat parameters.

I prefer workarounds for problematic hardware done outside the kernel,
if possible.

> Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
> 
> ---
> 
> Hi, Dmitry,
> 
> Dell people passed on a request to add a new parameter, "nosoftrepeat",
> to i8042 (in atkbd.c). So, if I understand right, things should work so:
> 
>  - None set in grub.conf: Softrepeat is set by the driver as detected
>    or derived. This is the default.
>  - "softrepeat" set: Softrepeat is on, regardless
>  - "nosoftrepeat" set: Softrepeat is off, regardless
>  - Both "softrepeat" and "nosoftrepeat" are set: Do not do that.
> 
> The code looked confusing, but there is an good explanation in this bug:
>  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181457
> 
> In short words, DRAC3 "plugs into" the keyboard connector, but does not
> emulate output, so we detect this as "dumb" keyboard and enable softrepeat.
> But softrepeat causes double keypresses.
> 
> I suppose we could revamp the old softrepeat parameter to be more than
> a boolean, but I see no point.
> 
> If you agree, please include the attached.
> 
> -- Pete
> 
> --- linux-2.6.16-rc2/drivers/input/keyboard/atkbd.c	2006-02-11 00:31:41.000000000 -0800
> +++ linux-2.6.16-rc2-lem/drivers/input/keyboard/atkbd.c	2006-02-21 11:53:53.000000000 -0800
> @@ -50,6 +50,10 @@ static int atkbd_softrepeat;
>  module_param_named(softrepeat, atkbd_softrepeat, bool, 0);
>  MODULE_PARM_DESC(softrepeat, "Use software keyboard repeat");
>  
> +static int atkbd_nosoftrepeat;
> +module_param_named(nosoftrepeat, atkbd_nosoftrepeat, bool, 0);
> +MODULE_PARM_DESC(nosoftrepeat, "Do not use software keyboard repeat");
> +
>  static int atkbd_softraw = 1;
>  module_param_named(softraw, atkbd_softraw, bool, 0);
>  MODULE_PARM_DESC(softraw, "Use software generated rawmode");
> @@ -862,7 +866,7 @@ static int atkbd_connect(struct serio *s
>  	atkbd->softrepeat = atkbd_softrepeat;
>  	atkbd->scroll = atkbd_scroll;
>  
> -	if (!atkbd->write)
> +	if (!atkbd->write && !atkbd_nosoftrepeat)
>  		atkbd->softrepeat = 1;
>  
>  	if (atkbd->softrepeat)
> 
> 

-- 
Vojtech Pavlik
Director SuSE Labs
