Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271899AbRH2EKV>; Wed, 29 Aug 2001 00:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271900AbRH2EKM>; Wed, 29 Aug 2001 00:10:12 -0400
Received: from digger1.defence.gov.au ([203.5.217.4]:20986 "EHLO
	digger1.defence.gov.au") by vger.kernel.org with ESMTP
	id <S271899AbRH2EJy>; Wed, 29 Aug 2001 00:09:54 -0400
From: Ian Dall <Ian.Dall@dsto.defence.gov.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15244.27087.313164.737903@gargle.gargle.HOWL>
Date: Wed, 29 Aug 2001 13:34:31 +0930
To: linux-kernel@vger.kernel.org
Subject: IPCONFIG fails for BOOTP
X-Mailer: VM 6.92 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version 2.4.8-ac9

I am attempting to set up a linux based xterm. The kernel loads
but times out attempting to get ipaddresses etc in ipconfig.
The following are defined in "include/linux/autoconf.h":

#define CONFIG_IP_PNP 1
#define CONFIG_IP_PNP_DHCP 1
#define CONFIG_IP_PNP_BOOTP 1
#undef  CONFIG_IP_PNP_RARP


A few printk's latter and it seems that the problem is in ic_bootp_recv()
around line 843:

#ifdef IPCONFIG_DEBUG
		printk("DHCP: Got message type %d\n", mt);
#endif

		switch (mt) {
		    case DHCPOFFER:

			 [.....]

		    default:
			/* Urque.  Forget it*/
			ic_myaddr = INADDR_NONE;
			ic_servaddr = INADDR_NONE;
			goto drop;
		}

At this point we could be receiving either DHCP *or* BOOTP extensions.
The code to handle the BOOTP extension follows, but is never executed
because of the "goto drop" in the default case for handling dhcp packets.
If the kernel were compiled without DHCP this problem would go away.

There are two possibilities to fix this. One is to fall through to the
bootp case instead of going to drop, or maybe fold the bootp code into
the default case of the switch statement. The only problem then seems to
be how to conditionalize the DHCP support.

Ian
