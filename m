Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRAOE1g>; Sun, 14 Jan 2001 23:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131519AbRAOE10>; Sun, 14 Jan 2001 23:27:26 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:45558 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S131248AbRAOE1Q>;
	Sun, 14 Jan 2001 23:27:16 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Christian Daudt <csd@redback.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 compilation error 
In-Reply-To: Your message of "Fri, 05 Jan 2001 10:58:07 -0800."
             <3A56193F.F90BE100@redback.com> 
Date: Mon, 15 Jan 2001 15:26:56 +1100
Message-Id: <E14I1EQ-0001RD-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3A56193F.F90BE100@redback.com> you write:
> I have attached my .config file. I'm not currently subscribed to this
> mailing list so pls email me directly with any questions.

Hi Christian,

	Thanks for the bug report.  Please try the enclosed patch,
which is pending for 2.4.1.

Cheers,
Rusty.
--
http://linux.conf.au The Linux conference Australia needed.

diff -urN -I \$.*\$ -X /tmp/kerndiff.ObwPZl --minimal linux-2.4.0-official/net/ipv4/netfilter/Config.in working-2.4.0/net/ipv4/netfilter/Config.in
--- linux-2.4.0-official/net/ipv4/netfilter/Config.in	Tue Mar 28 04:35:56 2000
+++ working-2.4.0/net/ipv4/netfilter/Config.in	Sun Jan  7 16:48:59 2001
@@ -37,11 +37,20 @@
   fi
 
   if [ "$CONFIG_IP_NF_CONNTRACK" != "n" ]; then
-    dep_tristate '  Full NAT' CONFIG_IP_NF_NAT $CONFIG_IP_NF_IPTABLES 
+    dep_tristate '  Full NAT' CONFIG_IP_NF_NAT $CONFIG_IP_NF_IPTABLES $CONFIG_IP_NF_CONNTRACK
     if [ "$CONFIG_IP_NF_NAT" != "n" ]; then
       define_bool CONFIG_IP_NF_NAT_NEEDED y
       dep_tristate '    MASQUERADE target support' CONFIG_IP_NF_TARGET_MASQUERADE $CONFIG_IP_NF_NAT
       dep_tristate '    REDIRECT target support' CONFIG_IP_NF_TARGET_REDIRECT $CONFIG_IP_NF_NAT
+      # If they want FTP, set to $CONFIG_IP_NF_NAT (m or y), 
+      # or $CONFIG_IP_NF_FTP (m or y), whichever is weaker.  Argh.
+      if [ "$CONFIG_IP_NF_FTP" = "m" ]; then
+	define_tristate CONFIG_IP_NF_NAT_FTP m
+      else
+	if [ "$CONFIG_IP_NF_FTP" = "y" ]; then
+	  define_tristate CONFIG_IP_NF_NAT_FTP $CONFIG_IP_NF_NAT
+	fi
+      fi
     fi
   fi
 
diff -urN -I \$.*\$ -X /tmp/kerndiff.ObwPZl --minimal linux-2.4.0-official/net/ipv4/netfilter/Makefile working-2.4.0/net/ipv4/netfilter/Makefile
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
