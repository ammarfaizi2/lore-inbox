Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWFBS2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWFBS2c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 14:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWFBS2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 14:28:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751441AbWFBS2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 14:28:31 -0400
Date: Fri, 2 Jun 2006 11:25:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, arjan@infradead.org
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060602112544.8e8e4591.akpm@osdl.org>
In-Reply-To: <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com>
	<20060601183836.d318950e.akpm@osdl.org>
	<986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006 06:14:21 -0700
"Barry K. Nathan" <barryn@pobox.com> wrote:

> (Ingo, I got your e-mail too, and I will reply to it once I've
> followed your instructions.)
> 
> On 6/1/06, Andrew Morton <akpm@osdl.org> wrote:
> > Damn, sorry.  LLC is completely borked.  You should emphatically set
> > CONFIG_LLC=n.
> 
> Just one problem with that...
> 
> config ATALK
>         tristate "Appletalk protocol support"
>         select LLC
> 
> This box runs netatalk for both file and print service, but I could
> temporarily disable it for testing... Ok, the kernel's up and running
> w/o CONFIG_LLC and CONFIG_ATALK now, and the warning still happened at
> boot time, but it has stayed up for over an hour without keeling over
> with a panic.

We have a probable fix for the LLC problem.  I placed this in the hot-fixes
directory:


diff -puN net/llc/llc_input.c~git-net-llc-fix net/llc/llc_input.c
--- devel/net/llc/llc_input.c~git-net-llc-fix	2006-06-01 19:34:28.000000000 -0700
+++ devel-akpm/net/llc/llc_input.c	2006-06-01 19:34:28.000000000 -0700
@@ -176,7 +176,6 @@ int llc_rcv(struct sk_buff *skb, struct 
  		struct sk_buff *cskb = skb_clone(skb, GFP_ATOMIC);
  		if (cskb)
  			rcv(cskb, dev, pt, orig_dev);
-		rcv(skb, dev, pt, orig_dev);
 	}
 	dest = llc_pdu_type(skb);
 	if (unlikely(!dest || !llc_type_handlers[dest - 1]))
_
 
