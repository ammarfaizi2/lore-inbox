Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262141AbSJASa6>; Tue, 1 Oct 2002 14:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262146AbSJASa6>; Tue, 1 Oct 2002 14:30:58 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:52487 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262141AbSJASa5>;
	Tue, 1 Oct 2002 14:30:57 -0400
Date: Tue, 1 Oct 2002 11:34:00 -0700
From: Greg KH <greg@kroah.com>
To: Martin Diehl <lists@mdiehl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: calling context when writing to tty_driver
Message-ID: <20021001183400.GA8959@kroah.com>
References: <Pine.LNX.4.21.0210010523290.485-100000@notebook.diehl.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0210010523290.485-100000@notebook.diehl.home>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 12:37:42PM +0200, Martin Diehl wrote:
> 
> Hi,
> 
> just hitting another "sleeping on semaphore from illegal context" issue
> with 2.5.39. Happened on down() in either usbserial->write_room() or
> usbserial->write(), when invoked from bh context.

Can you send me the whole backtrace?  I'm curious as to who is calling
those functions from bh context.

> Some grepping reveals no documentation of calling context requirements
> for those driver calls and existing serial code seems to be happy with bh
> context. Therefore I'm wondering whether it is permitted to call from
> don't-sleep context?

I don't know.

> Since write_room() is usually called immediately before write()'ing stuff
> to the driver it would be a good idea to keep them both callable from bh,
> IMHO. For example tty_ldisc->write_wakeup() might probably want to issue
> write_room() followed by write().
> 
> Currently, usbserial calls write_wakeup() from bh (on OUT urb completion)
> but needs process context for write_room() and write(). My impression is
> the whole point of write_room() is to find out how many data can be
> accepted by the write() - if write() would be allowed to sleep it could
> just block to deal with any amount of data.

Making write() block for any amount of data would increase the
complexity of the drivers.  What should probably be done is convert the
usb-serial drivers to use the new serial core, but I don't have the time
to do this work right now.  Any takers?

thanks,

greg k-h
