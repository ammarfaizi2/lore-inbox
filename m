Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263925AbTEWIKf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTEWIKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:10:35 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:18967 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263925AbTEWIKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:10:33 -0400
Date: Fri, 23 May 2003 01:26:36 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       bzzz@tmi.comex.ru
Subject: Re: [RFC] probably invalid accounting in jbd
Message-Id: <20030523012636.1d272586.akpm@digeo.com>
In-Reply-To: <871xypx62o.fsf_-_@gw.home.net>
References: <87d6igmarf.fsf@gw.home.net>
	<1053376482.11943.15.camel@sisko.scot.redhat.com>
	<87he7qe979.fsf@gw.home.net>
	<1053377493.11943.32.camel@sisko.scot.redhat.com>
	<87addhd2mc.fsf@gw.home.net>
	<20030521093848.59ada625.akpm@digeo.com>
	<871xypx62o.fsf_-_@gw.home.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2003 08:23:39.0052 (UTC) FILETIME=[9CC926C0:01C32104]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> I think current journal_release_buffer() which is used by ext3 allocator
>  in -mm tree has a bug. look, it won't decrement credits if concurrent
>  thread already put buffer on metadata list. but this may ext3_try_to_allocate()
>  may overflow handle's credist.

Yes, that is so.

But some other handle has gained itself a free buffer.  That is actually
harmless, except for one thing: as the handles are closed down,
->t_outstanding_credits will be too small.  We could conceivably end up
overflowing the journal.


umm, one possible solution to that is to rework the t_outstanding_credits
logic so that we instead record:

	number of buffers attached to the transaction +
		sum of the initial size of all currently-running handles.

as each handle is closed off, we subtract its initial size from the above
metric.  Any buffers which that handle happened to add to the lists would
have already been accounted for, when they were added.

I _think_ that'll work...

