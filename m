Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282463AbRKZULo>; Mon, 26 Nov 2001 15:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282472AbRKZUKk>; Mon, 26 Nov 2001 15:10:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16135 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S282479AbRKZUJZ>; Mon, 26 Nov 2001 15:09:25 -0500
Date: Mon, 26 Nov 2001 21:09:26 +0100
From: Jan Kara <jack@ucw.cz>
To: marcelo@atrey.karlin.mff.cuni.cz
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Compile fix in network
Message-ID: <20011126210926.B25797@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  I've found out that it's impossible to compile kernel without
networking support (problem appeared in 2.4.15). Patch which
fixes problem (just remove some includes which aren't really
needed) is attached.

							Honza

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="network-syms.diff"

diff -ru -X /home/jack/.kerndiffexclude linux-2.4.15/net/core/datagram.c linux-2.4.15-pre7-newquota/net/core/datagram.c
--- linux-2.4.15/net/core/datagram.c	Thu Apr 12 21:11:39 2001
+++ linux-2.4.15-pre7-newquota/net/core/datagram.c	Fri Nov 23 22:57:12 2001
@@ -41,8 +41,7 @@
 #include <net/ip.h>
 #include <net/protocol.h>
 #include <net/route.h>
-#include <net/tcp.h>
-#include <net/udp.h>
+#include <net/checksum.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
 
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.15/net/core/scm.c linux-2.4.15-pre7-newquota/net/core/scm.c
--- linux-2.4.15/net/core/scm.c	Fri Nov 10 00:57:53 2000
+++ linux-2.4.15-pre7-newquota/net/core/scm.c	Fri Nov 23 22:57:27 2001
@@ -29,8 +29,6 @@
 #include <linux/inet.h>
 #include <net/ip.h>
 #include <net/protocol.h>
-#include <net/tcp.h>
-#include <net/udp.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
 #include <net/scm.h>
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.15/net/core/skbuff.c linux-2.4.15-pre7-newquota/net/core/skbuff.c
--- linux-2.4.15/net/core/skbuff.c	Tue Aug  7 17:30:50 2001
+++ linux-2.4.15-pre7-newquota/net/core/skbuff.c	Fri Nov 23 22:54:27 2001
@@ -55,8 +55,7 @@
 #include <net/ip.h>
 #include <net/protocol.h>
 #include <net/dst.h>
-#include <net/tcp.h>
-#include <net/udp.h>
+#include <net/checksum.h>
 #include <net/sock.h>
 
 #include <asm/uaccess.h>
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.15/net/core/sock.c linux-2.4.15-pre7-newquota/net/core/sock.c
--- linux-2.4.15/net/core/sock.c	Sat Jul 28 21:12:38 2001
+++ linux-2.4.15-pre7-newquota/net/core/sock.c	Fri Nov 23 23:58:07 2001
@@ -114,17 +114,13 @@
 #include <asm/system.h>
 
 #include <linux/inet.h>
+#include <linux/ip.h>
 #include <linux/netdevice.h>
-#include <net/ip.h>
 #include <net/protocol.h>
-#include <net/arp.h>
 #include <net/route.h>
-#include <net/tcp.h>
-#include <net/udp.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
 #include <net/raw.h>
-#include <net/icmp.h>
 #include <linux/ipsec.h>
 
 #ifdef CONFIG_FILTER
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.15/net/ipv4/ipconfig.c linux-2.4.15-pre7-newquota/net/ipv4/ipconfig.c
--- linux-2.4.15/net/ipv4/ipconfig.c	Wed Nov 21 00:47:27 2001
+++ linux-2.4.15-pre7-newquota/net/ipv4/ipconfig.c	Wed Nov 21 21:36:24 2001
@@ -1144,9 +1144,7 @@
 	 */
 	if (ic_myaddr == INADDR_NONE ||
 #ifdef CONFIG_ROOT_NFS
-	    (MAJOR(ROOT_DEV) == UNNAMED_MAJOR
-	     && root_server_addr == INADDR_NONE
-	     && ic_servaddr == INADDR_NONE) ||
+	    (root_server_addr == INADDR_NONE && ic_servaddr == INADDR_NONE) ||
 #endif
 	    ic_first_dev->next) {
 #ifdef IPCONFIG_DYNAMIC
diff -ru -X /home/jack/.kerndiffexclude linux-2.4.15/net/socket.c linux-2.4.15-pre7-newquota/net/socket.c
--- linux-2.4.15/net/socket.c	Wed Oct 17 23:38:28 2001
+++ linux-2.4.15-pre7-newquota/net/socket.c	Fri Nov 23 23:57:40 2001
@@ -82,8 +82,6 @@
 #include <linux/inet.h>
 #include <net/ip.h>
 #include <net/sock.h>
-#include <net/tcp.h>
-#include <net/udp.h>
 #include <net/scm.h>
 #include <linux/netfilter.h>
 

--6TrnltStXW4iwmi0--
