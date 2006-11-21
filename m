Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031322AbWKUTFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031322AbWKUTFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031320AbWKUTFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:05:16 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:6534 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1031322AbWKUTFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:05:14 -0500
Date: Tue, 21 Nov 2006 22:01:50 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Matthew Frost <artusemrys@sbcglobal.net>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Paul Sokolovsky <pmiscml@gmail.com>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re: Where did find_bus() go in 2.6.18?
Message-ID: <20061121190150.GA25754@2ka.mipt.ru>
References: <1154868495.20061120003437@gmail.com> <4560ECAF.1030901@gmail.com> <664994303.20061120021314@gmail.com> <1164011675.31358.566.camel@laptopd505.fenrus.org> <4563457B.2070806@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <4563457B.2070806@sbcglobal.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 21 Nov 2006 22:01:50 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 12:29:15PM -0600, Matthew Frost (artusemrys@sbcglobal.net) wrote:
> So you have nested drivers.  The bottom driver (w1/slaves/w1_ds2760.c) talks to
> the hardware, and the top driver (misc/h2200_battery.c) interprets the output.
> You're dealing with a Dallas 1-Wire Bus protocol to talk to your battery
> management chip, which is a DS2760 High-Precision Li+ Battery Monitor.  You're
> telling us that h2200_battery uses find_bus() to locate the w1 bus and then the
> devices on that bus, so that it can use w1_ds2760 to read the chip.  So what is
> hanging you up here is that your top-level driver can't find the bus that the
> chip is on; once it can, everything should work?
> 
> The specific code:
> 
> void
> h2200_battery_probe_work(void *data)
> {
> 	struct bus_type *bus;
> 
> 	/* Get the battery w1 slave device. */
> 	bus = find_bus("w1");
> 	if (bus)
> 		ds2760_dev = bus_find_device(bus, NULL, NULL,
> 					     h2200_battery_match_callback);
> 
> 	if (!ds2760_dev) {
> 		/* No DS2760 device found; try again later. */
> 		queue_delayed_work(probe_q, &probe_work, HZ * 5);
> 		return;
> 	}
> }
> 
> What we need to do is help you find a better way to locate and identify a w1 device.
> 
> (cc: E. Polyakov for the w1 expertise)

Hello.

If find_bus() will not be resurrected, I can export w1_bus_type or
create special helpers to directly access w1 bus master devices.
But in that case there is no need to have all driver model in w1
subsystem at all...

> Matt

-- 
	Evgeniy Polyakov
