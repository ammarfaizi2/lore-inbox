Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312930AbSDBVOX>; Tue, 2 Apr 2002 16:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312931AbSDBVOO>; Tue, 2 Apr 2002 16:14:14 -0500
Received: from relay1.mentorg.com ([192.94.38.42]:19161 "EHLO
	relay1.mentorg.com") by vger.kernel.org with ESMTP
	id <S312930AbSDBVOD>; Tue, 2 Apr 2002 16:14:03 -0500
From: Aaron Baer <judah@opusnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 3c574_cs driver interrupt dropped errors?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 02 Apr 2002 13:13:17 -0800
Message-Id: <1017781997.5510.6.camel@laptop>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Google sure isn't turning up much detailed information about this so I
thought I'd see if anyone else here has seen this error before. 

(I've seen this with 2.4.17 and 2.4.18 currently running 2.4.18+preempt)

I'm getting a lot of this in /var/log/messages

Mar 26 11:37:52 laptop kernel: eth0: interrupt(s) dropped!
Mar 26 11:49:14 laptop kernel: eth0: interrupt(s) dropped!
Mar 26 11:52:47 laptop kernel: eth0: interrupt(s) dropped!
Mar 26 11:55:22 laptop kernel: eth0: interrupt(s) dropped!


it's a 3Com 572/574 Fast Ethernet card using the 3c574_cs.o driver

the man page says this, which makes sense:

eth#: interrupt(s) dropped!
Indicates that the driver did not receive an interrupt notification for
some reason. The driver will poll the card (with a significant
performance penalty) if the problem persists. The most likely cause is
an interrupt conflict and/or host bridge configuration problem.

because the source code says this,
(/usr/src/linux/drivers/net/pcmcia/3c574_cs.c)

<snip>
    /* Check for pending interrupt with expired latency timer: with
       this, we can limp along even if the interrupt is blocked */
    if ((inw(ioaddr + EL3_STATUS) & IntLatch) &&
                (inb(ioaddr + Timer) == 0xff)) {
                if (!lp->fast_poll)
                        printk(KERN_INFO "%s: interrupt(s) dropped!\n",
dev->name);
                el3_interrupt(dev->irq, lp, NULL);
                lp->fast_poll = HZ;
    }
</snip>



And I've tried multiple interrupts by manipulating
/etc/pcmcia/config.opts

Making sure that the irq's used do not conflict with anything in
/proc/interrupts

Yet I still see this problem. Anyone have any idea what might be going
on here?

Thanks,
A-

-- 
----
Aaron Baer
judah@opusnet.com
http://www.cat.pdx.edu/~baera/
