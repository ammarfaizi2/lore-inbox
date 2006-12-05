Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757674AbWLEXwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757674AbWLEXwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757050AbWLEXwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:52:19 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:5869 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757734AbWLEXwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:52:17 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Fleming <afleming@freescale.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
X-Message-Flag: Warning: May contain useful information
References: <1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
	<20061205123958.497a7bd6.akpm@osdl.org>
	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
	<20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
	<20061205135753.9c3844f8.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 05 Dec 2006 15:52:13 -0800
In-Reply-To: <20061205135753.9c3844f8.akpm@osdl.org> (Andrew Morton's message of "Tue, 5 Dec 2006 13:57:53 -0800")
Message-ID: <adaejrdc34i.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Dec 2006 23:52:14.0435 (UTC) FILETIME=[6372EB30:01C718C8]
Authentication-Results: sj-dkim-4; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Ah.  The point is that the phy code doesn't want to flush _all_ pending
 > callbacks.  It only wants to flush its own one.  And its own one doesn't
 > take rtnl_lock().

OK, got it.  You're absolutely correct.

 > Maybe the lesson here is that flush_scheduled_work() is a bad function.
 > It should really be flush_this_work(struct work_struct *w).  That is in
 > fact what approximately 100% of the flush_scheduled_work() callers actually
 > want to do.

I think flush_this_work() runs into trouble if it means "make sure
everything up to <this work> has completed" because it still syncs
with everything before <this work>, which has the same risk of
deadlock.  And I'm not totally sure everyone who does
flush_scheduled_work() really means "cancel my work" -- they might mean
"finish up my work".

For example I would have to do some archeology to remember exactly
what I needed flush_scheduled_work() when I wrote drivers/infiniband/ulp/ipoib

 - R.
