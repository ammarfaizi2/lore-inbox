Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268429AbRGXS5L>; Tue, 24 Jul 2001 14:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268431AbRGXS5B>; Tue, 24 Jul 2001 14:57:01 -0400
Received: from inway98.cdi.cz ([213.151.81.98]:30191 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S268429AbRGXS4u>;
	Tue, 24 Jul 2001 14:56:50 -0400
Posted-Date: Tue, 24 Jul 2001 20:56:44 +0200
Date: Tue, 24 Jul 2001 20:56:44 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: linux-kernel@vger.kernel.org
cc: jjciarla@raiz.uncu.edu.ar
Subject: Patch for better ip_dynaddr for 2.2.19
In-Reply-To: <Pine.LNX.4.33L.0107241521130.20326-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10107242047320.4963-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I'm sorry that it is for old 2.2.x but I have 2.2.19 router
as MASQ box for our microwave line. I setup automatic backup
via ISDN but I find that masq connections stops working when
ISDN gets dialed.
It is because routing is changed and maddr field is bad in
ip_masq struct.
There is existing solution: sysctl_ip_dynaddr. But it replaces
maddr only on connections where no reply was recieved from outside.
It is true for machine connected via diald for example but when
changing LIVE route it simply doesn't work.
I patched 3 files with very short patch. It allows you to add
4 to sysctl_ip_dynaddr flag and it skips no-reply test.
It works well now.
Patched version is bacward compatible and there is no speed
penalty (well almost).
What about 2.2.20 inclusion ? It this correct place to send patch to ?

devik

--------
diff -ru linux/net/ipv4/ip_masq.c gate2/net/ipv4/ip_masq.c
--- linux/net/ipv4/ip_masq.c	Sun Mar 25 18:37:41 2001
+++ gate2/net/ipv4/ip_masq.c	Tue Jul 24 20:05:21 2001
@@ -50,6 +50,7 @@
  *	Kai Bankett		:	do not toss other IP protos in proto_doff()
  *	Dan Kegel		:	pointed correct NAT behavior for UDP streams
  *	Julian Anastasov	:	use daddr and dport as hash keys
+ *  Martin Devera 	:	extended sysctl_ip_dynaddr functionality
  *	
  */
 
@@ -1236,9 +1237,9 @@
                  *	in this tunnel and routing iface address has changed...
                  *	 "You are welcome, diald".
                  */
-                if ( sysctl_ip_dynaddr && ms->flags & IP_MASQ_F_NO_REPLY && maddr != ms->maddr) {
-
-                        if (sysctl_ip_dynaddr > 1) {
+                if ( sysctl_ip_dynaddr && (sysctl_ip_dynaddr & 4 || 
+					ms->flags & IP_MASQ_F_NO_REPLY) && maddr != ms->maddr) {
+                        if ((sysctl_ip_dynaddr & 3) > 1) {
                                 IP_MASQ_INFO( "ip_fw_masquerade(): change masq.addr from %d.%d.%d.%d to %d.%d.%d.%d\n",
                                        NIPQUAD(ms->maddr),NIPQUAD(maddr));
                         }
@@ -1527,9 +1528,9 @@
                  *	in this tunnel and routing iface address has changed...
                  *	 "You are welcome, diald".
                  */
-                if ( sysctl_ip_dynaddr && ms->flags & IP_MASQ_F_NO_REPLY && maddr != ms->maddr) {
-
-                        if (sysctl_ip_dynaddr > 1) {
+                if ( sysctl_ip_dynaddr && (sysctl_ip_dynaddr & 4 || 
+					ms->flags & IP_MASQ_F_NO_REPLY) && maddr != ms->maddr) {
+                        if ((sysctl_ip_dynaddr & 3) > 1) {
 				IP_MASQ_INFO( "ip_fw_masq_icmp(): change masq.addr %d.%d.%d.%d to %d.%d.%d.%d",
 				       NIPQUAD(ms->maddr), NIPQUAD(maddr));
 			}
diff -ru linux/net/ipv4/tcp_ipv4.c gate2/net/ipv4/tcp_ipv4.c
--- linux/net/ipv4/tcp_ipv4.c	Sun Mar 25 18:37:41 2001
+++ gate2/net/ipv4/tcp_ipv4.c	Tue Jul 24 20:12:06 2001
@@ -1889,7 +1889,7 @@
 	}
 
 	if (new_saddr != sk->saddr) {
-		if (sysctl_ip_dynaddr > 1) {
+		if ((sysctl_ip_dynaddr & 3) > 1) {
 			printk(KERN_INFO "tcp_v4_rebuild_header(): shifting sk->saddr "
 			       "from %d.%d.%d.%d to %d.%d.%d.%d\n",
 			       NIPQUAD(sk->saddr), 
--- linux/Documentation/networking/ip_dynaddr.txt	Sun Mar 25 18:31:57 2001
+++ gate2/Documentation/networking/ip_dynaddr.txt	Tue Jul 24 20:44:42 2001
@@ -23,6 +23,12 @@
      # echo 2 > /proc/sys/net/ipv4/ip_dynaddr
   To disable (default)
      # echo 0 > /proc/sys/net/ipv4/ip_dynaddr
+  To always rewrite MASQ connections instead only when no reply
+  packet is recieved (needed to be able to change routing, for
+  example when doing backup-line) add 4 to flag, like:
+  	 # echo 5 > /proc/sys/net/ipv4/ip_dynaddr
+  or
+  	 # echo 6 > /proc/sys/net/ipv4/ip_dynaddr
 
 Enjoy!
 
---------------

