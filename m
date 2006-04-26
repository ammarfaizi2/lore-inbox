Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWDZJiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWDZJiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 05:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWDZJiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 05:38:16 -0400
Received: from styx.suse.cz ([82.119.242.94]:37549 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751349AbWDZJiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 05:38:15 -0400
Date: Wed, 26 Apr 2006 11:38:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: bjd <bjdouma@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001/001] INPUT: new ioctl's to retrieve values of EV_REP and EV_SND event codes
Message-ID: <20060426093813.GD27238@suse.cz>
References: <20060422204844.GA16968@skyscraper.unix9.prv> <d120d5000604250823p4f2ed2acv4287f7d70c71c7c0@mail.gmail.com> <20060425152600.GA30398@suse.cz> <200604260106.38480.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604260106.38480.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 01:06:38AM -0400, Dmitry Torokhov wrote:

> > Yes. And EVIOCSREP should just generate the events needed to notify the
> > drivers to do the change.
> > 
> 
> What do you gius think about the patch below?

It looks fine to me.

> -- 
> Dmitry
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/evdev.c |   21 +++++++++++++++++++++
>  include/linux/input.h |    2 ++
>  2 files changed, 23 insertions(+)
> 
> Index: work/drivers/input/evdev.c
> ===================================================================
> --- work.orig/drivers/input/evdev.c
> +++ work/drivers/input/evdev.c
> @@ -403,6 +403,27 @@ static long evdev_ioctl_handler(struct f
>  		case EVIOCGID:
>  			if (copy_to_user(p, &dev->id, sizeof(struct input_id)))
>  				return -EFAULT;
> +			return 0;
> +
> +		case EVIOCGREP:
> +			if (!test_bit(EV_REP, dev->evbit))
> +				return -ENOSYS;
> +			if (put_user(dev->rep[REP_DELAY], ip))
> +				return -EFAULT;
> +			if (put_user(dev->rep[REP_PERIOD], ip + 1))
> +				return -EFAULT;
> +			return 0;
> +
> +		case EVIOCSREP:
> +			if (!test_bit(EV_REP, dev->evbit))
> +				return -ENOSYS;
> +			if (get_user(u, ip))
> +				return -EFAULT;
> +			if (get_user(v, ip + 1))
> +				return -EFAULT;
> +
> +			input_event(dev, EV_REP, REP_DELAY, u);
> +			input_event(dev, EV_REP, REP_PERIOD, v);
>  
>  			return 0;
>  
> Index: work/include/linux/input.h
> ===================================================================
> --- work.orig/include/linux/input.h
> +++ work/include/linux/input.h
> @@ -56,6 +56,8 @@ struct input_absinfo {
>  
>  #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
>  #define EVIOCGID		_IOR('E', 0x02, struct input_id)	/* get device ID */
> +#define EVIOCGREP		_IOR('E', 0x03, int[2])			/* get repeat settings */
> +#define EVIOCSREP		_IOW('E', 0x03, int[2])			/* get repeat settings */
>  #define EVIOCGKEYCODE		_IOR('E', 0x04, int[2])			/* get keycode */
>  #define EVIOCSKEYCODE		_IOW('E', 0x04, int[2])			/* set keycode */
>  
> 
> 

-- 
Vojtech Pavlik
Director SuSE Labs
