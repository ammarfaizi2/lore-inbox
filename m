Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUJMIlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUJMIlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 04:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUJMIlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 04:41:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:20943 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267746AbUJMIll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 04:41:41 -0400
Date: Wed, 13 Oct 2004 01:39:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: nathans@sgi.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-xfs@oss.sgi.com
Subject: Re: Page cache write performance issue
Message-Id: <20041013013941.49693816.akpm@osdl.org>
In-Reply-To: <416CE423.3000607@cyberone.com.au>
References: <20041013054452.GB1618@frodo>
	<20041012231945.2aff9a00.akpm@osdl.org>
	<20041013063955.GA2079@frodo>
	<20041013000206.680132ad.akpm@osdl.org>
	<20041013172352.B4917536@wobbly.melbourne.sgi.com>
	<416CE423.3000607@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
>  Andrew probably has better ideas.

uh, is this an ia32 highmem box?

If so, you've hit the VM sour spot.  That 128M highmem zone gets 100%
filled with dirty pages and we end up doing a ton of writeout off the page
LRU.  And we do that while `dd' is cheerfully writing to a totally
different part of the disk via balance_dirty_pages().  Seekstorm ensues. 
Although last time I looked (a long time ago) the slowdown was only 2:1 -
perhaps your disk is in writethrough mode??

Basically, *any* other config is fine.  896MB and below, 1.5GB and above.

I could well understand that a minor kswapd tweak would make this bad
situation worse.  Making the dirty ratios really small (dirty_ratio less
than the 128MB) should make it go away.

If it's not ia32 then dunno.
