Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131865AbQLPNmL>; Sat, 16 Dec 2000 08:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131886AbQLPNlw>; Sat, 16 Dec 2000 08:41:52 -0500
Received: from coruscant.franken.de ([193.174.159.226]:5892 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S131865AbQLPNlp>; Sat, 16 Dec 2000 08:41:45 -0500
Date: Sat, 16 Dec 2000 14:09:41 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, "Barry K. Nathan" <barryn@pobox.com>,
        Rusty Russell <rusty@linuxcare.com>, Marc Boucher <marc@mbsi.ca>,
        James Morris <jmorris@intercode.com.au>
Subject: Re: test13pre2 - netfilter modiles compile failure
Message-ID: <20001216140941.A7422@coruscant.gnumonks.org>
In-Reply-To: <Pine.LNX.4.10.10012160015521.11822-100000@penguin.transmeta.com> <Pine.LNX.4.10.10012160031450.11822-100000@penguin.transmeta.com> <20001216115705.A6797@coruscant.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001216115705.A6797@coruscant.gnumonks.org>; from laforge@gnumonks.org on Sat, Dec 16, 2000 at 11:57:05AM +0100
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Setting Orange, the 58th day of The Aftermath in the YOLD 3166
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2000 at 11:57:05AM +0100, Harald Welte wrote:
> 
> As no other netfilter core team member responded yet, I'm going to provide 
> a patch for the 'true library' solution.

well... the 'true library' doesn't make sense, because of the exclusiveness.
In any case there's only one instance of ip_fw_compat inside the kernel:

- ipchains compiled in (ipfwadm option vanishes in 'make menuconfig')
- ipfwadm compiled in (ipchains option vanishes in 'make menuconfig')
- ipchains module loaded: you can't load ipfwadm module
- ipfwadm module loaded: you can't load ipchains module

anyway... here is a patch, which makes the stuff compile and link in all
the combinations I've tried so far. (Please leave the comments, because
we could use them from our patch-o-matic system)

--- linux/net/ipv4/netfilter/Makefile	Sat Dec 16 11:59:05 2000
+++ linux-fwcompat/net/ipv4/netfilter/Makefile	Sat Dec 16 15:03:02 2000
@@ -14,15 +14,38 @@
 # Multipart objects.
 list-multi		:= ip_conntrack.o iptable_nat.o ipfwadm.o ipchains.o
 
-ip_conntrack-objs	:= ip_conntrack_standalone.o ip_conntrack_core.o ip_conntrack_proto_generic.o ip_conntrack_proto_tcp.o ip_conntrack_proto_udp.o ip_conntrack_proto_icmp.o
-iptable_nat-objs	:= ip_nat_standalone.o ip_nat_rule.o ip_nat_core.o ip_nat_proto_unknown.o ip_nat_proto_tcp.o ip_nat_proto_udp.o ip_nat_proto_icmp.o
-ip_nf_compat-objs	:= ipfwadm_core.o ip_fw_compat.o ip_fw_compat_redir.o ip_fw_compat_masq.o $(ip_conntrack-objs) $(iptable_nat-objs)
-ipfwadm-objs		:= ipfwadm_core.o
-ipchains-objs		:= ipchains_core.o
+# objects for the conntrack and NAT core (used by standalone and backw. compat)
+ip_nf_conntrack-objs	:= ip_conntrack_core.o ip_conntrack_proto_generic.o ip_conntrack_proto_tcp.o ip_conntrack_proto_udp.o ip_conntrack_proto_icmp.o
+ip_nf_nat-objs		:= ip_nat_core.o ip_nat_proto_unknown.o ip_nat_proto_tcp.o ip_nat_proto_udp.o ip_nat_proto_icmp.o
 
+# objects for the standalone - connection tracking / NAT
+ip_conntrack-objs	:= ip_conntrack_standalone.o $(ip_nf_conntrack-objs)
+iptable_nat-objs	:= ip_nat_standalone.o ip_nat_rule.o $(ip_nf_nat-objs)
+
+# objects for backwards compatibility mode
+ip_nf_compat-objs	:= ip_fw_compat.o ip_fw_compat_redir.o ip_fw_compat_masq.o $(ip_nf_conntrack-objs) $(ip_nf_nat-objs)
+
+ipfwadm-objs		:= $(ip_nf_compat-objs) ipfwadm_core.o
+ipchains-objs		:= $(ip_nf_compat-objs) ipchains_core.o
+
+# connection tracking
 obj-$(CONFIG_IP_NF_CONNTRACK) += ip_conntrack.o
+
+# connection tracking helpers
 obj-$(CONFIG_IP_NF_FTP) += ip_conntrack_ftp.o
+
+# NAT helpers 
+obj-$(CONFIG_IP_NF_FTP) += ip_nat_ftp.o
+
+# generic IP tables 
 obj-$(CONFIG_IP_NF_IPTABLES) += ip_tables.o
+
+# the three instances of ip_tables
+obj-$(CONFIG_IP_NF_FILTER) += iptable_filter.o
+obj-$(CONFIG_IP_NF_MANGLE) += iptable_mangle.o
+obj-$(CONFIG_IP_NF_NAT) += iptable_nat.o
+
+# matches
 obj-$(CONFIG_IP_NF_MATCH_LIMIT) += ipt_limit.o
 obj-$(CONFIG_IP_NF_MATCH_MARK) += ipt_mark.o
 obj-$(CONFIG_IP_NF_MATCH_MAC) += ipt_mac.o
@@ -31,11 +54,8 @@
 obj-$(CONFIG_IP_NF_MATCH_TOS) += ipt_tos.o
 obj-$(CONFIG_IP_NF_MATCH_STATE) += ipt_state.o
 obj-$(CONFIG_IP_NF_MATCH_UNCLEAN) += ipt_unclean.o
-obj-$(CONFIG_IP_NF_NAT) += iptable_nat.o
-obj-$(CONFIG_IP_NF_FTP) += ip_nat_ftp.o
-obj-$(CONFIG_IP_NF_FILTER) += iptable_filter.o
-obj-$(CONFIG_IP_NF_MANGLE) += iptable_mangle.o
 
+# targets
 obj-$(CONFIG_IP_NF_TARGET_REJECT) += ipt_REJECT.o
 obj-$(CONFIG_IP_NF_TARGET_MIRROR) += ipt_MIRROR.o
 obj-$(CONFIG_IP_NF_TARGET_TOS) += ipt_TOS.o
@@ -44,8 +64,10 @@
 obj-$(CONFIG_IP_NF_TARGET_REDIRECT) += ipt_REDIRECT.o
 obj-$(CONFIG_IP_NF_TARGET_LOG) += ipt_LOG.o
 
-obj-$(CONFIG_IP_NF_COMPAT_IPCHAINS) += ipchains.o ip_nf_compat.o
-obj-$(CONFIG_IP_NF_COMPAT_IPFWADM) += ipfwadm.o ip_nf_compat.o
+# backwards compatibility 
+obj-$(CONFIG_IP_NF_COMPAT_IPCHAINS) += ipchains.o
+obj-$(CONFIG_IP_NF_COMPAT_IPFWADM) += ipfwadm.o
+
 obj-$(CONFIG_IP_NF_QUEUE) += ip_queue.o
 
 include $(TOPDIR)/Rules.make
@@ -61,6 +83,3 @@
 
 ipchains.o: $(ipchains-objs)
 	$(LD) -r -o $@ $(ipchains-objs)
-
-ip_nf_compat.o: $(ip_nf_compat-objs)
-	$(LD) -r -o $@ $(ip_nf_compat-objs)

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
