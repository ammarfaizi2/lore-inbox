Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272589AbTG1AF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272582AbTG1AFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:05:52 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:4870 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S272694AbTG0X0A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:26:00 -0400
Message-ID: <200307280140470646.1078EC67@192.168.128.16>
In-Reply-To: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Mon, 28 Jul 2003 01:40:47 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: "Bas Bloemsaat" <bloemsaa@xs4all.nl>, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org
Cc: layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2003 at 22:52 Bas Bloemsaat wrote:

>I learned from the kernel sources that any NIC receiving an ARP request
>for any local IP adress would respond to that request. Among others, that
>has the following implications:
>- when you have two NICs same ethernet segment, only one of them is used:
>they both respond to any ARP request. As only the first response is ever
>used (fasted router), only the NIC that responds first receives any
>traffic. This NIC may or may not be bound to the destination IP. It may
>not even be reachable because of iptables-rules. This also defeats a
>common form of load balancing.

I stepped into the same problems you have reported here.

There's a feature to do linux to behave like other OS and systems, called "hidden".
However it's not included into the default kernel main stream. Although IMHO IT SHOULD BE.
Here is the patch:
http://www.ssi.bg/~ja/#hidden

Extracted from http://www.linuxvirtualserver.org/docs/arp.html:
===
Linux kernel 2.0.xx doesn't do arp response on loopback alias and tunneling interfaces, it is good for the LVS cluster. However, Linux kernel 2.2.xx does all arp responses of all its IP addresses except the loopback addresses (127.0.0.0/255.0.0.0) and multicast addresses. 
===

Currently linux is the only OS those I have tried with this behaviour:

Solaris 8 -> does not send ARP reply of other interface.
Cisco -> does not send ARP reply of other interface.
Windows 2000, XP -> does not send ARP reply of other interface.
Linux 2.6.0-pre1, 2.4.20, 2.4.21 -> DOES send ARP reply of other interface


>- when you have two NICs on seperate ethernet segments, for example on a
>firewall, it is possible to probe one NIC for the IP address of the other.
>This can be used to gain information about the inside network of the
>firewall, which is a (minor) security risk. While this is not really
>practical because every IP address has to be tried, often the inside is of
>a limit range (10.x.x.x, 192.168.x.x), which makes it useful.

Yes, minor security problem arise with this _INTENTIONAL_ behaviour of linux networking.

The official approach is that you play with routing and netfilter/arpfilter to solve this _INTENTIONAL_ behaviour and make linux behave like other OS do.

The unofficial (not in the kernel main stream, reason unknow) is to use the "hidden patch".
This works using a /proc switch: /proc/sys/net/ipv4/conf/<XXX>/hidden, so it should not break anything.
However is not into the main kernel.

Regards,
Carlos Velasco


