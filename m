Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263772AbRFIEeb>; Sat, 9 Jun 2001 00:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263780AbRFIEeV>; Sat, 9 Jun 2001 00:34:21 -0400
Received: from sr1.terra.com.br ([200.176.2.216]:2566 "EHLO sr1.terra.com.br")
	by vger.kernel.org with ESMTP id <S263772AbRFIEeJ>;
	Sat, 9 Jun 2001 00:34:09 -0400
Message-ID: <3B21A790.63F428CE@zaz.com.br>
Date: Sat, 09 Jun 2001 01:35:28 -0300
From: Paulo Afonso Graner Fessel <pafessel@zaz.com.br>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: pt-BR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: hollis@austin.rr.com, torben.mathiasen@compaq.com
Subject: Probable endianess problem in TLAN driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm trying to use a Compaq Dual Netteligent card in a Apple Macintosh
Performa 6360. Basically, my purpose is to use this system as a more
powerful firewall than that the one I have today.

To make things shorter, the TLAN driver on its atual incarnation does
not work in PowerPC machines. It isn't detected on 2.2 kernel unless I
activate it with setpci; OTOH, it is detected on 2.4, but does not work.
I get messages like "TLAN: Adaptor Error: 0x180005" every time I try to
ping other hosts; when this message appears, the link is reset and goes
online again. Also I get occasional panics when I try to ping the
machine from other machines in my Ethernet network. I've noticed also
that the board statistics don't change: all values are zero, always.

Physical media disruption was ruled out, since mii-diag reported that
the link was up and I could verify this on the leds of the board and of
the hub I use; both reported link up for the connection. mii-diag also
detects correctly when the link is up or down.

As I'm really no kernel hacker, I started looking for help. I've found
Hollis of openprojects.org (CC:ed in this message), and we begun to
think what could be the problem. I've generated backtraces of the panics
I've got, but there wasn't nothing really conclusive. So Hollis
inspected the code and found lines like these:

	host_int = inw( dev->base_addr + TLAN_HOST_INT );
        outw( host_int, dev->base_addr + TLAN_HOST_INT );

or

	outl( virt_to_bus( tail_list ), dev->base_addr + TLAN_CH_PARM
);                
	outl( TLAN_HC_GO, dev->base_addr + TLAN_HOST_CMD );

He said me that these funtions don't address the endianess question, and
sent me a patch. He said that this probably wouldn't work, but I've
decided to give a try anyway. Here is the patch:

--- tlan.c.old  Thu Jun  7 21:24:25 2001
+++ tlan.c      Thu Jun  7 21:37:42 2001
@@ -172,6 +172,12 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 
+#if defined(__powerpc__)
+#define inw(addr)                      le32_to_cpu(inw(addr))
+#define inl(addr)                      le32_to_cpu(inl(addr))
+#define outw(val, addr)                outw(cpu_to_le32(val), addr)
+#define outl(val, addr)                outl(cpu_to_le32(val), addr)
+#endif

It's very clear (even to me) what it does: it takes into account the
big-endianess of PowerPC for out[l,w] and in[l,w]. I've applied this
patch, and for my surprise it brought some good effects. The error
messages stopped, and the machine does not crash anymore. Also, I'm now
able to see changes on the statistics of the board, even if they are
completely bogus nowadays. It's a real change for good but for one
thing: I still can't communicate with the other computers on my network.

I've tried to contact Torben, but oddly seems that he is not around. The
driver page in tlan.kernel.dk has not been updated since October 2000,
and there is no recent activity either on the TLAN driver mailing list
or in the new project page on Compaq
(http://linuxalpha.compaq.com/sourceforge/project/?group_id=12). Again,
as I'm no kernel hacker, I'd like to ask the linux-kernel list for help
(even if to point me to sources about correcting this problem).

Please answer directly to me, as I'm not subscribed to linux-kernel.

TIA,

Paulo Fessel
