Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbTDFUJA (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 16:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263068AbTDFUJA (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 16:09:00 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:23661 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263067AbTDFUI7 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 16:08:59 -0400
To: "Shawn Starr" <spstarr@sh0n.net>
Cc: "'Andrew Morton'" <akpm@digeo.com>, <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][2.5.66bk9+] - changes to timers still broken - we don't oops anymore
References: <000001c2fc78$5f1df8b0$030aa8c0@unknown>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 06 Apr 2003 13:20:28 -0700
In-Reply-To: <000001c2fc78$5f1df8b0$030aa8c0@unknown>
Message-ID: <52u1dbxtrn.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Apr 2003 20:20:31.0196 (UTC) FILETIME=[F89B39C0:01C2FC79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Shawn" == Shawn Starr <spstarr@sh0n.net> writes:

    Shawn> It just caused sshd to hang. I don't know why Here's what
    Shawn> strace reports: Sshd is stuck in 'D' and a child in zombie
    Shawn> state. The machine has been up for 2 days 18 hours 50 mins.

I may have missed some emails on this topic, so I apologize if this
objection was already answered.  In any case, if you're running with
Andrew's patch that added a del_timer_sync to release_dev(), I think I
see how that could cause problems.  Here's what I said in my previous
email:

  From looking at workqueue.c (especially the comment in
  queue_delayed_work() that says "Increase nr_queued so that the flush
  function knows that there's something pending."), it seems like
  flush_scheduled_work() should wait until even delayed work is done.
  Given that, I don't think the del_timer_sync() should be there --
  wouldn't flush_scheduled_work() block forever, since nr_queued can
  never reach 0 now?

Also, I didn't see an answer to the worry I expressed below:

  I don't see how it's _ever_ safe to call flush_scheduled_work().
  The comment in workqueue.c before flush_workqueue() says "NOTE: if
  work is being added to the queue constantly by some other context
  then this function might block indefinitely."  But
  flush_scheduled_work() is flushing the keventd_wq, which other code
  will definitely add work to.  If we're unlucky,
  flush_scheduled_work() could block forever.  Am I just being
  paranoid?

I admit that flush_scheduled_work() is unlikely to cause problems in
most real world situations, but I'd be curious to know if anyone
thinks this could ever lead to a livelock under some strange condition.

 - Roland
