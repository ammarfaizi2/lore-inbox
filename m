Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292728AbSBZTRB>; Tue, 26 Feb 2002 14:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292727AbSBZTQx>; Tue, 26 Feb 2002 14:16:53 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:45583 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S292725AbSBZTQg> convert rfc822-to-8bit; Tue, 26 Feb 2002 14:16:36 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76BB@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'alexis raynaud'" <araynaud@alphalink.fr>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Problem to use a Oxford semiconductor Intelligent DUAL Channe
	 l UA RT (OX16PCI952)
Date: Tue, 26 Feb 2002 11:17:17 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexis,

The 1.8432 MHz frequency is the "standard" frequency for PC UARTs. That's a
good thing. The "autoconfig failed" message is not a good thing. 

Since you corrected the #define for the 16PCI952 UART, the 5.0.5 driver
should be matching your card with the following entry at serial.c:4341:

        {       PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
                PCI_ANY_ID, PCI_ANY_ID,
                SPCI_FL_BASE0 , 2, 115200 }, 

Which looks correct. 

I just tried a quick test with an unmodified 5.0.5c (later) driver with my
954 chip and the autoconfig succeeds and it sets the proper divisor (12). 

I will setup a 5.0.5 serial driver and see what happens with my 954 chip. 

What vendor and model is your serial card with the 952 UART on it?

Please send me the output of the following two commands:

	setserial -a /dev/ttyS4
	stty -a < /dev/ttyS4

Please time the following command. It should take 53 seconds at 9600 bps:

	dd ibs=512 count=100 < /dev/zero | cat > /dev/ttyS4

Thanks for the additional info.
Ed Vance

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

-----Original Message-----
From: alexis raynaud [mailto:araynaud@alphalink.fr]
Sent: Tuesday, February 26, 2002 8:33 AM
To: 'Ed Vance'
Subject: RE: Problem to use a Oxford semiconductor Intelligent DUAL
Channe l UA RT (OX16PCI952)


Hi Ed Vance,

I've got some news (but not solution yet)

To answer your question the card's oscillator rate seems to be at 1.8432
MHz

Next I download the latest version of serial on the sourceforg site and
make the next modification on the sources :
	#define PCI_DEVICE_ID_OXSEMI_16PCI952 0x950A
	 	changing  to
	#define PCI_DEVICE_ID_OXSEMI_16PCI952 0x9521
and rebuilt the kernel (Linux version 2.2.20 (root@tech001) (gcc version
2.96 20000731 (Mandrake Linux 8.1 2.96-0.62mdk)) #9 Thu Feb 21 09:13:45
CET 2002)

when I insert the new module serial.o the kernel returns in the
/var/log/message
	Feb 26 16:38:09 fw kernel: Serial driver version 5.05
(2000-09-14) with MANY_PORTS MULTIPORT SHARE_IRQ 	SERIAL_PCI
enabled
	Feb 26 16:38:09 fw kernel: ttyS00 at 0x03f8 (irq = 4) is a
16550A
	Feb 26 16:38:09 fw kernel: ttyS01 at 0x02f8 (irq = 3) is a
16550A
	Feb 26 16:38:09 fw kernel: ttyS04 at port 0xfc78 (irq = 10) is a
16C950/954
	Feb 26 16:38:09 fw kernel: register_serial(): autoconfig failed

yeh it's detect my card with the good irq and port, but when I plug a
modem, ligths are blinking but the modem doesn't work at all.

I try other thing like setserial set_multiport, but I don't know what to
put for the option "port_monitor", "port1", "mask1" and "match1"


Have U any new idea ?




thanks

-----Message d'origine-----
De : Ed Vance [mailto:EdV@macrolink.com]
Envoyé : vendredi 15 février 2002 20:17
À : 'alexis raynaud'
Cc : 'linux-serial@vger.kernel.org'; 'linux-kernel'
Objet : RE: Problem to use a Oxford semiconductor Intelligent DUAL
Channe l UA RT (OX16PCI952)


Hi Alexis,

There is no matching entry for this board in the serial driver's
pci_boards
table. The 9521 device code is a new one. The driver is looking for 950A
for
16PCI952 UART.

Since you are getting data output, I suspect your card's oscillator does
not
match the driver's default. What is the highest supported baud rate that
this card? (the rate you get when UART divisor reg is = 1) Default is
115200
bps. If your card's oscillator rate is not 1.8432 MHz, then the default
baud
rate calculation will be wrong. 

If you can find out the maximum baud rate, try adjusting the it for the
port
with setserial's baud_base parameter. Two common base baud rates for 95X
based cards are 921600 and 3125000. 

If you cannot be sure what the card's baud rate clock base is, then
calculate the actual data rate by cat'ing a large file out the port and
timing it. Calculate the bytes per second and multiply by the number of
bit-times for your async config (usually 10, 1 start, 8 data, 1 stop).
This
will tell you for sure if the base_baud value needs to be adjusted.

let me know what happens.

Good luck,
Ed Vance

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

-----Original Message-----
From: alexis raynaud [mailto:araynaud@alphalink.fr]
Sent: Friday, February 15, 2002 7:42 AM
To: 'linux-serial@vger.kernel.org'
Subject: Problem to use a Oxford semiconductor Intelligent DUAL Channel
UA RT (OX16PCI952)


Hello, I hope U can help me...

here is my configuration :

I have a Intel motherboard AL440LX, with a PII 400 + a OX16PCI952.
My system is a RedHat 7.1 seawolf (and I also try on a Mandrake 8.1)
with a kernel 2.4.2-2.
Here are my version of serial's rpm :
		statserial-1.1-20
		setserial-2.17-2

