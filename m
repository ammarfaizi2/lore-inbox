Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbUKIHPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbUKIHPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 02:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUKIHPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 02:15:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:13034 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261401AbUKIHPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 02:15:19 -0500
Date: Mon, 8 Nov 2004 23:14:56 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, diffie@gmail.com, linux-kernel@vger.kernel.org,
       diffie@blazebox.homeip.net, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041109071455.GA11643@kroah.com>
References: <9dda349204110611043e093bca@mail.gmail.com> <20041107024841.402c16ed.akpm@osdl.org> <20041108075934.GA4602@elte.hu> <20041107234225.02c2f9b6.akpm@osdl.org> <20041108224259.GA14506@kroah.com> <20041108212747.33b6e14a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108212747.33b6e14a.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 09:27:47PM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > So I don't see how that could be failing here.  And why I don't see this
> >  on my boxes...
> 
> OK, progress.  The oops is due to CONFIG_LEGACY_PTY_COUNT=512.  I assume
> anything greater than 256 will trigger it.
> 
> - tty_register_driver() calls tty_register_device() for 512 devices.
> 
> - tty_register_device() calls pty_line_name() for the 512 devices, but
>   pty_line_name() only understands 256 devices.  After that, it starts
>   returning duplicated names.
> 
> - class_simple_device_add() gets an -EEXIST return from
>   class_device_register() and then tries to kfree local variable s_dev, but
>   it's already free.  Presumably all that icky refcounting under
>   class_device_register() did this for us already.  Can you fix this one
>   Greg?  Just enable slab debugging, set CONFIG_LEGACY_PTY_COUNT=512 and
>   watch the fun.

Ick, yeah, I just tested that.  I don't know why that's happening, I'll
go fix it up now.

thanks,

greg k-h
