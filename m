Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130331AbQLRKcW>; Mon, 18 Dec 2000 05:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130490AbQLRKcN>; Mon, 18 Dec 2000 05:32:13 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:16877 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130331AbQLRKcJ>; Mon, 18 Dec 2000 05:32:09 -0500
Message-ID: <3A3DE163.5AC30492@uow.edu.au>
Date: Mon, 18 Dec 2000 21:05:23 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Illgner <fillg1@web.de>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Problem with 3c59x and 3C905B
In-Reply-To: <JDEJLKPAIGJAKBJPIALIIEKOCBAA.fillg1@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Illgner wrote:
> 
> Hi folks,

Hello, Michael.  Good problem report.  You've done this before.

> ...
> Dec 17 19:44:48 ganerc kernel: Full duplex capable

Uh-oh.  Someone has set the `full duplex' bit in your
EEPROM.  Bit 15, word 0x0d.

>...
> Dec 17 19:59:15 ganerc kernel: eth0: MII #24 status 786d, link partner
> capability 40a1

40a1: the link partner is advertising only 10/100 half duplex.

> , setting half-duplex.

heh.  The driver lies.

> ...
>  MAC settings: full-duplex.

But vortex-diag doesn't.  You're running full-duplex.

> ...
> EEPROM contents (64 words, offset 0):
>  0x000: 0010 5ad8 25f1 9055 c579 0036 5051 6d50
>  0x008: 2971 0000 0010 5ad8 25f1 8010 0000 0022
                                   ^
                                  ^^^
> ...
> Options: force full-duplex.

And here is why - it's that EEPROM bit.

> ...
> Any idea what is going wrong here ?

You need to clear that bit - then the driver will run half-duplex.
If you have the 3com DOS-based config tool you can probably do
it with that.  Alternatively, see if you can get vortex-diag
(http://www.scyld.com/diag/) to do it - I find vortex-diag's
EEPROM writing a bit tricky to use.  So be careful to save the
output of `vortex-diag -ee' as a backup first.

You can probably kludge it in the driver with:

    /* Extract our information from the EEPROM data. */
    vp->info1 = eeprom[13];
+   vp->info1 &= ~0x8000;
    vp->info2 = eeprom[15];


Working out why your switch isn't talking full-duplex would
probably make things work too, but it's not a fix.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
