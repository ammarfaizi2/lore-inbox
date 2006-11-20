Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966675AbWKTUoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966675AbWKTUoh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966676AbWKTUoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:44:37 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:63941 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S966675AbWKTUog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:44:36 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: nigel@suspend2.net
Subject: Re: [PATCH -mm 0/2] Use freezeable workqueues to avoid suspend-related XFS corruptions
Date: Mon, 20 Nov 2006 21:40:46 +0100
User-Agent: KMail/1.9.1
Cc: David Chinner <dgc@sgi.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200611160912.51226.rjw@sisk.pl> <20061120001540.GX11034@melbourne.sgi.com> <1164020537.10428.11.camel@nigel.suspend2.net>
In-Reply-To: <1164020537.10428.11.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611202140.47322.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 20 November 2006 12:02, Nigel Cunningham wrote:
> Hi all.
> 
> I've did some testing this afternoon with bdev freezing disabled and
> without any non-vanilla code to freeze kthreads (Rafael's or my older
> version).

Thanks for testing this.

> If I put a BUG_ON() in submit_bio for non suspend2 I/O, it catches this
> trace:
> 
> submit_bio
> xfs_buf_iorequest
> xlog_bdstrat_cb
> xlog_state_release_iclog
> xlog_state_sync_all
> xfs_log_force
> xfs_syncsub
> xfs_sync
> vfs_sync
> vfs_sync_worker
> xfssyncd
> keventd_create_kthread

Well, this trace apparently comes from xfssyncd wich explicitly calls
try_to_freeze().  When does this happen?

> I haven't yet reproduced anything on another code path (eg pdflush).
> 
> So, it would appear that freezing kthreads without freezing bdevs should
> be a possible solution. It may however leave some I/O unsynced
> pre-resume and therefore result in possible dataloss if no resume
> occurs. I therefore wonder whether it's better to stick with bdev
> freezing

It looks like xfs is the only filesystem that really implements bdev freezing,
so for other filesystems it's irrelevant.  However, it may affect the dm, and
I'm not sure what happens if someone tries to use a swap file on a dm
device for the suspend _after_ we have frozen bdevs.

> or create some variant wherein XFS is taught to fully flush 
> pending writes and not create new I/O.

I think we should prevent filesystems from submitting any new I/O after
processes have been frozen, this way or another.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
