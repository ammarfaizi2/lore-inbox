Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261877AbTCaWeD>; Mon, 31 Mar 2003 17:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261883AbTCaWeC>; Mon, 31 Mar 2003 17:34:02 -0500
Received: from [12.47.58.55] ([12.47.58.55]:37311 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S261877AbTCaWeB>;
	Mon, 31 Mar 2003 17:34:01 -0500
Date: Mon, 31 Mar 2003 14:45:00 -0800
From: Andrew Morton <akpm@digeo.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: helgehaf@aitel.hist.no, erik@hensema.net, linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
Message-Id: <20030331144500.17bf3a2e.akpm@digeo.com>
In-Reply-To: <3E88BAF9.8040100@cyberone.com.au>
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net>
	<20030328231248.GH5147@zaurus.ucw.cz>
	<slrnb8gbfp.1d6.erik@bender.home.hensema.net>
	<3E8845A8.20107@aitel.hist.no>
	<3E88BAF9.8040100@cyberone.com.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Mar 2003 22:45:17.0200 (UTC) FILETIME=[3363C100:01C2F7D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> it seems to me that
> doing writeout whenever the disk would otherwise be idle
> (and we have dirty memory to write out) would be a good
> solution.

This is what the recently-removed BDI_read_active flag in backing_dev_info
was supposed to be for.  I let it go because I don't think it's terribly
important and it's time to stop fiddling with the vfs writeout code and it
wasn't right anyway.

Note that 2.5 starts pdflush writeout at 10% of memory dirty.  Or even lower
if there is a lot of mapped memory around.  Whereas 2.4 will start background
writeout at 30% or 40% dirty.  That's a fairly significant tuning change.

The algorithm for utilisation of an idle disk should be, in
balance_dirty_pages():

	if (ps.nr_dirty + ps.nr_writeback < background_thresh) {
		if (time_after(jiffies, bdi->last_read + HZ/100)) {
			if (bdi->write_requests_in_flight < 2) {
				struct writeback_control wbc = {
					.bdi		= bdi,
					.sync_mode	= WB_SYNC_NONE,
					.nr_to_write	= write_chunk,
				};

				writeback_inodes(&wbc);
			}
		}
		return;
	}


Or something like that.  It's pretty close.

It could have pretty bad failure modes.  Short-lived files in /tmp now
perform writeout, which needs to be waited on when those files are removed.

