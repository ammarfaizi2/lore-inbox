Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbUCLTKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbUCLTKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:10:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:57995 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261726AbUCLTKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:10:37 -0500
Date: Fri, 12 Mar 2004 11:12:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: piggin@cyberone.com.au, smurf@smurf.noris.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
Message-Id: <20040312111228.3425780b.akpm@osdl.org>
In-Reply-To: <4051C5F1.2050605@cyberone.com.au>
References: <404FACF4.3030601@cyberone.com.au>
	<200403111825.22674@WOLK>
	<40517E47.3010909@cyberone.com.au>
	<20040312012703.69f2bb9b.akpm@osdl.org>
	<pan.2004.03.12.11.08.02.700169@smurf.noris.de>
	<4051B0C6.2070302@cyberone.com.au>
	<4051C5F1.2050605@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> Just had a try of doing things like updatedb and dd if=/dev/zero of=./blah
> It is pretty swappy I guess.

You'll need to bring the scanning priority back into the picture: don't
move mapped pages down onto the inactive list at low scanning priorities. 
And that eans retaining the remember-the-priority-from-last-time logic.

Otherwise it's inevitable that even a `cat monster_file > /dev/null' will
eventually swap out everything it can.

> By the way, I would be interested to know the rationale behind
> mark_page_accessed as it is without this patch, also what is it doing in
> rmap.c (I know hardly anything actually uses page_test_and_clear_young, but
> still). It seems to me like it only serves to make VM behaviour harder to
> understand, but I'm probably missing something. Andrew?

hm, that's left-over code which is pretty pointless now.


	if (page_test_and_clear_young(page))
		mark_page_accessed(page);

	if (TestClearPageReferenced(page))
		referenced++;

The pages in here are never on the LRU, so all the mark_page_accessed()
will do is to set PG_Referenced.  And we immediately clear it again.  So
the mark_page_accessed() can be replaced with referenced++.


