Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268681AbUJEEFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268681AbUJEEFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 00:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268758AbUJEEFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 00:05:35 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:22211 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268681AbUJEEF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 00:05:28 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: jstubbs@work-at.co.jp, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <200410041611.17000.jstubbs@work-at.co.jp>
	<20041004013548.26e853fc.akpm@osdl.org>
	<200410041931.00159.jstubbs@work-at.co.jp>
	<20041004120535.3c68115a.akpm@osdl.org> <52brfhvs46.fsf@topspin.com>
	<20041004205136.49317eb7.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 04 Oct 2004 21:05:27 -0700
In-Reply-To: <20041004205136.49317eb7.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 4 Oct 2004 20:51:36 -0700")
Message-ID: <523c0tvmgo.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: PROBLEM: Consistent lock up on >=2.6.8
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 05 Oct 2004 04:05:27.0748 (UTC) FILETIME=[8C348040:01C4AA90]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> Excellent point.  We don't appear to have a function which
    Andrew> does that.

Excellent point right back at you... I didn't notice that the ip_vs
work was rescheduling itself.

    Andrew> How does this look?

	+void cancel_rearming_delayed_workqueue(struct workqueue_struct *wq,
	+					struct work_struct *work)
	+{
	+	while (!cancel_delayed_work(work))
	+		flush_workqueue(wq);
	+}

Seems like it should work as long as (as you note) the work _always_
reschedules itself, and no one else ever tries to schedule the work.

Maybe it's easier to say that users of rearming delayed work just have
to have a "stop" flag somewhere?  I have a feeling that an API for
such a particular situation is just an invitation for foot-shooting.

 - Roland
