Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271383AbRHOT0G>; Wed, 15 Aug 2001 15:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271381AbRHOTZ5>; Wed, 15 Aug 2001 15:25:57 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:57558 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271379AbRHOTZq>;
	Wed, 15 Aug 2001 15:25:46 -0400
Date: Wed, 15 Aug 2001 20:25:56 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Steve Hill <steve@navaho.co.uk>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: /dev/random in 2.4.6
Message-ID: <125898493.997907155@[169.254.45.213]>
In-Reply-To: <Pine.LNX.4.21.0108151605180.2107-100000@sorbus.navaho>
In-Reply-To: <Pine.LNX.4.21.0108151605180.2107-100000@sorbus.navaho>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve,

> Until recently I've been using the 2.2.16 kernel on Cobalt Qube 3's, but
> I've just upgraded to 2.4.6.  Since there's no mouse, keyboard, etc, there
> isn't much entropy data.  I had no problem getting plenty of data from
> /dev/random under 2.2, but under 2.4.6 there seems to be a distinct lack
> of data - it takes absolutely ages to extract about 256 bytes from it
> (whereas under 2.2 it was relatively quick).  Has there been a major
> change in the way the random number generator works under 2.4?

Some network drivers generate entropy on network interrupts, some
don't. Apparently this inconsistent state is the way people want
to keep it.

If you want to add entropy on network interrupts, look for the line
in your driver which does a request_irq, and | in SA_SAMPLE_RANDOM
to the flags value.

I'd prefer a single /proc/ entry to turn entropy on from ALL network
devices for precisely the reason you state (SCSI means no IDE
entity either), even if its off by default for ALL network
devices for paranoia reasons, but there seems to be some religious
issue at play which means the state currently depends on which
brand of network card you have.

Example 'fix:' (and do this in reverse to remove entropy from
network interrupts if you are paranoid) below.

(tabs probably broken in the text below but easier to do it manually
anyway)

--- eepro100.c~ Tue Feb 13 21:15:05 2001
+++ eepro100.c  Sun Apr  8 22:17:00 2001
@@ -923,7 +923,7 @@
        sp->in_interrupt = 0;

        /* .. we can safely take handler calls during init. */
-       retval = request_irq(dev->irq, &speedo_interrupt, SA_SHIRQ, 
dev->name, dev);
+       retval = request_irq(dev->irq, &speedo_interrupt, SA_SHIRQ | 
SA_SAMPLE_RANDOM, dev->name, dev);
        if (retval) {
                MOD_DEC_USE_COUNT;
                return retval;



--
Alex Bligh
