Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283764AbRK3SnL>; Fri, 30 Nov 2001 13:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283769AbRK3SnA>; Fri, 30 Nov 2001 13:43:00 -0500
Received: from [195.63.194.11] ([195.63.194.11]:54790 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S283763AbRK3Sly>; Fri, 30 Nov 2001 13:41:54 -0500
Message-ID: <3C07D09B.277CF7E2@evision-ventures.com>
Date: Fri, 30 Nov 2001 19:31:55 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: dalecki@evision.ag, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu> <20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de> <20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> <3C07B820.4108246F@mandrakesoft.com> <3C07BFE8.5B32C49C@evision-ventures.com> <20011130175058.B19193@flint.arm.linux.org.uk> <3C07C68D.67D60384@evision-ventures.com> <20011130180312.D19193@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Fri, Nov 30, 2001 at 06:49:01PM +0100, Martin Dalecki wrote:
> > Well sombeody really cares apparently! Thank's.
> 
> Currently its a restructuring of serial.c to allow different uart type
> ports to be driven without duplicating serial.c many times over.  (the
> generic_serial didn't hack it either).
> 
> > Any pointers where to ahve a look at it?
> 
> I should probably put this on a web page somewhere 8)
> 
>   :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot, module serial
>   (no password)
> 
> > BTW> Did you consider ther misc device idea? (Hooking serial at to the
> > misc device stuff).
> 
> I just caught that comment - I'll await your reply.

I'm just right now looking at the code found above.
First of all: GREAT WORK! And then you are right a bit, I just don't
see too much code duplication between the particular drivers there.
However I still don't see the need to carrige the whole tty stuff just
to drive a mouse... but I don't see a solution right now.
I wouldn't be good to introduce a scatter heap of "micro" 
driver modules like the ALSA people did as well too..

However in serial/linux/drivers/serial/serial_clps711x.c
the following wonders me a bit:

#ifdef CONFIG_DEVFS_FS
	normal_name:		SERIAL_CLPS711X_NAME,
	callout_name:		CALLOUT_CLPS711X_NAME,
#else
	normal_name:		SERIAL_CLPS711X_NAME,
	callout_name:		CALLOUT_CLPS711X_NAME,
#endif

What is the ifdef supposed to be good for?

 
One other suggestion serial_code.c could be just serial.c or code.c
or main.c, since _xxxx.c should distinguish between particulart devices.
It was a bit clumy to find the entry-point for me...
And then we have in uart_register_driver:

	normal->open		= uart_open;
	normal->close		= uart_close;
	normal->write		= uart_write;
	normal->put_char	= uart_put_char;
	normal->flush_chars	= uart_flush_chars;
	normal->write_room	= uart_write_room;
	normal->chars_in_buffer	= uart_chars_in_buffer;
	normal->flush_buffer	= uart_flush_buffer;
	normal->ioctl		= uart_ioctl;
	normal->throttle	= uart_throttle;
	normal->unthrottle	= uart_unthrottle;
	normal->send_xchar	= uart_send_xchar;
	normal->set_termios	= uart_set_termios;
	normal->stop		= uart_stop;
	normal->start		= uart_start;
	normal->hangup		= uart_hangup;
	normal->break_ctl	= uart_break_ctl;
	normal->wait_until_sent	= uart_wait_until_sent;

And so on....

Why not do:

{
     static strcut tty_driver _normal = {
     open: uart_open,
     close: uart_close,
     ...
     };

     ...

     *normal = _normal;
}
...
for the static stuff first and only initialize the
dynamically calculated addresses dynamically later, like
the double refferences...
This would save already *quite a bit* of .text ;-).

Yeah I know I'm a bit perverse about optimizations....


You already do it for the callout device nearly this
way:

	/*
	 * The callout device is just like the normal device except for
	 * the major number and the subtype code.
	 */
	*callout		= *normal;
	callout->name		= drv->callout_name;
	callout->major		= drv->callout_major;
	callout->subtype	= SERIAL_TYPE_CALLOUT;
	callout->read_proc	= NULL;
	callout->proc_entry	= NULL;

Reagrds.
