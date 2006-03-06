Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWCFBAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWCFBAr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 20:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWCFBAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 20:00:47 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:20079 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751186AbWCFBAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 20:00:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tNUprg25TDH+0O3Vx7r49xjRhYx4ILUQjRkEn3lZAu3feZufquIns7hbkZ94n53F3QxVlKacM2vH5KaU4gA4Xo9GjMH4uf7F3Jfw7bxDWqguzSLK4gza2uupywRdWZamzDFrhjI75YONGNT3fDDMIfKT+6to5U7I7PAQUIHuagA=
Message-ID: <440B89AB.3020203@gmail.com>
Date: Mon, 06 Mar 2006 09:00:27 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Zabolotny <zap@homelink.ru>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
References: <1141571334.6521.38.camel@localhost.localdomain>
In-Reply-To: <1141571334.6521.38.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
> At present, the backlight class presents two attributes to sysfs,
> brightness and power. I'm a little confused as to whether these
> attributes are currently doing the right things.
> 
> Taking brightness, at any one time we have several different brightness
> values:
> 
> * User requested brightness (echo y > /sys/class/backlight/xxx/brightness)
> * Driver determined brightness which accounts for things like FB 
>   blanking, low battery backlight limiting (an example from corgi_bl), 
>   user requested power state, device suspend/resume.
> 
> The solution might be to have brightness always return the user
> requested value y and have a new attribute returning the brightness as
> determined by the driver once it accounts for all the factors it needs
> to consider. Naming of such an attribute is tricky - "driver_brightness"
> perthaps?

Why not just agree on a normal range of values (ie, 0-255), and let the
driver "denormalize" them?  Thus, a driver that has only 2 levels of
brightness, will treat 0-127 as 0 and 128-255 as 1, and will return only
two possible values 0 and 255.

If a user requests max brightness (255), and the driver is capable of setting
it, then it returns 255.  But if for some reason it can't (ie low power state),
it returns the current max brightness, normalized, (ie 128 instead of 255 and
because that the scale is 0-255, a value of 128 tells the user that only
half of max brightness was set).

And instead of a new "driver_brightness" attribute, why not just a new
attribute that returns the number of brightness levels?

It's similar for power.  We can agree on a range, 0-255.  The range might be
overkill but is consistent with brightness.  The callback converts the VESA
constants to 0 - 0, 1 - 64, 2 - 128, 3 - 255 and sends the value to the driver.
The driver, denormalizes them to, most probably, on and off (0-127 - on,
128-255 - off).

Tony

