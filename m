Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132418AbRCZLjB>; Mon, 26 Mar 2001 06:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132428AbRCZLim>; Mon, 26 Mar 2001 06:38:42 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:19727 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP
	id <S132419AbRCZLid>; Mon, 26 Mar 2001 06:38:33 -0500
Message-ID: <3ABF2AF3.24F31CB3@nbase.co.il>
Date: Mon, 26 Mar 2001 13:41:39 +0200
From: Eran Mann <eran@nbase.co.il>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.3pre8 - fail to compile af_ipx.c, omission from drivers/net/Makefile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently net_init.o is missing from export-objs in 
drivers/net/Makefile in kernel 2.4.3.pre8, which causes network modules
to fail to load.

Additionally, trying to compile IPX in 2.4.3pre8 results in the
following errors:
make[2]: Entering directory `/mdk/src/linux-2.4.3/net/ipx'
gcc -D__KERNEL__ -I/mdk/src/linux-2.4.3/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include
/mdk/src/linux-2.4.3/include/linux/modversions.h   -DEXPORT_SYMTAB -c
af_ipx.c
af_ipx.c: In function `ipxrtr_route_packet':
af_ipx.c:1545: warning: passing arg 4 of `sock_alloc_send_skb_R05cfeed4'
makes integer from pointer without a cast
af_ipx.c:1545: too few arguments to function
`sock_alloc_send_skb_R05cfeed4'
af_ipx.c: At top level:
af_ipx.c:2534: unknown field `sendpage' specified in initializer
af_ipx.c:2534: `sock_no_sendpage' undeclared here (not in a function)
af_ipx.c:2534: warning: excess elements in struct initializer
af_ipx.c:2534: warning: (near initialization for `ipx_dgram_ops')
make[2]: *** [af_ipx.o] Error 1
make[2]: Leaving directory `/mdk/src/linux-2.4.3/net/ipx'
make[1]: *** [_modsubdir_ipx] Error 2
make[1]: Leaving directory `/mdk/src/linux-2.4.3/net'
make: *** [_mod_net] Error 2

These patches fix the above problems:
===========================================================================
--- linux-2.4.3pre8.orig/drivers/net/Makefile	Mon Mar 26 13:16:17 2001
+++ linux/drivers/net/Makefile	Mon Mar 26 12:03:26 2001
@@ -16,7 +16,7 @@
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
 export-objs     :=	8390.o arlan.o aironet4500_core.o aironet4500_card.o
ppp_async.o \
-			ppp_generic.o slhc.o pppox.o auto_irq.o
+			ppp_generic.o slhc.o pppox.o auto_irq.o net_init.o
 
 ifeq ($(CONFIG_TULIP),y)
   obj-y += tulip/tulip.o
=============================================================================
--- linux-2.4.3pre8.orig/net/ipx/af_ipx.c	Mon Mar 26 13:17:08 2001
+++ linux/net/ipx/af_ipx.c	Mon Mar 26 13:14:52 2001
@@ -1542,7 +1542,7 @@
 	ipx_offset = intrfc->if_ipx_offset;
 	size = sizeof(struct ipxhdr) + len + ipx_offset;
 
-	skb = sock_alloc_send_skb(sk, size, noblock, &err);
+	skb = sock_alloc_send_skb(sk, size, 0, noblock, &err);
 	if (!skb)
 		goto out_put;
 
@@ -2531,7 +2531,6 @@
 	sendmsg:	ipx_sendmsg,
 	recvmsg:	ipx_recvmsg,
 	mmap:		sock_no_mmap,
-	sendpage:	sock_no_sendpage,
 };
 
 #include <linux/smp_lock.h>
