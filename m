Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbTLWLw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 06:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbTLWLwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 06:52:55 -0500
Received: from [195.62.234.69] ([195.62.234.69]:62177 "EHLO
	mail.nectarine.info") by vger.kernel.org with ESMTP id S265112AbTLWLwv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 06:52:51 -0500
Message-ID: <3FE82CB2.7020606@nectarine.info>
Date: Tue, 23 Dec 2003 12:53:22 +0100
From: Giacomo Di Ciocco <admin@nectarine.info>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: petr.novak@i.cz
Cc: isdn4linux@listserv.isdn4linux.de
Subject: [PATCH] 2.4.23 drivers/isdn/hisax/w6692.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
i'am having a problem with this isdn card, sometimes, when the 
connection is working hard i get the message "W6692 IRQ LOOP"
and the isdn system gets blocked, i have to reboot the box to get it to 
work again (statically compiled driver).
I take a look to the driver's source and i found the reset procedure 
used in this case is a lot different from the procedure used in the function
resetW6692 so, without too much knowledge of kernel programming nor C, 
i've copied the code from the resetW6692 function to this point and i 
got it working.

00:0a.0 Network controller: Dynalink IS64PH ISDN Adapter
        Subsystem: Winbond Electronics Corp: Unknown device 6692
        Flags: medium devsel, IRQ 11
        Memory at ffbce000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at f800 [size=256]


562,565c562,582
<       if (!icnt) {
<               printk(KERN_WARNING "W6692 IRQ LOOP\n");
<               cs->writeW6692(cs, W_IMASK, 0xff);
<       }
---
 >         if (!icnt) {
 >               printk(KERN_WARNING "W6692 IRQ LOOP\n");
 >               cs->writeW6692(cs, W_D_CTL, W_D_CTL_SRST);
 >               cs->writeW6692(cs, W_D_CTL, 0x00);
 >               cs->writeW6692(cs, W_IMASK, 0xff);
 >               cs->writeW6692(cs, W_D_SAM, 0xff);
 >               cs->writeW6692(cs, W_D_TAM, 0xff);
 >               cs->writeW6692(cs, W_D_EXIM, 0x00);
 >               cs->writeW6692(cs, W_D_MODE, W_D_MODE_RACT);
 >               cs->writeW6692(cs, W_IMASK, 0x18);
 >               if (cs->subtyp == W6692_USR) {
 >                       /* seems that USR implemented some power 
control features
 >                         * Pin 79 is connected to the oscilator 
circuit so we
 >                        * have to handle it here
 >                        */
 >                       cs->writeW6692(cs, W_PCTL, 0x80);
 >                       cs->writeW6692(cs, W_XDATA, 0x00);
 >               }
 >
 >               }

