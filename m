Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271425AbTGQNfx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 09:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271426AbTGQNfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 09:35:53 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:7133 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S271425AbTGQNfw (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Thu, 17 Jul 2003 09:35:52 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16150.43444.734717.485697@laputa.namesys.com>
Date: Thu, 17 Jul 2003 17:50:44 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: [PATCH] 1/5 VM changes: zone-pressure.patch
In-Reply-To: <20030709034251.6902c488.akpm@osdl.org>
References: <16139.54887.932511.717315@laputa.namesys.com>
	<20030709031203.3971d9b4.akpm@osdl.org>
	<16139.60502.110693.175421@laputa.namesys.com>
	<20030709034251.6902c488.akpm@osdl.org>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov <Nikita@Namesys.COM> wrote:
 > >
 > >  > OK, fixes a bug.
 > > 
 > >  What bug?
 > 
 > Failing to consider mapped pages on the active list until the scanning
 > priority gets large.
 > 
 > I ran up your five patches on a 256MB box, running `qsbench -m 350'.  It got
 > all slow then the machine seized up.   I'll poke at it some.
 > 

My understanding of this is following:

1. kswapd/balance_pgdat runs through all priorities, but fails to rise
zone->free_pages above zone->pages_min. So it exet. Which is strange.

2. nobody is going to wake it up, because all memory allocators are
looping indefinitely in that newly introduced do_retry loop inside
__alloc_pages.

I think either wakeup_kswapd() should be called in __alloc_pages()
before goto rebalance, or kswapd should loop until it restores all zones
to the balance (actually, comment before balance_pgdat() says it does),
or both.

Nikita.
