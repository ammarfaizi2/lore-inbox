Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280240AbRJaO1I>; Wed, 31 Oct 2001 09:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280236AbRJaO06>; Wed, 31 Oct 2001 09:26:58 -0500
Received: from oyster.morinfr.org ([62.4.22.234]:18312 "EHLO
	oyster.morinfr.org") by vger.kernel.org with ESMTP
	id <S280237AbRJaO0p>; Wed, 31 Oct 2001 09:26:45 -0500
Date: Wed, 31 Oct 2001 15:27:17 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] TCP ECN bits and TCP_RESERVED_BITS macro
Message-ID: <20011031152717.A25584@morinfr.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

As most people here know, RFC3168 adds two new bits to the TCP header
(ECE and CWR). Those were reserved in RFC793 (standard for TCP).

Since RFC3168 is an proposed standard and ECN is now used widely on
Linux systems, I'd like to suggest the modification of the
TCP_RESERVED_BITS. This change seems logical wrt

include/linux/tcp.h the tcphdr struct :
    __u16   doff:4,
	        res1:4,
	        cwr:1,  
	        ece:1,

This change is pretty harmless, since, this macro is used in

1) include/net/tcp_ecn.h. I've patched the related part even if it would
have work without. It is just cleaner.

2) netfilter: 
 - in the LOG target, it won't break them. I'll submit patches
   to netfilter-devel to display TCP ECN bits just like any other TCP flags
   (which will ease the LOG readings)
 - In the unclean target where the current value breaks the module.

Patch against 2.4.14-pre6


diff -uNr linux/include/linux/tcp.h linux-new-tcprb/include/linux/tcp.h
--- linux/include/linux/tcp.h	Sat Apr 28 00:48:20 2001
+++ linux-new-tcprb/include/linux/tcp.h	Wed Oct 31 14:51:40 2001
@@ -110,7 +110,7 @@
 	TCP_FLAG_RST = __constant_htonl(0x00040000), 
 	TCP_FLAG_SYN = __constant_htonl(0x00020000), 
 	TCP_FLAG_FIN = __constant_htonl(0x00010000),
-	TCP_RESERVED_BITS = __constant_htonl(0x0FC00000),
+	TCP_RESERVED_BITS = __constant_htonl(0x0F000000),
 	TCP_DATA_OFFSET = __constant_htonl(0xF0000000)
 }; 
 
diff -uNr linux/include/net/tcp_ecn.h linux-new-tcprb/include/net/tcp_ecn.h
--- linux/include/net/tcp_ecn.h	Wed Oct 31 14:57:53 2001
+++ linux-new-tcprb/include/net/tcp_ecn.h	Wed Oct 31 14:50:46 2001
@@ -3,7 +3,7 @@
 
 #include <net/inet_ecn.h>
 
-#define TCP_HP_BITS (~(TCP_RESERVED_BITS|TCP_FLAG_PSH)|TCP_FLAG_ECE|TCP_FLAG_CWR)
+#define TCP_HP_BITS (~(TCP_RESERVED_BITS|TCP_FLAG_PSH))
 
 #define	TCP_ECN_OK		1
 #define TCP_ECN_QUEUE_CWR	2


All comments welcome.

-- 
Guillaume Morin <guillaume@morinfr.org>

         Do you worry that you're not liked ? How long till you break
                                (Our Lady Peace)
