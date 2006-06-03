Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWFCFz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWFCFz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 01:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWFCFz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 01:55:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:63155 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751078AbWFCFz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 01:55:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aXjx4Hi9K/J6t+2wg8HETOqU+4ufQGCCFQcwsSvV2Iu3mcq+5cHiEmqnTcY5qFJr+l6C3VaWTWd5hgR3wpUv5e2JKuxMuuQyQ7eUAW9wOGqGDlRHg9u7jvaDMtGNLVwDMJkRTq+VJmQvQnZffdKR6HileBfrgQqVOab19Z47dFc=
Message-ID: <9e4733910606022255r7fa7346bw661fb35f81668788@mail.gmail.com>
Date: Sat, 3 Jun 2006 01:55:46 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>, "Dave Airlie" <airlied@gmail.com>,
       "Ondrej Zajicek" <santiago@mail.cz>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <200606030125.20907.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com>
	 <24BBD756-4658-48A7-AD4D-1D25124A946B@mac.com>
	 <200606030125.20907.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/06, D. Hazelton <dhazelton@enter.net> wrote:
> The reason Jon is so hot on having direct access like that is he feels that
> modesetting and a few other simple tasks should be handled by helpers and
> acceleration itself should be handled by userspace libraries, without the drm
> daemon at all.

Jon thinks all of the HW level acceleration should be handled in the
DRM device drivers where it already exists. The acceleration code in
fbdev and XAA/EXA needs to die. DRM is the only choice since it is
possible to eliminate the other two and it is not possible to
eliminate DRM. Dave is in agreement with this design.

I think you are mixing up my comments about DRI vs DRM. DRI is the
user space acceleration code but it doesn't actually touch the
hardware. DRM actually touches it. I have never wanted user space
acceleration code for the low level hardware access.

Dave and I are only in disagreement on how to handle mode setting. In
his model there is a mode setting daemon that has a socket interface.
The libraries implementing xlib/OpenGL then talk to both this socket
and to the DRM device.

My desire is to have a single point of interface, DRM. Since mode
setting is not done very often I would use call_userhelper from the
DRM device driver to invoke it when necessary. To set a mode you IOCTL
DRM, which then bounces to a transient user space app.

Neither model forces mode setting exclusively into user space or the
kernel, each driver can chose to put it where ever is more efficient.
By initially reusing the existing X drivers it will probably all end
up in user space but people may rewrite that over time.

Two other things that probably have to go into user space are initial
reset and attached device (monitors) discovery.

-- 
Jon Smirl
jonsmirl@gmail.com
