Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753887AbWKFWmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbWKFWmc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753896AbWKFWmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:42:32 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50599
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1753887AbWKFWmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:42:31 -0500
Date: Mon, 06 Nov 2006 14:42:33 -0800 (PST)
Message-Id: <20061106.144233.23011532.davem@davemloft.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: acme@conectiva.com.br
Subject: Re: + net-uninline-skb_put.patch added to -mm tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <200611032218.kA3MITih003548@shell0.pdx.osdl.net>
References: <200611032218.kA3MITih003548@shell0.pdx.osdl.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: akpm@osdl.org
Date: Fri, 03 Nov 2006 14:18:29 -0800

> Subject: net: uninline skb_put()
> From: Andrew Morton <akpm@osdl.org>
> 
> It has 34 callsites for a total of 2650 bytes.
> 
> Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

A more accurate figure would probably be:

davem@sunset:~/src/GIT/net-2.6$ git grep skb_put | grep -v __skb_put | wc -l
1167

:-)

Half of the cost of this interface are the assertions, which while
useful are obviously over the top for such an oft-used routine in
packet processing.

Without the assertion checks it's merely:

	unsigned char *tmp = skb->tail;
	skb->tail += len;
	skb->len  += len;
	return tmp;

And even with 1167 call sites that is definitely something which
should be inlined.