Here is the lspci -v :
	00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX
Host bridge (rev 03)
	        Flags: bus master, medium devsel, latency 32
	        Memory at f8000000 (32-bit, prefetchable) [size=64M]
	        Capabilities: [a0] AGP version 1.0
	
	00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP
bridge (rev 03) (prog-if 00 [Normal decode])
	        Flags: bus master, 66Mhz, medium devsel, latency 64
	        Bus: primary=00, secondary=01, subordinate=01,
sec-latency=64
	
	00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
	        Flags: bus master, medium devsel, latency 0
	
	00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev
01) (prog-if 80 [Master])
	        Flags: bus master, medium devsel, latency 64
	        I/O ports at fc90 [size=16]
	
	00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev
01) (prog-if 00 [UHCI])
	        Flags: bus master, medium devsel, latency 64, IRQ 9
	        I/O ports at fcc0 [size=32]

	00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
	        Flags: medium devsel, IRQ 9
	
	00:0d.0 VGA compatible controller: ATI Technologies Inc 3D Rage
I/II 215GT [Mach64 GT] (rev 41) (prog-if 00 [VGA])
	        Subsystem: ATI Technologies Inc 3D Rage I/II 215GT
[Mach64 GT]
	        Flags: bus master, stepping, medium devsel, latency 66
	        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	        I/O ports at f800 [size=256]
	        Memory at fedff000 (32-bit, non-prefetchable) [size=4K]
	        Expansion ROM at <unassigned> [disabled] [size=128K]
	
	00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139 (rev 10)
	        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	        Flags: bus master, medium devsel, latency 64, IRQ 11
	        I/O ports at f400 [size=256]
	        Memory at fedfec00 (32-bit, non-prefetchable) [size=256]
	        Capabilities: [50] Power Management version 2
	        Capabilities: [60] Vital Product Data

	00:0f.0 Serial controller: Oxford Semiconductor Ltd: Unknown
device 9521 (prog-if 06 [16950])
	        Subsystem: Oxford Semiconductor Ltd: Unknown device 0001
	        Flags: medium devsel, IRQ 10
	        I/O ports at fc78 [size=8]
	        I/O ports at fc88 [size=8]
	        I/O ports at fce0 [size=32]
	        Memory at fedfc000 (32-bit, non-prefetchable) [size=4K]
	        Memory at fedfd000 (32-bit, non-prefetchable) [size=4K]
	        Capabilities: [40] Power Management version 1
	
	00:0f.1 Parallel controller: Oxford Semiconductor Ltd: Unknown
device 9523 (prog-if 01 [BiDir])
	        Subsystem: Oxford Semiconductor Ltd: Unknown device 0001
	        Flags: medium devsel, IRQ 10
	        I/O ports at fc68 [size=8]
	        I/O ports at fc74 [size=4]
	        I/O ports at fca0 [size=32]
	        Memory at fedfb000 (32-bit, non-prefetchable) [size=4K]
	        Capabilities: [40] Power Management version 1


I also make a :	setserial /dev/ttyS2 port 0xfc78 irq 10 that returns 

	/dev/ttyS2, UART: 16950/954, Port: 0xfc78, IRQ: 10
witch seems to be good

but when I connect a modem (UsRobotics 56k FaxModem ext)on the Serial
port and run the commande "wvdialconf", 
I can seen the modem light blinking (Rd, Sd) but not detect it
here is the result of the wvdialconf : 

	ttyS2<*1>: ATQ0 V1 E1 -- ATQ0 V1 E1
	ttyS2<*1>: ATQ0 V1 E1 -- ATQ0 V1 E1
	ttyS2<*1>: ATQ0 V1 E1 -- ATQ0 V1 E1
	ttyS2<*1>: nothing.
	ttyS0<*1>: ATQ0 V1 E1 -- ATQ0 V1 E1 -- ATQ0 V1 E1 -- nothing.
	ttyS1<*1>: ATQ0 V1 E1 -- ATQ0 V1 E1 -- ATQ0 V1 E1 -- nothing.
	Port Scan<*1>: S3   S4   S5   S6   S7   S8   S9   S10
	Port Scan<*1>: S11  S12  S13  S14  S15  S16  S17  S18
	Port Scan<*1>: S19  S20  S21  S22  S23  S24  S25  S26
	Port Scan<*1>: S27  S28  S29  S30  S31  SA0  SA1  SA2
	Port Scan<*1>: SC0  SC1  SC2  SC3  SI0  SI1  SI2  SI3
	Port Scan<*1>: SI4  SI5  SI6  SI7  SI8  SI9  SI10 SI11
	Port Scan<*1>: SI12 SI13 SI14 SI15 SR0  SR1  SR2  SR3
	Port Scan<*1>: SR4  SR5  SR6  SR7  SR8  SR9  SR10 SR11
	Port Scan<*1>: SR12 SR13 SR14 SR15 SR16 SR17 SR18 SR19
	Port Scan<*1>: SR20 SR21 SR22 SR23 SR24 SR25 SR26 SR27
	Port Scan<*1>: SR28 SR29 SR30 SR31 SR256 SR257 SR258 SR259
	Port Scan<*1>: SR260 SR261 SR262 SR263 SR264 SR265 SR266 SR267
	Port Scan<*1>: SR268 SR269 SR270 SR271 SR272 SR273 SR274 SR275
	Port Scan<*1>: SR276 SR277 SR278 SR279 SR280 SR281 SR282 SR283
	Port Scan<*1>: SR284 SR285 SR286 SR287

In advance, 
Thank a lot 

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
