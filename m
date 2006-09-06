Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWIFXCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWIFXCs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWIFXCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:02:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:47052 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964954AbWIFXB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:01:57 -0400
Date: Wed, 6 Sep 2006 15:56:55 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, bunk@stusta.de,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 20/37] IPV6 OOPSer triggerable by any user
Message-ID: <20060906225655.GU15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ipv6-oops-er-triggerable-by-any-user.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

[IPV6]: Fix kernel OOPs when setting sticky socket options.

Bug noticed by Remi Denis-Courmont <rdenis@simphalempin.com>.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv6/exthdrs.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

--- linux-2.6.17.11.orig/net/ipv6/exthdrs.c
+++ linux-2.6.17.11/net/ipv6/exthdrs.c
@@ -635,14 +635,17 @@ ipv6_renew_options(struct sock *sk, stru
 	struct ipv6_txoptions *opt2;
 	int err;
 
-	if (newtype != IPV6_HOPOPTS && opt->hopopt)
-		tot_len += CMSG_ALIGN(ipv6_optlen(opt->hopopt));
-	if (newtype != IPV6_RTHDRDSTOPTS && opt->dst0opt)
-		tot_len += CMSG_ALIGN(ipv6_optlen(opt->dst0opt));
-	if (newtype != IPV6_RTHDR && opt->srcrt)
-		tot_len += CMSG_ALIGN(ipv6_optlen(opt->srcrt));
-	if (newtype != IPV6_DSTOPTS && opt->dst1opt)
-		tot_len += CMSG_ALIGN(ipv6_optlen(opt->dst1opt));
+	if (opt) {
+		if (newtype != IPV6_HOPOPTS && opt->hopopt)
+			tot_len += CMSG_ALIGN(ipv6_optlen(opt->hopopt));
+		if (newtype != IPV6_RTHDRDSTOPTS && opt->dst0opt)
+			tot_len += CMSG_ALIGN(ipv6_optlen(opt->dst0opt));
+		if (newtype != IPV6_RTHDR && opt->srcrt)
+			tot_len += CMSG_ALIGN(ipv6_optlen(opt->srcrt));
+		if (newtype != IPV6_DSTOPTS && opt->dst1opt)
+			tot_len += CMSG_ALIGN(ipv6_optlen(opt->dst1opt));
+	}
+
 	if (newopt && newoptlen)
 		tot_len += CMSG_ALIGN(newoptlen);
 
@@ -659,25 +662,25 @@ ipv6_renew_options(struct sock *sk, stru
 	opt2->tot_len = tot_len;
 	p = (char *)(opt2 + 1);
 
-	err = ipv6_renew_option(opt->hopopt, newopt, newoptlen,
+	err = ipv6_renew_option(opt ? opt->hopopt : NULL, newopt, newoptlen,
 				newtype != IPV6_HOPOPTS,
 				&opt2->hopopt, &p);
 	if (err)
 		goto out;
 
-	err = ipv6_renew_option(opt->dst0opt, newopt, newoptlen,
+	err = ipv6_renew_option(opt ? opt->dst0opt : NULL, newopt, newoptlen,
 				newtype != IPV6_RTHDRDSTOPTS,
 				&opt2->dst0opt, &p);
 	if (err)
 		goto out;
 
-	err = ipv6_renew_option(opt->srcrt, newopt, newoptlen,
+	err = ipv6_renew_option(opt ? opt->srcrt : NULL, newopt, newoptlen,
 				newtype != IPV6_RTHDR,
-				(struct ipv6_opt_hdr **)opt2->srcrt, &p);
+				(struct ipv6_opt_hdr **)&opt2->srcrt, &p);
 	if (err)
 		goto out;
 
-	err = ipv6_renew_option(opt->dst1opt, newopt, newoptlen,
+	err = ipv6_renew_option(opt ? opt->dst1opt : NULL, newopt, newoptlen,
 				newtype != IPV6_DSTOPTS,
 				&opt2->dst1opt, &p);
 	if (err)

--
