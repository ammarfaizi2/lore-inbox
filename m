Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSJ1Q4s>; Mon, 28 Oct 2002 11:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSJ1Q4s>; Mon, 28 Oct 2002 11:56:48 -0500
Received: from hera.cwi.nl ([192.16.191.8]:2976 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261370AbSJ1Q4q>;
	Mon, 28 Oct 2002 11:56:46 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 28 Oct 2002 18:02:53 +0100 (MET)
Message-Id: <UTC200210281702.g9SH2rk26154.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: psmouse.c: Lost synchronization
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I regularly see wild mouse jumps, very annoying.
At the same moment messages like

17:15:42 psmouse.c: Lost synchronization, throwing 1 bytes away.
17:15:42 psmouse.c: Lost synchronization, throwing 2 bytes away.
17:16:59 psmouse.c: Lost synchronization, throwing 2 bytes away.
17:16:59 psmouse.c: Lost synchronization, throwing 1 bytes away.
17:18:13 psmouse.c: Lost synchronization, throwing 1 bytes away.
17:18:13 psmouse.c: Lost synchronization, throwing 2 bytes away.
17:31:48 psmouse.c: Lost synchronization, throwing 1 bytes away.
17:31:48 psmouse.c: Lost synchronization, throwing 2 bytes away.
17:31:51 psmouse.c: Lost synchronization, throwing 1 bytes away.
17:31:51 psmouse.c: Lost synchronization, throwing 2 bytes away.

appear in the log.
Since packets are 3 bytes long and subsequent pairs of messages
(with the same time stamp) always throw out 3 bytes, the conclusion
is that in reality sync was never lost.
Indeed, it is only with 2.5 that this mouse has problems.

So, the test

        if (psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/20)) {
                printk(KERN_WARNING "psmouse.c: Lost synchronization, "
				    "throwing %d bytes away.\n",
		       psmouse->pktcnt);
                psmouse->pktcnt = 0;
        }

is no good. I just replaced HZ/20 by 5*HZ.

If mouse sync is really lost (which I never observed in the past ten years)
then I am quite willing to wait a moment. But it is bad when nothing
is wrong, just a slow machine, and the kernel invents and creates
the problems itself.

Andries


[This was 2.5.44.]
