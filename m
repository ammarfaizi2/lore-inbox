Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbVAKVIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVAKVIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbVAKVHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:07:45 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:49331 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262836AbVAKVGw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:06:52 -0500
Subject: [PATCH] missing dependency for drivers/net/tun.c
From: Steve French <smfltc@us.ibm.com>
To: maxk@qualcomm.com, linux-kernel@vger.kernel.org
Cc: underley@underley.eu.org
Content-Type: multipart/mixed; boundary="=-haeYdBlFrhztqGnfrFAh"
Organization: IBM - Linux Technology Center
Message-Id: <1105477572.12905.16.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Jan 2005 15:06:12 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-haeYdBlFrhztqGnfrFAh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

drivers/net/tun.c has a missing dependency on enabling the crc32
libraries in kernel config.   With tun enabled and crc32 disabled "make
bzImage" (the linking step) fails. For example:

drivers/built-in.o(.text+0x656f1): In function `add_multi':
linux-2.5cifs/drivers/net/tun.c:112: undefined reference to `crc32_le'
drivers/built-in.o(.text+0x656f9):linux-2.5cifs/drivers/net/tun.c:112:
undefined reference to `bitreverse'

Line 112:

	        int bit_nr = ether_crc(ETH_ALEN, addr) >> 26;

is a call to the ether_crc macro which maps to the bitreverse function
which is only exported if you enable:
	library functions -> CRC32 functions 
in kernel config.  The following would fix it.




--=-haeYdBlFrhztqGnfrFAh
Content-Disposition: attachment; filename=tun-config.patch
Content-Type: text/plain; name=tun-config.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- drivers/net/Kconfig.old	2005-01-11 14:59:51.540023800 -0600
+++ drivers/net/Kconfig	2005-01-11 15:00:48.126421360 -0600
@@ -84,6 +84,7 @@
 config TUN
 	tristate "Universal TUN/TAP device driver support"
 	depends on NETDEVICES
+	select CRC32
 	---help---
 	  TUN/TAP provides packet reception and transmission for user space
 	  programs.  It can be viewed as a simple Point-to-Point or Ethernet

--=-haeYdBlFrhztqGnfrFAh--

