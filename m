Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAFClR>; Fri, 5 Jan 2001 21:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAFClG>; Fri, 5 Jan 2001 21:41:06 -0500
Received: from linuxcare.com.au ([203.29.91.49]:43527 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129267AbRAFCky>; Fri, 5 Jan 2001 21:40:54 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: schu@schu.net
CC: linux-kernel@vger.kernel.org, rusty@linuxcare.com.au
Subject: Re: PROBLEM: 2.4.0 Kernel Fails to compile when CONFIG_IP_NF_FTP is selected 
In-Reply-To: Your message of "Fri, 05 Jan 2001 16:59:50 -0800."
             <200101060059.QAA09816@pizda.ninka.net> 
Date: Sat, 06 Jan 2001 13:40:35 +1100
Message-Id: <E14EjHY-0005jK-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200101060059.QAA09816@pizda.ninka.net> you write:
> 
> You need to enable both CONNTRACK and full NAT in your configuration.
> 
> Rusty, why doesn't the Config stuff just enforece this if it
> is necessary when enabling FTP support etc.?

Deja Vu: we've been through this before.  But someone else
fuck^H^H^H^Hfixed the makefiles recently.

CONFIG_IP_NF_FTP controls BOTH the ftp connection tracking and NAT
code.  The correct fix is below (untested, but you get the idea).

Matthew, does this fix it for you?
Rusty.
--
Hacking time.

diff -urN -I \$.*\$ -X /tmp/kerndiff.SnTZ7N --minimal linux-2.4.0-official/net/ipv4/netfilter/Config.in working-2.4.0/net/ipv4/netfilter/Config.in
--- linux-2.4.0-official/net/ipv4/netfilter/Config.in	Tue Mar 28 04:35:56 2000
+++ working-2.4.0/net/ipv4/netfilter/Config.in	Sat Jan  6 13:36:34 2001
@@ -42,6 +42,10 @@
       define_bool CONFIG_IP_NF_NAT_NEEDED y
       dep_tristate '    MASQUERADE target support' CONFIG_IP_NF_TARGET_MASQUERADE $CONFIG_IP_NF_NAT
       dep_tristate '    REDIRECT target support' CONFIG_IP_NF_TARGET_REDIRECT $CONFIG_IP_NF_NAT
+      # If they want FTP, set same as $CONFIG_IP_NF_NAT (m or y).
+      if [ "$CONFIG_IP_NF_FTP" != "n" ]; then
+	define_tristate CONFIG_IP_NF_NAT_FTP $CONFIG_IP_NF_NAT
+      fi
     fi
   fi
 
diff -urN -I \$.*\$ -X /tmp/kerndiff.SnTZ7N --minimal linux-2.4.0-official/net/ipv4/netfilter/Makefile working-2.4.0/net/ipv4/netfilter/Makefile
--- linux-2.4.0-official/net/ipv4/netfilter/Makefile	Sat Dec 30 09:07:24 2000
+++ working-2.4.0/net/ipv4/netfilter/Makefile	Sat Jan  6 13:36:25 2001
@@ -35,7 +35,7 @@
 obj-$(CONFIG_IP_NF_FTP) += ip_conntrack_ftp.o
 
 # NAT helpers 
-obj-$(CONFIG_IP_NF_FTP) += ip_nat_ftp.o
+obj-$(CONFIG_IP_NF_NAT_FTP) += ip_nat_ftp.o
 
 # generic IP tables 
 obj-$(CONFIG_IP_NF_IPTABLES) += ip_tables.o
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
