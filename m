Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbTDIEgX (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTDIEgX (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:36:23 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:14237 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262713AbTDIEgW (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 00:36:22 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: "Shawn Starr" <spstarr@sh0n.net>, rml@tech9.net, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.5.66bk9+] - tty hangings - patches, dmesg & sysctl+T info
References: <20030406133827.34bfbf93.akpm@digeo.com>
	<003001c2fe3d$6eab1080$030aa8c0@unknown>
	<20030408211216.71022d84.akpm@digeo.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 08 Apr 2003 21:47:55 -0700
In-Reply-To: <20030408211216.71022d84.akpm@digeo.com>
Message-ID: <52znn0mg3o.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Apr 2003 04:47:58.0071 (UTC) FILETIME=[312F2870:01C2FE53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> Well it does look like you've hit the flush_workqueue
    Andrew> livelock.

I don't think it's really livelock.  I think it's just the fact that
his kernel (with your tty-shutdown-race-fix patch) does
del_timer_sync() without decrementing nr_queued() and so
flush_workqueue() never returns.

Still, I like the idea of this patch, since it resolves the livelock.
But I don't think the implementation is quite right.  insert_sequence
doesn't get incremented until delayed_work_timer_fn().  That means
that a driver (tty_io.c, for example) could call
schedule_delayed_work(), then call flush_scheduled_work() before
delayed_work_timer_fn() has run for that work.

In that case schedule_delayed_work() could return immediately because
insert_sequence and remove_sequence are (probably) equal.  Then
delayed_work_timer_fn() runs after the driver exits, and we're back
with the original problem (running a freed timer).

It should be pretty easy to rejigger the patch so that it works
correctly, just by moving the cwq->insert_sequence++ from
delayed_work_timer_fn() into queue_delayed_work() (right before the
add_timer(), say).  I'm still not positive that this covers
everything; I need to think a little harder.

In any case, I think we still have to do something to fix
release_dev() in tty_io.c.  It seems we should at least add the
clear_bit(TTY_DONT_FLIP, &tty->flags); however, I'm not familiar
enough with how the tty driver works to know whether TTY_DONT_FLIP
could get set again (while we're waiting for flush_scheduled_work()).
If so we would also need something along the lines of
cancel_delayed_work(&tty->flip.work).

Shawn, I think the patch I just posted a little while ago (with a
fixed cancel_delayed_work() implementation) is more likely to cure
your tty hanging right now.  However, I think something along the
lines of this patch from Andrew is a better solution in the long run.

 - Roland
