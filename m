Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131741AbRCOSQb>; Thu, 15 Mar 2001 13:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131748AbRCOSQV>; Thu, 15 Mar 2001 13:16:21 -0500
Received: from colorfullife.com ([216.156.138.34]:53514 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131741AbRCOSQM>;
	Thu, 15 Mar 2001 13:16:12 -0500
Message-ID: <005b01c0ad7c$00274f20$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <sampsa@netsonic.fi>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Performance is weird (fwd)
Date: Thu, 15 Mar 2001 19:08:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One difference between idle and a running user space app is that the
kernel->user space return path checks for pending softirqs, but the ide
thread doesn't.

Perhaps cpu_idle() should also check for pending softirq's before
hlt'ing?

idle thread is running.
* hw interrupt
* * hw interrupt handler
* * * packet arrives
* * * softirq marked
* * hw interrupt handler returns
* do_softirq
* * net_rx called
* * * an hw interrupt interrupts net_rx
* * * * a second packet arrives, softirq marked again.
* * * hw interrupt returns
* * net_rx returns
* do_softirq notices that net_rx is queued again, but doesn't process
    it immediately (otherwise it would cause an endless loop)
* hw interrupt returns
idle thread sleeps again.
!! one packet is waiting unprocessed

What about adding if(softirq_active...) do_softirq() into default_idle?
--
    Manfred


