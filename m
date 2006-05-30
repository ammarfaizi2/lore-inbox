Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWE3XVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWE3XVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWE3XVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:21:19 -0400
Received: from wx-out-0102.google.com ([66.249.82.205]:41666 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964806AbWE3XVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:21:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=M9s9daWj7l+QVdzXC+g5zcDfW3LoNlBcjkgPH8v/VPoZ5oypD1u07Eb7hPkwt06QRZHitzRHiOwBn1X0PA+qHWTyRoUzf1a7BuFrLET5Gz1RQSup8rcOlTbb7fyrGtY8uFb9yQRi4iCxlyqmNFOZVmRwyvsyOddE3g2ETAdH6Kk=
Message-ID: <447CD367.5050606@gmail.com>
Date: Wed, 31 May 2006 07:21:11 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Ondrej Zajicek <santiago@mail.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <20060530223513.GA32267@localhost.localdomain>
In-Reply-To: <20060530223513.GA32267@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ondrej Zajicek wrote:
> On Tue, May 30, 2006 at 10:40:20AM -0700, David Lang wrote:
>> as a long time linux user I tend to not to use the framebuffer, but 
>> instead use the standard vga text drivers (with X and sometimes dri/drm).
>>
>> in part this dates back to my early experiances with the framebuffer code 
>> when it was first introduced, but I still find that the framebuffer is not 
>> as nice to use as the simpler direct access for text modes. and when I 
>> start X up it doesn't need a framebuffer, so why suffer with the 
>> performance hit of the framebuffer?
> 
> Many users want to use text mode for console. But this request is not
> in contradiction with fbdev and fbcon. It just requires to do some work:
> 
> 1) To extend fbcon to be able to handle framebuffer in text mode.

And it can be done.  The matrox driver in 2.4 can do just that.  For 2.6,
we have tileblitting which is a drawing method that can handle pure text.
None of the drivers use this, but vgacon can be trivially written as a
framebuffer driver that uses tileblitting (instead of the default bitblit).

I believe that there was a vgafb driver before that does exactly what you
want.

> 2) To modify appropriate fbdev drivers to not do mode change at startup.
>    Fill fb_*_screeninfo with appropriate values for text mode instead.

Most drivers do not change the mode at startup.  Do not load fbcon, and
you will retain your text mode even if a framebuffer is loaded.  This is
not a hard and fast rule, so some drivers, especially those in embedded,
will explicitly change the mode at startup, that's a developer choice.

> 3) (optional) To modify appropriate fbdev drivers to be able to switch
>    back from graphics mode to text mode.

And a few drivers already do that, i810fb and rivafb.  Load rivafb or i810fb,
switch to graphics mode, unload, and you're back to text mode. The main problem
is that fbcon cannot be unloaded, but it's again trivial to rewrite fbcon so it
can be unloaded.  What prevents me for doing the rewrite is that only a few
drivers restore the hardware to text mode.

And this is one argument against making vgacon the primary console driver.
It does not have the capability to reset itself, it has to be done by
an external driver, whether by X or fbdev.

Tony
