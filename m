Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRDHWqw>; Sun, 8 Apr 2001 18:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbRDHWqb>; Sun, 8 Apr 2001 18:46:31 -0400
Received: from [195.224.53.219] ([195.224.53.219]:14720 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S131246AbRDHWq3>;
	Sun, 8 Apr 2001 18:46:29 -0400
Date: Sun, 08 Apr 2001 23:46:21 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Sources of entropy - /dev/random problem for network servers
Message-ID: <1457842476.986773581@[195.224.237.69]>
X-Mailer: Mulberry/2.1.0a4 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In debugging why my (unloaded) IMAP server takes many seconds
to open folders, I discovered what looks like a problem
in 2.4's feeding of entropy into /dev/random. When there
is insufficient entropy in the random number generator,
reading from /dev/random blocks for several seconds. /dev/random
is used (correctly) for crytographic key verification.

Entropy comes from 4 sources it seems: Keyboard, Mouse, Disk I/O
and IRQs.

The machine in question is locked in a data center (can't be
the only one) and thus sees none of the former two. IDE Entropy
comes from executed IDE commands. The disk is physically largely
inactive due to caching. But there's plenty of network traffic
which should generate IRQs.

However, only 3 drivers in drivers/net actually set
SA_SAMPLE_RANDOM when calling request_irq(). I believe
all of them should. And indeed this fixed the problem for
me using an eepro100().

The following patch fixes eepro100.c - others can be
patched similarly.

--
Alex Bligh

/usr/src/linux# diff -C3 drivers/net/eepro100.c{.keep,}
*** drivers/net/eepro100.c.keep Tue Feb 13 21:15:05 2001
--- drivers/net/eepro100.c      Sun Apr  8 22:17:00 2001
***************
*** 923,929 ****
        sp->in_interrupt = 0;

        /* .. we can safely take handler calls during init. */
!       retval = request_irq(dev->irq, &speedo_interrupt, SA_SHIRQ, 
dev->name, dev);
        if (retval) {
                MOD_DEC_USE_COUNT;
                return retval;
--- 923,929 ----
        sp->in_interrupt = 0;

        /* .. we can safely take handler calls during init. */
!       retval = request_irq(dev->irq, &speedo_interrupt, SA_SHIRQ | 
SA_SAMPLE_RANDOM, dev->name, dev);
        if (retval) {
                MOD_DEC_USE_COUNT;
                return retval;

[ENDS]
