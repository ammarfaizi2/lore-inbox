Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTJHDJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 23:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbTJHDJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 23:09:54 -0400
Received: from [209.77.185.85] ([209.77.185.85]:40358 "EHLO lumo.pacujo.net")
	by vger.kernel.org with ESMTP id S261176AbTJHDJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 23:09:53 -0400
To: linux-kernel@vger.kernel.org
Subject: NAPI Race?
CC: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
CC: Jamal Hadi Salim <hadi@cyberus.ca>
CC: Robert Olsson <Robert.Olsson@data.slu.se>
Date: 07 Oct 2003 20:07:31 -0700
Message-ID: <m3smm4qvf0.fsf@lumo.pacujo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Marko Rauhamaa <marko@pacujo.net>
X-Delivery-Agent: TMDA/0.82 (Needles)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It looks to me like net_rx_action() might suffer from a race, which in
turn might explain some weirdness in my driver test results.

Here's the essence of the function from net/core/dev.c:

net_rx_action()
{
        local_irq_disable();
        while (!list_empty(&queue->poll_list)) {
                local_irq_enable();
                /* do stuff */
                local_irq_disable();
        }
        local_irq_enable();
}

Say I receive a packet. net_rx_action() processes it in the while loop
and reenables interrupts. But just before net_rx_action() returns, I
receive another packet, and __netif_rx_schedule() gets called from the
driver. Then the soft irq is raised from within itself. If I'm not
interrupted for some other reason, the packet will get processed only at
the next jiffie when the soft irq is invoked again.

Am I mistaken?

As an aside, it looks also as though the design might technically allow
the network driver to starve the CPU (the very situation NAPI was
designed to protect against). If I receive a new packet always right
after returning from net_rx_action(), the interrupt will cause the soft
irq to be executed immediately. It's true that this scenario would
require a very accurately calibrated packet stream, but in my business
that just might take place.


Marko

-- 
Marko Rauhamaa      mailto:marko@pacujo.net     http://pacujo.net/marko/
