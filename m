Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129506AbRCWFIl>; Fri, 23 Mar 2001 00:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129509AbRCWFIb>; Fri, 23 Mar 2001 00:08:31 -0500
Received: from barry.mail.mindspring.net ([207.69.200.25]:39223 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129506AbRCWFIT>; Fri, 23 Mar 2001 00:08:19 -0500
Message-ID: <012301c0b357$3d29cc50$1601a8c0@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: <linux-kernel@vger.kernel.org>
Subject: Can't get serial.c to work with Xircom Cardbus Ethernet+Modem
Date: Fri, 23 Mar 2001 00:08:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I saw a discussion on this list about this problem earlier, but could not
find that it had actually been resolved.

With the removal of serial_cb from the 2.4.3pre kernels I can no longer use
the modem of my Xircom adapter.  According to the posts in the other thread
serial.c should now provide this functionality, however it still does not,
at least for me.

The thread seemed to come to the conclusion that this was caused because the
serial driver only looks for PCI devices of class SERIAL and not MODEM.  I
tried the patch shown there for the 5.05 serial driver but it still doesn't
find the serial interface on my Xircom 10/100 Ethernet+56K Modem combo card.

I'm pretty sure the issue is not caused by the problem above, because as far
as I can tell the modem on the adapter does present itself as a PCI SERIAL
class device as shown by the following lspci output:

[root@iso-2146-l1 ttsig]# /sbin/lspci
02:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
02:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03)

[root@iso-2146-l1 ttsig]# /sbin/lspci -n
02:00.0 Class 0200: 115d:0003 (rev 03)
02:00.1 Class 0700: 115d:0103 (rev 03)

[root@iso-2146-l1 ttsig]# /sbin/lspci -v
02:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
        Subsystem: Xircom Cardbus Ethernet 10/100
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at 1800 [size=128]
        Memory at 14800000 (32-bit, non-prefetchable) [size=2K]
        Memory at 14800800 (32-bit, non-prefetchable) [size=2K]
        Expansion ROM at 14400000 [size=16K]
        Capabilities: [dc] Power Management version 1

02:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03)
(prog-if
 02 [16550])
        Subsystem: Xircom CBEM56G-100 Ethernet + 56k Modem
        Flags: medium devsel, IRQ 11
        I/O ports at 1880 [size=8]
        Memory at 14801000 (32-bit, non-prefetchable) [size=2K]
        Memory at 14801800 (32-bit, non-prefetchable) [size=2K]
        Expansion ROM at 14404000 [size=16K]
        Capabilities: [dc] Power Management version 1

I'm pretty sure that Class 0700 is the proper class for a PCI serial device.
The serial_cb driver from 2.4.2 always recognized this device properly and
set it up as /dev/ttyS1 using IO 0x1880 and IRQ 11.  It showed under
setserial as a follows:

/dev/ttyS1, UART: 16550A, Port: 0x1880, IRQ: 11

Now with serial.c it doesn't even get reported, I get the following when I
load serial.c:

Serial driver version 5.05.SA (2000-09-14) with MANY_PORTS MULTIPORT
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A

I know the version doesn't show as 5.05A, but I applied the patch by hand
and left off that part.  I'm pretty sure the patch is irrelavent since the
device does show up as a true PCI SERIAL Class device.

Any ideas?  I may look at it more tomorrow.  For now I'm back to using
serial_cb which still works fine (even though that apparently suprises many
people).

Later,
Tom


