Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275291AbRJARBb>; Mon, 1 Oct 2001 13:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275290AbRJARBR>; Mon, 1 Oct 2001 13:01:17 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:54794 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S275289AbRJARA5>; Mon, 1 Oct 2001 13:00:57 -0400
Message-ID: <3BB8A09F.DAFE41B3@osdlab.org>
Date: Mon, 01 Oct 2001 09:58:07 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <Pine.LNX.4.21.0109261635190.957-100000@freak.distro.conectiva> <Pine.LNX.4.33.0109270746150.1679-100000@localhost.localdomain> <20010928010819.A434@turbolinux.com>
Content-Type: multipart/mixed;
 boundary="------------00741BC33BCD832C57A99F68"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------00741BC33BCD832C57A99F68
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andreas Dilger wrote:
> 
> A few minor changes to the code, after testing it a bit locally (note that I
> am using kernel patch C1):
> 
> First, a patch to change the MAC address kernel parameter to be in the
> standard XX:XX:XX:XX:XX:XX form, instead of separate bytes.  It also
> fixes the output of the IP addresses to be unsigned ints.  Isn't there
> a function in the kernel to format IP addresses for output already?

Not quite for formatting, but NIPQUAD(ipaddr) passes 4 octets of IP
address to <anywhere>.

Here's a patch/replacement for the IP address printing in the
netconsole
kernel module, using NIPQUAD().  Against netconsole version C2.

BTW, in linux/include/linux/kernel.h, isn't HIPQUAD() totally useless
(and also unused)?  It looks very little-endian-specific.
Well, it can be used on little-endian systems if the ipaddr is
in host-order.

~Randy
--------------00741BC33BCD832C57A99F68
Content-Type: text/plain; charset=us-ascii;
 name="netcon-ipaddr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netcon-ipaddr.patch"

--- linux/drivers/net/netconsole.c.save	Mon Oct  1 07:43:31 2001
+++ linux/drivers/net/netconsole.c	Mon Oct  1 09:28:57 2001
@@ -263,25 +263,20 @@
 		printk(KERN_ERR "netconsole: network device %s is not an IP protocol device, aborting.\n", dev);
 		return -1;
 	}
-	source_ip = ntohl(in_dev->ifa_list->ifa_local);
+	source_ip = in_dev->ifa_list->ifa_local;
 	if (!source_ip) {
 		printk(KERN_ERR "netconsole: network device %s has no local address, aborting.\n", dev);
 		return -1;
 	}
-#define IP(x) ((char *)&source_ip)[x]
-	printk(KERN_INFO "netconsole: using source IP %i.%i.%i.%i\n",
-		IP(3), IP(2), IP(1), IP(0));
-#undef IP
-	source_ip = htonl(source_ip);
+	printk(KERN_INFO "netconsole: using source IP %u.%u.%u.%u\n", NIPQUAD(source_ip));
+
+	target_ip = htonl(target_ip);
 	if (!target_ip) {
 		printk(KERN_ERR "netconsole: target_ip parameter not specified, aborting.\n");
 		return -1;
 	}
-#define IP(x) ((char *)&target_ip)[x]
-	printk(KERN_INFO "netconsole: using target IP %i.%i.%i.%i\n",
-		IP(3), IP(2), IP(1), IP(0));
-#undef IP
-	target_ip = htonl(target_ip);
+	printk(KERN_INFO "netconsole: using target IP %u.%u.%u.%u\n", NIPQUAD(target_ip));
+
 	if (!source_port) {
 		printk(KERN_ERR "netconsole: source_port parameter not specified, aborting.\n");
 		return -1;

--------------00741BC33BCD832C57A99F68--

