Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293367AbSBZWck>; Tue, 26 Feb 2002 17:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292688AbSBZWca>; Tue, 26 Feb 2002 17:32:30 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:4101 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S293609AbSBZWcV>; Tue, 26 Feb 2002 17:32:21 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76BD@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'alexis raynaud'" <araynaud@alphalink.fr>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Problem to use a Oxford semiconductor Intelligent DUAL Channe
	 l UA RT (OX16PCI952)
Date: Tue, 26 Feb 2002 14:32:54 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexis,

I had another thought about the "autoconfig failed" message ...

On Tue, Feb 26, 2002 8:33 AM, alexis raynaud wrote:
> when I insert the new module serial.o the kernel returns in the
> /var/log/message
> 	Feb 26 16:38:09 fw kernel: Serial driver version 5.05
> (2000-09-14) with MANY_PORTS MULTIPORT SHARE_IRQ 	SERIAL_PCI
> enabled
> 	Feb 26 16:38:09 fw kernel: ttyS00 at 0x03f8 (irq = 4) is a
> 16550A
> 	Feb 26 16:38:09 fw kernel: ttyS01 at 0x02f8 (irq = 3) is a
> 16550A
> 	Feb 26 16:38:09 fw kernel: ttyS04 at port 0xfc78 (irq = 10) is a
> 16C950/954
> 	Feb 26 16:38:09 fw kernel: register_serial(): autoconfig failed

Please set the SERIAL_DEBUG_AUTOCONF #define in serial.c at line 129. This
will tell us if the UART is failing the loopback test at line 3658. 

I do not know why the loopback test would fail on the 16PCI952, but that is
one of only two paths through autoconfig() that leave the port type as
PORT_UNKNOWN when control returns to the caller.  To get the "autoconfig
fails" message at line 5354, which is in the dmesg output, the port type
returned by autoconfig() must be PORT_UNKNOWN.

If the loopback test passes, then it must take the "case 1:" branch at line
3677 to stay PORT_UNKNOWN or miss all of the cases, as there is no default
case in the switch. To miss the case values, serial_in() would have to
return an int with a bit set in the range of bits 8 - 13, which is supposed
to be impossible. 

If the switch runs any case but 1, then the port type will not be returned
as PORT_UNKNOWN. (I did not spot a path that later sets it back to
PORT_UNKNOWN.)

At least, the debug message will confirm or deny a failure of the loopback
test as cause of the "autoconfig failed" message.

Best regards,
Ed Vance

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
