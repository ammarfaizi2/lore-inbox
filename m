Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWGQSxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWGQSxd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWGQSxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:53:33 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:41949 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751145AbWGQSxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:53:32 -0400
Date: Mon, 17 Jul 2006 20:53:30 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
Cc: keir@xensource.com, Tony Lindgren <tony@atomide.com>, zach@vmware.com,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: kernel/timer.c: next_timer_interrupt() strange/buggy(?) code (2.6.18-rc1-mm2)
Message-ID: <20060717185330.GA32264@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

next_timer_interrupt() contains the following gem:

        /* Check tv2-tv5. */
        varray[0] = &base->tv2;
        varray[1] = &base->tv3;
        varray[2] = &base->tv4;
        varray[3] = &base->tv5;
        for (i = 0; i < 4; i++) {
                j = INDEX(i);
                do {
                        if (list_empty(varray[i]->vec + j)) {
                                j = (j + 1) & TVN_MASK;
                                continue;
                        }
                        list_for_each_entry(nte, varray[i]->vec + j, entry)
                                if (time_before(nte->expires, expires))
                                        expires = nte->expires;
                        if (j < (INDEX(i)) && i < 3)
                                list = varray[i + 1]->vec + (INDEX(i + 1));
                        goto found;
                } while (j != (INDEX(i)));
        }
found:
        if (list) {



Excuse me, but why do we have a while loop here if the last instruction in
the while loop is a straight "goto found"?
(a "continue" simply continue:s the loop without checking the loop condition
at the bottom, right?)


Few lines above there's similar code:

        /* Look for timer events in tv1. */
        j = base->timer_jiffies & TVR_MASK;
        do {
                list_for_each_entry(nte, base->tv1.vec + j, entry) {
                        expires = nte->expires;
                        if (j < (base->timer_jiffies & TVR_MASK))
                                list = base->tv2.vec + (INDEX(0));
                        goto found;
                }
                j = (j + 1) & TVR_MASK;
        } while (j != (base->timer_jiffies & TVR_MASK));


However in this case now we process *one* list only, so the "goto found"
should be ok since we don't need to iterate through the multiple tv2-tv5 lists
as in the other potentially buggy loop.

Also, is the base->tv1.vec vs. base->tv2.vec difference above ok?

Possibly I'm too dense while reading this code, though...

Andreas Mohr
