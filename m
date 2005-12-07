Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbVLGWSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbVLGWSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbVLGWSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:18:43 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:20428 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030399AbVLGWSl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:18:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qs3wrRFQgni8pStxc37CL1p9Kq8AxIGAVRgREo5oZz7JS7jMupxxWIVXtt32digfhxs+fxKPS79rE7F0rDMUvlNs52FPzLv2Honbn2be6L6vQfDon+ukZWRlCNSir81WU21fHCJIEqe1nzNRI6sQWxxpiCHYguxOcUleHL1u/Cg=
Message-ID: <d120d5000512071418q521d2155r81759ef8993000d8@mail.gmail.com>
Date: Wed, 7 Dec 2005 17:18:40 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: dtor_core@ameritech.net, Greg KH <greg@kroah.com>,
       Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
In-Reply-To: <20051207190352.GI6793@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051205212337.74103b96.khali@linux-fr.org>
	 <20051205202707.GH15201@flint.arm.linux.org.uk>
	 <200512070105.40169.dtor_core@ameritech.net>
	 <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com>
	 <20051207180842.GG6793@flint.arm.linux.org.uk>
	 <d120d5000512071023u151c42f4lcc40862b2debad73@mail.gmail.com>
	 <20051207190352.GI6793@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Wed, Dec 07, 2005 at 01:23:11PM -0500, Dmitry Torokhov wrote:
> > On 12/7/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > On Wed, Dec 07, 2005 at 12:59:09PM -0500, Dmitry Torokhov > > I have started moving drivers from the "_simple" interface and I found
> > > > that I'm missing platform_device_del that would complement
> > > > platform_device_add. Would you object to having such a function, like
> > > > we do for other sysfs objects? With it one can write somthing like
> > > > this:
> > >
> > > Greg and myself discussed that, and we decided that it was adding
> > > unnecessary complexity to the interface.  Maybe Greg's view has
> > > changed?
> > >
> >
> > How do you write error handling path without the _del function if
> > platform_device_add is not the last call? you can't call
> > platform_device_unregister() and then platform_device_put(). And I
> > don't like to take extra references in error path or assign the
> > pointer to NULL in teh middle of unwinding...
>
> The example code in the commit comments contains a complete example of
> registering a platform device, and cleaning up should something go
> wrong with that process.
>

The problem with what you proposing is that one will have to code 2
cleanup code paths - one when platform_device_add fails (in this case
you just call platform_device_put) and another one when
platfrom_device_add succeeds but something else fails. In the second
case you have to use platfrom_device_unregister to release resources
but can't use platform_device_put because the device will most likely
be released by plaform_device_unregister. I prefer having single
cleanup code path, like most other drivers have.

> Unregistering is just a matter of calling platform_device_unregister().
> An unregister call is a del + put in exactly the same way as it is
> throughout the rest of the driver model.
>

Yes, and it works just fine everywhere except in initialization code
when you need to jump in the middle of _del + _put sequence.

--
Dmitry
