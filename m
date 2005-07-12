Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVGLP5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVGLP5d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 11:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVGLP5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 11:57:32 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:5858 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S261475AbVGLPzy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 11:55:54 -0400
Subject: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested?
	(Userspace accelerometer viewer)
From: Dave Hansen <dave@sr71.net>
To: Daniel Willmann <d.willmann@tu-bs.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Paul Sladen <thinkpad@paul.sladen.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
In-Reply-To: <20050711220911.00da2396@elara.orbit.homelinux.net>
References: <Pine.LNX.4.21.0507111011170.25721-100000@starsky.19inch.net>
	 <1121092015.7407.68.camel@localhost.localdomain>
	 <20050711220911.00da2396@elara.orbit.homelinux.net>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 08:55:33 -0700
Message-Id: <1121183733.8317.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 22:09 +0200, Daniel Willmann wrote: 
> I have implemented an absolute input driver (aka joystick) on the
> basis of Dave's 0.02 version of the driver. I attached the diff to this
> mail or just get it from:
> http://thebe.orbit.homelinux.net/~alphaone/ibm_hdaps_joystick.tar.gz

Thanks for doing this.  A few comments below.

> +static u16 lastx = 0, lasty = 0;
> 
> 
> +static void ibm_hdaps_joystick_poll(unsigned long unused)
>  {
> -       int movex, movey;
> +       int posx, posy;
>         struct hdaps_accel_data accel_data;
>  
>         accelerometer_read(&accel_data);
> -       movex = restx - accel_data.x_accel;
> -       movey = resty - accel_data.y_accel;
> -       if (abs(movex) > ibm_hdaps_mousedev_fuzz)
> -               input_report_rel(&hdaps_idev, REL_Y, movex);
> -       if (abs(movey) > ibm_hdaps_mousedev_fuzz)
> -               input_report_rel(&hdaps_idev, REL_X, movey);
> +       posx = accel_data.x_accel;
> +       posy = accel_data.y_accel;
> +
> +       if (ibm_hdaps_joystick_reversex) 
> +               posy = hdaps_idev.absmax[ABS_X] + (hdaps_idev.absmin[ABS_X] - posy);
> +       if (ibm_hdaps_joystick_reversey)
> +               posx = hdaps_idev.absmax[ABS_Y] + (hdaps_idev.absmin[ABS_Y] - posx);

I'm not sure this is a good idea to do in the driver.  Reversing the
movement like this is something that surely should be going into the
input layer.  It might even be there already.

> +       if (abs(posx-lastx) > 0)
> +               input_report_abs(&hdaps_idev, ABS_Y, posx);
> +       if (abs(posy-lasty) > 0)
> +               input_report_abs(&hdaps_idev, ABS_X, posy);

Why do you suppress the events like this?  I think this is done inside
of the input layer already.  What happens if you don't do this?

> +       if (ibm_hdaps_joystick_registered)
> +       {
> +               snprintf(buf, 256, "enabled\n");
> +       }
> +       else
> +               snprintf(buf, 256, "disabled\n");

Please follow the coding style that Jesper and I have been working with:

        if () {
        	foo();
        } else {
        	bar();
        } 

> +static ssize_t
> +hdaps_joystick_enable_store(struct device *dev, const char * buf, size_t count)
> +{
> +       if ((strncmp(buf, "1", 1) == 0)&&(!ibm_hdaps_joystick_registered))
> +       {
> +               ibm_hdaps_joystick_enable();
> +       }
> +       else if ((strncmp(buf, "0", 1) == 0)&&(ibm_hdaps_joystick_registered))
> +       {
> +               ibm_hdaps_joystick_disable();
> +       }
> +       return count;
> +}

I think this makes the sysfs interface a bit counter-intuitive.  The
"cat joystick_enable" shows "enabled" or "disabled", but you have to
echo "0" and "1" into it to get it to do what you want.

> +hdaps_joystick_fuzzx_store(struct device *dev, const char * buf,
> size_t count)
>  {
> -       if (!calibrated)
> +       uint16_t temp;
> +       if (ibm_hdaps_joystick_registered)
>                 return -EINVAL;
> +       if (sscanf(buf, "%hu", &temp) == 1)
> +       {
> +               hdaps_idev.absfuzz[ABS_X] = temp;
> +       }
> +       return count;
> +}

Since that fuzz variable is actually part of the input layer, we should
probably have a conversation with the input people to see if they want a
generic, adjustable fuzz for all ABS input devices, instead of
duplicating it in a bunch of drivers.

BTW, I don't think there's a need for a different fuzzx and fuzzy.

-- Dave

