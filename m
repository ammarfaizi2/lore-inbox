Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292900AbSB0WNY>; Wed, 27 Feb 2002 17:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293018AbSB0WNB>; Wed, 27 Feb 2002 17:13:01 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:63754 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S293009AbSB0WMo>; Wed, 27 Feb 2002 17:12:44 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76C0@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'alexis raynaud'" <araynaud@alphalink.fr>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Problem to use a Oxford semiconductor Intelligent DUAL Channe
	 l UA RT (OX16PCI952)
Date: Wed, 27 Feb 2002 14:13:39 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexis,

Thanks for the good data. I think I understand at least part of what is
happening.

It sounds like the card is the Oxford Semi UART evaluation card for the
16C952 chip. I could not find specific documentation for it on oxsemi web
site, so I do not know how to configure the jumpers. Make sure that the card
jumpers are set to enable 128 byte FIFO size on the PCI UART. If there is no
jumper for this, that is good. 

The measured baud rate from your time test is much slower than the target
rate of 9600 bps. Your measured transmit time of 425 seconds for 51200 bytes
suggests that the port is actually running at about 1200 bps instead of 9600
bps. The base_baud is shown by setserial to be set at 3125000, so to make
the actual rate 8 times higher suggests a base_baud value of about 390625,
which I did not expect. It is a very strange base_baud number. Check to see
if the card has a jumper to select between an oscillator crystal and a
packaged oscillator, like the 16C954 evaluation card has. If the card is
equipped like this, move the jumper to select the 1.8432 MHz oscillator. I
think you may have a 25.0 MHz oscillator selected. That would divide down
with a prescalar value of 4 to 6.25 MHz, which is 16 times 390625, the
measured base_baud. I could be wrong ... Perhaps it is a 6.250 MHz
oscillator and the prescalar is 1, which is how the 952 comes out of reset. 

The "rs port monitor (single)" log message that you are getting during
operation is probably caused by using the "set_multiport" option with
setserial. Do *not* set any multiport options for this UART. "multiport" is
only for cards that have a card level pending interrupt register, not for
all cards that have more than one port. 

If the corresponding entry for your card in the pci_boards array is correct,
there is no need to touch the port with setserial at all. 

For the next test, change the pci_boards array entry at serial.c:4341 (ver
5.05) so it looks like this:

        {       PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
                PCI_ANY_ID, PCI_ANY_ID,
                SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE , 2, 115200 },

This adds the base table flag so the second port is found at the second BAR,
as specified by the datasheet. Perhaps this was the source of the autoconfig
failure? If you cannot change the oscillator frequency to 1.8432 MHz, you
can change the base_baud value in the entry from 115200 to 390625 just to
see if it works. Please do *not* change the port options with setserial
before you test it. 

Please run the time test again to see what the actual baud rate is:

	dd ibs=512 count=100 < /dev/zero | cat > /dev/ttyS4

It should take about 53 seconds at 9600 bps. 

If anybody out there monitoring the list has one of these cards working, we
would both like to hear from you. 

Good luck,
Ed Vance

-----Original Message-----
From: alexis raynaud [mailto:araynaud@alphalink.fr]
Sent: Wednesday, February 27, 2002 12:24 AM
To: 'Ed Vance'
Subject: RE: Problem to use a Oxford semiconductor Intelligent DUAL
Channe l UA RT (OX16PCI952)


Hi Ed, thank a lot

the vendor is Oxford Semiconductor (www.oxsemi.com) and the model card a
OX16PCI952

the "setserial -a /dev/ttyS4" gives 

	/dev/ttyS4, Line 4, UART: 16950/954, Port: 0xfc78, IRQ: 10
	      Baud_base: 3125000, close_delay: 50, divisor: 0
		closing_wait: 3000
		Flags: spd_normal skip_test

and the "tty -a < /dev/ttyS4" gives
	speed 9600 baud; rows 0; columns 0; line = 0;
	intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol =
<undef>; eol2 = <undef>; start = ^Q; stop = ^S; 		susp =
^Z; rprnt = ^R; werase = ^W; lnext = ^V;
	flush = ^O; min = 1; time = 0;
	-parenb -parodd cs8 hupcl -cstopb cread clocal -crtscts
	-ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr
icrnl ixon -ixoff -iuclc -ixany -imaxbel
	opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0
tab0 bs0 vt0 ff0
	isig icanon iexten echo echoe echok -echonl -noflsh -xcase
-tostop -echoprt echoctl echoke


Your test take 7mn05s


And what do you know about "setserial set_multiport"
What are the signification of the options "port_monitor", "port1",
"mask1" and "match1"


BR




Hi Alexis,

The 1.8432 MHz frequency is the "standard" frequency for PC UARTs.
That's a
good thing. The "autoconfig failed" message is not a good thing. 

Since you corrected the #define for the 16PCI952 UART, the 5.0.5 driver
should be matching your card with the following entry at serial.c:4341:

        {       PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
                PCI_ANY_ID, PCI_ANY_ID,
                SPCI_FL_BASE0 , 2, 115200 }, 

Which looks correct. 

I just tried a quick test with an unmodified 5.0.5c (later) driver with
my
954 chip and the autoconfig succeeds and it sets the proper divisor
(12). 

I will setup a 5.0.5 serial driver and see what happens with my 954
chip. 

What vendor and model is your serial card with the 952 UART on it?

Please send me the output of the following two commands:

	setserial -a /dev/ttyS4
	stty -a < /dev/ttyS4

Please time the following command. It should take 53 seconds at 9600
bps:

	dd ibs=512 count=100 < /dev/zero | cat > /dev/ttyS4

Thanks for the additional info.
Ed Vance

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
