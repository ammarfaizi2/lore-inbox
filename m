Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315330AbSEBSbt>; Thu, 2 May 2002 14:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315256AbSEBSbs>; Thu, 2 May 2002 14:31:48 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:22284 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S315233AbSEBSbq>; Thu, 2 May 2002 14:31:46 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A77CF@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: antonelloderosa@inwind.it
Cc: "'root@chaos.analogic.com'" <root@chaos.analogic.com>,
        "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Controlling the serial port at kernel level
Date: Thu, 2 May 2002 11:31:45 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002, Richard B. Johnson wrote:
> 
> > On Thu, 2 May 2002, antonelloderosa@inwind.it wrote:
> 
> > Hallo,
> > I would find the way of controlling the serial port at kernel
> > level; more precisely I want to set the DTR or RTS pin of the serial
> > port whenever my host send or receive an udp packet. 
> >
> [ ... ] 
> 
> If this is just a hack and you don't care if it screws up
> somebody else using the UART, just....
> 
> #define BASE 0x3f8  // For first UART
> #define MCR 0x3fc
> #define DTR 0x01
> #define RTS 0x02
> 
> ... read/write directly to the MCR port, saving the bits you don't
> want to change... You use the outb(value, port); and inb(port);
> instructions for ports.
> 

Since you are using a built-in serial port, Dick Johnson's suggested 
method is, by far, the best return on your effort. The entry points 
in serial.c, rs_ioctl or set_modem_info, are "static" and would also 
require you to synthesize a tty "info" structure. Anything more 
than the quick hack would best be done by looking up the driver's 
port structure and calling rs_ioctl through the standard interface. 
That would be much more effort to get right. 

See function "set_modem_info" in drivers/char/serial.c for an example 
of setting the MCR. You should write and use a shell script that opens 
the port, turns off CREAD (to avoid echo writes), turns off HUPCL (to 
avoid disconnect related MCR writes), and holds the port open but 
leaves it idle. 

For example, something like:
	(stty -cread -hupcl; sleep 99999d) < /dev/ttyS0 &

That will get the UART initialized and held in an 
operational state while you program the MCR register from inside 
the kernel to change the modem signal states. If you are sure that 
there will be _NO_ other use of the port, then it will not be 
necessary to turn off interrupts while changing the MCR. (That's what 
the "save_flags(flags); cli();" and "restore_flags(flags);" lines of 
code do.)

Keep in mind that this is a brute force solution ...

Good luck.

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
