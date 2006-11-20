Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755902AbWKTLCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902AbWKTLCq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755951AbWKTLCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:02:46 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:54428 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1755902AbWKTLCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:02:45 -0500
Subject: Re: [PATCH -mm 0/2] Use freezeable workqueues to avoid
	suspend-related XFS corruptions
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: David Chinner <dgc@sgi.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20061120001540.GX11034@melbourne.sgi.com>
References: <200611160912.51226.rjw@sisk.pl>
	 <20061117005052.GK11034@melbourne.sgi.com> <200611171719.31389.rjw@sisk.pl>
	 <20061120001540.GX11034@melbourne.sgi.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 22:02:17 +1100
Message-Id: <1164020537.10428.11.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I've did some testing this afternoon with bdev freezing disabled and
without any non-vanilla code to freeze kthreads (Rafael's or my older
version).

If I put a BUG_ON() in submit_bio for non suspend2 I/O, it catches this
trace:

submit_bio
xfs_buf_iorequest
xlog_bdstrat_cb
xlog_state_release_iclog
xlog_state_sync_all
xfs_log_force
xfs_syncsub
xfs_sync
vfs_sync
vfs_sync_worker
xfssyncd
keventd_create_kthread

I haven't yet reproduced anything on another code path (eg pdflush).

So, it would appear that freezing kthreads without freezing bdevs should
be a possible solution. It may however leave some I/O unsynced
pre-resume and therefore result in possible dataloss if no resume
occurs. I therefore wonder whether it's better to stick with bdev
freezing or create some variant wherein XFS is taught to fully flush
pending writes and not create new I/O.

Regards,

Nigel

