Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263062AbTDBVL6>; Wed, 2 Apr 2003 16:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbTDBVL6>; Wed, 2 Apr 2003 16:11:58 -0500
Received: from web11307.mail.yahoo.com ([216.136.131.210]:4624 "HELO
	web11307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263062AbTDBVLr>; Wed, 2 Apr 2003 16:11:47 -0500
Message-ID: <20030402212311.69823.qmail@web11307.mail.yahoo.com>
Date: Wed, 2 Apr 2003 13:23:11 -0800 (PST)
From: Subbulu Koya <proteuskor@yahoo.com>
Subject: linux 2.4.20:Intel e1000 4.4.19 and 5.0.43 (Intel Pro1000/MT) hard lock in e1000_reset_hw
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During MAC reset(e1000_hw.c:e1000_reset_hw) my system
hard locks. I have tried the following configurations:

Software:

            Linux 2.4.20 SMP

            Intel e1000 versions 4.4.19 and 5.0.43
with SMP and with and without ANS/diagnostics

Hardware:

            Tyan S2723 Motherboatd w/ dual XEONs

            *(onboard) Intel 82545EM rev1 (Pro1000/MT)
on IRQ 48 (unshared)

            (also on board) Intel 82557/8/9 (EEPro100)
on IRQ 17 (unshared, unplugged)

 

I have traced it to the following point in the 4.4.19
code:

 

    e1000_hw.c : e1000_reset_hw(struct e1000_hw *hw)

    ...

      /* Issue a global reset to the MAC.  This will
reset the chip's

         * transmit, receive, DMA, and link units.  It
will not effect

         * the current PCI configuration.  The global
reset bit is self-

         * clearing, and should clear within a
microsecond.

         */

        DEBUGOUT("Issuing a global reset to MAC\n");

        ctrl = E1000_READ_REG(hw, CTRL);

 

        if(hw->mac_type > e1000_82543)

            E1000_WRITE_REG_IO(hw, CTRL, (ctrl |
E1000_CTRL_RST));

        else

            E1000_WRITE_REG(hw, CTRL, (ctrl |
E1000_CTRL_RST));

 

    ...

    In this case 'E1000_WRITE_REG_IO(hw, CTRL, (ctrl |
E1000_CTRL_RST));' is

    called. Then the systems continues to
msec_delay(4), at which point the

    system locks up entirely.

 

and in the 5.0.43 code:

    e1000_main.c: e1000_reset(struct e1000_adapter
*adapter)

    …

    E1000_WRITE_REG(&adapter->hw, PBA, pba);

 

    adapter->hw.fc = adapter->hw.original_fc;

    e1000_reset_hw(&adapter->hw);

   …

   In this case ‘E1000_WRITE_REG(&adapter->hw, PBA,
pba);’ is called. Then

   the system calls e1000_reset_hw, my first trace
message isn’t hit and so with

   this driver version I seem to lockup just a bit
earlier then with 4.4.19

 

In both cases e1000_reset() is being called by
e1000_down(). In order to create this problem I bring
the interface up and down once every 10seconds or so
using ifconfig.

 

Is it possible this driver isn't working properly with
the 82545EM rev 1?

Is their any additional information I can provide?

 

Thank you in advance,

/)dam.. .  . D o n ' t   S t o p

 



__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com
