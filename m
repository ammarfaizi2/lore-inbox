Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129801AbQJ1KxN>; Sat, 28 Oct 2000 06:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbQJ1KxE>; Sat, 28 Oct 2000 06:53:04 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:17285 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129801AbQJ1Kwr>; Sat, 28 Oct 2000 06:52:47 -0400
Message-ID: <39FAAFF2.200E1860@uow.edu.au>
Date: Sat, 28 Oct 2000 21:52:34 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen E. Clark" <sclark46@gte.net>
CC: lk <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: RTNL assert
In-Reply-To: <39FA4968.62588272@gte.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen E. Clark" wrote:
> 
> When I configure in Tunneling I get the following error message. Is this
> normal? This with 2.4test9pre5
> 
> GRE over IPv4 tunneling driver
> RTNL: assertion failed at devinet.c(775):inetdev_event

The rtnetlink lock needs to be taken around
register_netdevice().  There should be a function
which does these three common steps, but there isn't.


--- linux-2.4.0-test10-pre5/net/ipv4/ip_gre.c	Sat Sep  9 16:19:30 2000
+++ linux-akpm/net/ipv4/ip_gre.c	Sat Oct 28 21:44:23 2000
@@ -1266,7 +1266,9 @@
 #ifdef MODULE
 	register_netdev(&ipgre_fb_tunnel_dev);
 #else
+	rtnl_lock();
 	register_netdevice(&ipgre_fb_tunnel_dev);
+	rtnl_unlock();
 #endif
 
 	inet_add_protocol(&ipgre_protocol);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
