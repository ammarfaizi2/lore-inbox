Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVEXQkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVEXQkb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVEXQiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:38:13 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:10026 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262163AbVEXQf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:35:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=IBVB2pvF+Zv9viKZyfaCf7HFdIeOKhobD6/dHr1pBSpiHdnQrqK9XRBvmp3VOMf4eEJBCxvnZRqbNgCKzSBEKSdycKYMAZEWPAcNY57sih0AQL2tWzwwMhEu3IPgMypkfszzVYM8FAqle7RtigPagBU6DXE/S4VFlb3V4WXYzTA=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH Linux 2.6.12-rc4-mm2 00/03] cfq: various fixes
Message-ID: <20050524163518.0DA61D6C@htj.dyndns.org>
Date: Wed, 25 May 2005 01:35:19 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.

 This patchset is various fixes to cfq.  All patches are against
2.6.12-rc4-mm2.

 One thing that isn't fixed in this patchset but I think might be
problematic is the priority of async queue.  It seems that the async
queue doesn't receive any special attention regarding its priority.
It just follows normal rules and its priority jumps irregularly.
If I'm missing something, plz point out.

[ Start of patch descriptions ]

01_cfq_INSERT_BACK_fix.patch
	: cfq ELEVATOR_INSERT_BACK fix

	When inserting INSERT_BACK request, cfq_insert_request() calls
	cfq_dispatch_requests() repetitively until it returns zero
	indicating no request is dispatched.  This used to flush all
	the requests in the queue to the dispatch queue but, with idle
	slice implemented, the current active queue may decide to wait
	for new request using slice_timer.  When this happens, 0 is
	returned from cfq_dispatch_requests() even when other cfqq's
	have pending requests.  This breaks INSRET_BACK semantics.

	This patch adds @force argument which, when set to non-zero,
	disables idle_slice, and uses the argument when flushing
	cfqq's for INSERT_BACK.  While at it, use INT_MAX instead of
	cfq_quantum when flushing cfqq's, as we're gonna dump all the
	requests and using cfq_quantum does nothing but adding
	unnecessary iterations.

02_cfq_ioc_leak_fix.patch
	: cfq_io_context leak fix

	When a process has more than one cic's associated with it,
	only the first one was kmem_cache_free'd in the original code.
	This patch frees all cic's in cfq_free_io_context().

	While at it, remove unnecessary refcounting from cic's to ioc.
	This reference is created when each cic is created and removed
	altogether when the ioc is exited, and, thus, serves no
	purpose.

03_cfq_remove_unused_fields.patch
	: remove serveral unused fields from cfq data structures

	cfq_data->idle_start, cfq_data->end_prio and cfq_rq->end_pos
	are not used in meaningful way.  Remove'em.

[ End of patch descriptions ]

 Thanks.

--
tejun

