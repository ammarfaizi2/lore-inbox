Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbVKVVQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbVKVVQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbVKVVK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:10:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48799 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965201AbVKVVKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:10:11 -0500
Date: Tue, 22 Nov 2005 13:08:32 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: [patch 18/23] [PATCH] [IPV6]: Fix sending extension headers before and including routing header.
Message-ID: <20051122210832.GS28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-sending-extension-headers-before.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Based on suggestion from Masahide Nakamura <nakam@linux-ipv6.org>.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/net/ipv6.h       |    2 ++
 net/ipv6/exthdrs.c       |   19 +++++++++++++++++++
 net/ipv6/ip6_flowlabel.c |   16 ++++++----------
 net/ipv6/raw.c           |    4 +++-
 net/ipv6/udp.c           |    4 +++-
 5 files changed, 33 insertions(+), 12 deletions(-)

--- linux-2.6.14.2.orig/include/net/ipv6.h
+++ linux-2.6.14.2/include/net/ipv6.h
@@ -237,6 +237,8 @@ extern struct ipv6_txoptions *	ipv6_rene
 						   int newtype,
 						   struct ipv6_opt_hdr __user *newopt,
 						   int newoptlen);
+struct ipv6_txoptions *ipv6_fixup_options(struct ipv6_txoptions *opt_space,
+					  struct ipv6_txoptions *opt);
 
 extern int ip6_frag_nqueues;
 extern atomic_t ip6_frag_mem;
--- linux-2.6.14.2.orig/net/ipv6/exthdrs.c
+++ linux-2.6.14.2/net/ipv6/exthdrs.c
@@ -673,3 +673,22 @@ out:
 	return ERR_PTR(err);
 }
 
+struct ipv6_txoptions *ipv6_fixup_options(struct ipv6_txoptions *opt_space,
+					  struct ipv6_txoptions *opt)
+{
+	/*
+	 * ignore the dest before srcrt unless srcrt is being included.
+	 * --yoshfuji
+	 */
+	if (opt && opt->dst0opt && !opt->srcrt) {
+		if (opt_space != opt) {
+			memcpy(opt_space, opt, sizeof(*opt_space));
+			opt = opt_space;
+		}
+		opt->opt_nflen -= ipv6_optlen(opt->dst0opt);
+		opt->dst0opt = NULL;
+	}
+
+	return opt;
+}
+
--- linux-2.6.14.2.orig/net/ipv6/ip6_flowlabel.c
+++ linux-2.6.14.2/net/ipv6/ip6_flowlabel.c
@@ -225,20 +225,16 @@ struct ipv6_txoptions *fl6_merge_options
 					 struct ip6_flowlabel * fl,
 					 struct ipv6_txoptions * fopt)
 {
-	struct ipv6_txoptions * fl_opt = fl ? fl->opt : NULL;
-
-	if (fopt == NULL || fopt->opt_flen == 0) {
-		if (!fl_opt || !fl_opt->dst0opt || fl_opt->srcrt)
-			return fl_opt;
-	}
-
+	struct ipv6_txoptions * fl_opt = fl->opt;
+
+	if (fopt == NULL || fopt->opt_flen == 0)
+		return fl_opt;
+
 	if (fl_opt != NULL) {
 		opt_space->hopopt = fl_opt->hopopt;
-		opt_space->dst0opt = fl_opt->srcrt ? fl_opt->dst0opt : NULL;
+		opt_space->dst0opt = fl_opt->dst0opt;
 		opt_space->srcrt = fl_opt->srcrt;
 		opt_space->opt_nflen = fl_opt->opt_nflen;
-		if (fl_opt->dst0opt && !fl_opt->srcrt)
-			opt_space->opt_nflen -= ipv6_optlen(fl_opt->dst0opt);
 	} else {
 		if (fopt->opt_nflen == 0)
 			return fopt;
--- linux-2.6.14.2.orig/net/ipv6/raw.c
+++ linux-2.6.14.2/net/ipv6/raw.c
@@ -756,7 +756,9 @@ static int rawv6_sendmsg(struct kiocb *i
 	}
 	if (opt == NULL)
 		opt = np->opt;
-	opt = fl6_merge_options(&opt_space, flowlabel, opt);
+	if (flowlabel)
+		opt = fl6_merge_options(&opt_space, flowlabel, opt);
+	opt = ipv6_fixup_options(&opt_space, opt);
 
 	fl.proto = proto;
 	rawv6_probe_proto_opt(&fl, msg);
--- linux-2.6.14.2.orig/net/ipv6/udp.c
+++ linux-2.6.14.2/net/ipv6/udp.c
@@ -778,7 +778,9 @@ do_udp_sendmsg:
 	}
 	if (opt == NULL)
 		opt = np->opt;
-	opt = fl6_merge_options(&opt_space, flowlabel, opt);
+	if (flowlabel)
+		opt = fl6_merge_options(&opt_space, flowlabel, opt);
+	opt = ipv6_fixup_options(&opt_space, opt);
 
 	fl->proto = IPPROTO_UDP;
 	ipv6_addr_copy(&fl->fl6_dst, daddr);

--
