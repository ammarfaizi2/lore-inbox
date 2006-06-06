Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWFFQlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWFFQlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWFFQlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:41:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:27059 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750773AbWFFQlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:41:24 -0400
Date: Tue, 6 Jun 2006 09:38:27 -0700
From: Greg KH <gregkh@suse.de>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH 8/11] usbserial: pl2303: Ports tty functions.
Message-ID: <20060606163827.GA28298@suse.de>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br> <1149217398434-git-send-email-lcapitulino@mandriva.com.br> <20060602205014.GB31251@suse.de> <20060602154121.d3f19cbe.zaitcev@redhat.com> <20060602224435.GA26061@suse.de> <20060603191917.29967d61@home.brethil> <20060606073441.GD17682@suse.de> <20060606101058.1e1d31bc@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606101058.1e1d31bc@doriath.conectiva>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2006 at 10:10:58AM -0300, Luiz Fernando N. Capitulino wrote:
> On Tue, 6 Jun 2006 00:34:41 -0700
> Greg KH <gregkh@suse.de> wrote:
> 
> | On Sat, Jun 03, 2006 at 07:19:17PM -0300, Luiz Fernando N. Capitulino wrote:
> | > On Fri, 2 Jun 2006 15:44:35 -0700
> | > Greg KH <gregkh@suse.de> wrote:
> | > 
> | > | On Fri, Jun 02, 2006 at 03:41:21PM -0700, Pete Zaitcev wrote:
> | > | > On Fri, 2 Jun 2006 13:50:14 -0700, Greg KH <gregkh@suse.de> wrote:
> | > | > > On Fri, Jun 02, 2006 at 12:03:14AM -0300, Luiz Fernando N.Capitulino wrote:
> | > | > 
> | > | > > >   2. The new pl2303's set_termios() can (still) sleep. Serial Core's
> | > | > > >      documentation says that that method must not sleep, but I couldn't find
> | > | > > >      where in the Serial Core code it's called in atomic context. So, is this
> | > | > > >      still true? Isn't the Serial Core's documentation out of date?
> | > | > > 
> | > | > > If this is true then we should just stop the port right now, as the USB
> | > | > > devices can not handle this.  They need to be able to sleep to
> | > | > > accomplish this functionality.
> | > | > > 
> | > | > > Russell, is this a requirement of the serial layer?  Why?
> | > | > 
> | > | > Shouldn't it be all right to schedule the change at the moment of
> | > | > that call and have it happen later? Resisting a temptation to abuse
> | > | > keventd and schedule_work and using a tasklet may help with latency
> | > | > enough to make this tolerable.
> | > | 
> | > | Some devices require more than one usb message to set all of the proper
> | > | termios bits in the device.  Creating a way to queue them up and fire
> | > | them off later, and handle errors if something happened in the middle,
> | > | after we told userspace the termios change succeeded, might get quite
> | > | messy :(
> | > 
> | >  But set_termios() returns nothing, and look what termios
> | > man page says about tcsetattr() return value:
> | > 
> | > """
> | > Note that tcsetattr() returns success if any of the requested changes could
> | > be successfully carried out. Therefore, when making multiple changes it may be
> | > necessary to follow this call with a further call to tcgetattr() to check that
> | > all changes have been performed successfully.
> | > """
> | 
> | Good point, I forgot about that.
> | 
> | >  Also, why do they need to sleep? Did you note that my version of
> | > set_mctrl() is atomic?
> | 
> | Yes, that looks "atomic" in a way, but when the function returns, the
> | value is not really set.  It only happens some time in the future when
> | the urb completes (and hopefully it works, no retry is allowed...)
> | 
> | So it might be a bit "racy" :)
> 
>  Oh, that's true.
> 
>  Is it acceptable?

I don't think so.

> The hardware is capable to queue URBs, right?

Yes it is.

thanks,

greg k-h
