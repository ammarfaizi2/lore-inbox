Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUCNUPL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 15:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUCNUPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 15:15:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:25482 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261532AbUCNUPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 15:15:07 -0500
Date: Sun, 14 Mar 2004 12:15:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org, andrea@suse.de,
       riel@redhat.com, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
Message-Id: <20040314121503.13247112.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0403141638390.1554-100000@dmt.cyclades>
References: <20040310.195707.521627048.nomura@linux.bs1.fc.nec.co.jp>
	<Pine.LNX.4.44.0403141638390.1554-100000@dmt.cyclades>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
>  At first I was skeptic to the inclusion of this patch in v2.4 (due to the
>  freeze), but after thinking a bit more about I have a few points in favour 
>  of this modification (read Nomura's message below and the patch to know 
>  what I'm talking about):
> 
>  - It is off by default 
>  - It is very simple (non intrusive), it just changes the point in which 
>  anonymous pages are inserted into the LRU. 
>  - When turned on, I dont see it being a reason for introducing new 
>  bugs.
> 
>  What you think of this? 

hm, I hadn't noticed that 2.4 was changed to _not_ add anon pages to the
LRU.  I'd always regarded that as a workaround for pagemap_lru_lock contention
on large SMP machines which would never get beyond the suse kernel.

Having a magic knob is a weak solution: the majority of people who are
affected by this problem won't know to turn it on.

I confess that I don't really understand the failure mode.  So we have
zillions of anon pages which are not on the LRU.  We call swap_out() and
scan all these pages, failing to find swapcache space for them.

Why does adding the pages to the LRU up-front solve the problem?

(And why cannot we lazily add these anon pages to the LRU in swap_out, and
avoid the need for the knob?)

