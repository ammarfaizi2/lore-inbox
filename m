Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132675AbRC2JCQ>; Thu, 29 Mar 2001 04:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132673AbRC2JCG>; Thu, 29 Mar 2001 04:02:06 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:2317 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP
	id <S132670AbRC2JB5>; Thu, 29 Mar 2001 04:01:57 -0500
Message-ID: <3AC2F567.8EC0F775@nbase.co.il>
Date: Thu, 29 Mar 2001 10:42:15 +0200
From: Eran Mann <eran@nbase.co.il>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert-Velisav MICIOVICI <roby@dexter.allieddomecq.ro>
CC: linux-kernel@vger.kernel.org,
   Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: [PATCH] Re: [patch] Re: 2.4.3-pre8: IPX not building
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The improved patch below should fix it. This additional problem only
showed up when IPX was built into the kernel (non modular).
If you don't want to revert the previous patch and apply this one you
can simply change 
net/ipx/af_ipx line 126 from:
static int sysctl_ipx_pprop_broadcasting = 1;

to:
int sysctl_ipx_pprop_broadcasting = 1;

and then make bzImage again.
 
Robert-Velisav MICIOVICI <roby@dexter.allieddomecq.ro> wrote:
>
> Sorry to bother but it seems that the patchlet is still not good
> enough... problems at linkage or something:
>
<SNIP>
> net/network.o(.data+0x5f04): undefined reference to
> `sysctl_ipx_pprop_broadcasting'
> make: *** [vmlinux] Error 1
> [root@bigfoot linux-2.4.3-pre8]#

--- linux-2.4.3pre8.orig/net/ipx/af_ipx.c	Thu Mar 29 10:27:29 2001
+++ linux-2.4.3pre8/net/ipx/af_ipx.c	Thu Mar 29 10:22:59 2001
@@ -123,7 +123,7 @@
 static unsigned char ipxcfg_max_hops = 16;
 static char ipxcfg_auto_select_primary;
 static char ipxcfg_auto_create_interfaces;
-static int sysctl_ipx_pprop_broadcasting = 1;
+int sysctl_ipx_pprop_broadcasting = 1;
 
 /* Global Variables */
 static struct datalink_proto *p8022_datalink;
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
