Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbRGXOsP>; Tue, 24 Jul 2001 10:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267546AbRGXOsF>; Tue, 24 Jul 2001 10:48:05 -0400
Received: from hera.cwi.nl ([192.16.191.8]:18863 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264375AbRGXOry>;
	Tue, 24 Jul 2001 10:47:54 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 24 Jul 2001 14:47:56 GMT
Message-Id: <200107241447.OAA07015@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, net-tools@lina.inka.de, philb@gnu.org
Subject: ifconfig and SIOCSIFADDR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I just noticed that the command

	ifconfig eth1 netmask 255.255.255.0 broadcast 10.0.0.255 10.0.0.150

(with ifconfig from net-tools-1.60)
results in a netmask of 255.0.0.0, which is wrong in my situation.

Why does ifconfig ignore the explicitly given netmask?
Because it does SIOCSIFNETMASK, then SIOCSIFBRDADDR, then SIOCSIFADDR,
and the last ioctl destroys the information set by the previous two.
	
I consider this a kernel bug, but the code has been in the kernel
for a long time. In 2.2 and 2.4 it is (devinet.c):

	case SIOCSIFADDR:
		...
		if (!(dev->flags&IFF_POINTOPOINT)) {
			ifa->ifa_prefixlen = inet_abc_len(ifa->ifa_address);
			ifa->ifa_mask = inet_make_mask(ifa->ifa_prefixlen);
			if ((dev->flags&IFF_BROADCAST) && ifa->ifa_prefixlen < 31)
				ifa->ifa_broadcast = ifa->ifa_address|~ifa->ifa_mask;
		} else {
			ifa->ifa_prefixlen = 32;
			ifa->ifa_mask = inet_make_mask(32);
		}

and in 2.0 it is (net/core/dev.c):

	case SIOCSIFADDR:
		...
		/* This is naughty. When net-032e comes out It wants moving
		   into the net032 code not the kernel. Till then it can sit
		   here (SIGH) */
		if (!dev->pa_mask)
			dev->pa_mask = ip_get_mask(dev->pa_addr);
		if (!dev->pa_brdaddr)
			dev->pa_brdaddr = dev->pa_addr | ~dev->pa_mask;

that is, 2.0 and earlier will only (reluctantly) set netmask and
broadcast address when it was not set already.

Probably things should be corrected both in the kernel and in ifconfig:
SIOCSIFADDR should not change netmask and broadcast address,
and ifconfig should assume that SIOCSIFADDR may be destructive
and hence wait with setting netmask and broadcast address
until after the SIOCSIFADDR.

Andries

	
