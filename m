Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269785AbUJGLII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269785AbUJGLII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 07:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269793AbUJGLII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 07:08:08 -0400
Received: from boxa.alphawave.net ([207.218.5.130]:2441 "EHLO
	box.alphawave.net") by vger.kernel.org with ESMTP id S269785AbUJGLIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 07:08:00 -0400
Date: Thu, 7 Oct 2004 12:08:02 +0100
From: Nick Craig-Wood <nick@craig-wood.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Patch] new serial flow control
Message-ID: <20041007110802.GA1594@craig-wood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart MacDonald <stuartm@connecttech.com> wrote:
>  From: Alan Cox
> > On Mer, 2004-10-06 at 08:38, Samuel Thibault wrote:
> > > No: CRTSCTS is a one-signal-for-each-way flow control: each
> > > side of the link tells whether it can receive data. CTVB is a
> > > two-signals-for-only-one-way flow control: the device tells when it
> > > wants to send data, the PC acknowledges that, and then one frame of
> > > data can pass.
> > 
> > This sounds a lot like RS485 and some other related stuff. I need to
> > poke my pet async guru and find out if they are the same thing. If so
> > that would be useful.
> 
>  RS485 is a driver-transparent electrical interface.

Yes, in theory!  In practice it isn't quite transparent due to
tristating.

These are the 4 main types of serial interface that I use regularly
RS232, RS422, RS485 4-Wire and RS485 2-Wire.

RS232 we all know and love - 12 V signalling etc

RS422 is RS232 with a different electrical interface, ie 5V
differential (2 wires per signal, eg rx+, rx- etc)

RS485 4-Wire is like RS422 but the bus has the potential to go
tri-state.  In a bus with only one master, the master can just
transmit all the time and all the slaves will listen.  However if you
want to be a slave or have multiple masters it is necessary for you to
tristate the bus.

RS485 2-Wire is like RS485 4-Wire except the transmit and receive
lines are combined into rx_tx+ and rx_tx-.  In this kind of bus it is
essential everyone tristates the line after transmitting.

For the RS485 busses there needs to be some way of telling the serial
interface hardware that you want the bus to be tristate.  This is
typically done with DTR (which isn't used for RS485 busses), DTR=1
means untristate the bus and DTR=0 means tristate it.

When used like this timing is very critical - you must de-assert DTR
as soon as the serial character has left the serial UART.  This is
difficult to do exactly in user-space.  Alternatively you can use a
specialist serial interface which will do it for you.

In practice for our applications we use RS485 in master mode which
requires no difficult control.  When we have to do RS485 in 2-Wire
mode we transmit a character and block our application to wait for it
to come back then de-assert RTS.  Thats nasty though and would be much
better done in the serial driver, where you get an interrupt at
exactly the moment the tx fifo is empty.

>  Unfortunately the half-duplex and master-slave(s) arrangements
>  require some sort of token passing to know when they can
>  successfully transmit.

It does.  Its usually done with a packet protocol and addresses.

>  This is usually handled by the apps in some manner, although it's
>  often wanted to be handled by the serial driver. This could be one
>  method of signalling, but isn't sufficient to show RS485 operation.

The tristating above should be done in the driver if possible.  The
packet protocol etc should be done in the application.

The flow control method described by the OP doesn't sound exactly like
RS485, but the timing constraints of waggling RTS are exactly the
same.

-- 
Nick Craig-Wood <nick@craig-wood.com> -- http://www.craig-wood.com/nick
