Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272774AbRIMXRR>; Thu, 13 Sep 2001 19:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272797AbRIMXRH>; Thu, 13 Sep 2001 19:17:07 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:26619 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S272774AbRIMXQ4>;
	Thu, 13 Sep 2001 19:16:56 -0400
Date: Thu, 13 Sep 2001 16:17:07 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: Warning : Linux-IrDA patches on the way...
Message-ID: <20010913161707.A7470@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	This is this time of the year where I clean-up my hard drive
and dump a pile of IrDA patches on Linus and Alan for kernel
inclusion. Sorry for the massive spam...
	Dag, the maintainer of the IrDA stack, is very busy, so he
gave me explicit authorisation to do it :
http://www.pasta.cs.uit.no/pipermail/linux-irda/2001-September/003114.html

	The process will be similar to what worked last time. I've
made some fresh patches against kernel-2.4.10-pre8, each focused, well
defined and well tested (they have been submitted on the Linux-IrDA
mailing list a couple of times). Each will come in a subsequent
e-mail, as per Linus requirement.
	Linus, Alan : if the patch can't be applied to ht kernel,
please explain me why...

	Have fun...

	Jean

------------------------------------------------

	This is an overview of the patches to come :

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir248_sk_free_2.diff :
--------------------
	o [CORRECT] Fix socket memory leak (leak struct sock on each socket)
	o [CORRECT] Cleanup init/destroy socket code
		- (kfree -> sk_free, skb_queue_purge, ...)
	o [FEATURE] Cleanup comments & debugging code

ir247_ias_fix_max.diff :
----------------------
	o [CRITICA] Check overflow in string duplicate code in IAS/IAP
		- It was only done (more or less) if DEBUG was enabled
	o [CORRECT] Fix deadlock on legal large OCT_SEQ IAP replies
	o [CORRECT] Increase max IAS attribute size for IrDA compliance

ir248_disco_fixes_4.diff :
------------------------
	o [CORRECT] Fix corner case where getting stuck in LMP state machine
	o [CORRECT] Fix rare deadlock in LAP secondary state machine
	o [FEATURE] Bypass LMP state machine when propagating discovery event
		- Fix many case where event is discarded and not passed up
		- Reduce overhead on a critical path
	o [FEATURE] Properly do expiry when discovery is not active

ir248_irnet_nodelay.diff :
------------------------
	o [FEATURE] Use DEV_ADDR_ANY instead of 0
	o [FEATURE] Remove the 3 second delay from connection setup

ir247_lap_keepalive.diff :
------------------------
	<Apply after ir248_disco_fixes_4.diff to avoid "offset X lines">
	o [FEATURE] Add "lap_keepalive_time" sysctl
		- Control how long LAP stay alive after last socket closed
		- Allow to test the secondary disconnect path
		- Allow to trigger LMP deadlocks fixed one month ago

ir249_irda-usb_reorg.diff :
-------------------------
	<Big patch, but not so many changes>
	<Both mailing list will drop this patch because of its size>
	<Apply to kernel-2.4.10-pre8 or later, include fixes from that kernel>
	o [FEATURE] Reorganise the code logically, make it more maintainable
		- At HP, we say that it has been "re-invented"
	o [FEATURE] Lot's of comments, make it easier to read the code
		- And also remove some misleading comments
	o [CORRECT] Don't push same URB twice to USB stack (speed in KICK_TX)
	o [FEATURE] Defered timeout handling. It's just safer.
	o [FEATURE] Use the USB_ZERO_PACKET flag to avoid ugly KICK_TX code
		- Safer, leaner and correct : it's a standard USB feature.
		- Can revert back to old ugly way with a #define
		- Please fix uhci.c and usb-ohci.c to handle USB_ZERO_PACKET
	o [FEATURE] Reduce latency by not doing LAP turnaround in software
		- May be re-enabled with a dongle option
	o [FEATURE] Parse USB endpoint properly, get irq endpoint
	o [FEATURE] Set USB transfer flags safely

ir249_hw_name.diff :
------------------
	<Patch has been around for 6 months, I keep updating with new drivers>
	<Hard dependency on ir249_irda-usb_reorg.diff>
	o [FEATURE] Show net-device name in /proc/net/irda/irlap
		- Allow user to match /proc info with output of ifconfig
	o [FEATURE] Show hardware name and port in /proc/net/irda/irlap
		- Allow user to match /proc info to real IrDA dongle hw
