Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263184AbTDBXNZ>; Wed, 2 Apr 2003 18:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263185AbTDBXNZ>; Wed, 2 Apr 2003 18:13:25 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:15340 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S263184AbTDBXNY>;
	Wed, 2 Apr 2003 18:13:24 -0500
To: <linux-kernel@vger.kernel.org>
Subject: ISA vs PCI interrupt handling
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 03 Apr 2003 01:20:45 +0200
Message-ID: <m3n0j8lc4y.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A simple question: there are drivers for ISA and PCI devices. The IRQ
handlers are registered with request_irq(flags = 0) or
request_irq(SA_SHIRQ) for PCI.

In both cases, the device raises an IRQ line and the handler is called.
Does the handler have to make sure the device has lowered the IRQ?
I mean, in situation where the handler terminates with the IRQ line
being still active, will the handler be called again, or will the
driver deadlock? Does is behave differently on ISA and PCI?


Many network drivers use something like this:

static void
net_rx(struct net_device *dev)
{
        int boguscount = 10;
        do {
                do_something();
        } while (--boguscount);
}

Will such an IRQ handler work correctly after boguscount reaches 0?
Or is it just a protection against runaway devices, and it's normal
that they die from it (possibly recovering through a timer)?


My experiments with ISA devices show that after the handler terminates
without i.e. handling all requests, the IRQ line is stuck at +5V
(= logical "active" level) and the handler isn't called anymore.

Or does that mean the IRQ is edge-triggered, and the handler is being
called just once a low-to-high edge is detected?
-- 
Krzysztof Halasa
Network Administrator
