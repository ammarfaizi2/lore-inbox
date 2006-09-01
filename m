Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWIAA0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWIAA0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 20:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWIAA0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 20:26:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:32657 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964833AbWIAA0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 20:26:12 -0400
X-Authenticated: #704063
Subject: Re: [Patch] Uninitialized variable in drivers/net/wan/syncppp.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1157067913.2634.3.camel@localhost.localdomain>
References: <1157066002.13592.3.camel@alice>
	 <1157067913.2634.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 02:26:02 +0200
Message-Id: <1157070362.14246.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On Thu, 2006-08-31 at 18:45 -0500, Paul Fulghum wrote:
> Valid LCP configuration requests can have zero options (len == 4).
> If the magic number option is not included in the LCP CFG REQ,
> then the magic number should be treated as zero.
> 
> The correct fix is to initialize rmagic to zero before
> the if (len>4 && !sppp_lcp_conf_parse_options()) line.

Thanks for clarification. Here is an updated patch, which has the advantage
of also silencing the gcc warning.

For len equal to 4, we never call sppp_lcp_conf_parse_options(),
therefore rmagic does not get initialized.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-rc5/drivers/net/wan/syncppp.c.orig	2006-09-01 02:16:18.000000000 +0200
+++ linux-2.6.18-rc5/drivers/net/wan/syncppp.c	2006-09-01 02:16:40.000000000 +0200
@@ -469,7 +469,7 @@ static void sppp_lcp_input (struct sppp 
 	struct net_device *dev = sp->pp_if;
 	int len = skb->len;
 	u8 *p, opt[6];
-	u32 rmagic;
+	u32 rmagic = 0;
 
 	if (!pskb_may_pull(skb, sizeof(struct lcp_header))) {
 		if (sp->pp_flags & PP_DEBUG)


