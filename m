Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263224AbSJCJpw>; Thu, 3 Oct 2002 05:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263225AbSJCJpw>; Thu, 3 Oct 2002 05:45:52 -0400
Received: from dp.samba.org ([66.70.73.150]:18661 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263224AbSJCJpv>;
	Thu, 3 Oct 2002 05:45:51 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15772.4878.969143.541225@nanango.paulus.ozlabs.org>
Date: Thu, 3 Oct 2002 19:51:10 +1000 (EST)
To: Greg KH <greg@kroah.com>
Cc: Martin Diehl <lists@mdiehl.de>, linux-kernel@vger.kernel.org
Subject: Re: calling context when writing to tty_driver
In-Reply-To: <20021003065209.GA18481@kroah.com>
References: <20021001183400.GA8959@kroah.com>
	<Pine.LNX.4.21.0210012150300.485-100000@notebook.diehl.home>
	<20021003065209.GA18481@kroah.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

> On Tue, Oct 01, 2002 at 11:10:34PM +0200, Martin Diehl wrote:
> > If we agree serial drivers shouldn't sleep in write_room()/write() my
> > impression is this needs to be addressed somehow, regardless whether
> > usbserial uses the new serial core or not. Anybody tried this with a
> > bluetooth dongle over usbserial?
> 
> I don't know, do we agree that you can't sleep in those functions?  If
> so, I'll look into fixing the usbserial drivers up.

I really think that write and write_room shouldn't be allowed to
sleep.  If they can sleep it will cause much grief for PPP, since the
PPP start_xmit function does get called in softirq context, and in the
common case where you are doing PPP over a serial port, that will
ultimately end up in a call to the serial port's write routine.  If we
can't call the write routine from softirq context, that will mean we
will have to have some sort of helper thread (whether that is keventd
or something else), and that will introduce extra unnecessary latency
when you are using a serial port where the write routine doesn't ever
block (which is all of them except usbserial, at the moment).

I would have thought that the normal tty line discipline would impose
the same requirement.  You type a character, it gets put in a flip
buffer and processed later in softirq context.  That processing says
"we're supposed to echo this character" so it will call the serial
port's write routine - in softirq context, if I am not mistaken.

Regards,
Paul.
